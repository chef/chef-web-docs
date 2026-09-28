+++
title = "Applications / Middleware"

[menu.overview]
  identifier = "overview/solutions/compliance/applications_middleware"
  parent = "overview/solutions/compliance"
  title = "Applications / Middleware"
  weight = 70
+++

Current audit and remediation coverage for applications / middleware benchmarks in Chef Compliance.
This category has **9 benchmarks** with current coverage.

| Benchmark | Audit Versions | Remediation Versions | Coverage |
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

_A dagger (&dagger;) on a remediation version means Inferred Current: the customer-shipping
remediation tree is confirmed by an SME, but version-level release evidence wasn't found.
Inferred Current doesn't mean unsupported._

Audit and remediation coverage are tracked as independent dimensions. A benchmark may offer
more audit versions than remediation versions, or the reverse.

## Related

- [Compliance solution overview](/solutions/compliance/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
