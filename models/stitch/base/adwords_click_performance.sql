select

  googleclickid as gclid,
  day::date as date_day,
  keywordid as criteria_id,
  adgroupid as ad_group_id

from {{ var('click_performance_report') }}
