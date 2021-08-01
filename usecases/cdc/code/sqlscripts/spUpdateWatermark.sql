CREATE PROCEDURE spUpdateWatermark @LastModifiedtime datetime
 		AS

 		BEGIN

 			UPDATE [ControlTableForSourceToSink]
 			SET [WatermarkValue] = @LastModifiedtime 

 		END