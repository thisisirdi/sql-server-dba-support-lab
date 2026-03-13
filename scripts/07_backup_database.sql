/*
Script: 07_backup_database.sql

Purpose
-------
Perform a full database backup and review backup history.
*/

------------------------------------------------------------
-- Full Backup
------------------------------------------------------------
BACKUP DATABASE AWAC
TO DISK = 'C:\SQLBackups\AWAC_full_backup.bak'
WITH INIT, COMPRESSION, CHECKSUM, STATS = 10;
GO

------------------------------------------------------------
-- Backup History
------------------------------------------------------------
SELECT TOP 20
    bs.database_name,
    bs.backup_start_date,
    bs.backup_finish_date,
    bs.type,
    bs.backup_size / 1024 / 1024 AS backup_size_mb,
    bmf.physical_device_name
FROM msdb.dbo.backupset bs
JOIN msdb.dbo.backupmediafamily bmf
    ON bs.media_set_id = bmf.media_set_id
ORDER BY bs.backup_finish_date DESC;
GO





DECLARE @DatabaseName SYSNAME = 'GSK';
DECLARE @BackupPath NVARCHAR(4000) = 'C:\SQLBackups\' + @DatabaseName + '_full_backup.bak';

DECLARE @sql NVARCHAR(MAX) = '
BACKUP DATABASE ' + QUOTENAME(@DatabaseName) + '
TO DISK = ''' + @BackupPath + '''
WITH INIT, COMPRESSION, CHECKSUM, STATS = 10;
';

PRINT @sql;
EXEC sp_executesql @sql;
GO




SELECT
    name,
    recovery_model_desc
FROM sys.databases
WHERE name = 'GSK';
GO