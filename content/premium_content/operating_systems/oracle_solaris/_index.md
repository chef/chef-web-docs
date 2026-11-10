+++
title = "Oracle Solaris"

[menu.premium_content]
  identifier = "premium_content/operating_systems/oracle_solaris"
  parent = "premium_content/operating_systems"
  title = "Oracle Solaris"
  weight = 80
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) for Oracle Solaris define secure configuration requirements for Oracle Solaris 10 and 11.
Chef Premium Content provides these requirements as Chef InSpec audit profiles, without remediation content.

## What the benchmarks check

The requirements cover the following areas in the Oracle Solaris 11.2 benchmark at v1.1.0:

- **Package updates:** Using the latest package updates
- **Services:** Services to turn off, such as NIS, GSS, and Apache
- **Kernel and network:** Core dumps, broadcast forwarding, and ICMP handling
- **Auditing:** Audit classes, and auditing of connections, file changes, and privileges
- **File permissions:** The sticky bit on world-writable directories
- **System access:** Serial sign-in, SSH, FTP, and scheduled jobs
- **User accounts:** Password expiration, password strength, and default umask
- **Warning banners:** Banners for sign-in services, SSH, GNOME, and FTP
- **System maintenance:** Remote consoles, home directories, and user `.netrc` files

The exact requirements differ by benchmark and version.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Oracle Solaris 10` | v5.2.0 | --- | Audit Only |
| `CIS Oracle Solaris 11` | v1.1.0 | --- | Audit Only |
| `CIS Oracle Solaris 11.1` | v1.0.0 | --- | Audit Only |
| `CIS Oracle Solaris 11.2` | v1.1.0 | --- | Audit Only |

Audit and remediation coverage are tracked separately.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables)
for what each coverage term means.

## Available profiles

Each benchmark version ships two Chef InSpec profiles, one for each CIS profile level.
There's no server or workstation scope on any Oracle Solaris profile at any version:
the only axis is level.

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |

Profile names follow a consistent pattern, so you can predict the name you need:

```text
cis-oraclesolaris<os-version>-<level>-v<benchmark-version>
```

For example, the CIS Level 1 profile for Oracle Solaris 11.2 at benchmark v1.1.0 is
`cis-oraclesolaris11.2-level1-v1.1.0`.

The OS version in the profile name keeps its dot, as in `oraclesolaris11.1` and
`oraclesolaris11.2`, not `oraclesolaris111`.

Benchmark versions don't track OS versions here.
Oracle Solaris 10 is at benchmark v5.2.0, and Oracle Solaris 11 is at v1.1.0.
Check the table above before you compare versions across releases.

Choose the level that matches your risk posture:

- **Level 1** applies settings that improve security with limited operational impact.
  It's the common starting point for production systems.
- **Level 2** extends Level 1 with defense-in-depth settings intended for environments
  with stricter requirements. Level 2 is more likely to affect how applications behave,
  so test it before rolling it out broadly.

That's 8 profiles total across the four supported benchmarks.

## What you can do with this content

### Audit

Run the audit profile against an Oracle Solaris system to assess it against the
benchmark and report which requirements pass and which fail. Each failure identifies
the specific setting that doesn't meet the standard, so the result is an actionable
list rather than a score.

You can run audit content with [Chef InSpec](/inspec/latest/), the
[Compliance Phase](/client/latest/features/chef_compliance_phase/) during a Chef Infra
Client run, or an [Automate scan job](/automate/scan_jobs/).

### Harden

Remediation content isn't available for Oracle Solaris at any version, so hardening is
yours to implement. The audit results still tell you precisely which settings to
change, including the expected value for each one, so you can apply the fix with
whatever tooling you already use to manage the system.

### Detect drift

A system that passed an audit at build time doesn't stay compliant on its own. Package
updates, manual changes, and configuration management from other tools all move a system
away from its approved state. Running the audit profile on a schedule turns a one-time
assessment into continuous evidence, and
[compliance reporting in Chef Automate](/automate/reports/) shows how results change over
time.

## Remediation

All four Oracle Solaris benchmarks are audit only: you can assess systems and act on
the findings, but no matching Chef Infra cookbooks are published for this platform.
If you need to close findings with reusable, maintainable content, see
[The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
for writing your own.

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
