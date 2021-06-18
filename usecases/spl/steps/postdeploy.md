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

### Step 2 Assign your user to Storage Blob Data Contributor role

Open up the storage account created by the deployment and navigate to Access Control (IAM) and click on + Add and choose Add role assignment

![Step 2a](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/2a.png)

`Role` - Search for Storage Blob Data Contributor

`Select` - Search for your user and select it

Click Save

![Step 2b](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/2b.png)

Ideally you would actually add a security group with a name like `synapse_WSAdmins` to the Storage Blob Data Contributor role and your user (and others needing this access) would be a member of that security group.  This `synapse_WSAdmins` would also be a Group in the Access Control in Manage>Security>Access control in the Synapse Workspace