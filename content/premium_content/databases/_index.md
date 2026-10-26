+++
title = "Databases"
aliases = ["/solutions/compliance/databases/"]

[menu.premium_content]
  identifier = "premium_content/databases"
  parent = "premium_content/benchmark_coverage"
  title = "Databases"
  weight = 30
+++

Chef Premium Content has current coverage for **15 databases benchmarks**.
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
| `CIS PostgreSQL 17` | v1.0.0 | — | Audit Only |
| `STIG PostgreSQL 9.x` | v2 | — | Audit Only |

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
- [Build custom compliance checks with Chef InSpec](/solutions/compliance/extend/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
