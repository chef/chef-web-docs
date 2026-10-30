+++
title = "Chef Premium Content"
draft = false
gh_repo = "chef-web-docs"

[cascade]
  [cascade.params]
    swiftype_search_products = ["premium-content"]
    section_root = "/premium_content"
    menu_id = "premium_content"
    breadcrumbs = true

[menu]
  [menu.premium_content]
    title = "Overview"
    identifier = "premium_content/overview"
    parent = "premium_content"
    weight = 10
+++

Chef Premium Content is curated, ready-to-use content built on published security
benchmarks and distributed to licensed Chef users.
It's maintained by Chef against the source benchmarks, so you assess and correct systems
against a recognized standard without authoring and tracking that content yourself.

Premium Content comes in two forms:

| Content | Description | How you run it |
| --- | --- | --- |
| Audit | Chef InSpec profiles that assess a system against a benchmark and report which requirements pass and fail | [Chef InSpec](/inspec/latest/), the [Compliance Phase](/client/latest/features/chef_compliance_phase/), or an [Automate scan job](/automate/scan_jobs/) |
| Remediation | [Chef Infra cookbooks](/client/latest/cookbooks/) that correct the configuration behind a failed requirement | [Chef Infra Client](/client/latest/) |

Both are built from the same published benchmarks --- the
[CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) and
[DISA STIGs](https://public.cyber.mil/stigs/) --- but they're maintained as separate
content, which is why coverage is tracked separately for each.

## Access Chef Premium Content

Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement
includes, and contact your Chef account representative to confirm your access.

## Benchmark coverage

Audit and remediation coverage are tracked independently:
a benchmark can have one, the other, or both,
and the versions available for each can differ.
Every version is listed --- version sets are never reduced to a single latest version ---
because which version of a benchmark you're covered against
is usually the question that matters.

Current coverage is **127 benchmarks**:

| Coverage | Benchmarks |
| --- | ---: |
| Audit and remediation | 53 |
| Audit only | 66 |
| Remediation only | 8 |
| **Total** | **127** |

Across those benchmarks there are 191 audit versions and 84 remediation versions.

Browse coverage by category:

| Category | Benchmarks |
| --- | ---: |
| [Operating Systems](/premium_content/operating_systems/) | 66 |
| [Desktop / Client](/premium_content/desktop_client/) | 23 |
| [Databases](/premium_content/databases/) | 15 |
| [Applications / Middleware](/premium_content/applications_middleware/) | 9 |
| [Cloud](/premium_content/cloud/) | 4 |
| [Web Servers](/premium_content/web_servers/) | 5 |
| [Containers / Kubernetes](/premium_content/containers_kubernetes/) | 2 |
| [Network / Infrastructure](/premium_content/network_infrastructure/) | 2 |
| [Virtualization](/premium_content/virtualization/) | 1 |

### How to read the coverage tables

| Term | Meaning |
| --- | --- |
| Audit + Remediation | Both audit and remediation content cover this benchmark |
| Partial Audit + Remediation | Both are present, but the version sets overlap only partly |
| Audit Ahead | Audit content covers a newer benchmark version than remediation content does |
| Remediation Ahead | Remediation content covers a newer benchmark version than audit content does |
| Audit Only | Audit content only; no current remediation content |
| Remediation Only | Remediation content only; no current audit content |

An entry in a coverage table means Chef currently publishes content for that benchmark
version. It isn't a statement about your own compliance posture, which depends on the
systems you assess and the results you act on.

### Before you plan work around remediation content

Remediation coverage is narrower than audit coverage, and available versions differ by
benchmark, so check the category tables before committing to a remediation approach for a
specific benchmark.
Benchmarks are revised and Chef updates content to follow them, so treat coverage as
current state rather than a fixed guarantee.

For what to check before you run remediation content against production systems, see
[before you use remediation content](/solutions/compliance/#before-you-use-remediation-content).

## Use Premium Content

The coverage tables tell you what exists.
For how to run audit content, read its results, and correct what fails, see the
[Chef Compliance solution](/solutions/compliance/), which covers the workflow
end to end.

When your requirement isn't covered by a published benchmark, you can write your own
Chef InSpec controls instead.
See [Build custom compliance checks with Chef InSpec](/solutions/compliance/extend/).

## Related

- [Chef Compliance solution](/solutions/compliance/)
- [Progress Chef Enterprise Edition](/enterprise_chef/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
