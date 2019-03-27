{{
    config(
        enabled = var('etl') == 'fivetran' and var('adapter_value') == 'url'
    )
}}

{{ fivetran_adwords_url_performance() }}
