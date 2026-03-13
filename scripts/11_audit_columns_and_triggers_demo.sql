/*
Purpose:
    Demonstrate a common support-friendly audit pattern using
    CreatedAt and ModifiedAt timestamps.
*/

IF OBJECT_ID('dbo.SupportAuditDemo', 'U') IS NOT NULL
    DROP TABLE dbo.SupportAuditDemo;
GO

CREATE TABLE dbo.SupportAuditDemo (
    DemoID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    Status NVARCHAR(50) NOT NULL,
    CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_SupportAuditDemo_CreatedAt DEFAULT SYSUTCDATETIME(),
    ModifiedAt DATETIME2 NOT NULL CONSTRAINT DF_SupportAuditDemo_ModifiedAt DEFAULT SYSUTCDATETIME()
);
GO




/*
Purpose:
    Automatically update ModifiedAt whenever a row changes.
*/

CREATE OR ALTER TRIGGER dbo.trg_SupportAuditDemo_ModifiedAt
ON dbo.SupportAuditDemo
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE d
    SET ModifiedAt = SYSUTCDATETIME()
    FROM dbo.SupportAuditDemo d
    INNER JOIN inserted i
        ON d.DemoID = i.DemoID;
END;
GO



INSERT INTO dbo.SupportAuditDemo (CustomerName, Status)
VALUES
('Acme Corp', 'Open'),
('Northwind', 'Pending');
GO

UPDATE dbo.SupportAuditDemo
SET Status = 'Closed'
WHERE DemoID = 1;
GO

SELECT *
FROM dbo.SupportAuditDemo;
GO