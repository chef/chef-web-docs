+++
title = "Databases"

[menu.overview]
  identifier = "overview/solutions/compliance/databases"
  parent = "overview/solutions/compliance"
  title = "Databases"
  weight = 30
+++

Current audit and remediation coverage for databases benchmarks in Chef Compliance.
This category has **16 benchmarks** with current coverage.

| Benchmark | Audit Versions | Remediation Versions | Coverage |
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
| `OTHER Microsoft SQL Server 2016` | — | v1.1.0† | Remediation Only |
| `STIG PostgreSQL 9.x` | v2 | — | Audit Only |

_A dagger (&dagger;) on a remediation version means Inferred Current: the customer-shipping
remediation tree is confirmed by an SME, but version-level release evidence wasn't found.
Inferred Current doesn't mean unsupported._

Audit and remediation coverage are tracked as independent dimensions. A benchmark may offer
more audit versions than remediation versions, or the reverse.

## Related

- [Compliance solution overview](/solutions/compliance/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
