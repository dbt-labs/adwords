{% macro stitch_adwords_url_performance() %}

    {{ adapter_macro('adwords.stitch_adwords_url_performance') }}

{% endmacro %}


{% macro default__stitch_adwords_url_performance() %}

with base as (

    select * from {{ var('final_url_performance_report') }}

),

aggregated as (

    select

        {{ dbt_utils.surrogate_key (
            'customerid',
            'finalurl',
            'day',
            'campaignid',
            'adgroupid'
        
        ) }}::varchar as id,

        day::date as date_day,

        split_part(finalurl, '?', 1) as base_url,
        {{ dbt_utils.get_url_parameter('finalurl', 'host') }}::varchar as url_host,
        '/' || {{ dbt_utils.get_url_parameter('finalurl', 'path') }}::varchar as url_path,
        {{ dbt_utils.get_url_parameter('finalurl', 'utm_source') }} as utm_source,
        {{ dbt_utils.get_url_parameter('finalurl', 'utm_medium') }} as utm_medium,
        {{ dbt_utils.get_url_parameter('finalurl', 'utm_campaign') }} as utm_campaign,
        {{ dbt_utils.get_url_parameter('finalurl', 'utm_content') }} as utm_content,
        {{ dbt_utils.get_url_parameter('finalurl', 'utm_term') }} as utm_term,
        campaignid as campaign_id,
        campaign as campaign_name,
        adgroupid as ad_group_id,
        adgroup as ad_group_name,
        customerid as customer_id,
        _sdc_report_datetime,

        sum(clicks) as clicks,
        sum(impressions) as impressions,
        sum(cast((cost::float/1000000::float) as numeric(38,6))) as spend

    from base

    {{ dbt_utils.group_by(16) }}

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


{% macro snowflake__stitch_adwords_url_performance() %}

with base as (

    select * from {{ var('final_url_performance_report') }}

),

aggregated as (

    select

        {{ dbt_utils.surrogate_key (
            'customerid',
            'finalurl',
            'day',
            'campaignid',
            'adgroupid'
        
        ) }}::varchar as id,

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

    from base

    {{ dbt_utils.group_by(16) }}

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
