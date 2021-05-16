# Azure Machine Learning Workspace ARM Template

## Parameters

| Name | Type | Required | Description |
| :------------- | :----------: | :----------: | :------------- |
| deploymentTla | string | Yes | The three letter acronym to make the storage account unique when combined with the uniqueString and associated with the workspace.|
| workspaceName | string | No | Specifies the name of the Azure Machine Learning workspace. Prefixed with 'mlws-' and a uniqueString(resourceGroup().id)|
| keyVaultName | string | No | The name for the key vault to created and associated with the workspace. Prefixed with 'mlkv-' and a uniqueString(resourceGroup().id)|
| applicationInsightsName | string | No | The name for the application insights to created and associated with the workspace. Prefixed with 'mlai-', uniqueString(resourceGroup().id)|
| location | string | No | Specifies the location for all resources.|

## Outputs

| Name | Type | Description |
| :------------- | :----------: | :------------- |
| workspaceName | string | Specifies the name of the Azure Machine Learning workspace.|
| storageAccountName | string | The name for the storage account to created and associated with the workspace.|
| keyVaultName | string | The name for the key vault to created and associated with the workspace.|
| applicationInsightsName | string | The name for the application insights to created and associated with the workspace.|
| location | string | Specifies the location for all resources.|
