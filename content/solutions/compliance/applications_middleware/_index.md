+++
title = "Applications / Middleware"

[menu.overview]
  identifier = "overview/solutions/compliance/applications_middleware"
  parent = "overview/solutions/compliance"
  title = "Applications / Middleware"
  weight = 70
+++

Chef Compliance has current coverage for **9 applications / middleware benchmarks**.
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
| `CIS Apache Tomcat 10` | v1.1.0 | — | Audit Only |
| `CIS Apache Tomcat 10.1` | v1.1.0 | v1.1.0 | Audit + Remediation |
| `CIS Apache Tomcat 11` | v1.0.0 | — | Audit Only |
| `CIS Apache Tomcat 5.5` | v1.0.0 | — | Audit Only |
| `CIS Apache Tomcat 8` | v1.1.0 | v1.1.0 | Audit + Remediation |
| `CIS Apache Tomcat 9` | — | v1.1.0 | Remediation Only |
| `CIS IBM WebSphere Liberty` | v1.0.0 | — | Audit Only |
| `CIS Microsoft Exchange Server 2016` | — | v1.0.0 | Remediation Only |
| `CIS Microsoft SharePoint 2016` | v1.1.0 | v1.1.0 | Audit + Remediation |

For what each coverage term means, see
[how to read the coverage tables](/solutions/compliance/#how-to-read-the-coverage-tables).

## Related

- [Compliance solution overview](/solutions/compliance/)
- [Compliance audit](/solutions/compliance/#compliance-audit)
- [Compliance remediation](/solutions/compliance/#compliance-remediation)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
