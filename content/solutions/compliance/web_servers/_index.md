+++
title = "Web Servers"

[menu.overview]
  identifier = "overview/solutions/compliance/web_servers"
  parent = "overview/solutions/compliance"
  title = "Web Servers"
  weight = 60
+++

Chef Compliance has current coverage for **5 web servers benchmarks**.
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
| `CIS Apache HTTP Server 2.2` | v3.6.0 | v3.6.0 | Audit + Remediation |
| `CIS Apache HTTP Server 2.4` | v2.0.0 | v1.4.0, v2.0.0 | Partial Audit + Remediation |
| `CIS Microsoft IIS 10` | v1.1.1 | v1.1.1 | Audit + Remediation |
| `CIS NGINX` | — | v1.0.0 | Remediation Only |
| `STIG Microsoft IIS 10.0` | v2 | — | Audit Only |

For what each coverage term means, see
[how to read the coverage tables](/solutions/compliance/#how-to-read-the-coverage-tables).

## Related

- [Compliance solution overview](/solutions/compliance/)
- [Compliance audit](/solutions/compliance/#compliance-audit)
- [Compliance remediation](/solutions/compliance/#compliance-remediation)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
