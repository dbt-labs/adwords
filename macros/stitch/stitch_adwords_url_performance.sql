{% macro stitch_adwords_url_performance() %}

    {{ adapter_macro('adwords.stitch_adwords_url_performance') }}

{% endmacro %}


{% macro default__stitch_adwords_url_performance() %}

with base as (

    select * from {{ var('criteria_performance_report') }}

), 

aggregated as (

    select

        md5(customerid::varchar || coalesce(finalurl::varchar, '')) as id,

        day::date as date_day,
        
        split_part(finalurl, '?', 1) as base_url,
        parse_url(finalurl)['host']::varchar as url_host,
        '/' || parse_url(finalurl)['path']::varchar as url_path,
        nullif(parse_url(finalurl)['parameters']['utm_campaign']::varchar, '') as utm_campaign,
        nullif(parse_url(finalurl)['parameters']['utm_source']::varchar, '') as utm_source,
        nullif(parse_url(finalurl)['parameters']['utm_medium']::varchar, '') as utm_medium,
        nullif(parse_url(finalurl)['parameters']['utm_content']::varchar, '') as utm_content,
        nullif(parse_url(finalurl)['parameters']['utm_term']::varchar, '') as utm_term,
        
        campaignid as campaign_id,
        campaign as campaign_name,
        adgroupid as ad_group_id,
        adgroup as ad_group_name,
        customerid as customer_id,
        _sdc_report_datetime,
        
        sum(clicks) as clicks,
        sum(impressions) as impressions,
        sum(cast((cost::float/1000000::float) as numeric(38,6))) as spend
        
    from raw.adwords_stitch.final_url_report

    group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16

), 

ranked as (

    select
        *,
        rank() over (partition by id
            order by _sdc_report_datetime desc) as latest
    from aggregated

),

final as (

    select *
    from ranked
    where latest = 1

)

select * from final

{% endmacro %}