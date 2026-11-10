+++
title = "PostgreSQL"

[menu.premium_content]
  identifier = "premium_content/databases/postgresql"
  parent = "premium_content/databases"
  title = "PostgreSQL"
  weight = 70
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) and [DISA STIGs](https://public.cyber.mil/stigs/) for PostgreSQL define secure configuration requirements for PostgreSQL 9.x through 17.
Chef Premium Content provides Chef InSpec audit profiles and remediation content for these benchmarks.
Coverage varies by benchmark and version. See the coverage tables on this page for details.

## What the benchmarks check

The CIS requirements cover the following areas in the PostgreSQL 17 benchmark at v1.0.0:

- **Installation:** Package sources, required packages, and data cluster initialization
- **Directory and file permissions:** The file permissions mask, extension directories, and stored credentials
- **Logging and auditing:** Log destinations, log retention, and connection logging
- **Access and authorization:** Interactive sign-in, administrative privileges, and row-level security
- **Connection and sign-in:** Binding to an IP address, and local and host authentication
- **Settings:** Runtime parameters and FIPS-validated cryptography
- **Replication:** Replication users, WAL archiving, and base backups
- **Other settings:** Data directories, backup tooling, and miscellaneous settings

The STIG states its requirements individually.
The PostgreSQL 9.x STIG includes requirements for privileges, audit records, and how passwords are stored.

The exact requirements differ by benchmark and version.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS PostgreSQL 10` | --- | v1.0.0 | Remediation Only |
| `CIS PostgreSQL 11` | v1.0.0 | v1.0.0 | Audit + Remediation |
| `CIS PostgreSQL 16` | v1.0.0 | v1.0.0 | Audit + Remediation |
| `CIS PostgreSQL 17` | v1.0.0 | v1.0.0 | Audit + Remediation |
| `STIG PostgreSQL 9.x` | v2 | --- | Audit Only |

Audit and remediation coverage are tracked separately.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables)
for what each coverage term means.

## Available profiles

### CIS

CIS PostgreSQL profiles vary along a single axis: scope. There's a profile for
PostgreSQL itself, and a profile that also includes Linux host OS checks. There's no
Level 1 / Level 2 split for CIS PostgreSQL at any version, every profile is implicitly
the one published level.

```text
cis-postgresql<version>-level1-<scope>-v<benchmark-version>
```

For example, the profile covering PostgreSQL 16 plus Linux host OS checks at
benchmark v1.0.0 is `cis-postgresql16-level1-postgresqlonlinux-v1.0.0`.

CIS PostgreSQL 10 is remediation only.
No audit profile is available for this version, despite the naming pattern above.

- **PostgreSQL** checks the database engine configuration only.
- **PostgreSQL on Linux** adds checks against the underlying Linux host as well.

### STIG

STIG PostgreSQL uses the DISA MAC (Mission Assurance Category) x confidentiality
level matrix, the same shape Windows Server and Oracle Linux use for their STIG
sections in this guide. There are 9 profiles total, one for each combination of MAC
level (`i` / mission critical, `ii` / mission support, `iii` / administrative) and
confidentiality (`classified`, `public`, `sensitive`):

- `stig-postgresql9.x-i-missioncriticalclassified-v2`
- `stig-postgresql9.x-i-missioncriticalpublic-v2`
- `stig-postgresql9.x-i-missioncriticalsensitive-v2`
- `stig-postgresql9.x-ii-missionsupportclassified-v2`
- `stig-postgresql9.x-ii-missionsupportpublic-v2`
- `stig-postgresql9.x-ii-missionsupportsensitive-v2`
- `stig-postgresql9.x-iii-administrativeclassified-v2`
- `stig-postgresql9.x-iii-administrativepublic-v2`
- `stig-postgresql9.x-iii-administrativesensitive-v2`

The STIG version token here is the bare `v2`, not `v2.0.0`, this benchmark's own
versioning doesn't use a dotted scheme. The platform token keeps the literal `9.x`
rather than a specific point release like `9.6`, this STIG benchmark covers the
PostgreSQL 9.x line as a single generation, which is why its catalog name is "STIG
PostgreSQL 9.x" rather than a specific version number.

## What you can do with this content

### Audit

Run the audit profile against a PostgreSQL instance to assess it against the
benchmark and report which requirements pass and which fail. Each failure identifies
the specific setting that doesn't meet the standard, so the result is an actionable
list rather than a score. Both CIS and STIG profiles run through the same Chef
InSpec tooling.

You can run audit content with [Chef InSpec](/inspec/latest/), the
[Compliance Phase](/client/latest/features/chef_compliance_phase/) during a Chef
Infra Client run, or an [Automate scan job](/automate/scan_jobs/).

### Harden

Where remediation content is available for a benchmark version, you can correct the
configuration behind a failed requirement rather than writing the fix yourself.

### Detect drift

A PostgreSQL instance that passed an audit at build time doesn't stay compliant on
its own. Package updates, manual changes, and configuration management from other
tools all move an instance away from its approved state. Running the audit profile on
a schedule turns a one-time assessment into continuous evidence, and
[compliance reporting in Chef Automate](/automate/reports/) shows how results change
over time.

## Remediation

Remediation content is delivered as [Chef Infra cookbooks](/client/latest/cookbooks/)
that correct the configuration behind a failed benchmark requirement. Where an audit
profile reports that a setting doesn't meet the standard, the matching remediation
content applies the change that brings it back into line, so you can close findings
with the same tooling you already use to manage the system.

Check the version table above before you plan a hardening rollout, because
remediation and audit versions don't always line up.

- **PostgreSQL 10** is remediation only. There's no audit profile at all for this
  version, but the matching cookbook is still published, so you can apply the
  hardening content without first running an assessment against it.
- **PostgreSQL 11, 16, and 17** are fully aligned at v1.0.0 for both audit and
  remediation.
- **STIG PostgreSQL 9.x** is audit only. You can assess instances and act on the
  findings, but no matching Chef Infra cookbook is published for the STIG profiles.

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
