{% macro stitch_adwords_criteria_performance() %}

    {{ adapter.dispatch('stitch_adwords_criteria_performance', 'adwords')() }}

{% endmacro %}


{% macro default__stitch_adwords_criteria_performance() %}

with criteria_base as (

    select * from {{ var('criteria_performance_report') }}

), 

aggregated as (

    select
        
        {{ dbt_utils.surrogate_key (
            [
              'customerid',
              'keywordid',
              'adgroupid',
              'day'
            ]
        ) }}::varchar as id,
        
        day::date as date_day,
        keywordid as criteria_id,
        adgroup as ad_group_name,
        adgroupid as ad_group_id,
        adgroupstate as ad_group_state,
        campaign as campaign_name,
        campaignid as campaign_id,
        campaignstate as campaign_state,
        customerid as customer_id,
        _sdc_report_datetime,
        sum(clicks) as clicks,
        sum(impressions) as impressions,
        sum(cast((cost::float/1000000::float) as numeric(38,6))) as spend

    from criteria_base
    {{ dbt_utils.group_by(11) }}

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