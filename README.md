# Azure Analytics Accelerator

The following sections can be used to deploy an Azure Synapse Analytics Workspace and/or an Azure Machine Learning Workspace into the same Azure Resource Group or different Azure Resource Groups.  It will allow you to explore the some of the Data Lake and Datawarehousing capabilities available on Microsoft Azure. 

## Purpose

The purpose of thie Analytics Accellerator is to help you Learn Hands-on how to use data integration pipelines, Spark notebooks, and SQL Scripts in Azure Synaspe Analytics. This accelerator provides an examples using [Seattle Public Library](https://data.seattle.gov/browse?q=Seattle%20Public%20Libraries&sortBy=most_accessed&utf8=%E2%9C%93) public csv datasets, that are captured on ADLS and composed into parquet files, Spark tables, Serverless external tables, and Dedicated SQL pool tables, then consumed using SQL.  This accellerator should allow you more time to focus on hands on keyboard and learn about these Azure services:

* [Azure Synapse Analytics](https://github.com/DataSnowman/analytics-accelerator#deploy-an-azure-synapse-analytics-workspace)

* [Azure Machine Learning](https://github.com/DataSnowman/analytics-accelerator#deploy-an-azure-machine-learning-workspace)

Using the Getting Started wizard inside of the workspace is recommended to use sample data if you do not have your own to the Storage Account.

## Prerequisites

- Owner to the Azure Subscription being deployed. This is for creation of a separate Analytics Accelerator Resource Group(s) and to delegate roles necessary for this deployment.

## Post Deployment - Important steps required to use this Analytics Accelerator

```***Remember to come back to this link above after the deployment has completed***```

[Synapse Analytics Post Deployment](https://github.com/DataSnowman/analytics-accelerator/blob/main/workspace/synapse-workspace/README.md#post-deployment-steps)

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

## Deploy an Azure Databricks Workspace along with Azure Data Factory, and Azure SQL Database

[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FDataSnowman%2Fanalytics-accelerator%2Fmain%2Fworkspace%2Fadb-workspace%2Fazuredeploy.json) [![Visualize](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg?sanitize=true)](http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FDataSnowman%2Fanalytics-accelerator%2Fmain%2Fworkspace%2Fadb-workspace%2Fazuredeploy.json)

This template deploys the following:

- Azure Databricks Workspace
- Storage Account
- Azure SQL Database
- Azure Data Factory