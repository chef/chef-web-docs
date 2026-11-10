+++
title = "Apple macOS"

[menu.premium_content]
  identifier = "premium_content/desktop_client/apple_macos"
  parent = "premium_content/desktop_client"
  title = "Apple macOS"
  weight = 10
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) for Apple macOS define secure configuration requirements for macOS releases from 10.5 through 13.0.
Chef Premium Content provides Chef InSpec audit profiles and remediation content for these benchmarks.
Coverage varies by benchmark and version. See the coverage tables on this page for details.
Most of this coverage is audit only, so check the following table before you plan a hardening rollout.

## What the benchmarks check

The requirements cover the following areas in the macOS 13.0 benchmark at v2.0.0:

- **Software updates:** Update checks, automatic installs, and update deferment
- **System settings:** Sharing, location services, power, and iCloud settings
- **Logging and auditing:** Security auditing, audit flags, and log retention
- **Network:** Bonjour advertising, and HTTP and NFS servers
- **Authentication and authorization:** Home folder security, password complexity, and sudo timestamps
- **User interface and browser:** File name extensions and Safari settings

The exact requirements differ by benchmark and version.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Apple macOS 10.5` | v1.1.0 | --- | Audit Only |
| `CIS Apple macOS 10.6` | v1.0.0 | --- | Audit Only |
| `CIS Apple macOS 10.8` | v1.3.0 | --- | Audit Only |
| `CIS Apple macOS 10.9` | v1.3.0 | --- | Audit Only |
| `CIS Apple macOS 10.10` | v1.2.0 | --- | Audit Only |
| `CIS Apple macOS 10.11` | v1.1.0 | --- | Audit Only |
| `CIS Apple macOS 10.12` | v1.0.0 | --- | Audit Only |
| `CIS Apple macOS 10.13` | v1.0.0 | --- | Audit Only |
| `CIS Apple macOS 10.14` | v1.0.0 | v1.0.0 | Audit + Remediation |
| `CIS Apple macOS 10.15` | v1.0.0 | v1.0.0 | Audit + Remediation |
| `CIS Apple macOS 11.0` | v1.2.0 | --- | Audit Only |
| `CIS Apple macOS 13.0` | v2.0.0 | --- | Audit Only |

Audit and remediation coverage are tracked separately.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables) for what each coverage term means.

## Available profiles

Each benchmark version ships as two Chef InSpec profiles, one for each CIS profile level:

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |

The platform token in the profile name depends on the macOS release:

| macOS releases | Profile name pattern |
| --- | --- |
| 10.5, 10.6, 10.8, 10.9, 10.10, 10.11, and 10.12 | `cis-appleosx<os-version>-<level>-v<benchmark-version>` |
| 10.13, 10.14, 10.15, and 11.0 | `cis-applemacos<os-version>-<level>-v<benchmark-version>` |
| 13.0 | `cis-applemacos13.0ventura-<level>-v<benchmark-version>` |

For example, the CIS Level 1 profile for macOS 10.12 at benchmark v1.0.0 is `cis-appleosx10.12-level1-v1.0.0`.
The CIS Level 2 profile for macOS 13.0 at benchmark v2.0.0 is `cis-applemacos13.0ventura-level2-v2.0.0`.

Choose the level that matches your risk posture:

- **Level 1** applies settings that improve security with limited operational impact.
- **Level 2** extends Level 1 with defense-in-depth settings for stricter environments, and is more likely to affect how applications behave.

## What you can do with this content

### Audit

Run the audit profile against a macOS system to assess it against the benchmark and report which requirements pass and which fail.
Each failure identifies the specific setting that doesn't meet the standard, so the result is an actionable list rather than a score.

You can run audit content with [Chef InSpec](/inspec/latest/), the [Compliance Phase](/client/latest/features/chef_compliance_phase/) during a Chef Infra Client run, or an [Automate scan job](/automate/scan_jobs/).

### Harden

Where remediation content is available for a benchmark version, you can correct the configuration behind a failed requirement rather than writing the fix yourself.
For macOS, this applies to macOS 10.14 and macOS 10.15.

### Detect drift

A macOS system that passed an audit doesn't stay compliant on its own.
Operating system updates, application installs, and changes made by the person using the system can all move it away from its approved state.
Running the audit profile on a schedule turns a one-time assessment into continuous evidence, and [compliance reporting in Chef Automate](/automate/reports/) shows how results change over time.

## Remediation

Remediation content is delivered as [Chef Infra cookbooks](/client/latest/cookbooks/) that correct the configuration behind a failed benchmark requirement, so you can close findings with the same tooling you use to manage the system.

Check the version table before you plan a hardening rollout, because remediation isn't available for most macOS releases:

- **macOS 10.14 and macOS 10.15** have matching audit and remediation content at v1.0.0.
- **All other listed macOS releases**, including macOS 11.0 and macOS 13.0, are audit only.
  You can assess those systems and act on the findings, but matching remediation content isn't available.

## Access this content

Chef Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement includes, and contact your Chef account representative to confirm your access.

## Related

- [Desktop / client coverage](/premium_content/desktop_client/)
- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [The Chef Way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
