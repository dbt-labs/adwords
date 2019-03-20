{% if var('etl') == 'stitch' %}
{{ stitch_adwords_campaigns() }}
{% elif var('etl') == 'fivetran'%}
{{ fivetran_adwords_campaigns() }}
{% endif %}