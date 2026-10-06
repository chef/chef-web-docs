+++
title = "Cloud"

[menu.overview]
  identifier = "overview/solutions/compliance/cloud"
  parent = "overview/solutions/compliance"
  title = "Cloud"
  weight = 40
+++

Chef Compliance has current coverage for **5 cloud benchmarks**.
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
| `Microsoft Azure Foundations` | — | v1.1.0† | Remediation Only |

A dagger (†) on a remediation version means the version is **Inferred Current**:
it's part of Chef's current remediation content, but version-level release evidence wasn't found.
Inferred Current doesn't mean unsupported.

Some entries have no framework prefix.
Those benchmarks aren't published by Chef under a named framework, so no framework is shown
rather than one being inferred.

For what each coverage term means, see
[how to read the coverage tables](/solutions/compliance/#how-to-read-the-coverage-tables).

## Related

- [Compliance solution overview](/solutions/compliance/)
- [Compliance audit](/solutions/compliance/#compliance-audit)
- [Compliance remediation](/solutions/compliance/#compliance-remediation)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
