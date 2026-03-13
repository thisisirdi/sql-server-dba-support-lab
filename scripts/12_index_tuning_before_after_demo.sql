IF OBJECT_ID('dbo.PerformanceDemo', 'U') IS NOT NULL
    DROP TABLE dbo.PerformanceDemo;
GO

CREATE TABLE dbo.PerformanceDemo (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME2 NOT NULL,
    Status NVARCHAR(20) NOT NULL,
    TotalAmount DECIMAL(12,2) NOT NULL,
    Notes NVARCHAR(500) NULL
);
GO




SET NOCOUNT ON;

DECLARE @i INT = 1;

WHILE @i <= 50000
BEGIN
    INSERT INTO dbo.PerformanceDemo (CustomerID, OrderDate, Status, TotalAmount, Notes)
    VALUES (
        ABS(CHECKSUM(NEWID())) % 5000 + 1,
        DATEADD(DAY, -1 * (ABS(CHECKSUM(NEWID())) % 365), SYSUTCDATETIME()),
        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 'Open'
            WHEN 1 THEN 'Closed'
            WHEN 2 THEN 'Pending'
            ELSE 'Cancelled'
        END,
        CAST((ABS(CHECKSUM(NEWID())) % 100000) / 100.0 AS DECIMAL(12,2)),
        REPLICATE('X', 100)
    );

    SET @i += 1;
END;
GO



/*
Run before adding index.
Turn on metrics for before/after comparison.
*/
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

SELECT CustomerID, SUM(TotalAmount) AS total_sales
FROM dbo.PerformanceDemo
WHERE Status = 'Closed'
  AND OrderDate >= DATEADD(MONTH, -3, SYSUTCDATETIME())
GROUP BY CustomerID
ORDER BY total_sales DESC;
GO



/*
Run again after index creation and compare logical reads / CPU / elapsed time.
*/
SELECT CustomerID, SUM(TotalAmount) AS total_sales
FROM dbo.PerformanceDemo
WHERE Status = 'Closed'
  AND OrderDate >= DATEADD(MONTH, -3, SYSUTCDATETIME())
GROUP BY CustomerID
ORDER BY total_sales DESC;
GO

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO