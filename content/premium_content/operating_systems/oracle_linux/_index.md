+++
title = "Oracle Linux"

[menu.premium_content]
  identifier = "premium_content/operating_systems/oracle_linux"
  parent = "premium_content/operating_systems"
  title = "Oracle Linux"
  weight = 70
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) and [DISA STIGs](https://public.cyber.mil/stigs/) for Oracle Linux define secure configuration requirements for Oracle Linux 7 through 10.
Chef Premium Content provides Chef InSpec audit profiles and remediation content for these benchmarks.
Coverage varies by benchmark and version. See the coverage tables on this page for details.

## What the benchmarks check

The CIS requirements cover the following areas in the Oracle Linux 10 benchmark at v1.0.0:

- **Initial setup:** Filesystem kernel modules, partitions, package signing, and kernel settings
- **Services:** Services to remove, the GNOME Display Manager, and time synchronization
- **Network:** IPv6 status, network kernel modules, and redirect and logging settings
- **Host-based firewall:** firewalld installation and zone configuration
- **Access control:** SSH, account lockout, and password expiration
- **Logging and auditing:** AIDE, rsyslog, and audit rules
- **System maintenance:** Permissions on system files, world-writable files, and account consistency

The STIG states its requirements individually.
The Oracle Linux 8 STIG at v1.8.0 includes requirements for auditing, kernel settings, and kernel modules.

The exact requirements differ by benchmark and version.

## Supported versions

### CIS

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Oracle Linux 7` | v1.1.0, v3.1.1 | v3.1.1 | Partial Audit + Remediation |
| `CIS Oracle Linux 8` | v2.0.0, v3.0.0 | v2.0.0 | Partial Audit + Remediation |
| `CIS Oracle Linux 9` | v1.0.0, v2.0.0 | --- | Audit Only |
| `CIS Oracle Linux 10` | v1.0.0 | --- | Audit Only |

### STIG

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `STIG Oracle Linux 8` | v1.8.0 | --- | Audit Only |

Chef tracks audit and remediation coverage separately.
A benchmark can have more audit versions than remediation versions, or vice versa.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables)
for what each coverage term means.

## Available profiles

Oracle Linux ships a large number of Chef InSpec profiles across these benchmarks,
because each benchmark version is split into several variants. Rather than list them
all, the following sections give the naming pattern and the values each part can take,
so you can work out the profile you need.

### CIS profiles

CIS benchmark versions ship as four profiles, one for every combination of profile
level and system scope:

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |
| Scope | `server`, `workstation` |

```text
cis-oraclelinux<os-version>-<level>-<scope>-v<benchmark-version>
```

For example, the CIS Level 1 server profile for Oracle Linux 9 at benchmark v2.0.0 is
`cis-oraclelinux9-level1-server-v2.0.0`.

Whether a scope is present depends on the benchmark version, not the release. Oracle
Linux 7 at benchmark v1.1.0 ships level only, with no server or workstation scope, as
two profiles: `cis-oraclelinux7-level1-v1.1.0` and `cis-oraclelinux7-level2-v1.1.0`. At
v3.1.1, the same release ships the full four profiles with scope. Every other benchmark
version in the table above ships four profiles, so check the benchmark version before
you assume a scope is available.

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
stig-oraclelinux<os-version>-<mac><confidentiality>-v<benchmark-version>
```

For example, the MAC II mission support profile for a sensitive Oracle Linux 8 system
at benchmark v1.8.0 is `stig-oraclelinux8-ii-missionsupportsensitive-v1.8.0`.

Unlike Red Hat Enterprise Linux, where the CIS profiles use the short token
`rhel<version>` and the STIG profiles use the long token
`redhatenterpriselinux<version>`, Oracle Linux uses the same token `oraclelinux<version>`
for both CIS and STIG profiles. If you're coming from the Red Hat Enterprise Linux
page, you might expect a different long-form token for the STIG profiles. Oracle Linux
doesn't have one.

That gives nine combinations for each benchmark version. One further variant ships
alongside them:

| Variant | Purpose |
| --- | --- |
| `cationly` | Assesses only the requirements relating to Common Access Card authentication |

## What you can do with this content

### Audit

Run the audit profile against an Oracle Linux system to assess it against the
benchmark and report which requirements pass and which fail. Each failure identifies
the specific setting that doesn't meet the standard, so the result is an actionable
list rather than a score.

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

Oracle Linux 7 and 8 (CIS) are both partial, but in different directions. Oracle Linux
7 has remediation for v3.1.1, the later of its two audit versions. Oracle Linux 8 has
remediation for v2.0.0, the earlier of its two audit versions, so if you're planning a
rollout on the v3.0.0 audit content, matching remediation isn't available. Oracle
Linux 9 and 10 (CIS) are audit only. Check the version tables above before you plan a
hardening rollout, because remediation and audit versions don't always line up.

- **The Oracle Linux 8 STIG** is audit only. You can assess systems and act on the
  findings, but matching remediation content isn't available.

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
