+++
title = "HP-UX"

[menu.premium_content]
  identifier = "premium_content/operating_systems/hp_ux"
  parent = "premium_content/operating_systems"
  title = "HP-UX"
  weight = 50
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) for HP-UX define secure configuration requirements for HP-UX 11i.
Chef Premium Content provides these requirements as Chef InSpec audit profiles, without remediation content.

## What the benchmarks check

The requirements include the following areas in the benchmark at v1.4.2:

- **Patches:** Applying the latest operating system patches
- **Services:** Boot services to turn off
- **File system:** Finding unowned files and directories
- **Accounts:** Password complexity requirements

The exact requirements differ by benchmark and version.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS HP-UX 11i` | v1.4.2 | --- | Audit Only |

Audit and remediation coverage are tracked separately.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables)
for what each coverage term means.

## Available profiles

There are two profiles for HP-UX, both at benchmark v1.4.2:

```text
cis-hp-ux11i-<level>-v1.4.2
```

- `cis-hp-ux11i-level1-v1.4.2`
- `cis-hp-ux11i-level2-v1.4.2`

The only axis is CIS profile level. There's no server or workstation scope on either
profile, unlike most other platforms in this section.

The platform name in the profile is `hp-ux11i`, with a hyphen.
Keep the hyphen when you construct a profile name, because `hpux11i` doesn't exist.

`11i` is the HP-UX release family name, not a version number that varies. The single
published benchmark covers it.

Choose the level that matches your risk posture:

- **Level 1** applies settings that improve security with limited operational impact.
  It's the common starting point for production systems.
- **Level 2** extends Level 1 with defense-in-depth settings intended for environments
  with stricter requirements. Level 2 is more likely to affect how applications behave,
  so test it before rolling it out broadly.

## What you can do with this content

### Audit

Run the audit profile against an HP-UX system to assess it against the benchmark and
report which requirements pass and which fail. Each failure identifies the specific
setting that doesn't meet the standard, so the result is an actionable list rather than
a score.

You can run audit content with [Chef InSpec](/inspec/latest/), the
[Compliance Phase](/client/latest/features/chef_compliance_phase/) during a Chef Infra
Client run, or an [Automate scan job](/automate/scan_jobs/).

### Harden

There's no remediation content for HP-UX, so hardening is yours to implement. The audit
results still tell you precisely which settings to change, even though you'll apply the
fix yourself rather than through published remediation content.

### Detect drift

A system that passed an audit at build time doesn't stay compliant on its own. Package
updates, manual changes, and configuration management from other tools all move a system
away from its approved state. Running the audit profile on a schedule turns a one-time
assessment into continuous evidence, and
[compliance reporting in Chef Automate](/automate/reports/) shows how results change over
time.

## Remediation

The HP-UX benchmark is audit only: you can assess systems and act on the findings, but
no matching Chef Infra cookbooks are published for this platform. If you need to correct
the configuration behind a failed requirement, you'll need to write that content
yourself. See
[The Chef Way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
for guidance on writing your own compliance content.

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
