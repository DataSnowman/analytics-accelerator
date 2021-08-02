## Change Data Capture

### Step 1 Create Control Table and Stored Procedure used by Azure Data Factory

Use the following SQL script [ControlTableForSourceToSink.sql](https://github.com/DataSnowman/analytics-accelerator/blob/main/usecases/cdc/code/sqlscripts/ControlTableForSourceToSink.sql) to create the ControlTableForSourceToSink table in the database deployed by the ARM template in the Deploy an Azure Databricks Workspace Azure Analytics Accelerator.

![Step 1 table](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/cdcstep1table.png)

Use the following SQL script [spUpdateWatermark.sql](https://github.com/DataSnowman/analytics-accelerator/blob/main/usecases/cdc/code/sqlscripts/spUpdateWatermark.sql) to create the spUpdateWatermark stored procedure in the database deployed by the ARM template in the Deploy an Azure Databricks Workspace Azure Analytics Accelerator.

![Step 1 sproc](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/cdcstep1sproc.png)

Use the following SQL script [CreateStudent.sql](https://github.com/DataSnowman/analytics-accelerator/blob/main/usecases/cdc/code/sqlscripts/CreateStudent.sql) to create the studentMath table in the database deployed by the ARM template in the Deploy an Azure Databricks Workspace Azure Analytics Accelerator.

![Step 1 student](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/cdcstep1student.png)

### Step 2 Create Azure Data Factory Pipeline from local Template

Download [ADF Template zip](https://github.com/DataSnowman/analytics-accelerator/tree/main/usecases/cdc/code/adfTemplates)

![adftemplatezip](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/adftemplatezip.png)

Open up the ADF deployed by the ARM template in the Deploy an Azure Databricks Workspace Azure Analytics Accelerator.  Select Pipeline from template 

![adfplfromtemplate](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/adfplfromtemplate.png)

Select Use local template

![adfUseLocalTemplate](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/adfUseLocalTemplate.png)

Open local template

![adfOpenLocalTemplate](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/adfOpenLocalTemplate.png)

It should look like this

![adftemplateUserinputs](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/adftemplateUserinputs.png)

Select +New in the first User input and create an Azure SQL Database Linked Service to the database deployed by the ARM template in the Deploy an Azure Databricks Workspace Azure Analytics Accelerator

![adfDatabaseLinkedService](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/adfDatabaseLinkedService.png)

Select +New in the second User input and create an Azure Data Lake Storage Gen2 Linked Service 

![adfAdlsLinkedService](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/adfAdlsLinkedService.png)

For Input 3 select the same Database you chose in Input 1 

For Input 4 select the same Storage input you chose in Input 2

Then click on Use this template

![adfAllUserinputs.png](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/adfAllUserinputs.png)

It should look like this when it is imported

![adfTemplateImported](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/adfTemplateImported.png)

### Step 3 Debug the BulkCopyfromDB_with_ControlTable Pipeline 

Click on Debug, enter the name of the Control table `ControlTableForSourceToSink`
Click OK

![adfDebugPipelineRun](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/adfDebugPipelineRun.png)

Once the pipeline runs successfully it should look like this

![adfSuccessfulRun](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/adfSuccessfulRun.png)

Check that the files have been created in Storage using Azure Storage Explorer of Azure Portal in the browser.  The files should be in bronze container at a path like `CDC/Sales/Microsoft/AdventureWorksLT/SalesLT/Address/`

![adfFileInStorage](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/adfFileInStorage.png)

You can now save the pipline by clickin on Publish all

![adfPublishAll](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/adfPublishAll.png)

### Step 4 Import, configure, and run the Databrick Notebook

TBD