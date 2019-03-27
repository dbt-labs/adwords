{{
    config(
        enabled = var('etl') == 'fivetran' and var('adapter_value') == 'criteria'
    )
}}

{{ fivetran_adwords_criteria_performance() }}