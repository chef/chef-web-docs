+++
title = "Red Hat Enterprise Linux"

[menu.premium_content]
  identifier = "premium_content/operating_systems/rhel"
  parent = "premium_content/operating_systems"
  title = "Red Hat Enterprise Linux"
  weight = 90
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) and [DISA STIGs](https://public.cyber.mil/stigs/) for Red Hat Enterprise Linux define secure configuration requirements for releases from Red Hat Enterprise Linux 5 through 10.
Chef Premium Content provides these requirements as Chef InSpec audit profiles and remediation content, and coverage differs by benchmark and version, so check the following version table.

## What the benchmarks check

The CIS requirements cover the following areas in the Red Hat Enterprise Linux 10 benchmark at v1.0.0:

- **Initial setup:** Filesystem kernel modules, partitions, package signing, and kernel settings
- **Services:** Services to remove, the GNOME Display Manager, and time synchronization
- **Network:** IPv6 status, network kernel modules, and redirect and logging settings
- **Host-based firewall:** firewalld installation and zone configuration
- **Access control:** SSH, account lockout, and password expiration
- **Logging and auditing:** AIDE, rsyslog, and audit rules
- **System maintenance:** Permissions on system files, world-writable files, and account consistency

The STIG states its requirements individually.
The Red Hat Enterprise Linux 9 STIG at v1.1.0 includes requirements for supported releases, file permissions, SSH, and single-user mode.

The exact requirements differ by benchmark and version.

## Supported versions

### CIS

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Red Hat Enterprise Linux 5` | v2.2.0 | v2.2.0 | Audit + Remediation |
| `CIS Red Hat Enterprise Linux 6` | v2.0.2, v2.1.0, v3.0.0 | v3.0.0 | Partial Audit + Remediation |
| `CIS Red Hat Enterprise Linux 7` | v2.1.1, v2.2.0, v3.1.1, v4.0.0 | v3.1.1 | Partial Audit + Remediation |
| `CIS Red Hat Enterprise Linux 8` | v1.0.0, v1.0.1, v2.0.0, v3.0.0, v4.0.0 | v1.0.1, v2.0.0, v3.0.0 | Partial Audit + Remediation |
| `CIS Red Hat Enterprise Linux 9` | v1.0.0, v2.0.0 | v1.0.0, v2.0.0 | Audit + Remediation |
| `CIS Red Hat Enterprise Linux 10` | v1.0.0 | v1.0.0 | Audit + Remediation |

### STIG

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `STIG Red Hat Enterprise Linux 6` | v1.26.0 | --- | Audit Only |
| `STIG Red Hat Enterprise Linux 7` | v2.6.0 | v3.8.0 | Remediation Ahead |
| `STIG Red Hat Enterprise Linux 8` | v1.2.0 | v1.2.0 | Audit + Remediation |
| `STIG Red Hat Enterprise Linux 9` | v1.1.0 | v1.1.0 | Audit + Remediation |

Audit and remediation coverage are tracked separately, and a benchmark can have more
versions of one than the other.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables)
for what each coverage term means.

## Available profiles

Red Hat Enterprise Linux ships a large number of Chef InSpec profiles across these
benchmarks, because each benchmark version is split into several variants. Rather than
list them all, the following sections give the naming pattern and the values each part
can take, so you can work out the profile you need.

### CIS profiles

CIS benchmark versions ship as four profiles, one for every combination of profile
level and system scope:

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |
| Scope | `server`, `workstation` |

```text
cis-rhel<os-version>-<level>-<scope>-v<benchmark-version>
```

For example, the CIS Level 1 server profile for Red Hat Enterprise Linux 9 at benchmark
v2.0.0 is `cis-rhel9-level1-server-v2.0.0`.

Note that the platform token is the short form `rhel<version>`, not the full benchmark
title.

The exception is Red Hat Enterprise Linux 5, which has no server or workstation scope.
It ships level only, as two profiles: `cis-rhel5-level1-v2.2.0` and
`cis-rhel5-level2-v2.2.0`. Every other Red Hat Enterprise Linux release ships four
profiles, one for each combination of level and scope.

- **Level 1** applies settings that improve security with limited operational impact.
  It's the common starting point for production systems.
- **Level 2** extends Level 1 with defense-in-depth settings intended for environments
  with stricter requirements. Level 2 is more likely to affect how applications behave,
  so test it before rolling it out broadly.
- **Server** targets systems running without a graphical desktop.
- **Workstation** targets systems with an interactive desktop environment.

### STIG profiles

STIG content isn't organized by level. It's organized by the DISA Mission Assurance
Category and confidentiality level of the system, which together determine how strict
the applicable requirements are:

| Axis | Values |
| --- | --- |
| Mission Assurance Category | `i-missioncritical`, `ii-missionsupport`, `iii-administrative` |
| Confidentiality | `classified`, `public`, `sensitive` |

```text
stig-redhatenterpriselinux<os-version>-<mac><confidentiality>-v<benchmark-version>
```

For example, the MAC II mission support profile for a sensitive Red Hat Enterprise
Linux 8 system at benchmark v1.2.0 is
`stig-redhatenterpriselinux8-ii-missionsupportsensitive-v1.2.0`.

Note that the platform token here is the long form `redhatenterpriselinux<version>`,
not the short form `rhel<version>` used by the CIS profiles above. Mixing up the two
tokens is a common mistake.

That gives nine combinations for each benchmark version. Two further variants ship
alongside them:

| Variant | Purpose |
| --- | --- |
| `cationly` | Assesses only the requirements relating to Common Access Card authentication |
| `disableslowrules` | Omits the checks that take longest to execute, for faster feedback during development |

The `cationly` variant is available across the Red Hat Enterprise Linux STIG releases.
The `disableslowrules` variant ships for Red Hat Enterprise Linux 9 only, so don't
expect it for the 6, 7, or 8 STIGs.

## What you can do with this content

### Audit

Run the audit profile against a Red Hat Enterprise Linux system to assess it against
the benchmark and report which requirements pass and which fail. Each failure
identifies the specific setting that doesn't meet the standard, so the result is an
actionable list rather than a score.

You can run audit content with [Chef InSpec](/inspec/latest/), the
[Compliance Phase](/client/latest/features/chef_compliance_phase/) during a Chef Infra
Client run, or an [Automate scan job](/automate/scan_jobs/).

### Harden

Where remediation content is available for a benchmark version, you can correct the
configuration behind a failed requirement rather than writing the fix yourself.

### Detect drift

A system that passed an audit at build time doesn't stay compliant on its own. Package
updates, manual changes, and configuration management from other tools all move a
system away from its approved state. Running the audit profile on a schedule turns a
one-time assessment into continuous evidence, and
[compliance reporting in Chef Automate](/automate/reports/) shows how results change
over time.

## Remediation

Remediation content is delivered as [Chef Infra cookbooks](/client/latest/cookbooks/)
that correct the configuration behind a failed benchmark requirement, so you can close
findings with the same tooling you already use to manage the system.

Red Hat Enterprise Linux 5, 9, and 10 (CIS) have matching audit and remediation
versions. Red Hat Enterprise Linux 6, 7, and 8 (CIS) are partial: audit covers more
versions than remediation. Check the version tables above before you plan a hardening
rollout, because remediation and audit versions don't always line up.

- **The Red Hat Enterprise Linux 6 STIG** is audit only. You can assess systems and act
  on the findings, but matching remediation content isn't available.
- **The Red Hat Enterprise Linux 7 STIG** currently has remediation at a later version
  (v3.8.0) than the available audit content (v2.6.0).
- **The Red Hat Enterprise Linux 8 and 9 STIGs** have matching audit and remediation
  versions.

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
