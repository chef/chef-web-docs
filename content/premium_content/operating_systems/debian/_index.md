+++
title = "Debian"

[menu.premium_content]
  identifier = "premium_content/operating_systems/debian"
  parent = "premium_content/operating_systems"
  title = "Debian"
  weight = 40
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) for Debian Linux define secure configuration requirements for Debian Linux 9, 11, 12, and 13.
Chef Premium Content provides Chef InSpec audit profiles and remediation content for these benchmarks.
Coverage varies by benchmark and version. See the coverage tables on this page for details.

## What the benchmarks check

The requirements cover the following areas in the Debian Linux 13 benchmark at v1.0.0:

- **Initial setup:** Filesystem kernel modules, partition options, APT trusted keys, and kernel settings
- **Services:** Services to remove, listening services, and time synchronization
- **Network:** IPv6 status, network kernel modules, and redirect and logging settings
- **Host-based firewall:** ufw configuration and default policies
- **Access control:** SSH, PAM modules, and password history
- **Logging and auditing:** journald, rsyslog, and audit rules
- **System maintenance:** Permissions on system files, world-writable files, and account consistency

The exact requirements differ by benchmark and version.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Debian Linux 9` | v1.0.0, v1.0.1 | v1.0.0 | Partial Audit + Remediation |
| `CIS Debian Linux 11` | v2.0.0 | --- | Audit Only |
| `CIS Debian Linux 12` | v1.0.1, v1.1.0 | --- | Audit Only |
| `CIS Debian Linux 13` | v1.0.0 | v1.0.0 | Audit + Remediation |

Audit and remediation coverage are tracked separately.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables)
for what each coverage term means.

## Available profiles

Each benchmark version ships as four Chef InSpec profiles, one for every combination of
CIS profile level and system scope:

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |
| Scope | `server`, `workstation` |

Profile names follow a consistent pattern, so you can predict the name you need:

```text
cis-debianlinux<os-version>-<level>-<scope>-v<benchmark-version>
```

For example, the CIS Level 1 server profile for Debian Linux 12 at benchmark v1.1.0 is
`cis-debianlinux12-level1-server-v1.1.0`.

Note that the platform token is `debianlinux<version>`, as in `debianlinux12`. It isn't
`debian<version>`, and assuming the shorter form is a common mistake.

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

Run the audit profile against a Debian system to assess it against the benchmark and
report which requirements pass and which fail. Each failure identifies the specific
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

- **Debian Linux 13** has matching audit and remediation content at v1.0.0.
- **Debian Linux 9** is partial. Audit covers v1.0.0 and v1.0.1, but remediation covers
  v1.0.0 only, so plan hardening against the version you can actually remediate.
- **Debian Linux 11 and Debian Linux 12** are audit only. You can assess systems running
  those releases against the benchmark and act on the findings, but the corresponding
  remediation content isn't available.

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
