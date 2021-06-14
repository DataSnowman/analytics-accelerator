# Azure Analytics Accelerator

The following sections can be used to deploy an Azure Synapse Analytics Workspace and/or an Azure Machine Learning Workspace into the same Azure Resource Group or different Azure Resource Groups.

## Purpose

This template allows the Administrator to deploy an Analytics Accelerator environment of Azure Synapse Analytics with some pre-set parameters and Azure Machine Learning. This allows more time to focus on hands on keyboard and learn about these Azure services.

Using the Getting Started wizard inside of the workspace is recommended to use sample data if you do not have your own to the Storage Account.

## Prerequisites

- Owner to the Azure Subscription being deployed. This is for creation of a separate Analytics Accelerator Resource Group(s) and to delegate roles necessary for this deployment.

## Deploy an Azure Synapse Analytics Workspace

This template deploys necessary resources to run an Azure Synapse Analytics Workspace.

[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FDataSnowman%2Fanalytics-accelerator%2Fmain%2Fworkspace%2Fsynapse-workspace%2Fazuredeploy.json) [![Visualize](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg?sanitize=true)](http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FDataSnowman%2Fanalytics-accelerator%2Fmain%2Fworkspace%2Fsynapse-workspace%2Fazuredeploy.json)

This template deploys the following:

- An Azure Synapse Workspace
  - (OPTIONAL) Allows All connections in by default (Firewall IP Addresses)
  - Allows Azure Services to access the workspace by default
  - Managed Virtual Network is Enabled
- An Azure Synapse SQL Pool
- (OPTIONAL) Apache Spark Pool
  - Auto-paused set to 15 minutes of idling
- Azure Data Lake Storage Gen2 account
  - Azure Synapse Workspace identity given Storage Blob Data Contributor to the Storage Account
    - A new File System inside the Storage Account to be used by Azure Synapse
- A Logic App to Pause the SQL Pool at defined schedule
  - The Logic App will check for Active Queries. If there are active queries, it will wait 5 minutes and check again until there are none before pausing
- A Logic App to Resume the SQL Pool at defined schedule
- Both Logic App managed identities are given Contributor rights to the Resource Group
- Grants the Workspace identity CONTROL to all SQL pools and SQL on-demand pool

## Post Deployment

[Synapse Analytics Post Deployment](https://github.com/DataSnowman/analytics-accelerator/blob/main/workspace/synapse-workspace/README.md#postdeploymentsteps)

## Deploy an Azure Machine Learning Workspace

This template deploys necessary resources to run an Azure Machine Learning Workspace.

[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FDataSnowman%2Fanalytics-accelerator%2Fmain%2Fworkspace%2Faml-workspace%2Fazuredeploy.json)
[![Deploy To Azure US Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FDataSnowman%2Fanalytics-accelerator%2Fmain%2Fworkspace%2Faml-workspace%2Fazuredeploy.json)
[![Visualize](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg?sanitize=true)](http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FDataSnowman%2Fanalytics-accelerator%2Fmain%2Fworkspace%2Faml-workspace%2Fazuredeploy.json)

This template deploys the following:

- Azure Machine Learning Workspace
- Encrypted Storage Account
- KeyVault
- Applications Insights

