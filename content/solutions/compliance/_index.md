+++
title = "Chef Compliance"
description = "The Chef Way of compliance: assess systems against CIS Benchmarks and DISA STIGs with Chef InSpec, then correct what fails with Chef remediation content."
draft = false
gh_repo = "chef-web-docs"

[cascade]
  [cascade.params]
    swiftype_search_products = ["automate", "inspec", "client", "workstation"]
    section_root = "/solutions/compliance"
    breadcrumbs = true

[menu.overview]
  identifier = "overview/solutions/compliance/overview"
  parent = "overview/solutions/compliance"
  title = "Overview"
  weight = 1
+++

Chef Compliance assesses your systems against CIS Benchmarks and DISA STIGs, and corrects the configuration behind what fails.
It does this the Chef Way: every compliance requirement becomes code that you can run, review, and repeat.

## The Chef Way

The Chef Way treats a compliance requirement as code, so you don't check by hand or track results in a spreadsheet:

- **A control** states one requirement.
- **A profile** groups the controls for a benchmark or a system.
- **A run** produces a result that you can act on.

Every requirement then follows the same path:

1. **Audit:** Run a Chef InSpec profile, which reports a pass, fail, or skip for each requirement.
1. **Correct:** Fix what fails with Chef remediation content or your own change, or record a waiver if you accept the failure.
1. **Confirm:** Run the same profile again to prove the result.
1. **Repeat:** Schedule the assessment, so drift shows up as a control that starts failing.

### Follow the Chef Way

Choose the path that matches what you need to do:

| If you want to | Start with |
| --- | --- |
| Learn Chef InSpec with a working example | [The Chef Way of SSH compliance](/solutions/compliance/ssh_baseline/) |
| Assess the configuration of an AWS account | [The Chef Way of AWS compliance](/solutions/compliance/aws_foundations/) |
| Check a requirement that no benchmark covers | [The Chef Way of custom compliance checks](/solutions/compliance/custom_compliance_checks/) |
| Use a published CIS Benchmark or DISA STIG | [Find your platform](/premium_content/#find-your-platform) |
| Solve a specific fleet problem | [Common compliance scenarios](#common-compliance-scenarios) |

Published audit profiles and remediation cookbooks are part of [Chef Premium Content](/premium_content/).
Licensed users get them through a monthly delivery email and Chef Automate.
For details, see [get the profiles and cookbooks](/premium_content/#get-the-profiles-and-cookbooks).

## Compliance audit

An audit shows whether your systems meet a benchmark's requirements and identifies settings that need attention.
Chef InSpec can also inspect data in a database and the configuration of virtual resources through their APIs, so assessment isn't limited to systems you can sign in to.

### How you run an assessment

You can use more than one approach in the same fleet:

| Approach | Fits | How it runs |
| --- | --- | --- |
| [Compliance Phase](/client/latest/features/chef_compliance_phase/) | Nodes already managed by Chef Infra Client | As part of a Chef Infra Client run |
| [Scan jobs](/automate/scan_jobs/) in Chef Automate | Nodes and cloud accounts, including systems without an agent | Now, at a scheduled time, once, or on a recurring interval |
| Chef InSpec directly | Ad hoc checks, local development, and pipeline stages | Locally, or over SSH or WinRM |

### Results and evidence

[Compliance reporting in Chef Automate](/automate/reports/) shows results by node, profile, and control.
You can filter the results and download them as dated JSON or CSV.
If you accept a failing control, record it as a [waiver](/inspec/latest/configure/waivers/) so it doesn't remain an unexplained failure.

## Compliance remediation

Remediation content is delivered as [Chef Infra cookbooks](/client/latest/cookbooks/) that correct the configuration behind a failed requirement.
Chef Infra Client changes only what differs from the desired state, so re-running a cookbook on a correctly configured system changes nothing.

Audit and remediation content are built from the same published benchmark, but Chef tracks coverage for them separately.
A benchmark may have audit content, remediation content, or both, and the available versions may differ.
An audit version doesn't guarantee that a matching remediation version is available.

### Before you use remediation content

Check the following before you run remediation content:

- **Coverage:** Remediation coverage is narrower than audit coverage, so confirm that your benchmark version is covered on its [platform page](/premium_content/#find-your-platform).
- **Entitlement:** Remediation content is part of [Chef Premium Content](/premium_content/#access-chef-premium-content).
- **Updates:** Benchmarks are revised, and remediation content changes to follow them.
- **Testing:** Remediation content changes system configuration, so test it as you would any cookbook, using [Chef Workstation](/workstation/latest/).

## Common compliance scenarios

Each of the following scenarios describes a problem and the Chef Way to solve it.
If you haven't run Chef InSpec before, start with [The Chef Way of SSH compliance](/solutions/compliance/ssh_baseline/), because the same mechanics apply to each scenario.

### Assess a Linux fleet against CIS Benchmarks

**The problem:** You run many Linux systems across several distributions and releases, and you need to show that they meet CIS Benchmark requirements.

**The Chef Way:**

1. Confirm that the benchmark versions you need are covered in [Operating Systems](/premium_content/operating_systems/).
1. Get the profiles from [Chef Automate or your monthly delivery email](/premium_content/#get-the-profiles-and-cookbooks).
1. Run one assessment by hand, so you can read the output and recognize a real finding.
1. Turn on the [Compliance Phase](/client/latest/features/chef_compliance_phase/), so assessment runs with each Chef Infra Client run.
1. Review results by node, profile, and control in [compliance reporting](/automate/reports/).

### Assess Windows environments against security baselines

**The problem:** Your fleet spans several Windows Server releases and client builds, and each one has a different security baseline.

**The Chef Way:**

1. Find your releases on the [Windows Server](/premium_content/operating_systems/windows_server/) and [Windows](/premium_content/desktop_client/windows/) pages, and check each one separately.
1. Get the matching profiles from [Chef Automate or your monthly delivery email](/premium_content/#get-the-profiles-and-cookbooks).
1. For nodes running Chef Infra Client, turn on the [Compliance Phase](/client/latest/features/chef_compliance_phase/).
1. For nodes without an agent, add [node credentials](/automate/node_credentials/) for WinRM, and then create a [scan job](/automate/scan_jobs/).
1. Filter reporting by platform, so you can review each release separately.

To run a profile directly, follow [The Chef Way of SSH compliance](/solutions/compliance/ssh_baseline/) with a `winrm://` target instead of `ssh://`.
See the [Chef InSpec CLI reference](/inspec/latest/reference/cli/).

### Find compliance gaps in databases

**The problem:** Database configuration is in scope for your compliance requirements, but another team manages it with different tooling.

**The Chef Way:**

1. Check which benchmarks are covered in [Databases](/premium_content/databases/).
1. Get the matching profiles from [Chef Automate or your monthly delivery email](/premium_content/#get-the-profiles-and-cookbooks).
1. Where a requirement depends on data, query the running instance with a resource such as [`postgres_session`](/inspec/latest/resources/core/postgres_session/), [`mysql_session`](/inspec/latest/resources/core/mysql_session/), or [`oracledb_session`](/inspec/latest/resources/core/oracledb_session/).
   These resources need a database account with permission to run the query.
1. For requirements that no benchmark covers, see [The Chef Way of custom compliance checks](/solutions/compliance/custom_compliance_checks/).
1. Use deep filtering in [compliance reporting](/automate/reports/) to report on one database profile or control.

### Assess the configuration of a cloud account

**The problem:** Your cloud accounts hold storage, networks, and identities that nobody assesses on a schedule.

**The Chef Way:**

1. Work through [The Chef Way of AWS compliance](/solutions/compliance/aws_foundations/), which builds and runs an example profile for S3, IAM, and security groups.
1. Check whether a published benchmark covers your requirement in [Cloud](/premium_content/cloud/).
1. Extend the profile to other services with the [AWS resource pack](/inspec/resource_packs/aws/).
1. Add an AWS API node manager in [node integrations](/automate/node_integrations/), and then create a recurring [scan job](/automate/scan_jobs/) for the account.
1. Assess the servers in the account separately, using the benchmarks in [Operating Systems](/premium_content/operating_systems/).

### Address controls that keep failing across your fleet

**The problem:** The same controls fail on many systems in every assessment, and fixes aren't applied consistently.

**The Chef Way:**

1. Use the control failure data in [compliance reporting](/automate/reports/) to see which requirements fail most often.
1. Check whether remediation content covers that benchmark on its [platform page](/premium_content/#find-your-platform).
1. Where it's covered, [get the cookbook](/premium_content/#get-the-profiles-and-cookbooks), and then apply it as you would any cookbook, after you complete the checks in [Before you use remediation content](#before-you-use-remediation-content).
1. Reassess with the same audit content, as shown in [Step 6 of SSH compliance](/solutions/compliance/ssh_baseline/#step-6-fix-the-finding-and-reassess).
1. Where you accept a failure, record it as a [waiver](/inspec/latest/configure/waivers/).

### Maintain compliance across a mixed fleet

**The problem:** Your fleet spans on-premises servers, cloud accounts, desktops, databases, and containers, and each one has its own benchmark and process.

**The Chef Way:**

1. Identify what each class of system needs with [find your platform](/premium_content/#find-your-platform).
1. For nodes running Chef Infra Client, turn on the [Compliance Phase](/client/latest/features/chef_compliance_phase/).
1. For cloud accounts and systems without an agent, add [node credentials](/automate/node_credentials/), and then create recurring [scan jobs](/automate/scan_jobs/).
1. For requirements that need resource packs, such as Kubernetes clusters, see [The Chef Way of custom compliance checks](/solutions/compliance/custom_compliance_checks/).
1. Send results from each class of system to [compliance reporting](/automate/reports/).

### Prepare for a compliance assessment

**The problem:** An assessment is scheduled, and you need to show what was checked, against which benchmark, with what result, and which exceptions you accepted.

**The Chef Way:**

1. Record accepted failures as waivers before the assessment, so each one has a justification and expiration date.
   See [Step 7 of SSH compliance](/solutions/compliance/ssh_baseline/#step-7-waive-an-exception-youve-accepted) and the [waivers reference](/inspec/latest/configure/waivers/).
1. Filter [compliance reporting](/automate/reports/) to the systems and benchmarks in scope, and select the reporting date.
1. Export the filtered results as JSON or CSV.
1. Check that each failing control in scope is either remediated or waived.

## Supported compliance standards and platforms

Chef publishes audit and remediation content built on the [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) and [DISA STIGs](https://public.cyber.mil/stigs/).
[Chef Premium Content](/premium_content/) lists each supported platform, what its benchmarks check, and the audit and remediation versions available for it.
