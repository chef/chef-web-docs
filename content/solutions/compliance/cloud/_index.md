+++
title = "Cloud"

[menu.overview]
  identifier = "overview/solutions/compliance/cloud"
  parent = "overview/solutions/compliance"
  title = "Cloud"
  weight = 40
+++

Current audit and remediation coverage for cloud benchmarks in Chef Compliance.
This category has **5 benchmarks** with current coverage.

| Benchmark | Audit Versions | Remediation Versions | Coverage |
| --- | --- | --- | --- |
| `CIS AWS Foundations` | v1.0.0 | — | Audit Only |
| `CIS Microsoft 365` | v1.4.0 | v1.0.0 | Audit Ahead |
| `CIS Microsoft Azure Foundations` | v1.1.0, v1.5.0 | — | Audit Only |
| `OTHER InSpec GCP Resource Pack` | v1.1.0 | — | Audit Only |
| `OTHER Microsoft Azure Foundations` | — | v1.1.0† | Remediation Only |

_A dagger (&dagger;) on a remediation version means Inferred Current: the customer-shipping
remediation tree is confirmed by an SME, but version-level release evidence wasn't found.
Inferred Current doesn't mean unsupported._

Audit and remediation coverage are tracked as independent dimensions. A benchmark may offer
more audit versions than remediation versions, or the reverse.

## Related

- [Compliance solution overview](/solutions/compliance/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
