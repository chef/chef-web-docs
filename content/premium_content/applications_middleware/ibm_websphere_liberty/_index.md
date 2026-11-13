+++
title = "IBM WebSphere Liberty"

[menu.premium_content]
  identifier = "premium_content/applications_middleware/ibm_websphere_liberty"
  parent = "premium_content/applications_middleware"
  title = "IBM WebSphere Liberty"
  weight = 20
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) for IBM WebSphere Liberty define secure configuration requirements for Liberty servers.
Chef Premium Content provides these requirements as Chef InSpec audit profiles, without remediation content.

## What the benchmarks check

The requirements cover the following areas in the benchmark at v1.0.0:

- **Installation and file system:** Ownership of the binaries, file system access, and validating the installation
- **Authentication registries:** Removing basic and quick start registries, and using TLS for LDAP connections
- **Application security:** Automatic application updates and the JDK Security Manager
- **Web security:** Session cookies, HTTP ports, and trusted hosts
- **CSIv2 and Java serialization:** Transport settings, identity assertion, and serialization filters
- **Web services:** WS-Security policies, including signing and encrypting SOAP messages
- **Host and address lists:** Include and exclude lists for hosts and addresses
- **z/OS security:** SAF authorization, key rings, and the SAF registry
- **General settings:** Unused features, encrypted passwords, and the welcome page

The exact requirements differ by benchmark and version.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS IBM WebSphere Liberty` | v1.0.0 | --- | Audit Only |

The benchmark title doesn't name a Liberty release, so check the CIS benchmark to confirm that it applies to the release you run.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables) for what each coverage term means.

## Available profiles

The benchmark ships as two Chef InSpec profiles, one for each CIS profile level:

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |

```text
cis-ibmwebsphereliberty-<level>-v1.0.0
```

For example, the CIS Level 1 profile is `cis-ibmwebsphereliberty-level1-v1.0.0`.

Choose the level that matches your risk posture:

- **Level 1** applies settings that improve security with limited operational impact.
- **Level 2** extends Level 1 with defense-in-depth settings for stricter environments, and is more likely to affect how applications behave.

## What you can do with this content

### Audit

Run the audit profile against a system running IBM WebSphere Liberty to assess it against the benchmark and report which requirements pass and which fail.
Each failure identifies the specific setting that doesn't meet the standard, so the result is an actionable list rather than a score.

You can run audit content with [Chef InSpec](/inspec/latest/), the [Compliance Phase](/client/latest/features/chef_compliance_phase/) during a Chef Infra Client run, or an [Automate scan job](/automate/scan_jobs/).

### Detect drift

A Liberty server that passed an audit doesn't stay compliant on its own.
Upgrades, application deployments, and manual configuration changes can all move it away from its approved state.
Running the audit profile on a schedule turns a one-time assessment into continuous evidence, and [compliance reporting in Chef Automate](/automate/reports/) shows how results change over time.

## Remediation

IBM WebSphere Liberty is audit only.
You can assess servers and act on the findings, but matching remediation content isn't available, so plan to correct failed requirements with your own tooling.

## Access this content

Chef Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement includes, and contact your Chef account representative to confirm your access.

## Related

- [Applications / middleware coverage](/premium_content/applications_middleware/)
- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [The Chef Way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
