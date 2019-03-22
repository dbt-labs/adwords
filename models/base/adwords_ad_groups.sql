{% if var('etl') == 'stitch' %}
{{ stitch_adwords_ad_groups() }}
{% elif var('etl') == 'fivetran'%}
--Fivetran does not support Core tables
{% endif %}