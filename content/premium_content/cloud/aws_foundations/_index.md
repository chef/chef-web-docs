+++
title = "AWS Foundations"

[menu.premium_content]
  identifier = "premium_content/cloud/aws_foundations"
  parent = "premium_content/cloud"
  title = "AWS Foundations"
  weight = 5
+++

AWS accounts change often, and teams can create resources and change settings without going through a server configuration process.
That makes account-level settings, such as logging and monitoring, a common focus of security reviews.

Chef Premium Content covers AWS against the CIS Amazon Web Services Foundations Benchmark from the [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks).
This content assesses your AWS account, rather than the configuration of a single host.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS AWS Foundations` | v1.0.0 | --- | Audit Only |

See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables) for what each coverage term means.

## Available profiles

The benchmark ships as two Chef InSpec profiles, one for each CIS profile level:

| Axis | Values |
| --- | --- |
| Level | `level1`, `level2` |

```text
cis-aws-benchmark-<level>-1.0.0
```

For example, the CIS Level 1 profile is `cis-aws-benchmark-level1-1.0.0`.
These names don't have a `v` before the version, unlike most other Chef Premium Content profiles.

Choose the level that matches your risk posture:

- **Level 1** applies settings that improve security with limited operational impact.
- **Level 2** extends Level 1 with defense-in-depth settings for stricter environments, and is more likely to affect how services behave.

## What you can do with this content

### Audit

Run the audit profile with [Chef InSpec](/inspec/latest/) to assess your AWS account against the benchmark and report which requirements pass and which fail.
The profiles depend on the Chef InSpec AWS resources, so see the [AWS resource pack](/inspec/resource_packs/aws/) for what they inspect.

### Detect drift

An AWS account that passed an audit doesn't stay compliant on its own, because console changes and new deployments can move it away from its approved state.
Running the audit profile on a schedule turns a one-time assessment into continuous evidence.

## Remediation

CIS AWS Foundations is audit only.
You can assess your account and act on the findings, but matching remediation content isn't available, so plan to correct failed requirements with your own tooling.

## Write your own AWS checks

This benchmark is prebuilt content.
For checks that it doesn't cover, you can write your own controls with the AWS resource pack.
[The Chef way of AWS compliance](/solutions/compliance/aws_foundations/) walks through building and running a custom profile, which is separate from this benchmark.

## Access this content

Chef Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement includes, and contact your Chef account representative to confirm your access.

## Related

- [Cloud coverage](/premium_content/cloud/)
- [AWS resource pack](/inspec/resource_packs/aws/)
- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
