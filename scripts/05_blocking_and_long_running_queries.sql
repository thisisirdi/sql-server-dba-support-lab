/*
Script: 05_blocking_and_long_running_queries.sql

Purpose
-------
Identify blocking sessions and long-running queries
impacting system performance.
*/

SELECT
    r.session_id,
    r.blocking_session_id,
    r.status,
    r.wait_type,
    r.cpu_time,
    r.total_elapsed_time,
    DB_NAME(r.database_id) AS database_name,
    t.text AS sql_text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.session_id <> @@SPID
ORDER BY r.total_elapsed_time DESC;
GO


/*
Purpose:
    Show blocked sessions and the blocking session responsible.
*/
SELECT
    r.session_id,
    r.blocking_session_id,
    r.status,
    r.wait_type,
    r.wait_time,
    r.cpu_time,
    r.total_elapsed_time,
    DB_NAME(r.database_id) AS database_name,
    t.text AS sql_text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.blocking_session_id <> 0
ORDER BY r.total_elapsed_time DESC;
GO


SELECT
    s.session_id,
    s.login_name,
    s.host_name,
    s.program_name,
    s.status,
    s.cpu_time,
    s.memory_usage,
    s.total_scheduled_time,
    s.total_elapsed_time
FROM sys.dm_exec_sessions s
WHERE s.is_user_process = 1
ORDER BY s.total_elapsed_time DESC;
GO