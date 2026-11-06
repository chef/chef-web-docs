+++
title = "Apache HTTP Server"

[menu.premium_content]
  identifier = "premium_content/web_servers/apache_http_server"
  parent = "premium_content/web_servers"
  title = "Apache HTTP Server"
  weight = 10
+++

Apache HTTP Server is a widely deployed open source web server.
It often faces the internet directly, and its behavior depends on configuration files and modules that can differ from one server to the next.

Chef Premium Content covers Apache HTTP Server 2.2 and 2.4 against the [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks), so you can assess and correct these servers without writing and maintaining that content yourself.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Apache HTTP Server 2.2` | v3.6.0 | v3.6.0 | Audit + Remediation |
| `CIS Apache HTTP Server 2.4` | v2.0.0 | v1.4.0, v2.0.0 | Partial Audit + Remediation |

Audit and remediation coverage are tracked separately, and a benchmark can have more versions of one than the other.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables) for what each coverage term means.

## Available profiles

Each benchmark version with audit content ships as two Chef InSpec profiles, one for each CIS profile level:

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |

The platform token depends on the Apache HTTP Server release, so the two benchmarks don't share a pattern:

| Benchmark | Profile name pattern |
| --- | --- |
| `CIS Apache HTTP Server 2.2` | `cis-apache-http-server2.2-<level>-v3.6.0` |
| `CIS Apache HTTP Server 2.4` | `cis-apachehttp2.4-<level>-v2.0.0` |

For example, the CIS Level 1 profile for Apache HTTP Server 2.4 is `cis-apachehttp2.4-level1-v2.0.0`.

Choose the level that matches your risk posture:

- **Level 1** applies settings that improve security with limited operational impact.
- **Level 2** extends Level 1 with defense-in-depth settings for stricter environments, and is more likely to affect how applications behave.

## What you can do with this content

### Audit

Run the audit profile against a system running Apache HTTP Server to assess it against the benchmark and report which requirements pass and which fail.
Each failure identifies the specific setting that doesn't meet the standard, so the result is an actionable list rather than a score.

You can run audit content with [Chef InSpec](/inspec/latest/), the [Compliance Phase](/client/latest/features/chef_compliance_phase/) during a Chef Infra Client run, or an [Automate scan job](/automate/scan_jobs/).

### Harden

Where remediation content is available for a benchmark version, you can correct the configuration behind a failed requirement rather than writing the fix yourself.

### Detect drift

An Apache HTTP Server system that passed an audit doesn't stay compliant on its own.
Package updates, module changes, and manual configuration edits can all move it away from its approved state.
Running the audit profile on a schedule turns a one-time assessment into continuous evidence, and [compliance reporting in Chef Automate](/automate/reports/) shows how results change over time.

## Remediation

Remediation content is delivered as [Chef Infra cookbooks](/client/latest/cookbooks/) that correct the configuration behind a failed benchmark requirement, so you can close findings with the same tooling you use to manage the system.

Check the version table before you plan a hardening rollout, because remediation and audit versions don't always line up:

- **Apache HTTP Server 2.2** has matching audit and remediation content at v3.6.0.
- **Apache HTTP Server 2.4** is partial.
  Remediation covers v1.4.0 and v2.0.0, but audit covers v2.0.0 only, so plan hardening and assessment against v2.0.0 if you want to verify the result with a matching profile.

## Access this content

Chef Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement includes, and contact your Chef account representative to confirm your access.

## Related

- [Web servers coverage](/premium_content/web_servers/)
- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
