+++
title = "Desktop / Client"

[menu.overview]
  identifier = "overview/solutions/compliance/desktop_client"
  parent = "overview/solutions/compliance"
  title = "Desktop / Client"
  weight = 20
+++

Chef Compliance has current coverage for **23 desktop / client benchmarks**.
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
| `CIS Apple macOS 10.10` | v1.2.0 | — | Audit Only |
| `CIS Apple macOS 10.11` | v1.1.0 | — | Audit Only |
| `CIS Apple macOS 10.12` | v1.0.0 | — | Audit Only |
| `CIS Apple macOS 10.13` | v1.0.0 | — | Audit Only |
| `CIS Apple macOS 10.14` | v1.0.0 | v1.0.0 | Audit + Remediation |
| `CIS Apple macOS 10.15` | v1.0.0 | v1.0.0 | Audit + Remediation |
| `CIS Apple macOS 10.5` | v1.1.0 | — | Audit Only |
| `CIS Apple macOS 10.6` | v1.0.0 | — | Audit Only |
| `CIS Apple macOS 10.8` | v1.3.0 | — | Audit Only |
| `CIS Apple macOS 10.9` | v1.3.0 | — | Audit Only |
| `CIS Apple macOS 11.0` | v1.2.0 | — | Audit Only |
| `CIS Apple macOS 13.0` | v2.0.0 | — | Audit Only |
| `CIS Microsoft Windows 10-1511` | v1.1.0 | — | Audit Only |
| `CIS Microsoft Windows 10-1909` | v1.8.1 | v1.8.0†, v1.8.1† | Partial Audit + Remediation |
| `CIS Microsoft Windows 10-2004` | v1.9.1 | v1.9.1† | Audit + Remediation |
| `CIS Microsoft Windows 10-20h2` | v1.10.0 | v1.10.0 | Audit + Remediation |
| `CIS Microsoft Windows 10-21h1` | v1.11.0 | v1.11.0 | Audit + Remediation |
| `CIS Microsoft Windows 11` | v3.0.0 | — | Audit Only |
| `CIS Microsoft Windows 7` | v3.0.1 | — | Audit Only |
| `CIS Microsoft Windows 8` | v1.0.0 | — | Audit Only |
| `CIS Microsoft Windows 8.1` | v2.2.1 | — | Audit Only |
| `STIG Microsoft Windows 10` | v2.1.0 | v2.1.0 | Audit + Remediation |
| `STIG Microsoft Windows 11` | v1.2.0, v2.2.0 | v2.2.0 | Partial Audit + Remediation |

A dagger (†) on a remediation version means the version is **Inferred Current**:
it's part of Chef's current remediation content, but version-level release evidence wasn't found.
Inferred Current doesn't mean unsupported.

For what each coverage term means, see
[how to read the coverage tables](/solutions/compliance/#how-to-read-the-coverage-tables).

## Related

- [Compliance solution overview](/solutions/compliance/)
- [Compliance audit](/solutions/compliance/#compliance-audit)
- [Compliance remediation](/solutions/compliance/#compliance-remediation)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
