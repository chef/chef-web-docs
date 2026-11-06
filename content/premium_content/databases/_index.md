+++
title = "Databases"
aliases = ["/solutions/compliance/databases/"]

[menu.premium_content]
  identifier = "premium_content/databases"
  parent = "premium_content"
  title = "Databases"
  weight = 30
+++

Chef Premium Content has current coverage for **17 databases benchmarks**,
with every audit version and remediation version currently available.
See [benchmark coverage](/premium_content/#benchmark-coverage) for how audit and
remediation coverage are tracked, and the
[Compliance solution overview](/solutions/compliance/) for what each does.

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS MariaDB 10.6` | 1.0.0 | — | Audit Only |
| `CIS Microsoft SQL Server 2016` | 1.3.0, 1.4.0 | 1.1.0, 1.3.0 | Partial Audit + Remediation |
| `CIS Microsoft SQL Server 2017` | 1.2.0, 1.3.0 | 1.2.0 | Partial Audit + Remediation |
| `CIS Microsoft SQL Server 2019` | 1.2.0 | 1.2.0 | Audit + Remediation |
| `CIS Microsoft SQL Server 2022` | 1.1.0, 1.3.0 | — | Audit Only |
| `CIS MongoDB 3.6` | 1.0.0, 1.1.0 | 1.0.0, 1.1.0 | Audit + Remediation |
| `CIS Oracle Database 12c` | 3.0.0 | 2.1.0, 3.0.0 | Partial Audit + Remediation |
| `CIS Oracle Database 18c` | 1.0.0 | 1.0.0 | Audit + Remediation |
| `CIS Oracle Database 19c` | 1.0.0, 2.0.0 | 1.0.0 | Partial Audit + Remediation |
| `CIS Oracle Database 23ai` | 1.0.0 | — | Audit Only |
| `CIS Oracle MySQL 5.7` | 2.0.0 | — | Audit Only |
| `CIS PostgreSQL 10` | — | 1.0.0 | Remediation Only |
| `CIS PostgreSQL 11` | 1.0.0 | 1.0.0 | Audit + Remediation |
| `CIS PostgreSQL 16` | 1.0.0 | 1.0.0 | Audit + Remediation |
| `CIS PostgreSQL 17` | 1.0.0 | 1.0.0 | Audit + Remediation |
| `STIG MarkLogic Server` | not stated | not stated | Audit + Remediation |
| `STIG PostgreSQL 9.x` | 2 | — | Audit Only |

For what each coverage term means, see
[how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables).

## Inspect database configuration directly

Most database benchmarks above rely on Chef InSpec core resources,
such as `mssql_session`, `oracledb_session`, `postgres_session`, and `mysql_session`.
You can use those same resources to write controls for requirements
that no prebuilt benchmark covers.

Chef InSpec also provides two database resource packs:

- [MongoDB resource pack](/inspec/resource_packs/mongodb/) ---
  inspect MongoDB configuration and query a running instance
- [Elasticsearch resource pack](/inspec/resource_packs/elasticsearch/) ---
  inspect Elasticsearch configuration

Chef doesn't publish a prebuilt compliance benchmark for Elasticsearch.
The resource pack is for authoring your own checks,
and doesn't indicate Elasticsearch benchmark coverage.

A resource pack isn't a benchmark and doesn't assess anything on its own.
It provides the resources you use to write your own controls.

## Related

- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [Compliance audit](/solutions/compliance/#compliance-audit)
- [Compliance remediation](/solutions/compliance/#compliance-remediation)
- [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
