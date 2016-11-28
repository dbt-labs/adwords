select
  date::date,
  accountid::bigint as account_id,
  profileid::bigint as profile_id,
  profilename as profile_name,
  adwordscampaignid::bigint as campaign_id,
  campaign as campaign_name,
  adgroup as ad_group_name,
  nullif(adcontent, '') as ad_content,
  keyword,
  lower(addestinationurl) as destination_url,
  adclicks as clicks,
  adcost as cost,
  impressions
from {{ var('adwords_base_table') }}
