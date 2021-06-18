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

10. Click on Create a new compute or (select a compute cluster you already have and jump to [step 13](https://github.com/DataSnowman/analytics-accelerator/blob/main/workspace/aml-workspace/carpriceautomlui.md#13-you-configuration-is-now-complete)

![createnewcomp](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/createnewcomp.png)

11. Go with the default for compute as in image (or close to) and click Next

![defaultcomp](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/defaultcomp.png)

12. Compute name: automl and Max number of nodes: 4 and click Create.  It will take a few minutes to create the compute cluster

![automl4](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/automl4.png)

#### 13. You Configuration is now complete
        Click Next
![configcomplete](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/configcomplete.png)

14. Select Regression and click Finish

![regress](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/regress.png)

15.	Let it run to finish to complete the experiment.  

## Review the AutoML Experiment

Once the AutoML experiment completes (could take about 25 minutes)

1.	Click on the Run ID of the completed experiment

![runid](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/runid.png)

2. This takes you tho the run details.  Click on Models tab

![rundetails](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/rundetails.png)

3.	Click on View explanation

![models](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/models.png)

4.	Click on one of the explanation IDs

![explan](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/explan.png)

## Deploy AutoML Experiment carprice model

1.	Click on Deploy on the run page and then give the deployment a Name: carprice and Compute type: Azure Container Instance and click Deploy

![deploy](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/deploy.png)

2. To see how the deployment is proceeding click on Endpoints in the Assets section of the AML service workspace to see the endpoint.  The deployment status will be transitioning until the endpoint is created and then it will change to Healthy

![endpoint](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/endpoint.png)

![endpointdtl](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/endpointdtl.png)

3. The Container instance will be deployed into the resource group  

![aci](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/aci.png)

4. The deployment status will change to Healthy

![healthy](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/healthy.png)

5.	Consume the ACI web service in Power BI by clicking [here](https://github.com/Azure/carprice/tree/master/powerbi)



