IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'compose_allaccelerjyysgquoryocq_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [compose_allaccelerjyysgquoryocq_dfs_core_windows_net] 
	WITH (
		LOCATION   = 'https://allaccelerjyysgquoryocq.dfs.core.windows.net/compose', 
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
	DATA_SOURCE = [compose_allaccelerjyysgquoryocq_dfs_core_windows_net],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO

SELECT TOP 100 * FROM checkouts_by_title_physical_items
GO

