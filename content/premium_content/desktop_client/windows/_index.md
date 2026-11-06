+++
title = "Windows"

[menu.premium_content]
  identifier = "premium_content/desktop_client/windows"
  parent = "premium_content/desktop_client"
  title = "Windows"
  weight = 20
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) and [DISA STIGs](https://public.cyber.mil/stigs/) for Windows client releases define secure configuration requirements for Windows 10 and Windows 11.
Chef Premium Content provides these requirements as Chef InSpec audit profiles and remediation content, and coverage differs by benchmark and version, so check the following version table.
Benchmarks for Windows 10 are specific to a release, so identify the release you're running before you choose a profile.
For server releases, see [Windows Server](/premium_content/operating_systems/windows_server/).

## What the benchmarks check

The CIS requirements cover the following areas in the Windows 11 benchmark at v3.0.0:

- **Account policies:** Password settings
- **Local policies:** User rights assignments and security options
- **System services:** Services to turn off, such as Bluetooth Audio Gateway and OpenSSH Server
- **Windows Firewall:** Firewall state and logging for the domain, private, and public profiles
- **Advanced audit policy:** Which account, file share, and policy change events are recorded
- **Administrative templates:** Computer and user settings, such as virtualization-based security and lock screen behavior

The STIG states its requirements individually.
The Windows 11 STIG at v2.2.0 includes requirements for audit events, Microsoft Defender SmartScreen, and SMB signing.

The exact requirements differ by benchmark and version.

## Supported versions

### CIS

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Microsoft Windows 10-1511` | v1.1.0 | --- | Audit Only |
| `CIS Microsoft Windows 10-1909` | v1.8.1 | v1.8.1 | Audit + Remediation |
| `CIS Microsoft Windows 10-2004` | v1.9.1 | v1.9.1 | Audit + Remediation |
| `CIS Microsoft Windows 10-20h2` | v1.10.0 | --- | Audit Only |
| `CIS Microsoft Windows 10-21h1` | v1.11.0 | v1.11.0 | Audit + Remediation |
| `CIS Microsoft Windows 11` | v3.0.0 | --- | Audit Only |

### STIG

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `STIG Microsoft Windows 10` | --- | v2.1.0 | Remediation Only |
| `STIG Microsoft Windows 11` | v1.2.0, v2.2.0 | v2.2.0 | Partial Audit + Remediation |

Audit and remediation coverage are tracked separately, and a benchmark can have more versions of one than the other.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables) for what each coverage term means.

## Available profiles

The profiles that ship depend on the framework and the release.
The following sections give the naming pattern and the values each part can take.

### CIS profiles

CIS profile names combine a platform token, a variant, and the benchmark version:

```text
cis-<platform-token>-<variant>-v<benchmark-version>
```

The platform token depends on the release:

| Benchmark | Platform token | Benchmark version |
| --- | --- | --- |
| `CIS Microsoft Windows 10-1511` | `windows10-1511` | v1.1.0 |
| `CIS Microsoft Windows 10-1909` | `windows10enterpriserelease1909` | v1.8.1 |
| `CIS Microsoft Windows 10-2004` | `windows10enterpriserelease2004` | v1.9.1 |
| `CIS Microsoft Windows 10-20h2` | `windows10enterpriserelease20h2` | v1.10.0 |
| `CIS Microsoft Windows 10-21h1` | `windows10enterpriserelease21h1` | v1.11.0 |
| `CIS Microsoft Windows 11` | `windows11enterprise` | v3.0.0 |

Windows 10 release 1511 ships four variants: `level1`, `level2`, `level1-bitlocker`, and `level2-bitlocker`.

The later releases use longer variant names, and they don't all ship the same set:

| Variant | 1909, 2004, and 20H2 | 21H1 | Windows 11 |
| --- | --- | --- | --- |
| `level1-corporate-enterpriseenvironmentgeneraluse` | Yes | Yes | Yes |
| `level1-bitlocker` | Yes | Yes | Yes |
| `level1-nextgenerationwindowssecurity` | Yes | Yes | No |
| `level1-bitlocker-nextgenerationwindowssecurity` | Yes | Yes | No |
| `level2-highsecurity-sensitivedataenvironmentlimitedfunctionality` | Yes | Yes | Yes |
| `level2-bitlocker` | Yes | Yes | Yes |
| `level2-nextgenerationwindowssecurity` | Yes | Yes | No |
| `level2-bitlocker-nextgenerationwindowssecurity` | Yes | Yes | No |
| `bitlocker-optionaladd-onforwhenbitlockerisdeployed` | Yes | No | Yes |
| `nextgenerationwindowssecurity-optionaladd-onforuseinthenewesthardwareandconfigurationenvironments` | Yes | No | No |

For example, the CIS Level 1 corporate profile for Windows 10 release 2004 at benchmark v1.9.1 is `cis-windows10enterpriserelease2004-level1-corporate-enterpriseenvironmentgeneraluse-v1.9.1`.
The CIS Level 1 profile for Windows 10 release 1511 at benchmark v1.1.0 is `cis-windows10-1511-level1-v1.1.0`.

Choose the variant that matches your risk posture and the features you've deployed:

- **Level 1** applies settings that improve security with limited operational impact, and its base variant is for general enterprise use.
- **Level 2** extends Level 1 with defense-in-depth settings for high-security or sensitive-data environments, and is more likely to limit functionality.
- **BitLocker** variants and add-ons apply where BitLocker is deployed.
- **Next Generation Windows Security** variants and add-ons apply to newer hardware and configuration environments.

### STIG profiles

STIG content isn't organized by level.
It's organized by the DISA Mission Assurance Category and confidentiality level of the system, which together determine how strict the applicable requirements are:

| Axis | Values |
| --- | --- |
| Mission Assurance Category | `i-missioncritical`, `ii-missionsupport`, `iii-administrative` |
| Confidentiality | `classified`, `public`, `sensitive` |

```text
stig-microsoftwindows11-<mac><confidentiality>-v<benchmark-version>
```

For example, the MAC II mission support profile for a sensitive Windows 11 system at benchmark v2.2.0 is `stig-microsoftwindows11-ii-missionsupportsensitive-v2.2.0`.

That gives nine combinations for each benchmark version.
Two further variants ship with them:

| Variant | Purpose |
| --- | --- |
| `cationly` | Assesses only the requirements relating to Common Access Card authentication |
| `disableslowrules` | Omits the checks that take longest to execute, for faster feedback during development |

This naming applies only to the Windows 11 STIG.
The Windows 10 STIG is remediation only, so no audit profiles are published for it.

## What you can do with this content

### Audit

Run the audit profile against a Windows system to assess it against the benchmark and report which requirements pass and which fail.
Each failure identifies the specific setting that doesn't meet the standard, which matters on Windows, where a single finding often maps to one registry value or Group Policy setting.

You can run audit content with [Chef InSpec](/inspec/latest/), the [Compliance Phase](/client/latest/features/chef_compliance_phase/) during a Chef Infra Client run, or an [Automate scan job](/automate/scan_jobs/).

### Harden

Where remediation content is available for a benchmark version, you can correct the configuration behind a failed requirement rather than writing the fix yourself.

### Detect drift

Windows endpoints drift for reasons outside your change process.
Group Policy refreshes, application installs, and Windows Update can all move a system away from its approved state.
Running the audit profile on a schedule turns a one-time assessment into continuous evidence, and [compliance reporting in Chef Automate](/automate/reports/) shows how results change over time.

## Remediation

Remediation content is delivered as [Chef Infra cookbooks](/client/latest/cookbooks/) that correct the configuration behind a failed benchmark requirement, so you can close findings with the same tooling you use to manage the system.

Check the version tables before you plan a hardening rollout, because remediation and audit versions don't always line up:

- **CIS Windows 10 releases 1909, 2004, and 21H1** have matching audit and remediation content.
- **CIS Windows 10 releases 1511 and 20H2, and CIS Windows 11**, are audit only.
  You can assess those systems and act on the findings, but matching remediation content isn't available.
- **The Windows 11 STIG** is partial.
  Audit covers v1.2.0 and v2.2.0, but remediation covers v2.2.0 only.
- **The Windows 10 STIG** is remediation only, at v2.1.0.
  There's no audit profile, so you can't use Chef Premium Content to assess a system against this STIG before or after you apply the cookbook.

## Access this content

Chef Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement includes, and contact your Chef account representative to confirm your access.

## Related

- [Desktop / client coverage](/premium_content/desktop_client/)
- [Windows Server](/premium_content/operating_systems/windows_server/)
- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
