{{
    config(
        enabled = var('etl') == 'stitch' and var('adapter_value') == 'criteria'
    )
}}

{{ stitch_adwords_criteria_performance() }}