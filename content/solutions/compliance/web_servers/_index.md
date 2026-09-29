+++
title = "Web Servers"

[menu.overview]
  identifier = "overview/solutions/compliance/web_servers"
  parent = "overview/solutions/compliance"
  title = "Web Servers"
  weight = 60
+++

Current audit and remediation coverage for web servers benchmarks in Chef Compliance.
This category has **5 benchmarks** with current coverage.

| Benchmark | Audit Versions | Remediation Versions | Coverage |
| --- | --- | --- | --- |
| `CIS Apache HTTP Server 2.2` | v3.6.0 | v3.6.0 | Audit + Remediation |
| `CIS Apache HTTP Server 2.4` | v2.0.0 | v1.4.0, v2.0.0 | Partial Audit + Remediation |
| `CIS Microsoft IIS 10` | v1.1.1 | v1.1.1 | Audit + Remediation |
| `CIS NGINX` | — | v1.0.0 | Remediation Only |
| `STIG Microsoft IIS 10.0` | v2 | — | Audit Only |

_A dagger (&dagger;) on a remediation version means Inferred Current: the customer-shipping
remediation tree is confirmed by an SME, but version-level release evidence wasn't found.
Inferred Current doesn't mean unsupported._

Audit and remediation coverage are tracked as independent dimensions. A benchmark may offer
more audit versions than remediation versions, or the reverse.

## Related

- [Compliance solution overview](/solutions/compliance/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
