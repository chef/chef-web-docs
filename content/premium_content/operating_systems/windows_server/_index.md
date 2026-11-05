+++
title = "Windows Server"

[menu.premium_content]
  identifier = "premium_content/operating_systems/windows_server"
  parent = "premium_content/operating_systems"
  title = "Windows Server"
  weight = 20
+++

Windows Server runs a large share of enterprise directory, file, and
application workloads, and it's usually the platform under the heaviest audit scrutiny.
Windows Server estates also tend to be long-lived, so most organizations are assessing
several releases at once, against more than one standard.

Chef Premium Content covers Windows Server against both the
[CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) and the
[DISA STIGs](https://public.cyber.mil/stigs/). It's the broadest coverage in the
catalog, spanning Windows Server 2012 through Windows Server 2025.

## Supported versions

### CIS

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Microsoft Windows Server 2012` | v2.0.1, v2.3.0 | v2.2.0, v2.3.0 | Partial Audit + Remediation |
| `CIS Microsoft Windows Server 2012r2` | v2.2.1, v2.3.0, v2.5.0, v3.0.0 | v2.4.0, v2.5.0 | Partial Audit + Remediation |
| `CIS Microsoft Windows Server 2016` | v1.4.0, v2.0.0, v3.0.0 | v1.4.0 | Partial Audit + Remediation |
| `CIS Microsoft Windows Server 2016-1607` | v1.0.0, v1.1.0, v1.2.0, v1.3.0 | --- | Audit Only |
| `CIS Microsoft Windows Server 2019` | v1.1.0, v1.2.1, v1.3.0, v2.0.0, v3.0.1, v4.0.0 | v1.2.1, v1.3.0, v2.0.0, v4.0.0 | Partial Audit + Remediation |
| `CIS Microsoft Windows Server 2022` | v1.0.0, v2.0.0, v3.0.0, v4.0.0 | v1.0.0, v4.0.0 | Partial Audit + Remediation |
| `CIS Microsoft Windows Server 2025` | v1.0.0 | --- | Audit Only |

### STIG

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `STIG Microsoft Windows Server 2012` | v2.14.0, v2.15.0, v2.16.0, v2.17.0 | --- | Audit Only |
| `STIG Microsoft Windows Server 2012r2` | --- | v3.1.0 | Remediation Only |
| `STIG Microsoft Windows Server 2016` | v1.6.0, v1.9.0, v1.10.0, v1.11.0, v1.12.0, v2.1.0 | v2.1.0 | Partial Audit + Remediation |
| `STIG Microsoft Windows Server 2019` | v1.1.0, v1.2.0, v2.1.0, v2.2.0 | v2.1.0, v2.2.0 | Partial Audit + Remediation |
| `STIG Microsoft Windows Server 2022` | v1.2.0 | v2.3.0 | Remediation Ahead |

Audit and remediation coverage are tracked separately, and a benchmark can have more
versions of one than the other.
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

Note that the platform token is `windows<version>`, not the full benchmark title. The
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

For example, the MAC II mission support profile for a sensitive Windows Server 2016
system at benchmark v2.1.0 is
`stig-microsoftwindowsserver2016-ii-missionsupportsensitive-v2.1.0`.

That gives nine combinations for each benchmark version. Two further variants ship alongside
them:

| Variant | Purpose |
| --- | --- |
| `cationly` | Assesses only the requirements relating to Common Access Card authentication |
| `disableslowrules` | Omits the checks that take longest to execute, for faster feedback during development |

Windows Server 2012 and 2012r2 STIG profiles additionally carry a role token in the
name, so confirm the exact profile name for those releases before you run them.

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

- **Windows Server 2016-1607 and 2025 (CIS)** and the **Windows Server 2012 STIG** are
  audit only. You can assess systems and act on the findings, but matching remediation
  content isn't available.
- **The Windows Server 2012r2 STIG** is remediation only, with no audit profile.
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
