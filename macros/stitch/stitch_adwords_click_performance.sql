{% macro stitch_adwords_click_performance() %}

    {{ adapter.dispatch('stitch_adwords_click_performance', 'adwords')() }}

{% endmacro %}


{% macro default__stitch_adwords_click_performance() %}

with gclid_base as (

    select

        googleclickid as gclid,
        day::date as date_day,
        keywordid as criteria_id,
        adgroupid as ad_group_id,
        row_number() over (partition by gclid order by date_day) as row_num

    from {{ var('click_performance_report') }}

)

select * from gclid_base
where row_num = 1
and gclid is not null

{% endmacro %}