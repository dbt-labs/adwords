{% if var('etl') == 'stitch' %}
{{ stitch_adwords_ad_groups() }}
{% elif var('etl') == 'fivetran'%}
{{ fivetran_adwords_ad_groups() }}
{% endif %}