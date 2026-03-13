/*
Script: 04_index_and_stats_review.sql

Purpose
-------
Review missing indexes, fragmentation levels,
and statistics freshness for performance tuning.
*/

------------------------------------------------------------
-- Missing Index Recommendations
------------------------------------------------------------
SELECT TOP 20
    DB_NAME(mid.database_id) AS DatabaseName,
    OBJECT_NAME(mid.object_id, mid.database_id) AS TableName,
    migs.user_seeks,
    migs.avg_total_user_cost,
    migs.avg_user_impact,
    mid.equality_columns,
    mid.inequality_columns,
    mid.included_columns
FROM sys.dm_db_missing_index_group_stats migs
JOIN sys.dm_db_missing_index_groups mig
    ON migs.group_handle = mig.index_group_handle
JOIN sys.dm_db_missing_index_details mid
    ON mig.index_handle = mid.index_handle
ORDER BY migs.avg_user_impact DESC;
GO

------------------------------------------------------------
-- Index Fragmentation Review
------------------------------------------------------------
SELECT
    OBJECT_NAME(ps.object_id) AS TableName,
    i.name AS IndexName,
    ps.index_type_desc,
    ps.avg_fragmentation_in_percent,
    ps.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ps
JOIN sys.indexes i
    ON ps.object_id = i.object_id
   AND ps.index_id = i.index_id
WHERE ps.page_count > 100
ORDER BY ps.avg_fragmentation_in_percent DESC;
GO

/*
Purpose:
    Review statistics freshness, useful in troubleshooting poor estimates.
*/
SELECT
    OBJECT_SCHEMA_NAME(s.object_id) AS schema_name,
    OBJECT_NAME(s.object_id) AS table_name,
    s.name AS stats_name,
    STATS_DATE(s.object_id, s.stats_id) AS last_updated
FROM sys.stats s
WHERE OBJECTPROPERTY(s.object_id, 'IsUserTable') = 1
ORDER BY last_updated ASC;
GO


/*
Purpose:
    Compare index usage patterns to identify unused or low-value indexes.
*/
SELECT
    OBJECT_SCHEMA_NAME(i.object_id) AS schema_name,
    OBJECT_NAME(i.object_id) AS table_name,
    i.name AS index_name,
    i.type_desc,
    ISNULL(us.user_seeks, 0) AS user_seeks,
    ISNULL(us.user_scans, 0) AS user_scans,
    ISNULL(us.user_lookups, 0) AS user_lookups,
    ISNULL(us.user_updates, 0) AS user_updates
FROM sys.indexes i
LEFT JOIN sys.dm_db_index_usage_stats us
    ON i.object_id = us.object_id
   AND i.index_id = us.index_id
   AND us.database_id = DB_ID()
WHERE OBJECTPROPERTY(i.object_id, 'IsUserTable') = 1
  AND i.index_id > 0
ORDER BY user_updates DESC, user_seeks ASC;
GO