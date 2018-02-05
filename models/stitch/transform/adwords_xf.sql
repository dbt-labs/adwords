with clicks as (

  select * from {{ref('adwords_click_performance')}}

),

criteria as (

  select * from {{ref('adwords_criteria_performance')}}

)

select *
from clicks
join criteria using (criteria_id, ad_group_id, date_day)
