{% macro stitch_adwords_accounts() %}

    {{ adapter_macro('adwords.stitch_adwords_accounts') }}

{% endmacro %}


{% macro default__stitch_adwords_accounts() %}

with accounts_source as (

    select * from {{ var('accounts_table') }}

),

accounts_renamed as (

    select 

        customerid as account_id,
        name as account_name,
        canmanageclients as can_manage_clients,
        currencycode as currency_code,
        datetimezone as time_zone,
        testaccount as test_account

    from accounts_source

)

select * from accounts_renamed

{% endmacro %}