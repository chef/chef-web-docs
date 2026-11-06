+++
title = "IBM AIX"

[menu.premium_content]
  identifier = "premium_content/operating_systems/ibm_aix"
  parent = "premium_content/operating_systems"
  title = "IBM AIX"
  weight = 60
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) for IBM AIX define secure configuration requirements for AIX 5.3 through AIX 7.2.
Chef Premium Content provides these requirements as Chef InSpec audit profiles, without remediation content.

## What the benchmarks check

The requirements cover the following areas in the AIX 7.2 benchmark at v1.1.0:

- **System configuration:** Collecting configuration regularly, and allowlisting authorized scripts
- **File systems:** File system and logical volume encryption, default umask, and group write permissions
- **Network services:** Services to turn off, and NIS and SNMP settings
- **Accounts and passwords:** Password expiration and password attributes
- **Privilege escalation:** Executables that elevate privileges, and sudo
- **Patching:** Using FLRT and FLRTVC regularly
- **Logging and auditing:** Local and remote syslog, and AIX auditing

The exact requirements differ by benchmark and version.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS IBM AIX 5.3` | v1.1.0 | --- | Audit Only |
| `CIS IBM AIX 7` | v1.0.0, v1.1.0, v1.2.0 | --- | Audit Only |
| `CIS IBM AIX 7.1` | v1.1.0, v2.1.0 | --- | Audit Only |
| `CIS IBM AIX 7.2` | v1.1.0 | --- | Audit Only |

Audit and remediation coverage are tracked separately.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables)
for what each coverage term means.

## Available profiles

IBM AIX profile names have no single pattern. The platform token is spelled three
different ways across the four benchmarks, so a reader who infers a name from one
benchmark will construct a name that doesn't exist for another. The complete set of
profiles is listed below instead of a pattern.

| Benchmark | Profiles |
| --- | --- |
| CIS IBM AIX 5.3 (v1.1.0) | `cis-aix-5.3-6.1-level1-v1.1.0`, `cis-aix-5.3-6.1-level2-v1.1.0` |
| CIS IBM AIX 7 (v1.0.0) | `cis-ibmaix7-level1-v1.0.0`, `cis-ibmaix7-level2-v1.0.0` |
| CIS IBM AIX 7 (v1.1.0) | `cis-ibmaix7-level1-v1.1.0`, `cis-ibmaix7-level2-v1.1.0` |
| CIS IBM AIX 7 (v1.2.0) | `cis-ibmaix7-level1-v1.2.0`, `cis-ibmaix7-level2-v1.2.0` |
| CIS IBM AIX 7.1 (v1.1.0) | `cis-aix7.1-level1-v1.1.0`, `cis-aix7.1-level2-v1.1.0` |
| CIS IBM AIX 7.1 (v2.1.0) | `cis-aix7.1-level1-v2.1.0`, `cis-aix7.1-level2-v2.1.0` |
| CIS IBM AIX 7.2 (v1.1.0) | `cis-aix7.2-level1-v1.1.0`, `cis-aix7.2-level2-v1.1.0` |

The only axis is CIS profile level, `level1` and `level2`. There's no server or
workstation scope on any IBM AIX profile at any version, unlike most other platforms
covered in this section.

The three spellings are worth holding onto: the AIX 5.3 benchmark uses
`aix-5.3-6.1`, the AIX 7 benchmark uses `ibmaix7`, and the point release benchmarks use
`aix7.1` and `aix7.2`. The AIX 7 benchmark is the odd one, prefixing `ibm` where the
others don't.

The AIX 5.3 benchmark covers AIX 5.3 and AIX 6.1 together, which is why its token
carries the range `5.3-6.1`. That single benchmark is the published coverage for both
releases.

Choose the level that matches your risk posture:

- **Level 1** applies settings that improve security with limited operational impact.
  It's the common starting point for production systems.
- **Level 2** extends Level 1 with defense-in-depth settings intended for environments
  with stricter requirements. Level 2 is more likely to affect how applications behave,
  so test it before rolling it out broadly.

## What you can do with this content

### Audit

Run the audit profile against an IBM AIX system to assess it against the benchmark and
report which requirements pass and which fail. Each failure identifies the specific
setting that doesn't meet the standard, so the result is an actionable list rather than
a score.

You can run audit content with [Chef InSpec](/inspec/latest/), the
[Compliance Phase](/client/latest/features/chef_compliance_phase/) during a Chef Infra
Client run, or an [Automate scan job](/automate/scan_jobs/).

### Harden

There's no remediation content for IBM AIX at any version, so hardening is yours to
implement. The audit results still tell you precisely which settings to change, giving
you a concrete list to work from rather than a blank benchmark.

### Detect drift

A system that passed an audit at build time doesn't stay compliant on its own. Package
updates, manual changes, and configuration management from other tools all move a system
away from its approved state. Running the audit profile on a schedule turns a one-time
assessment into continuous evidence, and
[compliance reporting in Chef Automate](/automate/reports/) shows how results change over
time.

## Remediation

All four IBM AIX benchmarks are audit only. You can assess systems against the
benchmark and act on the findings, but no matching Chef Infra cookbooks are published
for this platform. See
[The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
for writing your own content to close the findings an audit reports.

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
