select

    date_day,
    null::varchar as utm_medium,
    null::varchar as utm_source,
    null::varchar as utm_campaign,
    null::varchar as utm_term,
    null::varchar as utm_content,
    criteria_id,
    ad_group_id,
    clicks,
    spend,
    impressions,
    'adwords'::varchar as ad_data_source

from {{ref('adwords_criteria_performance')}}
