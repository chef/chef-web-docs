+++
title = "Containers / Kubernetes"

[menu.overview]
  identifier = "overview/solutions/compliance/containers_kubernetes"
  parent = "overview/solutions/compliance"
  title = "Containers / Kubernetes"
  weight = 50
+++

Chef Compliance has current coverage for **2 containers / kubernetes benchmarks**.
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
| `CIS Docker` | — | v1.1.0 | Remediation Only |
| `CIS Kubernetes` | — | v1.5.0, v1.6.1, v1.12.0 | Remediation Only |

For what each coverage term means, see
[how to read the coverage tables](/solutions/compliance/#how-to-read-the-coverage-tables).

## Related

- [Compliance solution overview](/solutions/compliance/)
- [Compliance audit](/solutions/compliance/#compliance-audit)
- [Compliance remediation](/solutions/compliance/#compliance-remediation)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
