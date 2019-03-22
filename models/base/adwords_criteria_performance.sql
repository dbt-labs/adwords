{% if var('etl') == 'stitch' %}
{{ stitch_adwords_criteria_performance() }}
{% elif var('etl') == 'fivetran'%}
{{ fivetran_adwords_criteria_performance() }}
{% endif %}