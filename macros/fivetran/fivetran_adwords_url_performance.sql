{% macro fivetran_adwords_url_performance() %}

    {{ adapter.dispatch('fivetran_adwords_url_performance', 'adwords')() }}

{% endmacro %}


{% macro default__fivetran_adwords_url_performance() %}

with url_performance_base as (

    select * from {{ var('final_url_performance_report') }}

),

aggregated as (

    select

        {{ dbt_utils.surrogate_key (
            [
              'customer_id',
              'final_urls',
              'date',
              'campaign_id',
              'ad_group_id'
            ]
        ) }}::varchar as id,

        date::date as date_day,

        {{ dbt_utils.split_part('final_urls', "'?'", 1) }} as base_url,
        {{ dbt_utils.get_url_host('final_urls') }} as url_host,
        '/' || {{ dbt_utils.get_url_path('final_urls') }} as url_path,
        {{ dbt_utils.get_url_parameter('final_urls', 'utm_source') }} as utm_source,
        {{ dbt_utils.get_url_parameter('final_urls', 'utm_medium') }} as utm_medium,
        {{ dbt_utils.get_url_parameter('final_urls', 'utm_campaign') }} as utm_campaign,
        {{ dbt_utils.get_url_parameter('final_urls', 'utm_content') }} as utm_content,
        {{ dbt_utils.get_url_parameter('final_urls', 'utm_term') }} as utm_term,
        campaign_id,
        campaign_name,
        ad_group_id,
        ad_group_name,
        customer_id,
        _fivetran_synced as fivetran_synced_at,

        sum(clicks) as clicks,
        sum(impressions) as impressions,
        sum(cast((cost::float) as numeric(38,6))) as spend

    from url_performance_base

    {{ dbt_utils.group_by(16) }}

),

ranked as (

    select
    
        *,
        rank() over (partition by id
            order by fivetran_synced_at desc) as latest
            
    from aggregated

),

final as (

    select *
    from ranked
    where latest = 1

)

select * from final

{% endmacro %}