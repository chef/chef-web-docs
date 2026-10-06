+++
title = "Databases"

[menu.overview]
  identifier = "overview/solutions/compliance/databases"
  parent = "overview/solutions/compliance"
  title = "Databases"
  weight = 30
+++

Chef Compliance has current coverage for **16 databases benchmarks**.
Each benchmark below lists every audit version and every remediation version
currently available.

Chef tracks audit and remediation coverage as independent dimensions,
so a benchmark may have audit coverage, remediation coverage, or both.
Where both exist, the available versions can differ ---
an audit version doesn't imply a matching remediation version.

For what audit and remediation each do, see the
[Compliance solution overview](/solutions/compliance/).

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS MariaDB 10.6` | v1.0.0 | — | Audit Only |
| `CIS Microsoft SQL Server 2016` | v1.3.0, v1.4.0 | v1.3.0 | Partial Audit + Remediation |
| `CIS Microsoft SQL Server 2017` | v1.2.0, v1.3.0 | v1.2.0 | Partial Audit + Remediation |
| `CIS Microsoft SQL Server 2019` | v1.1.0, v1.2.0, v1.5.2 | v1.1.0, v1.2.0 | Partial Audit + Remediation |
| `CIS Microsoft SQL Server 2022` | v1.1.0, v1.3.0 | — | Audit Only |
| `CIS MongoDB 3.6` | v1.1.0 | v1.0.0, v1.1.0 | Partial Audit + Remediation |
| `CIS Oracle Database 12c` | v3.0.0 | v2.1.0 | Audit Ahead |
| `CIS Oracle Database 19c` | v1.0.0, v2.0.0 | — | Audit Only |
| `CIS Oracle Database 23ai` | v1.0.0 | — | Audit Only |
| `CIS Oracle MySQL 5.7` | v2.0.0 | — | Audit Only |
| `CIS PostgreSQL 10` | — | v1.0.0 | Remediation Only |
| `CIS PostgreSQL 11` | v1.0.0 | v1.0.0 | Audit + Remediation |
| `CIS PostgreSQL 16` | v1.0.0 | v1.0.0 | Audit + Remediation |
| `CIS PostgreSQL 17` | v1.0.0 | v1.0.0† | Audit + Remediation |
| `Microsoft SQL Server 2016` | — | v1.1.0† | Remediation Only |
| `STIG PostgreSQL 9.x` | v2 | — | Audit Only |

A dagger (†) on a remediation version means the version is **Inferred Current**:
it's part of Chef's current remediation content, but version-level release evidence wasn't found.
Inferred Current doesn't mean unsupported.

Some entries have no framework prefix.
Those benchmarks aren't published by Chef under a named framework, so no framework is shown
rather than one being inferred.

For what each coverage term means, see
[how to read the coverage tables](/solutions/compliance/#how-to-read-the-coverage-tables).

## Related

- [Compliance solution overview](/solutions/compliance/)
- [Compliance audit](/solutions/compliance/#compliance-audit)
- [Compliance remediation](/solutions/compliance/#compliance-remediation)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
