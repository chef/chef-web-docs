+++
title = "Microsoft IIS"

[menu.premium_content]
  identifier = "premium_content/web_servers/microsoft_iis"
  parent = "premium_content/web_servers"
  title = "Microsoft IIS"
  weight = 20
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) and [DISA STIGs](https://public.cyber.mil/stigs/) for Microsoft Internet Information Services (IIS) define secure configuration requirements for IIS 10.
Chef Premium Content provides these requirements as Chef InSpec audit profiles and remediation content, and coverage differs by benchmark and version, so check the following version table.

## What the benchmarks check

The CIS requirements cover the following areas in the Microsoft IIS 10 benchmark at v1.1.1:

- **Basic configuration:** Web content location, host headers, directory browsing, and application pool identity
- **Configure authentication and authorization:** Authorization rules, forms authentication, and password format
- **ASP.NET configuration:** Deployment method, detailed errors, cookies, and .NET trust levels
- **Request filtering:** Content length, query strings, double-encoded requests, and file extensions
- **Logging:** Log location, advanced logging, and ETW logging
- **FTP:** Encrypted FTP requests and sign-in attempt restrictions
- **Transport encryption:** HSTS, TLS versions, and cipher suites

The STIG states its requirements individually.
The IIS 10.0 STIG includes requirements for enhanced logging, accounts created by uninstalled features, and SHA-2 encryption.

The exact requirements differ by benchmark and version.

## Supported versions

### CIS

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Microsoft IIS 10` | v1.1.1 | v1.1.1 | Audit + Remediation |

### STIG

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `STIG Microsoft IIS 10.0` | v2 | --- | Audit Only |

Audit and remediation coverage are tracked separately.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables) for what each coverage term means.

## Available profiles

The CIS and STIG benchmarks use different platform tokens and name their profiles differently.
The following sections give the names for each framework.

### CIS profiles

The benchmark ships as two Chef InSpec profiles, one for each CIS profile level:

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |

```text
cis-microsoftiis10-<level>-iis10-v1.1.1
```

For example, the CIS Level 1 profile is `cis-microsoftiis10-level1-iis10-v1.1.1`.

Choose the level that matches your risk posture:

- **Level 1** applies settings that improve security with limited operational impact.
- **Level 2** extends Level 1 with defense-in-depth settings for stricter environments, and is more likely to affect how applications behave.

### STIG profiles

STIG content isn't organized by level.
It's organized by the DISA Mission Assurance Category and confidentiality level of the system, which together determine how strict the applicable requirements are:

| Axis | Values |
| --- | --- |
| Mission Assurance Category | `i-missioncritical`, `ii-missionsupport`, `iii-administrative` |
| Confidentiality | `classified`, `public`, `sensitive` |

```text
stig-microsoftiis10.0server-<mac><confidentiality>-v2
```

For example, the MAC II mission support profile for a sensitive system is `stig-microsoftiis10.0server-ii-missionsupportsensitive-v2`.

That gives nine profiles.
The version in the name is `v2`, with no minor or patch number.

## What you can do with this content

### Audit

Run the audit profile against a system running IIS to assess it against the benchmark and report which requirements pass and which fail.
Each failure identifies the specific setting that doesn't meet the standard, so the result is an actionable list rather than a score.

You can run audit content with [Chef InSpec](/inspec/latest/), the [Compliance Phase](/client/latest/features/chef_compliance_phase/) during a Chef Infra Client run, or an [Automate scan job](/automate/scan_jobs/).

### Harden

Where remediation content is available for a benchmark version, you can correct the configuration behind a failed requirement rather than writing the fix yourself.
For IIS, this applies to the CIS benchmark only.

### Detect drift

An IIS server that passed an audit doesn't stay compliant on its own.
Site deployments, role and feature changes, and manual configuration changes can all move it away from its approved state.
Running the audit profile on a schedule turns a one-time assessment into continuous evidence, and [compliance reporting in Chef Automate](/automate/reports/) shows how results change over time.

## Remediation

Remediation content is delivered as [Chef Infra cookbooks](/client/latest/cookbooks/) that correct the configuration behind a failed benchmark requirement, so you can close findings with the same tooling you use to manage the system.

Check the version tables before you plan a hardening rollout, because remediation isn't available for both frameworks:

- **CIS Microsoft IIS 10** has matching audit and remediation content at v1.1.1.
- **The Microsoft IIS 10.0 STIG** is audit only.
  You can assess servers and act on the findings, but matching remediation content isn't available.

## Access this content

Chef Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement includes, and contact your Chef account representative to confirm your access.

## Related

- [Web servers coverage](/premium_content/web_servers/)
- [Windows Server](/premium_content/operating_systems/windows_server/)
- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
