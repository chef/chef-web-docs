+++
title = "Cloud"
aliases = ["/solutions/compliance/cloud/"]

[menu.premium_content]
  identifier = "premium_content/cloud"
  parent = "premium_content"
  title = "Cloud"
  weight = 50
+++

Chef Premium Content has current coverage for **3 cloud benchmarks**,
with every audit version and remediation version currently available.
See [benchmark coverage](/premium_content/#benchmark-coverage) for how audit and
remediation coverage are tracked, and the
[Compliance solution overview](/solutions/compliance/) for what each does.

## Browse by platform

Platform pages describe what the benchmarks cover, which profiles ship, and what
remediation is available:

| Platform | Benchmarks |
| --- | --- |
| [Microsoft 365](/premium_content/cloud/microsoft_365/) | CIS |
| [Microsoft Azure](/premium_content/cloud/microsoft_azure/) | CIS |

## All cloud benchmarks

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS AWS Foundations` | 1.0.0 | — | Audit Only |
| `CIS Microsoft 365` | 1.4.0 | 1.0.0 | Audit Ahead |
| `CIS Microsoft Azure Foundations` | 1.0.0, 1.1.0 | 1.1.0 | Partial Audit + Remediation |

For what each coverage term means, see
[how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables).

## Inspect cloud configuration directly

The benchmarks above are prebuilt content.
When your requirement isn't covered by one ---
a provider service with no published benchmark,
or a control specific to your organization ---
you can write your own Chef InSpec controls against the provider API.

Chef InSpec provides resource packs for the major cloud providers:

- [AWS resource pack](/inspec/resource_packs/aws/) ---
  inspect EC2, IAM, RDS, Lambda, VPC and networking, CloudFront, CloudWatch, and more
- [Azure resource pack](/inspec/resource_packs/azure/) ---
  inspect virtual machines, SQL, networking, Key Vault, policy, and Active Directory
- [GCP resource pack](/inspec/resource_packs/gcp/) ---
  inspect Compute Engine, Cloud SQL, Cloud Storage, GKE, IAM, KMS, and more

A resource pack isn't a benchmark and doesn't assess anything on its own.
It provides the resources you use to write your own controls.

For a worked example,
[The Chef way of AWS compliance](/solutions/compliance/aws_foundations/)
builds a profile on the AWS pack that checks S3 buckets, IAM policies, and security groups
across an account, then runs it and reads the findings.

## Related

- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [Compliance audit](/solutions/compliance/#compliance-audit)
- [Compliance remediation](/solutions/compliance/#compliance-remediation)
- [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
