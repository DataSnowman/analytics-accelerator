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


## Post Deployment Steps

### Step 1 Setup Managed Private Endpoint

Because the Synapse Workspace is using a Managed Virtual Network, the Storage Account requires a Managed Private Endpoint to be created into the Managed Virtual Network.

You can create a Managed private endpoint to your data source from Azure Synapse Studio. Select the Overview tab in Azure portal and select Open Synapse Studio.

![Step 1a](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/1a.png)

In Azure Synapse Studio, select the Manage tab from the left navigation. Select Managed Virtual Networks and then select + New.

![Step 1b](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/1b.png)

Select the data source type. In this case, the target data source is an Azure Data Lake Storage Gen2 account. Select Continue.

![Step 1c](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/1c.png)

In the next window, enter information about the data source. In this example, we're creating a Managed private endpoint to an ADLS Gen2 account. Enter a Name for the Managed private endpoint (i.e. `AzureDataLakeStorageMpe1`). Provide an Azure subscription and the Storage account name created in the deployment. Select Create.

![Step 1d](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/1d.png)

After submitting the request, you'll see its status. To verify the successful creation of your Managed private endpoint was created, check its Provisioning State. You may need to wait 1 minute and select Refresh to update the provisioning state. You can see that the Managed private endpoint to the ADLS Gen2 account was successfully created.

You can also see that the Approval State is Pending.

![Step 1e](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/1e.png)

The owner of the target resource can approve or deny the private endpoint connection request. If the owner approves the private endpoint connection request, then a private link is established. If denied, then a private link isn't established.

To Approve the managed private endpoint search for Private Link in the Azure Portal and click on Pending connections, and then the connection and select Approve.  

![Step 1f](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/1f.png)

After a few minutes the Approval state in Synapse Mangaged private endpoints will change from Pending to Approved

![Step 1g](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/1g.png)

Further information can be found: [Create a Managed private endpoint to your data source](https://docs.microsoft.com/en-us/azure/synapse-analytics/security/how-to-create-managed-private-endpoints)

### Step 2 - Assign your user to Storage Blob Data Contributor role

Open up the storage account created by the deployment and navigate to Access Control (IAM) and click on + Add and choose Add role assignment

![Step 2a](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/2a.png)

`Role` - Search for Storage Blob Data Contributor

`Select` - Search for your user and select it

Click Save

![Step 2b](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/2b.png)

Ideally you would actually add a security group with a name like `synapse_WSAdmins` to the Storage Blob Data Contributor role and your user (and others needing this access) would be a member of that security group.  This `synapse_WSAdmins` would also be a Group in the Access Control in Manage>Security>Access control in the Synapse Workspace

### Step 3 - Create a folder in the capture container and download/copy files

`Note - You don't need to copy them all.  Maybe Checkouts_by_Title.csv which is 7.7 GB should be your choice to try this out.  Also pick the option that works best for you.`

Create a folder called `SeattlePublicLibrary` in the capture container on the storage account created in the deployment

![Step 3a](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3a.png)

Download the Seattle Public Library datasets from [https://data.seattle.gov/](https://data.seattle.gov/browse?q=Seattle%20Public%20Libraries&sortBy=most_accessed&utf8=%E2%9C%93) and copy the Seattle Public Datasets as csv files into the SeattlePublicLibrary folder in the capture container.

Click on the Export button for these files:

#### Table of Sources

| Name | File | Download URL | Size (as of 6/2021) |
| :------------- | :----------: | :----------: | :------------- |
| [Checkouts by Title](https://data.seattle.gov/Community/Checkouts-by-Title/tmmm-ytt6) | Checkouts_by_Title.csv | https://data.seattle.gov/api/views/tmmm-ytt6/rows.csv?accessType=DOWNLOAD | 7.7 GB |
| [Checkouts By Title Physical Items](https://data.seattle.gov/Community/Checkouts-By-Title-Physical-Items-/5src-czff) | Checkouts_By_Title__Physical_Items_.csv | https://data.seattle.gov/api/views/5src-czff/rows.csv?accessType=DOWNLOAD | 25.2 GB |
| [Library Collection Inventory](https://data.seattle.gov/Community/Library-Collection-Inventory/6vkj-f5xf) | Library_Collection_Inventory.csv | https://data.seattle.gov/api/views/6vkj-f5xf/rows.csv?accessType=DOWNLOAD | 18.5 GB|
| [Integrated Library System ILS Data Dictionary](https://data.seattle.gov/Community/Integrated-Library-System-ILS-Data-Dictionary/pbt3-ytbc) | Integrated_Library_System__ILS__Data_Dictionary.csv | https://data.seattle.gov/api/views/pbt3-ytbc/rows.csv?accessType=DOWNLOAD | 40.9 KB |


`Decision Point`

This download/copy can be done in at least 3 different options:

#### Option 1 - Slowest

Download to your laptop and then copy to Azure Storage account using something like [Microsoft Azure Storage Explorer](https://azure.microsoft.com/en-us/features/storage-explorer/)

![Step 3b](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3b.png)

Or the Data Linked Storage accounts in Azure Synapse Analytics Studio.  

![Step 3c](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3c.png)

`Note the files are pretty large so this would be the slowest option`

#### Option 2 - Speed things up using an Azure WIndows Server VM

You can install [Microsoft Azure Storage Explorer](https://azure.microsoft.com/en-us/features/storage-explorer/) on an Azure Windows Server VM, or use [AzCopy](https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10).  The advantage of this option is that you could have faster network access from an Azure VM for the download and if the VM is in the same region as your Synapse deployment the copy to the Storage account using Microsoft Azure Storage Explorer will be faster.
`Note that Microsoft Azure Storage Explorer uses AzCopy but provides a GUI interface vs using the Azure CLI`

#### Option 3 - Learn how to use a Synapse Copy Data tool to move the files with HTTP connection in a Copy Activity

`Note this option would be best when you want to connect the Copy activity to a Notebook activity (and other things like a Data flow) later to make a more realistic pipeline that could be scheduled`

In the Synapse Studio click on the Integrate section and click the + and choose `Copy Data tool`

![Step 3d](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3d.png)

Select `Built-in copy task` and click Next

![Step 3e](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3e.png)

Source type - Select HTTP and click + Create new connection

![Step 3f](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3f.png)

`Name` - HttpServerSPL
`Base URL` - https://data.seattle.gov/api/views/
`Authentication type` - Anonymous

Click Create

![Step 3g](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3g.png)

Select `More` link next to Connection failed and then click on 
`Edit interactive authoring` link

![Step 3h](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3h.png)

Choose the `Enable` radio button to enable Interactive authoring and click Apply

![Step 3i](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3i.png)

Once Interactive authoring enabled green click Next

![Step 3j](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3j.png)

Add the rest of the Relitive URL from the Download URL column in the [Table of Sources](https://github.com/DataSnowman/analytics-accelerator/blob/main/workspace/synapse-workspace/README.md#table-of-sources) table (i.e. `tmmm-ytt6/rows.csv?accessType=DOWNLOAD`)

`Request method` - GET

Click Next

![Step 3k](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3k.png)

Select `First row has header`

![Step 3l](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3l.png)

Select `Preview data` and then x to close

![Step 3m](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3m.png)

Click Next

Select `Target type` Azure Data Lake Storage Gen2 and click + Create new connection

![Step 3n](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3n.png)

`Name` - AzureDataLakeStorageSPLcapture
`Authentication method` - Account key (or your choose Auth method)
`Azure subscription` - Choose you subscription
`Storage account name` - Choose the storage account deployed by the Analytics Accelerator

Test connection and click Create

![Step 3o](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3o.png)

Enter of Browse to the 
`Folder path` capture/SeattlePublicLibrary
`File name` - Checkouts_by_Title.csv

Click Next

![Step 3p](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3p.png)

Select Add header to file and click Next

![Step 3q](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3q.png)

Change the `Task name` to CopyPipeline_spl (or something similar) and click Next

![Step 3r](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3r.png)

Click Next

![Step 3s](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3s.png)

Click Finish

![Step 3t](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3t.png)

Click on Monitor to see the Copy pipeline running

![Step 3u](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3u.png)

Click on the name of the pipeline to view the progress

![Step 3v](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3v.png)

Click on the glasses symbol to see details

![Step 3w](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3w.png)

### Step 4 - Monitor if file(s) have copied into storage account

Open up Synapse Studio and navigate to the Data section (right below Home) and click the Linked tab, open the ADLS Gen2 storage and see if the csv files are in the capture container.  You will see the file beginning to copy

![Step 4a](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/4a.png)

### Step 5 - Import the 4 Spark Notebooks from the Develop section in Synapse Studio.  

Import these Notebooks from this [GitHub Repo](https://github.com/DataSnowman/analytics-accelerator/tree/main/code/notebooks)

Make Sure you pick the 2.4 or 3.0 version depending on which version of the Spark pool you are using (changes in data parsing formats, and comments on Spark SQL throwing an error).  Choose appropriately depending if your chose a Spark 2.4 version pool or Spark 3.0 version pool.

[Spark 2.4 Notebooks](https://github.com/DataSnowman/analytics-accelerator/tree/main/code/notebooks/Spark2dot4Notebooks)

1. LoadCheckouts_By_Title__Physical_Items_FromCaptureToParquetComposeWithPySpark2.ipynb
2. LoadCheckouts_by_Title_FromCaptureToParquetComposeWithPySpark2.ipynb
3. LoadIntegrated_Library_System__ILS__Data_Dictionary_FromCaptureToParquetComposeWithPySpark2.ipynb
4. LoadLibrary_Collection_InventoryFromCaptureToParquetComposeWithPySpark2.ipynb


[Spark 3.0 Notebooks](https://github.com/DataSnowman/analytics-accelerator/tree/main/code/notebooks/Spark3dot0Notebooks)

1. LoadCheckouts_By_Title__Physical_Items_FromCaptureToParquetComposeWithPySpark3.ipynb
2. LoadCheckouts_by_Title_FromCaptureToParquetComposeWithPySpark3.ipynb
3. LoadIntegrated_Library_System__ILS__Data_Dictionary_FromCaptureToParquetComposeWithPySpark3.ipynb
4. LoadLibrary_Collection_InventoryFromCaptureToParquetComposeWithPySpark3.ipynb

To import the notebooks into Synapse in the Develop Section and click on + and choose `Import`

![Step 5a](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/5a.png)

Navigate to where you have the notebooks, select them, and click open

![Step 5b](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/5b.png)

The Notebook should look something like this when attached to Spark Pool `Synasp1`

![Step 5c](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/5c.png)

### Step 6 - Open up each notebook and edit and publish 

Find the storage account name `spkaccelerjqvse6bhhchxi` in the cells of each notebook and replace it with the name of your storage account deployed by this Analytics Accelerator

`Note: The storage account name is in the 1st, 3rd, 7th, and 11th cell of each notebook`

Update the storage account in all of the cells necessary by searching in the browser for `spkaccelerjqvse6bhhchxi` and replacing with the name of your deployed storage account name.  In my case `allaccelerjyysgquoryocq`

Cell 1

![Step 6a](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/6a.png)

Becomes

![Step 6b](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/6b.png)

Cell 3

![Step 6c](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/6c.png)

Becomes

![Step 6d](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/6d.png)

Cell 7

![Step 6e](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/6e.png)

Becomes

![Step 6f](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/6f.png)

Cell 11

![Step 6g](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/6g.png)

Becomes

![Step 6h](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/6h.png)

Publish all the changes to the Notebook

Click on `Publish all`

![Step 6i](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/6i.png)

Click `Publish`

![Step 6j](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/6j.png)

### Step 7 - Run each notebook

Run with Run all or a cell at a time if you want to learn what is going on) to create parquet files in the compose container in storage and also create Spark tables

Click `Run all` or run the notebook a cell at a time to understand what it is doing

![Step 7a](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/7a.png)

In general the notebook reads the csv file from capture container into a dataframe with a defined schema, transforms some columns, writes the file out as a parquet files in the compose container, and then creates a Spark table from the parquet files.

### Step 8 - Run Select Top 100 rows query on the spark table(s)

Once all the cells in the notebook have successfully run you should have a new Spark database called `seattlepubliclibrary` and a spark table called `checkouts_by_title_physical_items` that can be queried using SQL Serverless

![Step 8a](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/8a.png)

### Step 9 - Create External tables on Compose Parquet files to Query with Synapse Serverless

1. Go into the compose container compose in the SeattlePublicLibrary/CheckoutsByTitlePhysicalItems/checkouts.parquet

2. Right click one of the parquet files (I.e. part-00000-3a372d93-5f94-48f8-995d-5e8abfdfb654-c000.snappy.parquet) and select New SQL script>Create external table

![Step 9a](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/9a.png)

3. Select a database or create a new one, provide a table name, and select Using SQL Script. Then click Create.

![Step 9b](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/9b.png)

This will create a script that looks like this:

![Step 9c](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/9c.png)

Here is the script with a wild card to access all the parquet files

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'compose_spkaccelerjqvse6bhhchxi_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [compose_spkaccelerjqvse6bhhchxi_dfs_core_windows_net] 
	WITH (
		LOCATION   = 'https://spkaccelerjqvse6bhhchxi.dfs.core.windows.net/compose', 
	)
Go

CREATE EXTERNAL TABLE checkouts_by_title_physical_items (
	[id] varchar(8000),
	[checkout_year] int,
	[bib_number] int,
	[item_barcode] varchar(8000),
	[item_type] varchar(8000),
	[collection] varchar(8000),
	[call_number] varchar(8000),
	[item_title] varchar(8000),
	[subjects] varchar(8000),
	[checkout_date_time] datetime2(7),
	[load_date] datetime2(7)
	)
	WITH (
	LOCATION = 'SeattlePublicLibrary/CheckoutsByTitlePhysicalItems/checkouts.parquet/part-*.snappy.parquet',
	DATA_SOURCE = [compose_spkaccelerjqvse6bhhchxi_dfs_core_windows_net],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO

SELECT TOP 100 * FROM checkouts_by_title_physical_items
GO

Remember to use a * wildcard in the LOCATION so the table is made on all of the files and not just one.  It looks like this:

Replace part-00000-3a372d93-5f94-48f8-995d-5e8abfdfb654-c000.snappy.parquet with part-*.snappy.parquet so it looks like this:

LOCATION = 'SeattlePublicLibrary/CheckoutsByTitlePhysicalItems/checkouts.parquet/part-*.snappy.parquet',

### Step 10 - Load the Parquet files to an external table in the dedicated SQL Pool

`Note: Make sure that the Dedicated SQL Pool is running and not paused`

1. Go into the compose container compose in the SeattlePublicLibrary/CheckoutsByTitlePhysicalItems/checkouts.parquet

2. Right click one of the parquet files (I.e. part-00000-3a372d93-5f94-48f8-995d-5e8abfdfb654-c000.snappy.parquet) and select New SQL script>Bulk load

![Step 9a](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/9a.png)

3. Select 

`File type` - Parquet
`Compression` - snappy
`Max string length` - 4000 (or something less) 
`Max errors` - 100 (or lower or higher)

Click Continue

![Step 9d](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/9b.png)

Fill in the Bulk load fields

`Select target table` - Create new
`New target table` - dbo.checkouts_by_title_physical_items_dp - Heap

Click Open script

![Step 9e](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/9e.png)

This will create a script that looks like this:

![Step 9f](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/9f.png)

Here is the script with a wild card to access all the parquet files

IF NOT EXISTS (SELECT * FROM sys.objects O JOIN sys.schemas S ON O.schema_id = S.schema_id WHERE O.NAME = 'checkouts_by_title_physical_items_dp' AND O.TYPE = 'U' AND S.NAME = 'dbo')
CREATE TABLE dbo.checkouts_by_title_physical_items_dp
	(
	 [id] nvarchar(4000),
	 [checkout_year] int,
	 [bib_number] int,
	 [item_barcode] nvarchar(4000),
	 [item_type] nvarchar(4000),
	 [collection] nvarchar(4000),
	 [call_number] nvarchar(4000),
	 [item_title] nvarchar(4000),
	 [subjects] nvarchar(4000),
	 [checkout_date_time] datetime2(7),
	 [load_date] datetime2(7)
	)
WITH
	(
	DISTRIBUTION = ROUND_ROBIN,
	 HEAP
	 -- CLUSTERED COLUMNSTORE INDEX
	)
GO

--Uncomment the 4 lines below to create a stored procedure for data pipeline orchestration​
--CREATE PROC bulk_load_checkouts_by_title_physical_items_dp
--AS
--BEGIN
COPY INTO dbo.checkouts_by_title_physical_items_dp
(id 1, checkout_year 2, bib_number 3, item_barcode 4, item_type 5, collection 6, call_number 7, item_title 8, subjects 9, checkout_date_time 10, load_date 11)
FROM 'https://allaccelerjyysgquoryocq.dfs.core.windows.net//compose/SeattlePublicLibrary/CheckoutsByTitlePhysicalItems/checkouts.parquet/part-00000-3a372d93-5f94-48f8-995d-5e8abfdfb654-c000.snappy.parquet'
WITH
(
	FILE_TYPE = 'PARQUET'
	,MAXERRORS = 100
	,COMPRESSION = 'snappy'
	,IDENTITY_INSERT = 'OFF'
)
--END
GO

SELECT TOP 100 * FROM dbo.checkouts_by_title_physical_items_dp
GO

Remember to use a * wildcard in the LOCATION so the table is made on all of the files and not just one.  It looks like this:

Replace 

FROM 'https://allaccelerjyysgquoryocq.dfs.core.windows.net//compose/SeattlePublicLibrary/CheckoutsByTitlePhysicalItems/checkouts.parquet/part-00000-3a372d93-5f94-48f8-995d-5e8abfdfb654-c000.snappy.parquet'

so it looks like this:

FROM 'https://allaccelerjyysgquoryocq.dfs.core.windows.net/compose/SeattlePublicLibrary/CheckoutsByTitlePhysicalItems/checkouts.parquet/*.snappy.parquet'

Please note that the Bulk load script generator might create an extra / between the storage account and the container

allaccelerjyysgquoryocq.dfs.core.windows.net`//`compose/SeattlePublicLibrary/

Remove one so it only has one `/` 

allaccelerjyysgquoryocq.dfs.core.windows.net`/`compose/SeattlePublicLibrary/