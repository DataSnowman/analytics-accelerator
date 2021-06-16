## Azure Synapse Analytics Workspace ARM Template

## Parameters

| Name | Type | Required | Description |
| :------------- | :----------: | :----------: | :------------- |
| Resource group | string | Yes | The Resource group where the services will be deployed |
| Region | string | Yes | The Azure Region where you want to deploy the services |
| _artifacts Location | string | Yes | Template Link URI |
| _artifacts Location SAS Token | string | No | Template Location SAS Token |
| Location | string | No | Specifies the Location based on the Region selected above |
| Deployment Tla | string | Yes | The three letter acronym to make the storage account and other services unique when combined with the uniqueString and associated with the workspace|
| Allow All Connections | string | Yes | True or False |
| Spark Deployment | string | Yes | True or False |
| Spark Node Size | string | Yes | Small, Medium, Large |
| Deployment Type | string | Yes | devtest, acceler, prod, shared |
| Sql Administrator Login | string | Yes | The username of the SQL Administrator | 
| Sql Administrator Login Password | string | Yes | The password for the SQL Administrator |
| Sku | string | Yes | Select the SKU of the SQL pool |
| Metadata Sync | sting | Yes | True or False to choose whether you want to synchronise metadata |
| Frequency | string | Yes | Choose whether to run schedule every day of the week, or only on weekdays |
| Time Zone | string | Yes | Time Zone for the schedule |
| Resume Time | string | Yes | Time of Day when the data warehouse will be resumed |
| Pause Time | string | Yes | Time of day when the data warehouse will be paused |