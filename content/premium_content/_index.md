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

Chef Premium Content turns published security benchmarks from the [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) and [DISA STIGs](https://public.cyber.mil/stigs/) into content you can run.
Chef maintains it against the source benchmarks and distributes it to licensed users.

It comes in two forms, and coverage is tracked separately for each:

- **Audit content:** Chef InSpec profiles that assess a system against a benchmark and report which requirements pass and fail.
- **Remediation content:** [Chef Infra cookbooks](/client/latest/cookbooks/) that correct the configuration behind a failed requirement.

## Find your platform

Each platform page describes what its benchmarks check, which versions are covered, and which profiles ship.

| Category | Platforms | Benchmarks |
| --- | --- | ---: |
| [Operating systems](/premium_content/operating_systems/) | [AlmaLinux OS](/premium_content/operating_systems/almalinux/), [Amazon Linux](/premium_content/operating_systems/amazon_linux/), [CentOS](/premium_content/operating_systems/centos/), [Debian](/premium_content/operating_systems/debian/), [HP-UX](/premium_content/operating_systems/hp_ux/), [IBM AIX](/premium_content/operating_systems/ibm_aix/), [Oracle Linux](/premium_content/operating_systems/oracle_linux/), [Oracle Solaris](/premium_content/operating_systems/oracle_solaris/), [Red Hat Enterprise Linux](/premium_content/operating_systems/rhel/), [Rocky Linux](/premium_content/operating_systems/rocky_linux/), [SUSE Linux Enterprise Server](/premium_content/operating_systems/sles/), [Ubuntu](/premium_content/operating_systems/ubuntu/), [Windows Server](/premium_content/operating_systems/windows_server/) | 61 |
| [Desktop / client](/premium_content/desktop_client/) | [Apple macOS](/premium_content/desktop_client/apple_macos/), [Windows](/premium_content/desktop_client/windows/) | 20 |
| [Databases](/premium_content/databases/) | [MariaDB](/premium_content/databases/mariadb/), [Microsoft SQL Server](/premium_content/databases/microsoft_sql_server/), [MongoDB](/premium_content/databases/mongodb/), [Oracle Database](/premium_content/databases/oracle_database/), [Oracle MySQL](/premium_content/databases/oracle_mysql/), [PostgreSQL](/premium_content/databases/postgresql/) | 17 |
| [Applications / middleware](/premium_content/applications_middleware/) | [Apache Tomcat](/premium_content/applications_middleware/apache_tomcat/), [IBM WebSphere Liberty](/premium_content/applications_middleware/ibm_websphere_liberty/) | 7 |
| [Web servers](/premium_content/web_servers/) | [Apache HTTP Server](/premium_content/web_servers/apache_http_server/), [Microsoft IIS](/premium_content/web_servers/microsoft_iis/) | 4 |
| [Cloud](/premium_content/cloud/) | [AWS Foundations](/premium_content/cloud/aws_foundations/), [Microsoft 365](/premium_content/cloud/microsoft_365/), [Microsoft Azure](/premium_content/cloud/microsoft_azure/) | 3 |
| [Virtualization](/premium_content/virtualization/) | [VMware ESXi](/premium_content/virtualization/vmware_esxi/) | 3 |
| [Network / infrastructure](/premium_content/network_infrastructure/) | [Cisco IOS](/premium_content/network_infrastructure/cisco_ios/) | 2 |
| [Containers](/premium_content/containers_kubernetes/) | [Docker](/premium_content/containers_kubernetes/docker/) | 1 |

Each category page lists every benchmark in that category, including any that don't have a platform page.

## Benchmark coverage

Current coverage is **118 benchmarks**, with 164 audit versions and 87 remediation versions.

| Coverage | Benchmarks |
| --- | ---: |
| Audit and remediation | 58 |
| Audit only | 54 |
| Remediation only | 6 |
| **Total** | **118** |

Audit and remediation coverage are tracked independently.
A benchmark can have one, the other, or both, and the versions available for each can differ.
Coverage tables list every version rather than only the latest, because the version you're covered against is usually the question that matters.

## Use Premium Content

The following sections explain how to get Premium Content and how to use it.

### Get the profiles and cookbooks

Chef provides Premium Content to licensed users in two ways: a delivery email and Chef Automate.

#### Delivery email

Chef sends licensed users a Premium Content email every month, which includes new and updated profiles and cookbooks.
The email lists the available audit profiles and remediation cookbooks, with the date each one was last updated and a link to download its archive.
Use the email to get a specific benchmark version, including earlier versions that are still available.

#### Chef Automate

Chef Automate ships with the available benchmark profiles and cookbooks, and new profile versions ship with the product.
To install, download, upload, or update profiles, see [Chef Automate profiles](/automate/profiles/).

### Run the content

To use Premium Content, follow these steps:

1. Find your benchmark on its [platform page](#find-your-platform), and check which audit and remediation versions are available.
1. Choose the profile that matches your system, using the naming pattern on the platform page.
1. Run the audit content, and review which requirements pass and fail.
   Most audit content runs with [Chef InSpec](/inspec/latest/), the [Compliance Phase](/client/latest/features/chef_compliance_phase/), or an [Automate scan job](/automate/scan_jobs/).
   Where a platform works differently, its page explains how to run it.
1. Correct what fails, using remediation content where it's available or your own tooling where it isn't.
   See [before you use remediation content](/solutions/compliance/#before-you-use-remediation-content) before you run it against production systems.
1. Run the audit content on a schedule, and use [compliance reporting in Chef Automate](/automate/reports/) to see how results change over time.

For the workflow end to end, see the [Chef Compliance solution](/solutions/compliance/).
When a published benchmark doesn't cover your requirement, see [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/).

## Reference

The following sections explain the terms and version numbers used in the coverage tables.

### How to read the coverage tables

| Term | Meaning |
| --- | --- |
| Audit + Remediation | Both audit and remediation content cover this benchmark |
| Partial Audit + Remediation | Both are present, but the version sets overlap only partly |
| Audit Ahead | Audit content covers a newer benchmark version than remediation content does |
| Remediation Ahead | Remediation content covers a newer benchmark version than audit content does |
| Audit Only | Audit content only; no current remediation content |
| Remediation Only | Remediation content only; no current audit content |

An entry in a coverage table means Chef currently publishes content for that benchmark version.
It isn't a statement about your own compliance posture, which depends on the systems you assess and the results you act on.

### Benchmark versions and content builds

Coverage tables list the _benchmark_ version, such as `v2.0.0`.
That's the version published by CIS or DISA.

The content you receive carries a second number, written as a suffix: `2.0.0-3`.
The suffix is the Chef build of that benchmark version.
A benchmark version is first published as `-1`.
If an issue is found and corrected, Chef publishes a new build of the same benchmark version as `-2`, then `-3`, and distributes the updated content to entitled users.

Both `2.0.0-1` and `2.0.0-3` cover the same benchmark requirements, and the higher suffix is the more current Chef build.
Coverage tables don't list build numbers, because they change independently of the benchmark.
Always use the most recent build you've received.

### Coverage changes over time

Remediation coverage is narrower than audit coverage, and available versions differ by benchmark, so check the coverage tables before you commit to a remediation approach.
Benchmarks are revised and Chef updates content to follow them, so treat coverage as current state rather than a fixed guarantee.

## Access Chef Premium Content

Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement includes, and contact your Chef account representative to confirm your access.

## Related

- [Chef Compliance solution](/solutions/compliance/)
- [Progress Chef Enterprise Edition](/enterprise_chef/)
- [Chef InSpec](/inspec/latest/)
- [Compliance reporting in Chef Automate](/automate/reports/)
