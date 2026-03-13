/*
Script: 08_restore_validation.sql

Purpose
-------
Validate backup files before performing restores.
*/

------------------------------------------------------------
-- Validate Backup Integrity
------------------------------------------------------------
RESTORE VERIFYONLY
FROM DISK = 'C:\SQLBackups\AWAC_full_backup.bak';
GO


/*
Next step after VERIFYONLY:
1. Inspect logical file names with FILELISTONLY
2. Use MOVE clauses when restoring to a different path/server
3. Validate row counts and application connectivity post-restore
*/

------------------------------------------------------------
-- Inspect Backup Contents
------------------------------------------------------------
RESTORE FILELISTONLY
FROM DISK = 'C:\SQLBackups\AWAC_full_backup.bak';
GO


/*
Template restore command - update logical names and physical paths first.
*/
RESTORE DATABASE GSK_RestoreTest
FROM DISK = 'C:\SQLBackups\GSK_full_backup.bak'
WITH
    MOVE 'GSK' TO 'C:\SQLData\GSK_RestoreTest.mdf',
    MOVE 'GSK_log' TO 'C:\SQLLogs\GSK_RestoreTest_log.ldf',
    REPLACE,
    RECOVERY,
    STATS = 10;
GO


RESTORE FILELISTONLY
FROM DISK = 'C:\SQLBackups\AWAC_full_backup.bak';
GO