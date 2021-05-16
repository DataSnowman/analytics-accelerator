# Azure Machine Learning Workspace ARM Template

## Parameters

| Name | Type | Required | Description |
| :------------- | :----------: | :----------: | :------------- |
| Resource group | string | Yes | The Resource group where the services will be deployed |
| Region | string | Yes | The Azure Region where you want to deploy the services |
| Deployment Tla | string | Yes | The three letter acronym to make the storage account unique when combined with the uniqueString and associated with the workspace|
| Workspace Name | string | No | Specifies the name of the Azure Machine Learning workspace. Prefixed with 'mlws-' and a uniqueString(resourceGroup().id)|
| Location | string | No | Specifies the Location based on the Region selected above |
| Key Vault Name | string | No | The name for the key vault to created and associated with the workspace. Prefixed with 'mlkv-' and a uniqueString(resourceGroup().id)|
| Application Insights Name | string | No | The name for the application insights to created and associated with the workspace. Prefixed with 'mlai-', uniqueString(resourceGroup().id)|

## Outputs

| Name | Type | Description |
| :------------- | :----------: | :------------- |
| workspaceName | string | Specifies the name of the Azure Machine Learning workspace.|
| storageAccountName | string | The name for the storage account to created and associated with the workspace.|
| keyVaultName | string | The name for the key vault to created and associated with the workspace.|
| applicationInsightsName | string | The name for the application insights to created and associated with the workspace.|
| location | string | Specifies the location for all resources.|
