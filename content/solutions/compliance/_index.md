+++
title = "Compliance"
draft = false
gh_repo = "chef-web-docs"

[cascade]
  [cascade.params]
    swiftype_search_products = ["automate", "inspec", "client"]
    menu_id = "solutions_compliance"
    section_root = "/solutions/compliance"
    breadcrumbs = true

[menu.solutions_compliance]
  title = "Compliance"
  weight = 1
+++

Chef lets you define compliance and security requirements as code, scan your infrastructure
against them continuously, see results in one place, and remediate drift &mdash; across cloud,
on-premises, and hybrid environments.

This solution brings together the products you need for a complete compliance journey:

- **[Chef InSpec](/inspec/latest/)** &mdash; author and test compliance controls in a
  human- and machine-readable language.
- **[Chef Automate](/automate/reports/)** &mdash; run scans, visualize pass/fail results, and
  track compliance drift over time.
- **[Chef Infra Client](/client/latest/features/chef_compliance_phase/)** &mdash; run compliance
  scans automatically as part of every Chef Infra Client run, and remediate failed controls.
- **[Chef 360 Platform](/360/latest/)** &mdash; schedule and orchestrate compliance jobs across
  your entire fleet.

## The compliance workflow

| Step | What you do | Product |
| --- | --- | --- |
| 1. Author | Write compliance controls in a human-readable language | [Chef InSpec](/inspec/latest/) |
| 2. Test locally | Validate profiles before rollout | Chef InSpec + [Chef Workstation](/workstation/latest/) |
| 3. Scan | Run profiles against nodes, cloud accounts, and containers | [Chef Infra Client](/client/latest/features/chef_compliance_phase/) or Chef Automate agents |
| 4. Visualize | View pass/fail results and drift trends on role-based dashboards | [Chef Automate](/automate/reports/) |
| 5. Remediate | Apply cookbooks or scripts to fix failed controls | Chef Infra |
| 6. Orchestrate at scale | Schedule and monitor compliance jobs across your fleet | [Chef 360 Platform](/360/latest/) |

## Common scenarios

- **Meet a CIS or STIG benchmark** &mdash; browse the supported benchmark catalog by category
  below to find current audit and remediation coverage.
- **Run compliance checks automatically** &mdash; use the
  [Compliance Phase](/client/latest/features/chef_compliance_phase/) to run Chef InSpec profiles
  on every Chef Infra Client run.
- **Get organization-wide compliance visibility** &mdash; see
  [Compliance reporting in Chef Automate](/automate/reports/) or orchestrate fleet-wide scans
  with [Chef 360](/360/latest/).

## Supported benchmark coverage

Chef Compliance currently has **134 distinct benchmarks with current coverage**: 60 with both
audit and remediation coverage, 60 with audit-only coverage, and 14 with remediation-only
coverage. Audit and remediation are tracked as independent dimensions &mdash; a benchmark may
offer more audit versions than remediation versions, or the reverse.

Browse the catalog by category:

| Category | Benchmarks |
| --- | --- |
| [Operating Systems](/solutions/compliance/operating_systems/) | 69 |
| [Desktop / Client](/solutions/compliance/desktop_client/) | 23 |
| [Databases](/solutions/compliance/databases/) | 16 |
| [Applications / Middleware](/solutions/compliance/applications_middleware/) | 9 |
| [Cloud](/solutions/compliance/cloud/) | 5 |
| [Web Servers](/solutions/compliance/web_servers/) | 5 |
| [Containers / Kubernetes](/solutions/compliance/containers_kubernetes/) | 2 |
| [Network / Infrastructure](/solutions/compliance/network_infrastructure/) | 2 |
| [Virtualization](/solutions/compliance/virtualization/) | 1 |

A dagger (**&dagger;**) on a remediation version in the tables below means _Inferred Current_:
the customer-shipping remediation tree is confirmed by an SME, but version-level release
evidence wasn't found. Inferred Current does not mean unsupported.
