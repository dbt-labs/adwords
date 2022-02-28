{% macro stitch_adwords_ad_groups() %}

    {{ adapter.dispatch('stitch_adwords_ad_groups', 'adwords')() }}

{% endmacro %}


{% macro default__stitch_adwords_ad_groups() %}

with ad_groups_source as (

    select * from {{ var('ad_groups_table') }}

),

ad_groups_renamed as (

    select 

        id as ad_group_id,
        name,
        adgrouptype as ad_group_type,
        baseadgroupid as base_ad_group_id,
        basecampaignid as base_campaign_id,
        campaignid as campaign_id,
        campaignname as campaign_name,
        settings,
        status,
        "_SDC_CUSTOMER_ID" as account_id,
        labels

    from ad_groups_source

)

select * from ad_groups_renamed

{% endmacro %}