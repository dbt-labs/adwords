{{
    config(
        enabled = var('etl') == 'fivetran'
    )
}}

{{ fivetran_adwords_click_performance() }}
