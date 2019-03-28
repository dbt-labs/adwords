{{
    config(
        enabled = var('etl') == 'stitch' and var('adapter_value') == 'url'
    )
}}

{{ stitch_adwords_url_performance() }}
