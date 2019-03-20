{% if var('etl') == 'stitch' %}
{{ stitch_adwords_accounts() }}
{% elif var('etl') == 'fivetran'%}
{{ fivetran_adwords_accounts() }}
{% endif %}