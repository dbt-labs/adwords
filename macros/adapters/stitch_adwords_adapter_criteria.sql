{% macro stitch_adwords_adapter_criteria() %}

    with criteria_performance as (
        
        select * from {{ ref('adwords_criteria_performance') }}
        
    ),

    joined as (

        select

            date_day as campaign_date,
            ad_group_id,
            criteria_id,
            ad_group_name,
            campaign_id,
            campaign_name,
            clicks,
            spend,
            impressions,
            'adwords' as platform

        from criteria_performance
        
    )

    select * from joined
    
{% endmacro %}