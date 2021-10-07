## Azure Purview Data Governance

### Step 1 If you don't have Azure resources to scan in Purview [Deploy CDC Accelerator](https://github.com/DataSnowman/analytics-accelerator#deploy-an-azure-databricks-workspace) 

`To get a SQL Server database to scan you can deploy the Change Data Capture Accelerator to deploy ADLS, Azure Databricks, ADF, and Azure SQL Database`

### Step 2 Scan a Azure SQL Database

Follow the steps in [Register and scan an Azure SQL Database](https://docs.microsoft.com/en-us/azure/purview/register-scan-azure-sql-database)

### Step 3 Scan a Azure Data Lake Storage

If you would like to scan some data in ADLS and you deployed the Change Data Capture Accelerator in Step 1 above then use the CDC use case [Steps](https://github.com/DataSnowman/analytics-accelerator/blob/main/usecases/cdc/steps/usecasesteps.md) to create some content in ADLS

Then follow the steps in [Register and scan Azure Data Lake Storage Gen2](https://docs.microsoft.com/en-us/azure/purview/register-scan-adls-gen2)