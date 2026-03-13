/*
Script: 06_security_and_audit_checks.sql

Purpose
-------
Review server logins and database role memberships
for security auditing and troubleshooting.
*/

------------------------------------------------------------
-- Server Logins
------------------------------------------------------------
SELECT
    name,
    type_desc,
    is_disabled,
    create_date,
    modify_date
FROM sys.server_principals
WHERE type IN ('S','U','G')
ORDER BY name;
GO

------------------------------------------------------------
-- Database Role Memberships
------------------------------------------------------------
SELECT
    rp.name AS DatabaseRole,
    mp.name AS MemberName
FROM sys.database_role_members drm
JOIN sys.database_principals rp
    ON drm.role_principal_id = rp.principal_id
JOIN sys.database_principals mp
    ON drm.member_principal_id = mp.principal_id
ORDER BY rp.name;
GO

/*
Purpose:
    Review privileged server-level role memberships.
*/
SELECT
    r.name AS server_role,
    m.name AS member_name
FROM sys.server_role_members srm
JOIN sys.server_principals r
    ON srm.role_principal_id = r.principal_id
JOIN sys.server_principals m
    ON srm.member_principal_id = m.principal_id
ORDER BY r.name, m.name;
GO



/*
Purpose:
    Find potential orphaned users after restore/migration.
*/
SELECT
    dp.name AS database_user,
    dp.type_desc
FROM sys.database_principals dp
LEFT JOIN sys.server_principals sp
    ON dp.sid = sp.sid
WHERE dp.type IN ('S','U','G')
  AND dp.principal_id > 4
  AND sp.sid IS NULL
ORDER BY dp.name;
GO