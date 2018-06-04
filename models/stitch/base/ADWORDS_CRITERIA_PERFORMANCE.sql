with adwords_base as (

    select
        *,
        rank() over (partition by day, customerid
            order by _sdc_report_datetime desc) as latest
    from {{ var('criteria_performance_report') }}

),

adwords_final as (

    select

        md5(keywordid::varchar || adgroupid::varchar || day::varchar) as id,
        keywordid as criteria_id,
        adgroup as ad_group,
        adgroupid as ad_group_id,
        adgroupstate as ad_group_state,
        campaign,
        campaignid as campaign_id,
        campaignstate as campaign_state,
        customerid as customer_id,
        clicks,
        impressions,
        cast((cost::float/1000000::float) as numeric(38,6)) as spend,
        day::date as date_day

    from adwords_base
    where latest = 1

)

select * from adwords_final
