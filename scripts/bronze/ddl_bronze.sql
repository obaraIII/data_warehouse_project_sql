USE [Data_Warehouse]
GO
/****** Object:  StoredProcedure [bronze].[load_bronze]    Script Date: 26/01/2026 13:46:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER   PROCEDURE [bronze].[load_bronze] AS
BEGIN
DECLARE @start_time DATETIME, @end_time DATETIME, @bronze_start_time DATETIME, @bronze_end_time DATETIME;
	BEGIN TRY
		PRINT '============================================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '============================================================================';
	
		PRINT '----------------------------------------------------------------------------';
		PRINT 'Loading CRM Tables'
		PRINT '----------------------------------------------------------------------------';
		
		SET @bronze_start_time = GETDATE();
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Bulk Inserting Into: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\DataWarehouse Project\data_warehouse_project_sql\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		--SELECT * FROM bronze.crm_cust_info;
		--SELECT COUNT(*) FROM bronze.crm_cust_info;
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '----------------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: [bronze].[crm_prd_info]'
		TRUNCATE TABLE [bronze].[crm_prd_info];
	
		PRINT '>> Bulk Inserting Into: [bronze].[crm_prd_info]'
		BULK INSERT [bronze].[crm_prd_info]
		FROM 'C:\DataWarehouse Project\data_warehouse_project_sql\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
	
		--SELECT * FROM [bronze].[crm_prd_info];
		--SELECT COUNT(*) FROM [bronze].[crm_prd_info];
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '----------------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: [bronze].[crm_sales_details]'
		TRUNCATE TABLE [bronze].[crm_sales_details];
	
		PRINT '>> Bulk Inserting Into: [bronze].[crm_sales_details]'
		BULK INSERT [bronze].[crm_sales_details]
		FROM 'C:\DataWarehouse Project\data_warehouse_project_sql\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
	
		--SELECT * FROM [bronze].[crm_sales_details];
		--SELECT COUNT(*) FROM [bronze].[crm_sales_details];
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '----------------------------------------------------------------------------';


		PRINT '----------------------------------------------------------------------------';
		PRINT 'Loading ERP Tables'
		PRINT '----------------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: [bronze].[erp_cust_az12]'
		TRUNCATE TABLE [bronze].[erp_cust_az12];

		PRINT '>> Bulk Inserting Into: [bronze].[erp_cust_az12]'
		BULK INSERT [bronze].[erp_cust_az12]
		FROM 'C:\DataWarehouse Project\data_warehouse_project_sql\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
	
		--SELECT * FROM [bronze].[erp_cust_az12];
		--SELECT COUNT(*) FROM [bronze].[erp_cust_az12];
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '----------------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: [bronze].[erp_loc_a101]'
		TRUNCATE TABLE [bronze].[erp_loc_a101];

		PRINT '>> Bulk Inserting Into: [bronze].[erp_loc_a101]'
		BULK INSERT [bronze].[erp_loc_a101]
		FROM 'C:\DataWarehouse Project\data_warehouse_project_sql\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
	
		--SELECT * FROM [bronze].[erp_loc_a101];
		--SELECT COUNT(*) FROM [bronze].[erp_loc_a101];
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '----------------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: [bronze].[erp_px_cat_g1v2]'
		TRUNCATE TABLE [bronze].[erp_px_cat_g1v2];

		PRINT '>> Bulk Inserting Into: [bronze].[erp_px_cat_g1v2]'
		BULK INSERT [bronze].[erp_px_cat_g1v2]
		FROM 'C:\DataWarehouse Project\data_warehouse_project_sql\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
	
		--SELECT * FROM [bronze].[erp_px_cat_g1v2];
		--SELECT COUNT(*) FROM [bronze].[erp_px_cat_g1v2];
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>';

		SET @bronze_end_time = GETDATE();
		PRINT 'Loading Bronze Layer is completed';
		PRINT 'Total Loading Duration: ' + CAST(DATEDIFF(second,@bronze_start_time,@bronze_end_time) AS NVARCHAR) + ' seconds';
		PRINT '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>';

	END TRY
	BEGIN CATCH
	PRINT '============================================================================';
	PRINT 'Error occured during loading Bronze Layer';
	PRINT 'Error Message' + ERROR_MESSAGE();
	PRINT 'Error Number' + CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error State' + CAST(ERROR_STATE() AS NVARCHAR);
	PRINT '============================================================================';
	END CATCH
END
