+++
title = "Windows Server"

[menu.premium_content]
  identifier = "premium_content/operating_systems/windows_server"
  parent = "premium_content/operating_systems"
  title = "Windows Server"
  weight = 130
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) and [DISA STIGs](https://public.cyber.mil/stigs/) for Windows Server define secure configuration requirements for Windows Server releases from 2012 through 2025.
Chef Premium Content provides Chef InSpec audit profiles and remediation content for these benchmarks.
Coverage varies by benchmark and version. See the coverage tables on this page for details.

## What the benchmarks check

The CIS requirements cover the following areas in the Windows Server 2022 benchmark at v4.0.0:

- **Account policies:** Password and account lockout settings
- **Local policies:** User rights assignments and security options
- **Windows Firewall:** Firewall state for the domain, private, and public profiles
- **Advanced audit policy:** Which account, policy, and privilege events are recorded
- **Administrative templates:** Computer and user settings managed through Group Policy

The STIG states its requirements individually.
The Windows Server 2019 STIG at v2.2.0 includes requirements for audit events, user rights, Remote Desktop Services, and network signing.

The exact requirements differ by release, benchmark version, and profile.

## Supported versions

### CIS

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Microsoft Windows Server 2012` | v2.0.1, v2.3.0 | v2.2.0, v2.3.0 | Partial Audit + Remediation |
| `CIS Microsoft Windows Server 2012r2` | v2.2.1, v2.3.0, v2.5.0, v3.0.0 | v2.4.0, v2.5.0 | Partial Audit + Remediation |
| `CIS Microsoft Windows Server 2016` | v1.4.0, v2.0.0, v3.0.0 | v1.1.0, v1.2.0, v1.3.0, v2.0.0 | Partial Audit + Remediation |
| `CIS Microsoft Windows Server 2016-1607` | v1.0.0, v1.1.0, v1.2.0, v1.3.0 | --- | Audit Only |
| `CIS Microsoft Windows Server 2019` | v1.3.0, v2.0.0, v3.0.1, v4.0.0 | v1.1.0, v1.2.1, v2.0.0, v4.0.0 | Partial Audit + Remediation |
| `CIS Microsoft Windows Server 2022` | v1.0.0, v2.0.0, v3.0.0, v4.0.0 | v1.0.0, v2.0.0, v4.0.0 | Partial Audit + Remediation |
| `CIS Microsoft Windows Server 2025` | v1.0.0, v2.1.0 | v1.0.0, v2.1.0 | Audit + Remediation |

### STIG

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `STIG Microsoft Windows Server 2012r2` | --- | v3.1.0 | Remediation Only |
| `STIG Microsoft Windows Server 2016` | --- | v2.1.0 | Remediation Only |
| `STIG Microsoft Windows Server 2019` | v2.2.0 | v2.1.0, v2.2.0 | Partial Audit + Remediation |
| `STIG Microsoft Windows Server 2022` | v1.2.0 | v2.3.0 | Remediation Ahead |

Chef tracks audit and remediation coverage separately.
A benchmark can have more audit versions than remediation versions, or vice versa.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables)
for what each coverage term means.

## Available profiles

Windows Server ships more than 300 Chef InSpec profiles across these benchmarks, because
each benchmark version is split into several variants. Rather than list them all, the
sections below give the naming pattern and the values each part can take, so you can
work out the profile you need.

### CIS profiles

CIS benchmark versions ship as four profiles, one for every combination of profile level
and server role:

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |
| Role | `memberserver`, `domaincontroller` |

```text
cis-windows<os-version>-<level>-<role>-v<benchmark-version>
```

For example, the CIS Level 1 member server profile for Windows Server 2022 at benchmark
v2.0.0 is `cis-windows2022-level1-memberserver-v2.0.0`.

The platform name in the profile is `windows<version>`, not the full benchmark title. The
one exception is Windows Server 2016-1607, which uses `windows2016rtm-release1607`.

- **Level 1** applies settings that improve security with limited operational impact.
- **Level 2** extends Level 1 with defense-in-depth settings for stricter environments,
  and is more likely to affect application behavior.
- **Member server** targets systems joined to a domain in an application or file server
  role.
- **Domain controller** targets systems running Active Directory Domain Services, which
  carry additional requirements that don't apply to member servers.

### STIG profiles

STIG content isn't organized by level. It's organized by the DISA Mission Assurance
Category and confidentiality level of the system, which together determine how strict
the applicable requirements are:

| Axis | Values |
| --- | --- |
| Mission Assurance Category | `i-missioncritical`, `ii-missionsupport`, `iii-administrative` |
| Confidentiality | `classified`, `public`, `sensitive` |

```text
stig-microsoftwindowsserver<os-version>-<mac><confidentiality>-v<benchmark-version>
```

For example, the MAC II mission support profile for a sensitive Windows Server 2019
system at benchmark v2.2.0 is
`stig-microsoftwindowsserver2019-ii-missionsupportsensitive-v2.2.0`.

That gives nine combinations for each benchmark version. Two further variants ship alongside
them:

| Variant | Purpose |
| --- | --- |
| `cationly` | Assesses only the requirements relating to Common Access Card authentication |
| `disableslowrules` | Omits the checks that take longest to execute, for faster feedback during development |

This naming applies to the Windows Server 2019 and 2022 STIGs, which are the STIG
benchmarks with audit content. The Windows Server 2012r2 and 2016 STIGs are remediation
only, so no audit profiles are published for them.

## What you can do with this content

### Audit

Run the audit profile against a Windows Server system to assess it against the benchmark
and report which requirements pass and which fail. Each failure identifies the specific
setting that doesn't meet the standard, which matters on Windows, where a single finding
often maps to one registry value or Group Policy setting.

You can run audit content with [Chef InSpec](/inspec/latest/), the
[Compliance Phase](/client/latest/features/chef_compliance_phase/) during a Chef Infra
Client run, or an [Automate scan job](/automate/scan_jobs/).

### Harden

Where remediation content is available for a benchmark version, you can correct the
configuration behind a failed requirement rather than writing the fix yourself.

### Detect drift

Windows Server configuration drifts for reasons outside your change process: Group
Policy refreshes, role and feature installs, and Windows Update can all move a system
away from its approved state. Running the audit profile on a schedule turns a one-time
assessment into continuous evidence, and
[compliance reporting in Chef Automate](/automate/reports/) shows how results change over
time.

## Remediation

Remediation content is delivered as [Chef Infra cookbooks](/client/latest/cookbooks/)
that correct the configuration behind a failed benchmark requirement, so you can close
findings with the same tooling you already use to manage the system.

Remediation coverage is available for most CIS benchmarks and for the Windows Server
2012r2, 2016, 2019, and 2022 STIGs. Check the version tables above before you plan a
hardening rollout: remediation and audit versions don't always line up.

- **Windows Server 2016-1607 (CIS)** is audit only. You can assess systems and act on
  the findings, but matching remediation content isn't available.
- **The Windows Server 2012r2 and 2016 STIGs** are remediation only, with no audit
  profile.
- **The Windows Server 2022 STIG** currently has remediation at a later version than the
  available audit content.

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
