{{
    config(
        enabled = var('adapter_value') == 'url'
    )
}}

with url_base as (

    select * from {{ ref('adwords_url_performance') }}

),

final as (

select 
    date_day as campaign_date,
    ad_group_id,
    ad_group_name,
    campaign_id,
    url_host,
    url_path,
    utm_source,
    utm_medium,
    utm_campaign,
    utm_term,
    campaign_name,
    clicks,
    impressions,
    spend,
    'adwords' as platform

from  url_base

)

select * from final
