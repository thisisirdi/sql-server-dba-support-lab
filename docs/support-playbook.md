# SQL Server Support Playbook

This document outlines the typical workflow used during SQL Server support engagements.

It provides a structured approach to diagnosing performance issues, configuration problems, and operational risks.

---

# Support Workflow

Typical troubleshooting workflow:

1. Collect environment inventory
2. Review database health
3. Inspect performance metrics
4. Identify blocking or long-running queries
5. Evaluate indexing and statistics
6. Review security configuration
7. Validate backup and restore readiness

---

# Step 1 – Environment Inventory

Run: scripts/01_environment_inventory.sql

Key information collected:

- SQL Server version
- Server edition
- compatibility levels
- database states
- recovery models

Why this matters:

Understanding the environment configuration is critical before troubleshooting or performing upgrades.

---

# Step 2 – Database Health Checks

Run: scripts/02_database_health_checks.sql


This identifies:

- database file sizes
- log file growth
- recovery models
- log space utilization

Common issues:

- log files filling up
- databases stuck in full recovery without log backups

---

# Step 3 – Performance Diagnostics

Run: scripts/03_performance_diagnostics.sql

Review:

- top CPU consuming queries
- wait statistics
- long-running workloads

Typical causes of performance issues:

- missing indexes
- inefficient queries
- resource contention

---

# Step 4 – Index and Statistics Review

Run: scripts/04_index_and_stats_review.sql


Focus on:

- missing index suggestions
- index fragmentation
- outdated statistics

Recommended actions:

- rebuild fragmented indexes
- update statistics
- evaluate missing index recommendations

---

# Step 5 – Blocking and Concurrency

Run: scripts/05_blocking_and_long_running_queries.sql

Identify:

- blocking chains
- stalled sessions
- long running transactions

Typical resolution steps:

- identify root blocking query
- review transaction scope
- optimize query or indexing

---

# Step 6 – Security and Access Review

Run: scripts/06_security_and_audit_checks.sql


Review:

- login inventory
- role memberships
- disabled accounts

Security risks:

- excessive privileges
- orphaned users
- stale accounts

---

# Step 7 – Backup Validation

Run:
scripts/07_backup_database.sql
scripts/08_restore_validation.sql


Verify:

- full backups exist
- backups complete successfully
- restore validation passes

Backup best practices:

- full backups daily
- log backups every 5–15 minutes for critical systems
- periodic restore tests

---

# Step 8 – Upgrade Readiness

Run: scripts/09_upgrade_readiness_checklist.sql


Evaluate:

- compatibility levels
- backup coverage
- SQL Server services
- deprecated features

---

# General DBA Support Checklist

When responding to incidents:

- Verify server health
- Review performance metrics
- Check blocking sessions
- Confirm backup availability
- Document findings

---

# Incident Documentation

During support engagements record:

- problem description
- environment details
- root cause
- remediation actions
- follow-up recommendations