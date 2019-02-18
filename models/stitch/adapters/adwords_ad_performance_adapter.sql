with criteria_performance as (
    
    select * from {{ ref('adwords_criteria_performance') }}
    
),

url_performance as (
    
    select * from {{ ref('adwords_url_performance') }}
    
),

joined as (

    select

        criteria_performance.date_day as campaign_date,
        url_performance.url_host,
        url_performance.url_path,
        url_performance.utm_source,
        url_performance.utm_medium,
        url_performance.utm_campaign,
        url_performance.utm_content,
        url_performance.utm_term,
        criteria_performance.ad_group_id,
        criteria_performance.ad_group_name,
        criteria_performance.campaign_id,
        criteria_performance.campaign_name,
        criteria_performance.criteria_id,
        criteria_performance.clicks,
        criteria_performance.spend,
        criteria_performance.impressions,
        'adwords' as platform

    from criteria_performance
    left join url_performance using (campaign_id)
    
)

select * from joined