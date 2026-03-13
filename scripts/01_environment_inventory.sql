/*
Script: 01_environment_inventory.sql

Purpose
-------
Collect core SQL Server instance and database metadata.
Used during onboarding, troubleshooting, and upgrade readiness assessments.

Safe to run in production (read-only).
*/

------------------------------------------------------------
-- SQL Server Version Information
------------------------------------------------------------
SELECT @@VERSION AS SqlServerVersion;
GO

------------------------------------------------------------
-- Core Server Properties
-- Useful for documenting environment configuration
------------------------------------------------------------
SELECT
    SERVERPROPERTY('MachineName') AS MachineName,
    SERVERPROPERTY('ServerName') AS ServerName,
    SERVERPROPERTY('Edition') AS Edition,
    SERVERPROPERTY('ProductVersion') AS ProductVersion,
    SERVERPROPERTY('ProductLevel') AS ProductLevel,
    SERVERPROPERTY('EngineEdition') AS EngineEdition;
GO

------------------------------------------------------------
-- Database Inventory
-- Lists state, compatibility level, and recovery models
------------------------------------------------------------
SELECT
    name,
    database_id,
    compatibility_level,
    recovery_model_desc,
    state_desc
FROM sys.databases
ORDER BY name;
GO