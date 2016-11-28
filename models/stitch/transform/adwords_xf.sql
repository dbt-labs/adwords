with adwords as (

  select * from {{ref('adwords')}}

)

select
  *,
  split_part(destination_url,'?',1) as base_url,
  nullif(split_part(split_part(destination_url,'utm_source=',2), '&', 1), '') as utm_source,
  nullif(split_part(split_part(destination_url,'utm_medium=',2), '&', 1), '') as utm_medium,
  nullif(split_part(split_part(destination_url,'utm_campaign=',2), '&', 1), '') as utm_campaign,
  nullif(split_part(split_part(destination_url,'utm_content=',2), '&', 1), '') as utm_content,
  nullif(split_part(split_part(destination_url,'utm_term=',2), '&', 1), '') as utm_term
from adwords
