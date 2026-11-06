+++
title = "Microsoft SQL Server"

[menu.premium_content]
  identifier = "premium_content/databases/microsoft_sql_server"
  parent = "premium_content/databases"
  title = "Microsoft SQL Server"
  weight = 30
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) for Microsoft SQL Server define secure configuration requirements for SQL Server 2016 through 2022, for both the database engine and Amazon RDS.
Chef Premium Content provides these requirements as Chef InSpec audit profiles and remediation content, and coverage differs by benchmark and version, so check the following version table.

## What the benchmarks check

The requirements cover the following areas in the SQL Server 2022 database engine benchmark at v1.3.0:

- **Installation and updates:** Cumulative and security updates, and single-function servers
- **Surface area:** Server configuration options, the `Trustworthy` property, and the `sa` account
- **Authentication and authorization:** Authentication mode, contained databases, and service accounts
- **Password policies:** `MUST_CHANGE`, `CHECK_EXPIRATION`, and `CHECK_POLICY` for SQL logins
- **Auditing and logging:** Error log retention, the default trace, and login auditing
- **Application development:** User input and CLR assembly permission sets
- **Encryption:** Symmetric and asymmetric key strength
- **Other settings:** The SQL Server Browser service

The exact requirements differ by benchmark and version.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Microsoft SQL Server 2016` | v1.3.0, v1.4.0 | v1.1.0, v1.3.0 | Partial Audit + Remediation |
| `CIS Microsoft SQL Server 2017` | v1.2.0, v1.3.0 | v1.2.0 | Partial Audit + Remediation |
| `CIS Microsoft SQL Server 2019` | v1.2.0 | v1.2.0 | Audit + Remediation |
| `CIS Microsoft SQL Server 2022` | v1.1.0, v1.3.0 | --- | Audit Only |

Audit and remediation coverage are tracked separately.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables)
for what each coverage term means.

## Available profiles

Each benchmark version ships as Chef InSpec profiles covering the applicable
combinations of CIS profile level and deployment target:

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |
| Scope | `databaseengine`, `awsrds` |

Profile names follow a consistent pattern, so you can predict the name you need:

```text
cis-microsoftsql<year>-<level>-<scope>-v<benchmark-version>
```

For example, the CIS Level 1 Database Engine profile for SQL Server 2022 at benchmark
v1.3.0 is `cis-microsoftsql2022-level1-databaseengine-v1.3.0`.

Note that the platform token is `microsoftsql<year>`, not `microsoftsqlserver` or
`mssql` --- "server" and any abbreviation are both dropped.

Level 2 availability is version-dependent, and for SQL Server 2016 and 2017 it's also
scope-dependent. This is the main trap when constructing a profile name for this
platform:

- **SQL Server 2016**: Level 1 ships for both scopes at v1.3.0 and v1.4.0. Level 2
  exists only at v1.4.0, and only for the `databaseengine` scope --- there's no Level 2
  `awsrds` profile for 2016 at any version.
- **SQL Server 2017**: the same shape applies. Level 1 ships for both scopes at v1.2.0
  and v1.3.0. Level 2 exists only at v1.3.0, and only for `databaseengine`.
- **SQL Server 2019**: Level 2 ships for both scopes at v1.2.0, the only version in the
  published catalog.
- **SQL Server 2022**: Level 2 ships for both scopes at both v1.1.0 and v1.3.0.

Assuming Level 2 exists for `awsrds` on SQL Server 2016 or 2017 produces a profile name
that doesn't exist. Check the benchmark version and scope you're targeting before you
construct one.

Choose the level that matches your risk posture and the scope that matches how the
instance is deployed:

- **Level 1** applies settings that improve security with limited operational impact.
  It's the common starting point for production instances.
- **Level 2** extends Level 1 with defense-in-depth settings intended for environments
  with stricter requirements. Level 2 is more likely to affect how applications behave,
  so test it before rolling it out broadly.
- **Database Engine** targets an on-premises or self-managed SQL Server instance.
- **AWS RDS** targets a managed Amazon RDS for SQL Server instance. Amazon manages the
  underlying OS and some settings this benchmark would otherwise check, so coverage
  differs slightly by scope.

## What you can do with this content

### Audit

Run the audit profile against a SQL Server instance to assess it against the benchmark
and report which requirements pass and which fail. Each failure identifies the specific
setting that doesn't meet the standard, so the result is an actionable list rather than
a score.

You can run audit content with [Chef InSpec](/inspec/latest/), the
[Compliance Phase](/client/latest/features/chef_compliance_phase/) during a Chef Infra
Client run, or an [Automate scan job](/automate/scan_jobs/).

### Harden

Where remediation content is available for a benchmark version, you can correct the
configuration behind a failed requirement rather than writing the fix yourself.

### Detect drift

An instance that passed an audit at build time doesn't stay compliant on its own.
Configuration changes, administrative access, and tooling from other sources all move
an instance away from its approved state. Running the audit profile on a schedule turns
a one-time assessment into continuous evidence, and
[compliance reporting in Chef Automate](/automate/reports/) shows how results change over
time.

## Remediation

Remediation content is delivered as [Chef Infra cookbooks](/client/latest/cookbooks/)
that correct the configuration behind a failed benchmark requirement. Where an audit
profile reports that a setting doesn't meet the standard, the matching remediation
content applies the change that brings it back into line, so you can close findings with
the same tooling you already use to manage the instance.

Check the version table above before you plan a hardening rollout, because remediation
and audit versions don't always line up.

- **SQL Server 2016 and SQL Server 2017** are partial. Remediation trails audit by one
  version in each case: 2016 remediation covers v1.1.0 and v1.3.0 against audit's v1.3.0
  and v1.4.0, and 2017 remediation covers only v1.2.0 against audit's v1.2.0 and v1.3.0.
  Plan hardening against the version you can actually remediate.
- **SQL Server 2019** is fully aligned at v1.2.0.
- **SQL Server 2022** is audit only. You can assess instances and act on the findings,
  but the corresponding remediation content isn't available.

## Access this content

Chef Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement
includes, and contact your Chef account representative to confirm your access.

## Related

- [Databases coverage](/premium_content/databases/)
- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
