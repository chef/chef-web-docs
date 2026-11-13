+++
title = "Oracle Database"

[menu.premium_content]
  identifier = "premium_content/databases/oracle_database"
  parent = "premium_content/databases"
  title = "Oracle Database"
  weight = 50
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) for Oracle Database define secure configuration requirements for Oracle Database 12c through 23ai.
Chef Premium Content provides Chef InSpec audit profiles and remediation content for these benchmarks.
Coverage varies by benchmark and version. See the coverage tables on this page for details.

## What the benchmarks check

The requirements cover the following areas in the Oracle Database 23ai benchmark at v1.0.0:

- **Installation and patching:** The Oracle software version and patches
- **Database settings:** Initialization parameters such as `REMOTE_OS_ROLES`
- **Profiles:** Failed sign-in limits, lockout time, and password lifetime and reuse
- **Accounts and links:** Default passwords, password files, and public database links
- **Auditing:** System actions, sign-in and sign-out events, and export activity
- **Access control:** System privileges and roles revoked from unauthorized grantees

The exact requirements differ by benchmark and version.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Oracle Database 12c` | v3.0.0 | v2.1.0, v3.0.0 | Partial Audit + Remediation |
| `CIS Oracle Database 18c` | v1.0.0 | v1.0.0 | Audit + Remediation |
| `CIS Oracle Database 19c` | v1.0.0, v2.0.0 | v1.0.0 | Partial Audit + Remediation |
| `CIS Oracle Database 23ai` | v1.0.0 | --- | Audit Only |

Audit and remediation coverage are tracked separately.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables) for what each coverage term means.

## Available profiles

There's no single profile name pattern across Oracle Database versions.
The profile set changes shape at every major version, so profiles are listed for each version instead of derived from a pattern.
There's no Level 2 at any version for this platform---only Level 1 profiles are published, unlike most other database pages in this section.

**CIS Oracle Database 12c (benchmark v3.0.0)** ships 6 profiles, one for each combination of target and auditing mode:

| Target | Traditional auditing | Unified auditing |
| --- | --- | --- |
| Database engine (`rdbms`) | `cis-oracledatabase12c-level1-rdbmsusingtraditionalauditing-v3.0.0` | `cis-oracledatabase12c-level1-rdbmsusingunifiedauditing-v3.0.0` |
| Linux host OS | `cis-oracledatabase12c-level1-linuxhostosusingtraditionalauditing-v3.0.0` | `cis-oracledatabase12c-level1-linuxhostosusingunifiedauditing-v3.0.0` |
| Windows Server host OS | `cis-oracledatabase12c-level1-windowsserverhostosusingtraditionalauditing-v3.0.0` | `cis-oracledatabase12c-level1-windowsserverhostosusingunifiedauditing-v3.0.0` |

**CIS Oracle Database 18c (benchmark v1.0.0)** ships the same 6-profile shape as 12c:

| Target | Traditional auditing | Unified auditing |
| --- | --- | --- |
| Database engine (`rdbms`) | `cis-oracledatabase18c-level1-rdbmsusingtraditionalauditing-v1.0.0` | `cis-oracledatabase18c-level1-rdbmsusingunifiedauditing-v1.0.0` |
| Linux host OS | `cis-oracledatabase18c-level1-linuxhostosusingtraditionalauditing-v1.0.0` | `cis-oracledatabase18c-level1-linuxhostosusingunifiedauditing-v1.0.0` |
| Windows Server host OS | `cis-oracledatabase18c-level1-windowsserverhostosusingtraditionalauditing-v1.0.0` | `cis-oracledatabase18c-level1-windowsserverhostosusingunifiedauditing-v1.0.0` |

**CIS Oracle Database 19c, benchmark v1.0.0** ships the same 6-profile shape as 12c and 18c:

| Target | Traditional auditing | Unified auditing |
| --- | --- | --- |
| Database engine (`rdbms`) | `cis-oracledatabase19c-level1-rdbmsusingtraditionalauditing-v1.0.0` | `cis-oracledatabase19c-level1-rdbmsusingunifiedauditing-v1.0.0` |
| Linux host OS | `cis-oracledatabase19c-level1-linuxhostosusingtraditionalauditing-v1.0.0` | `cis-oracledatabase19c-level1-linuxhostosusingunifiedauditing-v1.0.0` |
| Windows Server host OS | `cis-oracledatabase19c-level1-windowsserverhostosusingtraditionalauditing-v1.0.0` | `cis-oracledatabase19c-level1-windowsserverhostosusingunifiedauditing-v1.0.0` |

**CIS Oracle Database 19c, benchmark v2.0.0** changes the shape: the traditional/unified auditing-mode split and the Linux/Windows host-OS split both disappear.
Only 2 profiles are published:

| Profile | Covers |
| --- | --- |
| `cis-oracledatabase19c-level1-rdbms-v2.0.0` | Database engine checks only |
| `cis-oracledatabase19c-level1-rdbmsonhostos-v2.0.0` | Database engine checks plus host operating system checks |

**CIS Oracle Database 23ai (benchmark v1.0.0)** changes the shape again: there's no more traditional/unified auditing-mode split, but the host-OS split returns, now naming the operating system explicitly instead of a generic "on host OS" toggle.
Only 3 profiles are published:

| Profile | Covers |
| --- | --- |
| `cis-oracledatabase23ai-level1-rdbms-v1.0.0` | Database engine checks only |
| `cis-oracledatabase23ai-level1-rdbmsonlinuxhostos-v1.0.0` | Database engine checks plus Linux host OS checks |
| `cis-oracledatabase23ai-level1-rdbmsonwindowsserverhostos-v1.0.0` | Database engine checks plus Windows Server host OS checks |

Profile names change between versions, so always check the table for the exact version you're running.

- **Level 1** is the only level published for Oracle Database at any version; there's no Level 2 content for this platform.

## What you can do with this content

### Audit

Run the audit profile against an Oracle Database instance to assess it against the benchmark and report which requirements pass and which fail.
Each failure identifies the specific setting that doesn't meet the standard, so the result lists what to fix.

You can run audit content with [Chef InSpec](/inspec/latest/), the [Compliance Phase](/client/latest/features/chef_compliance_phase/) during a Chef Infra Client run, or an [Automate scan job](/automate/scan_jobs/).

### Harden

Where remediation content is available for a benchmark version, you can correct the configuration behind a failed requirement rather than writing the fix yourself.

### Detect drift

An Oracle Database instance that passed an audit at build time doesn't stay compliant on its own.
Package updates, manual changes, and configuration management from other tools all move a system away from its approved state.
Running the audit profile on a schedule turns a one-time assessment into continuous evidence, and [compliance reporting in Chef Automate](/automate/reports/) shows how results change over time.

## Remediation

Remediation content is delivered as [Chef Infra cookbooks](/client/latest/cookbooks/) that correct the configuration behind a failed benchmark requirement.
Where an audit profile reports that a setting doesn't meet the standard, the matching remediation content applies the change that brings it back into line, so you can close findings with the same tooling you already use to manage the system.

Check the version table above before you plan a hardening rollout, because remediation and audit versions don't always line up.

- **Oracle Database 12c** is partial. Remediation covers v2.1.0 and v3.0.0, but audit covers only v3.0.0, so v2.1.0 remediation has no matching audit profile.
- **Oracle Database 18c** is fully aligned at v1.0.0.
- **Oracle Database 19c** is partial: remediation covers only v1.0.0 even though audit also covers v2.0.0, so hardening against v2.0.0 isn't available.
- **Oracle Database 23ai** is audit only---you can assess instances and act on the findings, but the corresponding remediation content isn't available.

## Access this content

Chef Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement includes, and contact your Chef account representative to confirm your access.

## Related

- [Databases coverage](/premium_content/databases/)
- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [The Chef Way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
