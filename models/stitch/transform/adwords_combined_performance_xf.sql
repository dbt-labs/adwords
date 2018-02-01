with criteria as (
    select * from {{ref('adwords_criteria_performance')}}
)

, campaign as (
    select * from {{ref('adwords_campaign_performance')}}
)

select *
from criteria

union all

select
    NULL::int as criteria_id,
    NULL::varchar(1024) as criteria_display_name,
    NULL::varchar(1024) as ad_group,
    NULL::int as ad_group_id,
    NULL::varchar(1024) as ad_group_state,
    campaign.campaign,
    campaign.campaign_id,
    campaign.campaign_state,
    campaign.customer_id,
    campaign.clicks,
    campaign.impressions,
    campaign.spend,
    campaign.date_day
from campaign
left join criteria on campaign.campaign_id=criteria.campaign_id
where criteria.campaign_id is null
