# Welcome to a hands-on exercise using **AI insights** in Power BI Desktop to predict car price


## Power BI Desktop

1. Go to https://powerbi.microsoft.com/en-us/desktop/ to download Power BI Desktop

2. Install Power BI Desktop

Note if you dont have a Windows PC you can also do this using Power BI Dataflows in PowerBI.com.  Click [here](https://github.com/DataSnowman/analytics-accelerator/blob/main/usecases/carprice/steps/carpricepowerbidf.md) and login to Power BI.

3.	Download or clone the repo and open this [Power BI report](https://github.com/DataSnowman/analytics-accelerator/tree/main/usecases/carprice/powerbi) 

![gitpbicarprice](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/gitpbicarprice.png)

The report should look like this

![carpriceanalysis](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/carpriceanalysis.png)

4.	Click on Transform data> and select Data source settings

![dssettings](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/dssettings.png)

5.	Click on Change source

![changesource](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/changesource.png)

6.	Change the path to where you have the carprice dataset [Here in Git](https://github.com/DataSnowman/analytics-accelerator/tree/main/usecases/carprice/dataset) Click Ok and Close

![path](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/path.png)

7.	Click on Transform data> and select Transform data

![dssettings](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/dssettings.png)

8. Click on Azure Machine Learning in AI Insights in the top right corner.  It might ask you to authenticate so enter your Azure AD credentials (same you long into Power BI with)

![aiinsights](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/aiinsights.png)

9. Click on the Auto ML model you deployed in Azure Machine Learning, look at the parameters and click OK 

![customaml](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/customaml.png)

10.	You might have an error since you can't access my model, but if you named it the same you might see the predicted value twice.  You can remove the Applied AzureML.carprics (second one or the first one if it is causing a error) in the APPLIED STEPS on the bottom right.

![inference](https://raw.githubusercontent.com/DataSnowman/analytics-accelerator/main/images/inference.png)

11. Click Close & Apply

