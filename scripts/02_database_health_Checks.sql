/*
Script: 02_database_health_checks.sql

Purpose
-------
Basic database health checks used during support and upgrade planning.

Includes:
• Database file sizes
• Recovery models
• Log utilization
*/

------------------------------------------------------------
-- Database Files and Sizes
------------------------------------------------------------
SELECT
    d.name AS DatabaseName,
    d.state_desc,
    d.recovery_model_desc,
    mf.name AS LogicalFileName,
    mf.type_desc,
    mf.size * 8 / 1024 AS SizeMB
FROM sys.databases d
JOIN sys.master_files mf
    ON d.database_id = mf.database_id
ORDER BY d.name, mf.type_desc;
GO

------------------------------------------------------------
-- Transaction Log Usage
-- Helps identify potential log growth issues
------------------------------------------------------------
DBCC SQLPERF(LOGSPACE);
GO