{{
    config(
        enabled = var('adapter_value') == 'criteria'
    )
}}

with criteria_base as (

    select * from {{ ref('adwords_criteria_performance') }}

),

final as (

    select
        date_day as campaign_date,
        criteria_id,
        ad_group_name,
        ad_group_id,
        ad_group_state,
        campaign_name,
        campaign_id,
        campaign_state,
        customer_id,
        clicks,
        impressions,
        spend,
        'adwords' as platform

    from criteria_base
)

select * from final