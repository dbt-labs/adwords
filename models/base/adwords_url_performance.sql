{% if var('etl') == 'stitch' %}
{{ stitch_adwords_url_performance() }}
{% elif var('etl') == 'fivetran'%}
{{ fivetran_adwords_url_performance() }}
{% endif %}