+++
title = "Ubuntu"

[menu.premium_content]
  identifier = "premium_content/operating_systems/ubuntu"
  parent = "premium_content/operating_systems"
  title = "Ubuntu"
  weight = 120
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) and [DISA STIGs](https://public.cyber.mil/stigs/) for Ubuntu define secure configuration requirements for Ubuntu LTS releases from 12.04 through 24.04.
Chef Premium Content provides Chef InSpec audit profiles and remediation content for these benchmarks.
Coverage varies by benchmark and version. See the coverage tables on this page for details.

## What the benchmarks check

The CIS requirements cover the following areas in the Ubuntu 24.04 benchmark at v1.0.0:

- **Initial setup:** Filesystem kernel modules, partition options, and prelink
- **Services:** Services to remove, the mail transfer agent, and time synchronization
- **Network:** IPv6 status, network kernel modules, and packet redirect settings
- **Host-based firewall:** Using a single firewall utility, and ufw, nftables, and iptables policies
- **Access control:** SSH and PAM modules
- **Logging and auditing:** journald, rsyslog, and audit rules
- **System maintenance:** Permissions on system files, world-writable files, and account consistency

The STIG states its requirements individually.
The Ubuntu 20.04 STIG at v1.2.0 includes requirements for session locking, Personal Identity Verification credentials, and audit records.

The exact requirements differ by benchmark and version.

## Supported versions

### CIS

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Ubuntu Linux 12.04` | v1.1.0 | --- | Audit Only |
| `CIS Ubuntu Linux 14.04` | v1.0.0 | --- | Audit Only |
| `CIS Ubuntu Linux 16.04` | v1.0.0 | --- | Audit Only |
| `CIS Ubuntu Linux 18.04` | v1.0.0, v2.1.0 | v1.0.0, v2.1.0 | Audit + Remediation |
| `CIS Ubuntu Linux 20.04` | v1.0.0, v1.1.0 | v1.0.0 | Partial Audit + Remediation |
| `CIS Ubuntu Linux 22.04` | v1.0.0, v2.0.0 | v1.0.0, v2.0.0 | Audit + Remediation |
| `CIS Ubuntu Linux 24.04` | v1.0.0 | v1.0.0 | Audit + Remediation |

### STIG

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `STIG Ubuntu Linux 20.04` | v1.2.0 | v1.2.0 | Audit + Remediation |

Chef tracks audit and remediation coverage separately.
A benchmark can have more audit versions than remediation versions, or vice versa.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables)
for what each coverage term means.

## Available profiles

Ubuntu ships a large number of Chef InSpec profiles across these benchmarks, because
each benchmark version is split into several variants. Rather than list them all, the
following sections give the naming pattern and the values each part can take, so you can
work out the profile you need.

### CIS profiles

Most CIS benchmark versions ship as four profiles, one for every combination of profile
level and system scope:

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |
| Scope | `server`, `workstation` |

```text
cis-ubuntu<os-version>lts-<level>-<scope>-v<benchmark-version>
```

For example, the CIS Level 1 server profile for Ubuntu 22.04 at benchmark v2.0.0 is
`cis-ubuntu22.04lts-level1-server-v2.0.0`.

The platform name in the profile has a trailing `lts`, as in `ubuntu22.04lts`. It isn't
`ubuntu<version>` on its own.

The exceptions are Ubuntu 12.04 and Ubuntu 14.04, which have no server or workstation
scope. They ship level only, as two profiles for each benchmark version, such as
`cis-ubuntu12.04lts-level1-v1.1.0` and `cis-ubuntu14.04lts-level2-v1.0.0`. Every other
Ubuntu release ships four profiles, one for each combination of level and scope.

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
stig-canonicalubuntu<os-version>lts-<mac><confidentiality>-v<benchmark-version>
```

For example, the MAC II mission support profile for a sensitive Ubuntu 20.04 system at
benchmark v1.2.0 is
`stig-canonicalubuntu20.04lts-ii-missionsupportsensitive-v1.2.0`.

The platform name here has a `canonical` prefix, as in
`canonicalubuntu20.04lts`. It differs from the `ubuntu<version>lts` name used by the
CIS profiles above.

That gives nine combinations for each benchmark version. One further variant ships
alongside them:

| Variant | Purpose |
| --- | --- |
| `cationly` | Assesses only the requirements relating to Common Access Card authentication |

## What you can do with this content

### Audit

Run the audit profile against an Ubuntu system to assess it against the benchmark and
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
updates, unattended upgrades, manual changes, and configuration management from other
tools all move a system away from its approved state. Running the audit profile on a
schedule turns a one-time assessment into continuous evidence, and
[compliance reporting in Chef Automate](/automate/reports/) shows how results change
over time.

## Remediation

Remediation content is delivered as [Chef Infra cookbooks](/client/latest/cookbooks/)
that correct the configuration behind a failed benchmark requirement, so you can close
findings with the same tooling you already use to manage the system.

Ubuntu 18.04, 22.04, and 24.04 (CIS), together with the Ubuntu 20.04 STIG, have matching
audit and remediation versions. Check the version tables above before you plan a
hardening rollout, because remediation and audit versions don't always line up.

- **Ubuntu 12.04, 14.04, and 16.04 (CIS)** are audit only. You can assess systems and
  act on the findings, but matching remediation content isn't available.
- **Ubuntu 20.04 (CIS)** is partial. Audit covers v1.0.0 and v1.1.0, but remediation
  covers v1.0.0 only, so plan hardening against the version you can actually remediate.

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
