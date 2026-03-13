# SQL Server Upgrade Runbook

This document describes a structured process for upgrading a SQL Server environment safely.

---

# Upgrade Objectives

Typical reasons for upgrading SQL Server:

- end of support lifecycle
- security updates
- performance improvements
- compatibility with newer applications

---

# Phase 1 – Pre-Upgrade Assessment

Run the following scripts:
scripts/01_environment_inventory.sql
scripts/02_database_health_checks.sql
scripts/09_upgrade_readiness_checklist.sql

Validate:

- SQL Server version and edition
- database compatibility levels
- database states
- recovery models
- service configuration

---

# Phase 2 – Backup Strategy

Before upgrade:

1. Perform full database backups
2. Verify backup integrity
3. Store backup copies securely

Run:
scripts/07_backup_database.sql
scripts/08_restore_validation.sql


Confirm:

- backups complete successfully
- restore verification passes

---

# Phase 3 – Compatibility Checks

Review:

- deprecated features
- application dependencies
- compatibility levels

Potential issues:

- deprecated T-SQL features
- outdated drivers
- unsupported integrations

---

# Phase 4 – Maintenance Window Planning

Define:

- upgrade duration estimate
- rollback strategy
- communication plan

Checklist:

- application downtime approved
- monitoring tools configured
- DBA staff available

---

# Phase 5 – Upgrade Execution

Steps:

1. Stop application connections
2. Perform final backup
3. Execute SQL Server upgrade
4. Verify server services
5. Check database availability

---

# Phase 6 – Post-Upgrade Validation

Verify:

- databases online
- application connectivity
- query performance
- job schedules

Run diagnostics:
scripts/03_performance_diagnostics.sql
scripts/04_index_and_stats_review.sql
scripts/05_blocking_and_long_running_queries.sql


---

# Phase 7 – Performance Review

After upgrade monitor:

- query performance
- wait statistics
- CPU and IO usage

Recommended actions:

- rebuild indexes
- update statistics
- tune queries if needed

---

# Rollback Plan

In case of failure:

1. Restore databases from backup
2. revert application connections
3. re-enable services

Rollback should be tested in staging before production upgrade.

---

# Upgrade Documentation

Record:

- original version
- upgraded version
- start time
- completion time
- issues encountered
- remediation steps