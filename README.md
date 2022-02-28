# Google Ads (adwords)

This package models Google Adwords data.

[Here](https://developers.google.com/adwords/api/docs/appendix/reports) is info
from Google's API.

[Here](https://docs.getdbt.com/docs/package-management) is some additional 
information about packages in dbt. If you haven't already, you will need to create
a `packages.yml` file in your project and supply the git link from this repository.

You should then copy the adwords package structure from the `dbt_project.yml` in
this repository into your project's `dbt_project.yml` file and replace the `#`
values with the adwords table names from your warehouse.

Please note, because several of the models are based on Adwords "reports" which
have a layer of aggregation occurring, the specific fields you select in your ETL
tool are very important in the output of the data. Selecting additional fields
may cause unexpected fan out that these models will not account for. The 
recommendation is to track only fields in the models listed in the macros.

If your team uses UTM parameters for your campaigns, then you should supply the 
`adapter_value` var "url". This will query data from the `adwords_url_performance` 
model. If your account use gclids or a combination of UTMs and gclids (ie some urls 
with have just the gclid) then you should supply the `adapter_value` var "criteria". 
This will query data from the `adwords_criteria_performance` report.

## Stitch
[Here](https://www.stitchdata.com/docs/integrations/saas/google-adwords#schema) 
is info about Stitch's Adwords connector. 

## Fivetran
[Here](https://fivetran.com/docs/applications/google-ads/setup-guide) 
is info about Fivetran's Adwords connector.

Fivetran does not support the core tables. The core tables are accounts, ad_groups, ads, and campaigns.