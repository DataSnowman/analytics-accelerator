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
FROM 'https://allaccelerjyysgquoryocq.dfs.core.windows.net/compose/SeattlePublicLibrary/CheckoutsByTitlePhysicalItems/checkouts.parquet/*.snappy.parquet'
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