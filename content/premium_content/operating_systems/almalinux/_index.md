+++
title = "AlmaLinux OS"

[menu.premium_content]
  identifier = "premium_content/operating_systems/almalinux"
  parent = "premium_content/operating_systems"
  title = "AlmaLinux OS"
  weight = 10
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) for AlmaLinux OS define secure configuration requirements for AlmaLinux OS 8, 9, and 10.
Chef Premium Content provides these requirements as Chef InSpec profiles for all three releases, and as remediation content for AlmaLinux OS 8.

## What the benchmarks check

The requirements cover the following areas in the AlmaLinux OS 9 benchmark at v2.0.0:

- **Initial setup:** Filesystem kernel modules, package signing keys, SELinux, and bootloader settings
- **Services:** Services and clients to remove, time synchronization, and job scheduling
- **Network:** IPv6 status, network kernel modules, and IP forwarding
- **Host-based firewall:** firewalld and nftables configuration
- **Access control:** SSH, sudo, PAM, and password expiration
- **Logging and auditing:** AIDE, journald, and auditd
- **System maintenance:** Permissions on system files and account password storage

The exact requirements differ by release, benchmark version, level, and scope.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS AlmaLinux OS 8` | v2.0.0 | v2.0.0 | Audit + Remediation |
| `CIS AlmaLinux OS 9` | v2.0.0 | --- | Audit Only |
| `CIS AlmaLinux OS 10` | v1.0.0 | --- | Audit Only |

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
cis-almalinuxos<os-version>-<level>-<scope>-v<benchmark-version>
```

For example, the CIS Level 1 server profile for AlmaLinux OS 9 at benchmark v2.0.0 is
`cis-almalinuxos9-level1-server-v2.0.0`.

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

Run the audit profile against an AlmaLinux system to assess it against the benchmark and
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

Remediation content is available for **AlmaLinux OS 8 at benchmark v2.0.0**.

Remediation content is delivered as [Chef Infra cookbooks](/client/latest/cookbooks/)
that correct the configuration behind a failed benchmark requirement. Where an audit
profile reports that a setting doesn't meet the standard, the matching remediation
content applies the change that brings it back into line, so you can close findings with
the same tooling you already use to manage the system.

AlmaLinux OS 9 and AlmaLinux OS 10 are currently **audit only**. You can assess systems
running those versions against the benchmark and act on the findings, but the
corresponding remediation content isn't available yet.

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
