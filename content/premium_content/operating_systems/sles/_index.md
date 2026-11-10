+++
title = "SUSE Linux Enterprise Server"

[menu.premium_content]
  identifier = "premium_content/operating_systems/sles"
  parent = "premium_content/operating_systems"
  title = "SUSE Linux Enterprise Server"
  weight = 110
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) for SUSE Linux Enterprise Server define secure configuration requirements for releases 11, 12, and 15.
Chef Premium Content provides Chef InSpec audit profiles and remediation content for these benchmarks.
Coverage varies by benchmark and version. See the coverage tables on this page for details.

## What the benchmarks check

The requirements cover the following areas in the SUSE Linux Enterprise Server 15 benchmark at v2.0.1:

- **Initial setup:** Filesystem kernel modules, partition options, package signing, and crypto policy
- **Services:** Services to remove, X Window servers, and time synchronization
- **Network:** IPv6 status, network kernel modules, and packet redirect settings
- **Host-based firewall:** Using a single firewall utility, and firewalld configuration
- **Access control:** SSH, account lockout, and password age
- **Logging and auditing:** AIDE, rsyslog, and audit rules
- **System maintenance:** Permissions on system files, world-writable files, and account consistency

The exact requirements differ by benchmark and version.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS SUSE Linux Enterprise Server 11` | v1.1.0 | --- | Audit Only |
| `CIS SUSE Linux Enterprise Server 12` | v1.0.0, v3.1.0 | --- | Audit Only |
| `CIS SUSE Linux Enterprise Server 15` | v1.0.0, v2.0.1 | v1.0.0 | Partial Audit + Remediation |

Audit and remediation coverage are tracked separately.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables)
for what each coverage term means.

## Available profiles

Each benchmark version ships as Chef InSpec profiles covering the applicable
combinations of CIS profile level and system scope:

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |
| Scope | `server`, `workstation` |

Profile names follow a consistent pattern, so you can predict the name you need:

```text
cis-sles<os-version>-<level>-<scope>-v<benchmark-version>
```

For example, the CIS Level 1 server profile for SUSE Linux Enterprise Server 15 at
benchmark v2.0.1 is `cis-sles15-level1-server-v2.0.1`.

The platform name in the profile is the short form `sles<version>`, as in `sles15`, even
though the benchmark itself is named "SUSE Linux Enterprise Server."

Whether a scope is present in a profile name depends on the benchmark version, not on
the release. SUSE Linux Enterprise Server 11 at v1.1.0 and SUSE Linux Enterprise
Server 12 at v1.0.0 ship level only, with no server or workstation scope:
`cis-sles11-level1-v1.1.0`, `cis-sles11-level2-v1.1.0`, `cis-sles12-level1-v1.0.0`, and
`cis-sles12-level2-v1.0.0`.
SUSE Linux Enterprise Server 12 at v3.1.0, and SUSE Linux Enterprise Server 15 at both
v1.0.0 and v2.0.1, ship the full four profiles with scope. Check the benchmark version
you're targeting before you construct a profile name, because assuming scope is always
present produces a name that doesn't exist.

Choose the level that matches your risk posture and the scope that matches the system's
role, where scope applies:

- **Level 1** applies settings that improve security with limited operational impact.
  It's the common starting point for production systems.
- **Level 2** extends Level 1 with defense-in-depth settings intended for environments
  with stricter requirements. Level 2 is more likely to affect how applications behave,
  so test it before rolling it out broadly.
- **Server** targets systems running without a graphical desktop.
- **Workstation** targets systems with an interactive desktop environment.

## What you can do with this content

### Audit

Run the audit profile against a SUSE Linux Enterprise Server system to assess it against
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
updates, manual changes, and configuration management from other tools all move a system
away from its approved state. Running the audit profile on a schedule turns a one-time
assessment into continuous evidence, and
[compliance reporting in Chef Automate](/automate/reports/) shows how results change over
time.

## Remediation

Remediation content is delivered as [Chef Infra cookbooks](/client/latest/cookbooks/)
that correct the configuration behind a failed benchmark requirement. Where an audit
profile reports that a setting doesn't meet the standard, the matching remediation
content applies the change that brings it back into line, so you can close findings with
the same tooling you already use to manage the system.

Check the version table above before you plan a hardening rollout, because remediation
and audit versions don't always line up.

- **SUSE Linux Enterprise Server 15** is partial. Audit covers v1.0.0 and v2.0.1, but
  remediation covers v1.0.0 only, so plan hardening against the version you can actually
  remediate.
- **SUSE Linux Enterprise Server 11 and SUSE Linux Enterprise Server 12** are audit
  only. You can assess systems running those releases against the benchmark and act on
  the findings, but the corresponding remediation content isn't available.

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
