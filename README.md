# SQL Server DBA Support Lab

A practical collection of SQL Server scripts used for:

- Database administration
- Performance diagnostics
- Security auditing
- Backup and restore validation
- Upgrade readiness assessments

This repository demonstrates common operational tasks performed by database administrators and support engineers.

---

# Project Goals

This project showcases real-world SQL Server support workflows including:

• Environment discovery and inventory  
• Database health and configuration checks  
• Performance troubleshooting  
• Index and statistics analysis  
• Security and login audits  
• Backup and restore validation  
• Upgrade readiness preparation  

These scripts are designed to assist DBAs when onboarding new environments or troubleshooting production systems.

---

# Repository Structure
scripts/
  01_environment_inventory.sql
  02_database_health_checks.sql
  03_performance_diagnostics.sql
  04_index_and_stats_review.sql
  05_blocking_and_long_running_queries.sql
  06_security_and_audit_checks.sql
  07_backup_database.sql
  08_restore_validation.sql
  09_upgrade_readiness_checklist.sql
  10_schema_metadata_and_table_dimensions.sql
  11_audit_columns_and_triggers_demo.sql
  12_index_tuning_before_after_demo.sql

screenshots/ 
  backup_success.png
  databse_inventory.png
  missing_indexes.png
  restore_success.png
  restore_verification.png
  security_and_audit.png
  server_properties.png
  top_queries.png
  
docs/ 
  findings-template.md
  support-playbook.md
  upgrade-runbook.md

# Example Use Cases

### SQL Server Upgrade Planning

Run:

1. Environment inventory
2. Database health checks
3. Backup validation
4. Upgrade readiness checklist

This helps identify potential upgrade risks.

---

### Performance Investigation

Use:

- performance diagnostics
- index and statistics review
- blocking queries analysis

to identify bottlenecks.

---

### Security Review

Audit:

- server logins
- database roles
- orphaned users
- permission assignments

---

### Backup and Restore Validation

Scripts demonstrate:

- full backup creation
- backup history review
- restore validation using VERIFYONLY
- inspection of backup file contents

---

# Intended Audience

This repository is useful for:

- Database Administrators
- DevOps Engineers
- Data Engineers
- Technical Support Engineers
- Consultants performing SQL Server health checks

---

# Notes

These scripts are intended for diagnostic and educational purposes.

Always review and adapt scripts before executing in production environments.
