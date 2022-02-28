{% macro fivetran_adwords_criteria_performance() %}

    {{ adapter.dispatch('fivetran_adwords_criteria_performance', 'adwords')() }}

{% endmacro %}


{% macro default__fivetran_adwords_criteria_performance() %}

with criteria_base as (

    select * from {{ var('criteria_performance_report') }}

), 

aggregated as (

    select
        
        {{ dbt_utils.surrogate_key (
            [
              'customer_id',
              'id',
              'ad_group_id',
              'date'
            ]
        ) }}::varchar as id,
        
        date::date as date_day,
        id as criteria_id,
        ad_group_name,
        ad_group_id,
        ad_group_status as ad_group_state,
        campaign_name,
        campaign_id,
        campaign_status as campaign_state,
        customer_id,
        _fivetran_synced,
        sum(clicks) as clicks,
        sum(impressions) as impressions,
        sum(cast((cost::float) as numeric(38,6))) as spend

    from criteria_base
    {{ dbt_utils.group_by(11) }}

), 

ranked as (

    select
    
        *,
        rank() over (partition by id
            order by _fivetran_synced desc) as latest
            
    from aggregated

),

final as (

    select *
    from ranked
    where latest = 1

)

select * from final

{% endmacro %}