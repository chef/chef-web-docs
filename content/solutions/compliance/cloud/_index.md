+++
title = "Cloud"

[menu.overview]
  identifier = "overview/solutions/compliance/cloud"
  parent = "overview/solutions/compliance"
  title = "Cloud"
  weight = 50
+++

Chef Compliance has current coverage for **4 cloud benchmarks**.
Each benchmark below lists every audit version and every remediation version
currently available.

Chef tracks audit and remediation coverage as independent dimensions,
so a benchmark may have audit coverage, remediation coverage, or both.
Where both exist, the available versions can differ ---
an audit version doesn't imply a matching remediation version.

For what audit and remediation each do, see the
[Compliance solution overview](/solutions/compliance/).

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS AWS Foundations` | v1.0.0 | — | Audit Only |
| `CIS Microsoft 365` | v1.4.0 | v1.0.0 | Audit Ahead |
| `CIS Microsoft Azure Foundations` | v1.1.0, v1.5.0 | — | Audit Only |
| `InSpec GCP Resource Pack` | v1.1.0 | — | Audit Only |

For what each coverage term means, see
[how to read the coverage tables](/solutions/compliance/#how-to-read-the-coverage-tables).

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
[Audit an AWS account against security baseline](/solutions/compliance/aws_foundations/)
builds a profile on the AWS pack that checks S3 buckets, IAM policies, and security groups
across an account, then runs it and reads the findings.

## Related

- [Compliance solution overview](/solutions/compliance/)
- [Compliance audit](/solutions/compliance/#compliance-audit)
- [Compliance remediation](/solutions/compliance/#compliance-remediation)
- [Build custom compliance checks with Chef InSpec](/solutions/compliance/extend/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
