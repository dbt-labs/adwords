with base as (
    select *,
             RANK() OVER (PARTITION BY day
                          ORDER BY _sdc_report_datetime DESC) as latest
    from {{ var('campaign_performance_report') }}
)

select --adgroup as ad_group,
        --adgroupid as ad_group_id,
        campaign,
        campaignid as campaign_id,
        campaignstate,
        clicks,
        cast((cost::float/1000000::float) as numeric(38,6)) as spend,
        --criteriadisplayname,
        customerid as customer_id,
        day::date as date_day,
        impressions
        --keywordid as criteria_id
from base
where latest=1
