# adwords

This package models Google Adwords data.

Please note, because several of the models are based on Adwords "reports" which
have a layer of aggregation occurring, the specific fields you select in your ETL
tool are very important in the output of the data. Selecting additional fields
may cause unexpected fan out that these models will not account for.

If your Adwords Ads account use UTM parameters, then you should enable the 
`adwords_url_ad_performance` adapter which uses the 'adwords_url_performance' report. 
If your account use gclids or a combination of UTMs and gclids (ie some urls 
with have just the gclid) then you should enable the `adwords_gclid_ad_performance_adapter`
which uses the `adwords_criteria_performance` report. You should make this selection in enabling/disabling the proper adapter in your `dbt_profile.yml` file.

[Here](https://developers.google.com/adwords/api/docs/appendix/reports) is info
from Google's API.

[Here](https://www.stitchdata.com/docs/integrations/saas/google-adwords#schema) 
is info about Stitch's Adwords connector. 

[Here](https://fivetran.com/docs/applications/google-ads/setup-guide) 
is info about Fivetran's Adwords connector.