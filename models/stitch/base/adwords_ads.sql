{% if var('etl') == 'stitch' %}
{{ stitch_adwords_ads() }}
{% elif var('etl') == 'fivetran'%}
{{ fivetran_adwords_ads() }}
{% endif %}