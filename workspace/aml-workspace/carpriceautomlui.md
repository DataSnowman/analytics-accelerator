# Welcome to a hands-on exercise using the **Azure Machine Learning service** to author a model using the **Automated machine learning UI**


## Create an AutoML Experiment

1. Open the Azure Machine Learning workspace by clicking on it in the Azure portal

![openworkspace](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/openworkspace.png)

2.	Click on Automated machine learning under the Authoring section and then click on + New Automated ML run

![openautoml](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/openautoml.png)

3.	Click on + Create dataset and select From local files

![createds](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/createds.png)

4. Enter a Name: carprice, Dataset type: Tabular, and a description of your choice and click Next

![dsname](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/dsname.png)

5. Select or create a datastore: workspaceblobstore and Upload files (navigate to the carprice.csv file [Here](https://github.com/DataSnowman/analytics-accelerator/blob/main/usecases/carprice/dataset/carprice.csv)in this repo)
Click Next

![upload](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/upload.png)

6. Preview the dataset and click Next

![previewds](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/previewds.png)

7. Make sure that price is of type Integer (Mine was seen a String and I had to change it to Integer) and click Next

![priceint](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/priceint.png)

8. Click Create

![createbtn](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/createbtn.png)

9. Select the carprice dataset and click Next

![configrun](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/configrun.png)

10. Click on Create a new compute or (select a compute cluster you already have and jump to [step ?]()

![createnewcomp](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/createnewcomp.png)

11. Go with the default for compute as in image (or close to) and click Next

![defaultcomp](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/defaultcomp.png)

12. Compute name: automl and Max number of nodes: 4 and click Create.  It will take a few minutes to create the compute cluster

![automl4](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/automl4.png)

#### 13. You Configuration is now complete
        Click Next
![configcomplete](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/configcomplete.png)


![createexp](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/createexp.png)

4.	Enter an Experiment name and click on Create a new compute

![expname](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/expname.png)

5.	Enter a Compute name, Select virtual machine size, set Minimum number of nodes to 0, set Maximum number of nodes to 6, and click Create

![createcompute](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/createcompute.png)

This may take a couple minutes

![createnewcompute](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/createnewcompute.png)

6.	Select a training compute and chose the new compute created above.  Click ``Next``

![amlnext](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/amlnext.png)

7.	Click on Upload to upload the carprice.csv you downloaded in the prerequisites. Or get it from the path where you cloned this GitHub repo.

![uploaddataset](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/uploaddataset.png)

8.	Select carprice.csv

![selectcarprice](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/selectcarprice.png)

9.	Preview the data.  You may need to have at least 1 node runnin on on ML compute to see the preview.

![previewdata](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/previewdata.png)

10.	Ignore the SYMBOLING and NORMALIZED-LOSSES columns (features) by clicking on the Included/Ignored slider

![ignore](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/ignore.png)

11.	Chose Regression for the prediction task and price for Target column.
12.	Click ``Start``

![start](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/start.png)

13.	Let it run to finish to complete the experiment.  Do this the first time ahead of the demo to have a completed experiment.

## Review the AutoML Experiment

Once the AutoML experiment completes 

1.	Click on the Run ID of the completed experiment

![runid](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/runid.png)

2.	View the Iteration Chart and view some of the point on the graph

![ichart](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/ichart.png)

3.	Scroll down to the Iterations and talk about the models and their Spearman Correlation

![spearman](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/spearman.png)

4.	Click on VotingEnsemble and look at the graph Predicted vs. True

![predvtrue](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/predvtrue.png)

## Deploy AutoML Experiment carprice model

1.	Scroll down and click on Deploy Model VotingEnsemble

![voting](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/voting.png)

2. Deploy Model, enter a Deployment name and click the Deploy button.

``Note that if you click the Deploy button it is going to take 20 minutes to deploy the model.  You will also have to delete the deployment, so you are not charged on Azure to continue to run the compute in an Azure Container Instance (ACI)``

![deploymodel](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/deploymodel.png)

3. To see how the deployment is proceeding click on Images in the Assets section of the AML service workspace to see the image.  The status will be Running until the image is created and then it will change to Succeeded

![deployedmage](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/deployedmage.png)

4. Once the image creation succeeds, to see how the deployment is proceeding click on Deployments in the Assets section of the AML service workspace to see the deployment.  

![deployment](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/deployment.png)

5. After you are finished with the deployment you can delete the ACI deployment by clicking the box in front of the deployment and click on Delete.  ``Note that you will only want to do this after the Power BI part is completed``

![deletedeployment](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/deletedeployment.png)

6.	Consume the ACI web service in Power BI by clicking [here](https://github.com/Azure/carprice/tree/master/powerbi)



