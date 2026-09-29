+++
title = "Chef Compliance"
draft = false
gh_repo = "chef-web-docs"

[cascade]
  [cascade.params]
    swiftype_search_products = ["automate", "inspec", "client"]
    section_root = "/solutions/compliance"
    breadcrumbs = true

[menu.overview]
  identifier = "overview/solutions/compliance/overview"
  parent = "overview/solutions/compliance"
  title = "Overview"
  weight = 1
+++

Keeping every system compliant takes a lot of effort &mdash; checking things by hand and piecing
together data and evidence from different places. Chef Compliance helps you do this easily: check
for compliance continuously, see the results in one place, and fix what drifts &mdash; whether
your systems run in the cloud, on-premises, or a mix of both.

You don't need to learn a new product for this. Chef Compliance is a journey through the tools
you may already use:

- **[Chef InSpec](/inspec/latest/)** &mdash; write your compliance and security checks in plain,
  readable language, so both engineers and auditors can understand them.
- **[Chef Automate](/automate/reports/)** &mdash; see pass/fail results and compliance trends
  for your whole fleet on one dashboard.
- **[Chef Infra Client](/client/latest/features/chef_compliance_phase/)** &mdash; check for
  compliance automatically every time Chef Infra Client runs, and fix what fails.
- **[Chef 360 Platform](/360/latest/)** &mdash; schedule and coordinate compliance checks across
  every node you manage.

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
