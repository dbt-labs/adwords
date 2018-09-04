select

    date_day as campaign_date,
    criteria_id,
    ad_group_id,
    ad_group_name,
    campaign_id,
    campaign_name,
    clicks,
    spend,
    impressions,
    'adwords' as platform

from {{ref('adwords_criteria_performance')}}