/*
Script: 09_upgrade_readiness_checklist.sql

Purpose
-------
Collect environment information needed before performing
a SQL Server upgrade.
*/

------------------------------------------------------------
-- SQL Server Services
------------------------------------------------------------
SELECT
    servicename,
    status_desc,
    startup_type_desc
FROM sys.dm_server_services
ORDER BY servicename; 

GO

------------------------------------------------------------
-- Last Backup by Database
------------------------------------------------------------
SELECT
    d.name AS database_name,
    MAX(bs.backup_finish_date) AS last_backup
FROM sys.databases d
LEFT JOIN msdb.dbo.backupset bs
    ON d.name = bs.database_name
GROUP BY d.name
ORDER BY last_backup ASC;
GO