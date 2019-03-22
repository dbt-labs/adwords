{% if var('adapter_value') == 'url' %} 
        {{ stitch_adwords_adapter_url  () }}
{% endif %}

{% if var('adapter_value') == 'criteria' %} 
        {{ stitch_adwords_adapter_criteria  () }}
{% endif %}

