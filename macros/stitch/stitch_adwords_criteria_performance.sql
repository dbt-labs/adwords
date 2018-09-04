{% macro stitch_adwords_criteria_performance() %}

    {{ adapter_macro('adwords.stitch_adwords_criteria_performance') }}

{% endmacro %}


{% macro default__stitch_adwords_criteria_performance() %}

with base as (

    select
        *,
        rank() over (partition by day, customerid
            order by _sdc_report_datetime desc) as latest
    from {{ var('criteria_performance_report') }}

),

final as (

    select

        md5(keywordid::varchar || adgroupid::varchar || day::varchar) as id,
        day::date as date_day,
        keywordid as criteria_id,
        adgroup as ad_group_name,
        adgroupid as ad_group_id,
        adgroupstate as ad_group_state,
        campaign as campaign_name,
        campaignid as campaign_id,
        campaignstate as campaign_state,
        customerid as customer_id,
        sum(clicks) as clicks,
        sum(impressions) as impressions,
        sum(cast((cost::float/1000000::float) as numeric(38,6))) as spend

    from base
    where latest = 1
    group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

)

select * from final

{% endmacro %}