+++
title = "CentOS"

[menu.premium_content]
  identifier = "premium_content/operating_systems/centos"
  parent = "premium_content/operating_systems"
  title = "CentOS"
  weight = 30
+++

CentOS Linux was for many years the standard free rebuild of Red Hat Enterprise Linux
and remains widely deployed, particularly on long-lived systems. Many estates still run
CentOS Linux releases that are past upstream end of life but still in production and
still in audit scope, which is exactly where benchmark evidence matters.

Chef Premium Content covers CentOS Linux against the
[CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks), so you can assess and
correct CentOS Linux systems without writing and maintaining that content yourself.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS CentOS Linux 6` | v1.1.0, v2.0.2, v3.0.0 | v3.0.0 | Partial Audit + Remediation |
| `CIS CentOS Linux 7` | v1.1.0, v2.2.0, v3.1.2 | v2.2.0, v3.1.2 | Partial Audit + Remediation |
| `CIS CentOS Linux 8` | v1.0.0, v1.0.1 | v1.0.0, v1.0.1 | Audit + Remediation |

Audit and remediation coverage are tracked separately.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables)
for what each coverage term means.

## Available profiles

Most benchmark versions ship as four Chef InSpec profiles, one for every combination of
CIS profile level and system scope:

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |
| Scope | `server`, `workstation` |

Profile names follow a consistent pattern, so you can predict the name you need:

```text
cis-centos<os-version>-<level>-<scope>-v<benchmark-version>
```

For example, the CIS Level 1 server profile for CentOS Linux 7 at benchmark v3.1.2 is
`cis-centos7-level1-server-v3.1.2`.

Note that the platform token is the short form `centos<version>`, as in `centos7`. It
isn't `centoslinux<version>`, and assuming the longer form is a common mistake.

Whether a scope is present depends on the benchmark version, not on the release. At
benchmark v1.1.0, CentOS Linux 6 and CentOS Linux 7 ship level only, with no server or
workstation scope: the four profile names at that version are `cis-centos6-level1-v1.1.0`,
`cis-centos6-level2-v1.1.0`, `cis-centos7-level1-v1.1.0`, and `cis-centos7-level2-v1.1.0`.
Every other benchmark version in the table above ships the full four profiles with scope.
Check the benchmark version before you construct a profile name, since a scoped name
doesn't exist at v1.1.0.

Choose the level that matches your risk posture and the scope that matches the system's
role:

- **Level 1** applies settings that improve security with limited operational impact.
  It's the common starting point for production systems.
- **Level 2** extends Level 1 with defense-in-depth settings intended for environments
  with stricter requirements. Level 2 is more likely to affect how applications behave,
  so test it before rolling it out broadly.
- **Server** targets systems running without a graphical desktop.
- **Workstation** targets systems with an interactive desktop environment.

## What you can do with this content

### Audit

Run the audit profile against a CentOS Linux system to assess it against the benchmark
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

A system that passed an audit at build time doesn't stay compliant on its own. Package
updates, manual changes, and configuration management from other tools all move a system
away from its approved state. Running the audit profile on a schedule turns a one-time
assessment into continuous evidence, and
[compliance reporting in Chef Automate](/automate/reports/) shows how results change over
time.

## Remediation

Remediation content is delivered as [Chef Infra cookbooks](/client/latest/cookbooks/)
that correct the configuration behind a failed benchmark requirement. Where an audit
profile reports that a setting doesn't meet the standard, the matching remediation
content applies the change that brings it back into line, so you can close findings with
the same tooling you already use to manage the system.

Check the version table above before you plan a hardening rollout, because remediation
and audit versions don't always line up.

- **CentOS Linux 8** has matching audit and remediation content at v1.0.0 and v1.0.1.
- **CentOS Linux 7** is partial. Audit covers v1.1.0, v2.2.0, and v3.1.2, but remediation
  covers v2.2.0 and v3.1.2 only.
- **CentOS Linux 6** is partial. Audit covers v1.1.0, v2.0.2, and v3.0.0, but remediation
  covers v3.0.0 only.

## Access this content

Chef Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement
includes, and contact your Chef account representative to confirm your access.

## Related

- [Operating systems coverage](/premium_content/operating_systems/)
- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
