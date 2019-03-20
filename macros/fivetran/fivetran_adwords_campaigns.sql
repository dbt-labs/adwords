{% macro fivetran_adwords_campaigns() %}

    {{ adapter_macro('adwords.fivetran_adwords_campaigns') }}

{% endmacro %}


{% macro default__fivetran_adwords_campaigns() %}

with campaigns_source as (

    select * from {{ var('campaigns_table') }}

),

campaigns_renamed as (

    select 

        id as campaign_id,
        name,
        adservingoptimizationstatus as ad_serving_optimization_status,
        advertisingchanneltype as advertising_channel_type,
        basecampaignid as base_campaign_id,
        campaigntrialtype as campaign_trial_type,
        startdate as start_date,
        enddate as end_date,
        servingstatus as serving_status,
        settings,
        status,
        "_SDC_CUSTOMER_ID" as account_id,
        labels

    from campaigns_source

)

select * from campaigns_renamed

{% endmacro %}