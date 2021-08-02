## Change Data Capture

### Step 1 Create Control Table and Stored Procedure used by Azure Data Factory

Use the following SQL script [ControlTableForSourceToSink.sql](https://github.com/DataSnowman/analytics-accelerator/blob/main/usecases/cdc/code/sqlscripts/ControlTableForSourceToSink.sql) to create the ControlTableForSourceToSink table in the database deployed by the ARM template in the Deploy an Azure Databricks Workspace Azure Analytics Accelerator.

![Step 1 table](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/cdcstep1table.png)

Use the following SQL script [spUpdateWatermark.sql](https://github.com/DataSnowman/analytics-accelerator/blob/main/usecases/cdc/code/sqlscripts/spUpdateWatermark.sql) to create the spUpdateWatermark stored procedure in the database deployed by the ARM template in the Deploy an Azure Databricks Workspace Azure Analytics Accelerator.

![Step 1 sproc](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/cdcstep1sproc.png)

Use the following SQL script [CreateStudent.sql](https://github.com/DataSnowman/analytics-accelerator/blob/main/usecases/cdc/code/sqlscripts/CreateStudent.sql) to create the studentMath table in the database deployed by the ARM template in the Deploy an Azure Databricks Workspace Azure Analytics Accelerator.

![Step 1 student](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/cdcstep1student.png)

### Step 2 Create Azure Data Factory Pipeline from Template



![Step 3d](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3d.png)

Select `Built-in copy task` and click Next

![adfplfromtemplate](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/adfplfromtemplate.png)

Source type - Select HTTP and click + Create new connection

![Step 3f](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/3f.png)

`Name` - HttpServerSPL
`Base URL` - https://data.seattle.gov/api/views/
`Authentication type` - Anonymous





### Step 4 Monitor if file(s) have copied into storage account

Open up Synapse Studio and navigate to the Data section (right below Home) and click the Linked tab, open the ADLS Gen2 storage and see if the csv files are in the capture container.  You will see the file beginning to copy

![Step 4a](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/4a.png)

### Step 5 Import the 4 Spark Notebooks from the Develop section in Synapse Studio.  

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

Navigate to where you have the downloaded the notebooks [Or Find Here](https://github.com/DataSnowman/analytics-accelerator/tree/main/usecases/spl/code/notebooks), select them, and click open

![Step 5b](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/5b.png)

The Notebook should look something like this when attached to Spark Pool `Synasp1`

![Step 5c](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/5c.png)

### Step 6 Open up each notebook and edit and publish 

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

### Step 7 Run each notebook

Run with Run all or a cell at a time if you want to learn what is going on) to create parquet files in the compose container in storage and also create Spark tables

Click `Run all` or run the notebook a cell at a time to understand what it is doing

![Step 7a](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/7a.png)

In general the notebook reads the csv file from capture container into a dataframe with a defined schema, transforms some columns, writes the file out as a parquet files in the compose container, and then creates a Spark table from the parquet files.

### Step 8 Run Select Top 100 rows query on the spark table(s)

Once all the cells in the notebook have successfully run you should have a new Spark database called `seattlepubliclibrary` and a spark table called `checkouts_by_title_physical_items` that can be queried using SQL Serverless

![Step 8a](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/8a.png)

### Step 9 Create External tables on Compose Parquet files to Query with Synapse Serverless

1. Go into the compose container compose in the SeattlePublicLibrary/CheckoutsByTitlePhysicalItems/checkouts.parquet

2. Right click one of the parquet files (I.e. part-00000-3a372d93-5f94-48f8-995d-5e8abfdfb654-c000.snappy.parquet) and select New SQL script>Create external table

![Step 9a](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/9a.png)

3. Select a database or create a new one, provide a table name, and select Using SQL Script. Then click Create.

![Step 9b](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/9b.png)

This will create a script that looks like this:

![Step 9c](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/9c.png)

[Here](https://github.com/DataSnowman/analytics-accelerator/blob/main/usecases/spl/code/sqlscripts/ServerlessExternalcheckouts_by_title_physical_items.sql) is the script with a wild card to access all the parquet files

```
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
```

Remember to use a * wildcard in the LOCATION so the table is made on all of the files and not just one.  It looks like this:

Replace part-00000-3a372d93-5f94-48f8-995d-5e8abfdfb654-c000.snappy.parquet with part-*.snappy.parquet so it looks like this:

LOCATION = 'SeattlePublicLibrary/CheckoutsByTitlePhysicalItems/checkouts.parquet/part-*.snappy.parquet',

### Step 10 Load the Parquet files to an external table in the dedicated SQL Pool

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

[Here](https://github.com/DataSnowman/analytics-accelerator/blob/main/usecases/spl/code/sqlscripts/DedicatedSQLcheckouts_by_title_physical_items_dp.sql) is the script with a wild card to access all the parquet files:

```
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
```

Remember to use a * wildcard in the LOCATION so the table is made on all of the files and not just one.  It looks like this:

Replace 

FROM 'https://allaccelerjyysgquoryocq.dfs.core.windows.net//compose/SeattlePublicLibrary/CheckoutsByTitlePhysicalItems/checkouts.parquet/part-00000-3a372d93-5f94-48f8-995d-5e8abfdfb654-c000.snappy.parquet'

so it looks like this:

FROM 'https://allaccelerjyysgquoryocq.dfs.core.windows.net/compose/SeattlePublicLibrary/CheckoutsByTitlePhysicalItems/checkouts.parquet/*.snappy.parquet'

Please note that the Bulk load script generator might create an extra / between the storage account and the container

allaccelerjyysgquoryocq.dfs.core.windows.net`//`compose/SeattlePublicLibrary/

Remove one so it only has one `/` 

allaccelerjyysgquoryocq.dfs.core.windows.net`/`compose/SeattlePublicLibrary/