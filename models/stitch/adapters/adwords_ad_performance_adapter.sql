select

    date_day as campaign_date,
    url_host,
    url_path,
    utm_source,
    utm_medium,
    utm_campaign,
    utm_content,
    utm_term,
    ad_group_id,
    ad_group_name,
    campaign_id,
    campaign_name,
    clicks,
    spend,
    impressions,
    'adwords' as platform

from {{ref('adwords_url_performance')}}