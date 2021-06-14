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

### Step 1

Because the Synapse Workspace is using a Managed Virtual Network, the Storage Account requires a Managed Private Endpoint to be created into the Managed Virtual Network.

You can create a Managed private endpoint to your data source from Azure Synapse Studio. Select the Overview tab in Azure portal and select Launch Synapse Studio.

![Step 1a](https://raw.githubusercontent.com/datasnowman/azure-quickstart-templates/master/101-synapse-poc/images/1a.png)

In Azure Synapse Studio, select the Manage tab from the left navigation. Select Managed Virtual Networks and then select + New.

![Step 1b](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-synapse-poc/images/10.png)

Select the data source type. In this case, the target data source is an ADLS Gen2 account. Select Continue.

![Step 1c](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-synapse-poc/images/11.png)

In the next window, enter information about the data source. In this example, we're creating a Managed private endpoint to an ADLS Gen2 account. Enter a Name for the Managed private endpoint. Provide an Azure subscription and a Storage account name. Select Create.

![Step 1d](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-synapse-poc/images/12.png)

After submitting the request, you'll see its status. To verify the successful creation of your Managed private endpoint was created, check its Provisioning State. You may need to wait 1 minute and select Refresh to update the provisioning state. You can see that the Managed private endpoint to the ADLS Gen2 account was successfully created.

You can also see that the Approval State is Pending. The owner of the target resource can approve or deny the private endpoint connection request. If the owner approves the private endpoint connection request, then a private link is established. If denied, then a private link isn't established.

![Step 1e](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-synapse-poc/images/13.png)

Further information can be found:

[Create a Managed private endpoint to your data source](https://docs.microsoft.com/en-us/azure/synapse-analytics/security/how-to-create-managed-private-endpoints)

Step 2 - Create a folder called SeattlePublicLibrary in the capture container on the storage account created in the Deployment in Step 1 and then Download from https://data.seattle.gov/browse?q=Seattle%20Public%20Libraries&sortBy=most_accessed&utf8=%E2%9C%93 and copy the Seattle Public Datasets as csv files into the SeattlePublicLibrary folder in the capture container

Click on the Export button for: 
	- Checkouts by Title at https://data.seattle.gov/Community/Checkouts-by-Title/tmmm-ytt6
	- Library Collection Inventory at https://data.seattle.gov/Community/Library-Collection-Inventory/6vkj-f5xf
	- Integrated Library System ILS Data Dictionary at https://data.seattle.gov/Community/Integrated-Library-System-ILS-Data-Dictionary/pbt3-ytbc
	- Checkouts By Title Physical Items at https://data.seattle.gov/Community/Checkouts-By-Title-Physical-Items-/5src-czff

You can use Microsoft Azure Storage Explorer to do this on you computer or use an Azure VM, or other methods.

Click on the TEXT/CSV button for Seattle Public Libraries at https://data.seattle.gov/dataset/Seattle-Public-Libraries/9a6b-u88b

Step 3 - Open up the storage accout created by the deployment in Step 1 and navigate to Access Control (IAM) and click on + Add and choose Add role assignment
	- Search for Storage Blob Data Contributor
	- Search for your user and click Save

Ideally you would actually add a security group with a name like synapse_WSAdmins to the Storage Blob Data Contributor role and your user would be a member of that security group.  This synapse_WSAdmins would also be a Group in the Access Control in Manage>Security>Access control in the Synapse Workspace

Step 4 - Open up Synapse Studio and navigate to the Data section (right below Home) and click the Linked tab, open the ADLS Gen2 storage and see if the csv files are in the capture container

Step 5 - Import the 4 Spark Notebooks from the Develop section in Synapse Studio.  Import these Notebooks:

	- LoadCheckouts_By_Title__Physical_Items_FromCaptureToParquetComposeWithPySpark.ipynb
	- LoadCheckouts_by_Title_FromCaptureToParquetComposeWithPySpark.ipynb
	- LoadIntegrated_Library_System__ILS__Data_Dictionary_FromCaptureToParquetComposeWithPySpark.ipynb
	- LoadLibrary_Collection_InventoryFromCaptureToParquetComposeWithPySpark.ipynb

Make Sure you pick the 2.4 or 3.0 version depending on which version of the Spark pool you are using (changes in data parsing formats, and comments on Spark SQL throwing an error)

Step 6 - Open up each notebook and find the storage account name "splacceler5lmevhdeon4ym" in the cells of each notebook and replace it with the name of your storage account.  
             The storage account name is in the 1st, 3rd, 7th, and 11th cell of each notebook.  

Step 7 - Run each notebook (with Run all or a cell at a time if you want to learn what is going on) to create parquet files in the compose container in storage and also create Spark tables

Step 8 - Run Select Top 100 rows query on the spark tables

Step 9 - Create External tables on Compose Parquet files to load to SQL Pool

	- Go into the compose container compose in the SeattlePublicLibrary/CheckoutsByTitlePhysicalItems/checkouts.parquet and right click one of the parquet files (I.e. part-00000-f747df7e-a79a-497c-ade0-4d0e0c9692ee-c000.snappy.parquet) and select New SQL script>Create external table.  Select a database or create a new one, provide a table name, and select Using SQL Script. Then click Create.