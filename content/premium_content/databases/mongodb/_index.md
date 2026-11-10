+++
title = "MongoDB"

[menu.premium_content]
  identifier = "premium_content/databases/mongodb"
  parent = "premium_content/databases"
  title = "MongoDB"
  weight = 20
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) for MongoDB define secure configuration requirements for MongoDB 3.6.
Chef Premium Content provides these requirements as Chef InSpec audit profiles and remediation content.

## What the benchmarks check

The requirements cover the following areas in the benchmark at v1.1.0:

- **Installation and patching:** The MongoDB version and patches
- **Authentication:** Authentication settings, the localhost exception, and sharded clusters
- **Authorization:** Role-based access control, network listeners, and least-privilege accounts
- **Data protection:** Encryption in transit and at rest, and FIPS mode
- **Auditing:** System activity auditing, audit filters, and log handling
- **Operating system hardening:** Default ports, resource limits, and server-side scripting
- **File permissions:** Authentication files and database files

The exact requirements differ by benchmark and version.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS MongoDB 3.6` | v1.0.0, v1.1.0 | v1.0.0, v1.1.0 | Audit + Remediation |

Audit and remediation coverage are tracked separately.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables)
for what each coverage term means.

## Available profiles

Each benchmark version ships as Chef InSpec profiles covering the applicable CIS
profile level:

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |

Profile names follow a consistent pattern, so you can predict the name you need:

```text
cis-mongodb<version>-<level>-mongodb-v<benchmark-version>
```

For example, the CIS Level 1 profile for MongoDB 3.6 at benchmark v1.1.0 is
`cis-mongodb3.6-level1-mongodb-v1.1.0`.

MongoDB has a single release, 3.6, so the version in the profile name is always `3.6`.
There's only one target scope for this platform: `mongodb`.

Both levels ship for both benchmark versions. There's no level restriction and no
version gap to watch for: the same two profiles, Level 1 and Level 2, are available at
v1.0.0 and at v1.1.0.

Choose the level that matches your risk posture:

- **Level 1** applies settings that improve security with limited operational impact.
  It's the common starting point for production instances.
- **Level 2** extends Level 1 with defense-in-depth settings intended for environments
  with stricter requirements. Level 2 is more likely to affect how applications behave,
  so test it before rolling it out broadly.

## What you can do with this content

### Audit

Run the audit profile against a MongoDB instance to assess it against the benchmark
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

MongoDB 3.6 remediation is fully aligned with audit: both v1.0.0 and v1.1.0 have
matching remediation cookbooks, so you can plan a hardening rollout against either
benchmark version without a coverage gap to work around.

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
