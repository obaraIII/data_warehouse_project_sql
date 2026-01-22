/*
============================================================================
Create Databse and Schemas
============================================================================
Script Purpose:
	This script creates a new databse naemd 'Data_Warehouse' after checking if it exists.
	If the database exists, it is dropped and recreated. Additionally, three schemas (bronze, silver,gold) are created within the database.

WARNING:
	Running this script will drop the entire 'Data_Warehouse' database if it exists.
	All data in the database will be permanently deleted. Proceed with caution and ensure proper data backups before running this script.
	*/

USE master;
GO

--Drop and recreate 'Data_Warehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Data_Warehouse')
BEGIN
	ALTER DATABASE Data_Warehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Data_Warehouse;
END;
GO
--Create Data_Warehouse Database
CREATE DATABASE Data_Warehouse;
GO

USE Data_Warehouse;
GO
--Create Schemas: bronze, silver and gold
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
