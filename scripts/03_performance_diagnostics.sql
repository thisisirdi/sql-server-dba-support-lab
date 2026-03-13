/*
Script: 03_performance_diagnostics.sql

Purpose
-------
Identify expensive queries currently or historically executed
on the SQL Server instance.

Uses Dynamic Management Views (DMVs).
*/

------------------------------------------------------------
-- Top Queries by CPU Consumption
------------------------------------------------------------
SELECT TOP 10
    qs.execution_count,
    qs.total_worker_time / 1000 AS total_cpu_ms,
    qs.total_elapsed_time / 1000 AS total_duration_ms,
    qs.total_logical_reads,
    qs.total_logical_writes,
    SUBSTRING(st.text,
        (qs.statement_start_offset/2) + 1,
        ((CASE qs.statement_end_offset
            WHEN -1 THEN DATALENGTH(st.text)
            ELSE qs.statement_end_offset
        END - qs.statement_start_offset)/2) + 1
    ) AS query_text
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
ORDER BY qs.total_worker_time DESC;
GO

------------------------------------------------------------
-- Wait Statistics Overview
------------------------------------------------------------
SELECT TOP 20
    wait_type,
    waiting_tasks_count,
    wait_time_ms
FROM sys.dm_os_wait_stats
WHERE wait_type NOT LIKE 'SLEEP%'
ORDER BY wait_time_ms DESC;
GO