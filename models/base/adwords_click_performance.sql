{% if var('etl') == 'stitch' %}
{{ stitch_adwords_click_performance() }}
{% elif var('etl') == 'fivetran'%}
{{ fivetran_adwords_click_performance() }}
{% endif %}