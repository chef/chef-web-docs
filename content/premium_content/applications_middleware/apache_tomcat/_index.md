+++
title = "Apache Tomcat"

[menu.premium_content]
  identifier = "premium_content/applications_middleware/apache_tomcat"
  parent = "premium_content/applications_middleware"
  title = "Apache Tomcat"
  weight = 10
+++

The [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) for Apache Tomcat define secure configuration requirements for Tomcat 5.5 through Tomcat 11.
Chef Premium Content provides Chef InSpec audit profiles and remediation content for these benchmarks.
Coverage varies by benchmark and version. See the coverage tables on this page for details.

## What the benchmarks check

The requirements cover the following areas in the Apache Tomcat 11 benchmark at v1.0.0:

- **Extraneous resources:** Unneeded files and directories, and unused connectors
- **Server information:** The server details that Tomcat advertises
- **Shutdown port:** The shutdown command and shutdown port
- **File and directory access:** Access to `$CATALINA_HOME`, logs, web applications, and configuration files
- **Realms:** Secure realms and account lockout
- **Connector security:** SSL on sensitive connectors and client certificate authentication
- **Logging:** Application logging and log file locations
- **Application deployment:** Automatic deployment, deployment on startup, and access to sensitive packages
- **Other settings:** The manager application, connection timeouts, and running applications without privileges

The exact requirements differ by benchmark and version.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Apache Tomcat 5.5` | v1.0.0 | --- | Audit Only |
| `CIS Apache Tomcat 8` | v1.1.0 | v1.1.0 | Audit + Remediation |
| `CIS Apache Tomcat 9` | v1.1.0 | v1.1.0 | Audit + Remediation |
| `CIS Apache Tomcat 10.1` | v1.1.0 | v1.1.0 | Audit + Remediation |
| `CIS Apache Tomcat 11` | v1.0.0 | --- | Audit Only |

Audit and remediation coverage are tracked separately.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables) for what each coverage term means.

## Available profiles

Apache Tomcat profile names don't follow a single pattern, so the following table lists them for each benchmark.
Replace `<level>` with `level1` or `level2`.

| Benchmark | Chef InSpec profiles |
| --- | --- |
| `CIS Apache Tomcat 5.5` | `cis-apachetomcat-5.5-6.0-<level>-v1.0.0` |
| `CIS Apache Tomcat 8` | `cis-tomcat8-benchmark-v1.1.0` |
| `CIS Apache Tomcat 9` | `cis-apachetomcat9-<level>-v1.1.0` |
| `CIS Apache Tomcat 10.1` | `cis-apachetomcat10-<level>-v1.1.0` |
| `CIS Apache Tomcat 11` | `cis-apachetomcat11-<level>-v1.0.0` |

Three of these names differ from what the benchmark title suggests:

- **Apache Tomcat 5.5:** The profile name covers both Tomcat 5.5 and Tomcat 6.0.
- **Apache Tomcat 8:** A single `benchmark` profile ships, with no separate levels.
- **Apache Tomcat 10.1:** The platform token is `apachetomcat10`, not `apachetomcat10.1`.

Where a benchmark ships both levels, choose the one that matches your risk posture:

- **Level 1** applies settings that improve security with limited operational impact.
- **Level 2** extends Level 1 with defense-in-depth settings for stricter environments, and is more likely to affect how applications behave.

## What you can do with this content

### Audit

Run the audit profile against a system running Apache Tomcat to assess it against the benchmark and report which requirements pass and which fail.
Each failure identifies the specific setting that doesn't meet the standard, so the result is an actionable list rather than a score.

You can run audit content with [Chef InSpec](/inspec/latest/), the [Compliance Phase](/client/latest/features/chef_compliance_phase/) during a Chef Infra Client run, or an [Automate scan job](/automate/scan_jobs/).

### Harden

Where remediation content is available for a benchmark version, you can correct the configuration behind a failed requirement rather than writing the fix yourself.
For Apache Tomcat, this applies to Tomcat 8, Tomcat 9, and Tomcat 10.1.

### Detect drift

A Tomcat installation that passed an audit doesn't stay compliant on its own.
Upgrades, application deployments, and manual configuration changes can all move it away from its approved state.
Running the audit profile on a schedule turns a one-time assessment into continuous evidence, and [compliance reporting in Chef Automate](/automate/reports/) shows how results change over time.

## Remediation

Remediation content is delivered as [Chef Infra cookbooks](/client/latest/cookbooks/) that correct the configuration behind a failed benchmark requirement, so you can close findings with the same tooling you use to manage the system.

Check the version table before you plan a hardening rollout, because remediation isn't available for every benchmark:

- **Apache Tomcat 8, 9, and 10.1** have matching audit and remediation content at v1.1.0.
- **Apache Tomcat 5.5 and 11** are audit only.
  You can assess those installations and act on the findings, but matching remediation content isn't available.

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
