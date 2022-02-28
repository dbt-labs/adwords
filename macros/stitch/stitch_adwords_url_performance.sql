{% macro stitch_adwords_url_performance() %}

    {{ adapter.dispatch('stitch_adwords_url_performance', 'adwords')() }}

{% endmacro %}


{% macro default__stitch_adwords_url_performance() %}

with url_performance_base as (

    select * from {{ var('final_url_performance_report') }}

),

aggregated as (

    select

        {{ dbt_utils.surrogate_key (
            [
              'customerid',
              'finalurl',
              'day',
              'campaignid',
              'adgroupid'
            ]
        ) }}::varchar as id,

        day::date as date_day,

        {{ dbt_utils.split_part('finalurl', "'?'", 1) }} as base_url,
        {{ dbt_utils.get_url_host('finalurl') }} as url_host,
        '/' || {{ dbt_utils.get_url_path('finalurl') }} as url_path,
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

    from url_performance_base

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