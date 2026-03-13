# SQL Server Findings Report Template

This document is used to record observations, risks, and recommendations during a SQL Server health check, upgrade assessment, or troubleshooting engagement.

---

# Engagement Overview

| Field | Value |
|------|------|
| Client | |
| Environment | Production / Staging / Development |
| SQL Server Version | |
| Edition | |
| Assessment Date | |
| Assessed By | |

---

# Environment Summary

## Server Information

| Property | Value |
|--------|------|
| Server Name | |
| Machine Name | |
| SQL Server Version | |
| Edition | |
| Product Level | |
| Engine Edition | |

---

# Database Inventory

| Database | Compatibility Level | Recovery Model | Status |
|---------|---------------------|---------------|-------|
| | | | |

Observations:

- List any unusual configuration
- Highlight deprecated compatibility levels
- Note offline or suspect databases

---

# Backup Strategy Review

| Database | Last Full Backup | Last Log Backup | Backup Status |
|----------|-----------------|----------------|---------------|
| | | | |

Observations:

- Are backups running regularly?
- Are backups stored securely?
- Is restore validation tested?

Risks:

- Missing backups
- Large backup windows
- Unverified restore processes

---

# Performance Diagnostics

## Expensive Queries

| Query | CPU Usage | Duration | Logical Reads |
|------|----------|----------|---------------|
| | | | |

Observations:

- Identify high CPU or IO queries
- Check if indexes support workload patterns

---

# Index Analysis

| Table | Index | Fragmentation | Page Count |
|------|------|---------------|------------|
| | | | |

Observations:

- High fragmentation indexes
- Missing index recommendations
- Unused indexes

---

# Security Review

| Login | Type | Status |
|------|------|-------|
| | | |

Observations:

- Disabled accounts
- Excessive privileges
- Orphaned users

---

# Blocking / Concurrency Issues

| Session ID | Blocking Session | Wait Type | Query |
|-----------|-----------------|-----------|------|
| | | | |

Observations:

- Long running queries
- Blocking chains

---

# Upgrade Readiness Assessment

Checklist:

- SQL Server version identified
- Database compatibility levels reviewed
- Deprecated features reviewed
- Backup verified
- Maintenance window identified

Upgrade Risk Level:

Low / Medium / High

---

# Recommendations

| Priority | Recommendation |
|---------|---------------|
| High | |
| Medium | |
| Low | |

---

# Next Steps

1. Address critical findings
2. Schedule maintenance window
3. Validate upgrade path
4. Test restore in staging
5. Perform upgrade

---

# Notes

Additional comments and observations.