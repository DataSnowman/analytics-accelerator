# Azure Analytics Accelerator

The following accelerators can be used to deploy an `Azure Synapse Analytics Workspace` and/or an `Azure Machine Learning Workspace` and/or an `Azure Databricks Workspace` into the same Azure Resource Group or separate Azure Resource Groups.  It will allow you to explore some of the AI and Machine Learning, Data Lake, Data Lakehouse, and Data Warehousing capabilities available on Microsoft Azure.  You will also be able to use [Power BI](https://powerbi.microsoft.com/en-us/) to access data from analytic data stores and access deployed Azure Machine Learning custom models for scoring data.

## Purpose

The purpose of this Analytics Accelerator is to help you learn and grow through Hands-on common use cases that show you how to use things like data integration pipelines, Spark notebooks, and SQL Scripts in Azure Synapse Analytics, and/or ADF pipelines, and/or Azure Databricks notebooks, and/or Azure Machine Learning AutoML.

This [GitHub Repository](https://github.com/DataSnowman/analytics-accelerator) along with an Azure Subscription [No Azure Subscription click here](https://azure.microsoft.com/en-us/free/synapse-analytics/) should allow you to accelerate:

* Business Value
* Time-to-insight
* Modernization
* Skilling
* Proof of Concepts
* Architecture choice
* Infrastructure as code for PoC, Dev, Test, Prod

## Common Use Cases

This accelerator provides an examples of common use cases using things like [Seattle Public Library](https://data.seattle.gov/browse?q=Seattle%20Public%20Libraries&sortBy=most_accessed&utf8=%E2%9C%93) public csv datasets (and other datasets), that are captured on ADLS and composed into parquet files, Spark tables, Serverless external tables, and Dedicated SQL pool tables, then consumed using SQL. 

| Deployment | Use Case Name | Use Case Type | Dataset | Description | Code | Instruction Steps |
| :------------- | :----------: | :----------: | :----------: | :----------: | :----------: | :----------: |
| [Azure Synapse Analytics](https://github.com/DataSnowman/analytics-accelerator#deploy-an-azure-synapse-analytics-workspace) | Seattle Public Library | Data Lake / Data Warehouse | [Seattle Public Library](https://data.seattle.gov/browse?q=Seattle%20Public%20Libraries&sortBy=most_accessed&utf8=%E2%9C%93) CSV | Public csv datasets that are captured on ADLS and composed into parquet files, Spark tables, Serverless external tables, and Dedicated SQL pool tables, then consumed using SQL. | [Code](https://github.com/DataSnowman/analytics-accelerator/tree/main/usecases/spl/code) | [Steps](https://github.com/DataSnowman/analytics-accelerator/blob/main/usecases/spl/steps/usecasesteps.md#seattle-public-library-csv-files) |
| [Azure Machine Learning](https://github.com/DataSnowman/analytics-accelerator#deploy-an-azure-machine-learning-workspace) | Car Price | AutoML | UC Irvine Machine Learning Repository | [UCI Automobile Data Set](https://archive.ics.uci.edu/ml/datasets/automobile) | [Code](https://github.com/DataSnowman/analytics-accelerator/tree/main/usecases/carprice/code) | [Steps](https://github.com/DataSnowman/analytics-accelerator/tree/main/usecases/carprice/steps/usecasesteps.md) |
| [Azure Machine Learning](https://github.com/DataSnowman/analytics-accelerator#deploy-an-azure-machine-learning-workspace) | Student Success | AutoML | UC Irvine Machine Learning Repository | [UCI Student Performance Data Set](http://archive.ics.uci.edu/ml/datasets/Student+Performance) | TBD [Code]() | TBD [Steps]() |
| [Azure Databricks](https://github.com/DataSnowman/analytics-accelerator#deploy-an-azure-databricks-workspace) | Covid-19 | Azure Databricks | JHU Covid-19 | TBD | TBD [Code]() | TBD [Steps]() |

## Open EDU Analytics

If you are interest in Education Analytics please check out the GitHub Repository [OpenEduAnalytics](https://github.com/microsoft/OpenEduAnalytics)

Open Education Analytics (OEA) is a fully open-sourced (Creative Commons and MIT) data integration and analytics architecture and reference implementation for the education sector built on Synapse Analytics - with Azure Data Lake Storage as the storage backbone, and Azure Active Directory as providing the role-based access control.

## Azure Analytics Services

This accelerator should allow you more time to focus on hands on keyboard and learn about these Azure Analytics Services:

* [Azure Synapse Analytics](https://github.com/DataSnowman/analytics-accelerator#deploy-an-azure-synapse-analytics-workspace)

* [Azure Machine Learning](https://github.com/DataSnowman/analytics-accelerator#deploy-an-azure-machine-learning-workspace)

* [Azure Databricks](https://github.com/DataSnowman/analytics-accelerator#deploy-an-azure-databricks-workspace)

Use your own data, the [Common Use Cases](https://github.com/DataSnowman/analytics-accelerator#common-use-cases) above, or the Getting Started wizard inside of the workspace is recommended to use sample data if you do not have your own.

## Prerequisites

- Owner to the Azure Subscription being deployed. This is for creation of a separate Analytics Accelerator Resource Group(s) and to delegate roles necessary for this deployment.

## Post Deployment - Important steps required to use this Analytics Accelerator

```***Remember to come back to this link above after the deployment has completed***```

[Synapse Analytics Post Deployment](https://github.com/DataSnowman/analytics-accelerator/blob/main/usecases/spl/steps/postdeploy.md#post-deployment-steps)

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

## Deploy an Azure Databricks Workspace

`Together with Azure Data Lake Storage Gen2, Azure Data Factory, and Azure SQL Database`

[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FDataSnowman%2Fanalytics-accelerator%2Fmain%2Fworkspace%2Fadb-workspace%2Fazuredeploy.json) [![Visualize](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg?sanitize=true)](http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FDataSnowman%2Fanalytics-accelerator%2Fmain%2Fworkspace%2Fadb-workspace%2Fazuredeploy.json)

This template deploys the following:

- Azure Databricks Workspace
- Azure Data Lake Storage Gen2
- Azure Data Factory
- Azure SQL Database
