/*
Purpose:
    Inspect schema design, data types, nullability, defaults, and identity usage.
    Useful for support cases, migrations, and application troubleshooting.
*/

SELECT
    s.name AS schema_name,
    t.name AS table_name,
    c.column_id,
    c.name AS column_name,
    ty.name AS data_type,
    c.max_length,
    c.precision,
    c.scale,
    c.is_nullable,
    c.is_identity,
    dc.definition AS default_definition
FROM sys.tables t
JOIN sys.schemas s
    ON t.schema_id = s.schema_id
JOIN sys.columns c
    ON t.object_id = c.object_id
JOIN sys.types ty
    ON c.user_type_id = ty.user_type_id
LEFT JOIN sys.default_constraints dc
    ON c.default_object_id = dc.object_id
ORDER BY s.name, t.name, c.column_id;
GO



/*
Purpose:
    Estimate table size and row volume for support and upgrade planning.
*/

SELECT
    s.name AS schema_name,
    t.name AS table_name,
    p.rows AS row_count,
    CAST(ROUND((SUM(a.total_pages) * 8.0) / 1024, 2) AS DECIMAL(18,2)) AS total_space_mb,
    CAST(ROUND((SUM(a.used_pages) * 8.0) / 1024, 2) AS DECIMAL(18,2)) AS used_space_mb,
    CAST(ROUND(((SUM(a.total_pages) - SUM(a.used_pages)) * 8.0) / 1024, 2) AS DECIMAL(18,2)) AS unused_space_mb
FROM sys.tables t
JOIN sys.schemas s
    ON t.schema_id = s.schema_id
JOIN sys.indexes i
    ON t.object_id = i.object_id
JOIN sys.partitions p
    ON i.object_id = p.object_id
   AND i.index_id = p.index_id
JOIN sys.allocation_units a
    ON p.partition_id = a.container_id
WHERE t.is_ms_shipped = 0
GROUP BY s.name, t.name, p.rows
ORDER BY total_space_mb DESC, row_count DESC;
GO



SELECT TOP 20
    s.name AS schema_name,
    t.name AS table_name,
    SUM(p.rows) AS row_count
FROM sys.tables t
JOIN sys.schemas s
    ON t.schema_id = s.schema_id
JOIN sys.partitions p
    ON t.object_id = p.object_id
WHERE p.index_id IN (0,1)
GROUP BY s.name, t.name
ORDER BY row_count DESC;
GO




/*
Purpose:
    Identify tables missing primary keys, which often affects maintenance,
    replication, ORM behavior, and upgrade/migration planning.
*/

SELECT
    s.name AS schema_name,
    t.name AS table_name
FROM sys.tables t
JOIN sys.schemas s
    ON t.schema_id = s.schema_id
LEFT JOIN sys.key_constraints kc
    ON t.object_id = kc.parent_object_id
   AND kc.type = 'PK'
WHERE kc.object_id IS NULL
  AND t.is_ms_shipped = 0
ORDER BY s.name, t.name;
GO