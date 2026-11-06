+++
title = "MariaDB"

[menu.premium_content]
  identifier = "premium_content/databases/mariadb"
  parent = "premium_content/databases"
  title = "MariaDB"
  weight = 10
+++

MariaDB is a widely used open-source relational database, often deployed as a
drop-in replacement for MySQL on both standalone hosts and Linux servers managed
through configuration management.

Chef Premium Content covers MariaDB against the
[CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks), so you can assess
MariaDB instances without writing and maintaining that content yourself.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS MariaDB 10.6` | v1.0.0 | --- | Audit Only |

Audit and remediation coverage are tracked separately.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables)
for what each coverage term means.

## Available profiles

The benchmark version ships as four Chef InSpec profiles, one for every combination of
CIS profile level and deployment scope:

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |
| Scope | `mariadbrdbms`, `mariadbrdbmsonlinux` |

Profile names follow a consistent pattern, so you can predict the name you need:

```text
cis-mariadb<version>-<level>-<scope>-v<benchmark-version>
```

For example, the CIS Level 1 profile for the database engine on MariaDB 10.6 at
benchmark v1.0.0 is `cis-mariadb10.6-level1-mariadbrdbms-v1.0.0`.

Note that the scope token for a database engine running on a Linux host is
`mariadbrdbmsonlinux`, not `mariadbonlinux` or `onlinux` --- it's the full
`mariadbrdbms` token with `onlinux` appended, run together as a single word.

Both levels ship at this single benchmark version, so there's no level or scope
restriction to account for here, unlike some other database platforms.

Choose the level that matches your risk posture and the scope that matches how the
instance is deployed:

- **Level 1** applies settings that improve security with limited operational impact.
  It's the common starting point for production instances.
- **Level 2** extends Level 1 with defense-in-depth settings intended for environments
  with stricter requirements. Level 2 is more likely to affect how applications behave,
  so test it before rolling it out broadly.
- **MariaDB RDBMS** targets the database engine itself, independent of the underlying
  host.
- **MariaDB RDBMS on Linux** targets a database engine running on a Linux host, and
  also checks host-level settings that affect the database's security.

## What you can do with this content

### Audit

Run the audit profile against a MariaDB instance to assess it against the benchmark
and report which requirements pass and which fail. Each failure identifies the
specific setting that doesn't meet the standard, so the result is an actionable list
rather than a score.

You can run audit content with [Chef InSpec](/inspec/latest/), the
[Compliance Phase](/client/latest/features/chef_compliance_phase/) during a Chef Infra
Client run, or an [Automate scan job](/automate/scan_jobs/).

### Detect drift

An instance that passed an audit at build time doesn't stay compliant on its own.
Configuration changes, administrative access, and tooling from other sources all move
an instance away from its approved state. Running the audit profile on a schedule turns
a one-time assessment into continuous evidence, and
[compliance reporting in Chef Automate](/automate/reports/) shows how results change over
time.

## Remediation

There's no remediation content for MariaDB. Coverage is audit only, so you can assess
instances against the benchmark and act on the findings, but you need to apply the
corresponding fixes through your own tooling.

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
