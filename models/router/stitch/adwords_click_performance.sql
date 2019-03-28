{{
    config(
        enabled = var('etl') == 'stitch'
    )
}}

{{ stitch_adwords_click_performance() }}
