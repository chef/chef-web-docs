+++
title = "Amazon Linux"

[menu.premium_content]
  identifier = "premium_content/operating_systems/amazon_linux"
  parent = "premium_content/operating_systems"
  title = "Amazon Linux"
  weight = 20
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) for Amazon Linux define secure configuration requirements for Amazon Linux 1, Amazon Linux 2, and Amazon Linux 2023.
Chef Premium Content provides Chef InSpec audit profiles and remediation content for these benchmarks.
Coverage varies by benchmark and version. See the coverage tables on this page for details.

## What the benchmarks check

The requirements cover the following areas in the Amazon Linux 2023 benchmark at v1.0.0:

- **Initial setup:** Filesystems, partition options, and core dumps
- **Services:** Time synchronization, and services to remove such as DNS servers and HTTP proxies
- **Network:** IPv6 status, packet redirects, ICMP handling, and firewalld
- **Access control:** Scheduled jobs, SSH, and account lockout
- **Logging and auditing:** rsyslog, journald, and audit rules
- **System maintenance:** Permissions on system files, SUID and SGID files, and duplicate accounts

The exact requirements differ by benchmark and version.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Amazon Linux 1` | v1.1.0 | --- | Audit Only |
| `CIS Amazon Linux 2` | v1.0.0, v2.0.0 | v2.0.0 | Partial Audit + Remediation |
| `CIS Amazon Linux 2023` | v1.0.0 | --- | Audit Only |

Audit and remediation coverage are tracked separately.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables)
for what each coverage term means.

## Available profiles

Amazon Linux is the least consistent of the operating system families in its profile
naming, because Amazon has changed the release and benchmark structure across the three
generations. There's no single pattern that predicts a profile name across all three
releases, so the complete set is listed here instead:

| Release | Benchmark version | Profile name |
| --- | --- | --- |
| Amazon Linux 1 | v1.1.0 | `cis-amazonlinux-2014.09-2015.03-level1-v1.1.0` |
| Amazon Linux 1 | v1.1.0 | `cis-amazonlinux-2014.09-2015.03-level2-v1.1.0` |
| Amazon Linux 2 | v1.0.0 | `cis-amazonlinux2-level1-v1.0.0` |
| Amazon Linux 2 | v1.0.0 | `cis-amazonlinux2-level2-v1.0.0` |
| Amazon Linux 2 | v2.0.0 | `cis-amazonlinux2-level1-v2.0.0` |
| Amazon Linux 2 | v2.0.0 | `cis-amazonlinux2-level2-v2.0.0` |
| Amazon Linux 2023 | v1.0.0 | `cis-amazonlinux2023-level1-server-v1.0.0` |
| Amazon Linux 2023 | v1.0.0 | `cis-amazonlinux2023-level2-server-v1.0.0` |

A few points are worth calling out:

- Amazon Linux 1 and Amazon Linux 2 ship level only, with no server or workstation
  scope in the profile name.
- Amazon Linux 2023 is the only release that carries a scope, and it ships `server`
  only. There's no workstation profile for Amazon Linux 2023. This is consistent with
  Amazon Linux being a server and cloud instance operating system rather than a
  desktop one.
- The Amazon Linux 1 platform token embeds the release date range,
  `amazonlinux-2014.09-2015.03`, rather than a simple version number. This reflects the
  Amazon Linux 1 release naming of the period. It's easy to mistype, so the exact
  names are listed in the table above.
- Level axis values across all releases are `level1` and `level2`.

Choose the level that matches your risk posture:

- **Level 1** applies settings that improve security with limited operational impact.
  It's the common starting point for production systems.
- **Level 2** extends Level 1 with defense-in-depth settings intended for environments
  with stricter requirements. Level 2 is more likely to affect how applications behave,
  so test it before rolling it out broadly.

## What you can do with this content

### Audit

Run the audit profile against an Amazon Linux system to assess it against the benchmark
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

- **Amazon Linux 2** is partial. Audit covers v1.0.0 and v2.0.0, but remediation covers
  v2.0.0 only, so plan hardening against the version you can actually remediate.
- **Amazon Linux 1 and Amazon Linux 2023** are audit only. You can assess systems
  running those releases against the benchmark and act on the findings, but the
  corresponding remediation content isn't available.

## Access this content

Chef Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement
includes, and contact your Chef account representative to confirm your access.

## Related

- [Operating systems coverage](/premium_content/operating_systems/)
- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [The Chef Way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
