{% if var('etl') == 'stitch' %}
{{ stitch_adwords_ads() }}
{% elif var('etl') == 'fivetran'%}
--Fivetran does not support Core tables
{% endif %}