+++
title = "Chef Compliance"
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

Chef Compliance helps you assess your systems against established security benchmarks,
see where they fall short, correct the configuration that caused the gap, and confirm the fix.

You define your requirements once as code, apply them across every platform you run, and keep a
dated record of what passed, what failed, and what you accepted ---
whether those systems run in the cloud, in your own data center, or both.

## Compliance challenges Chef helps solve

Compliance work gets harder as an estate grows, and it gets harder in specific, recognizable ways.

### Every platform has a different definition of compliant

A compliance requirement that means one thing on Red Hat Enterprise Linux means something
different on Windows Server, different again on a PostgreSQL instance,
and different again on an Azure subscription.
Each platform has its own published benchmark, its own control identifiers,
and its own set of configuration settings that satisfy them.

Teams end up maintaining a separate approach for each platform,
and the cost of compliance grows with every technology the organization adopts.

### Audits happen periodically, but configuration changes continuously

A system can pass an assessment on the day it's checked and drift out of compliance the following
week --- a package update, a troubleshooting change left in place,
or a new system built from an older image.

A point-in-time assessment tells you the state of your estate on one day.
It doesn't tell you whether that state held.

### Finding a problem isn't the same as fixing it

An assessment produces a list of failed controls.
Turning that list into corrected systems is separate work, and it's usually manual.

The same failed control on two hundred systems becomes two hundred changes,
applied by different people at different times in slightly different ways.
The result is inconsistent even where every individual fix was correct.

### Evidence is assembled by hand

Demonstrating compliance means showing which systems were assessed,
against which version of which benchmark, with what result,
and what was deliberately accepted as an exception.

When that information lives in scan output on individual machines, in spreadsheets,
and in people's memory, assembling it becomes a project in itself,
repeated for every assessment.

### Benchmarks move

CIS Benchmarks and DISA STIGs are revised.
A new version adds controls, changes thresholds, and retires requirements.

Keeping your own copy of a benchmark current means tracking those revisions across every platform
you run and reworking your checks each time.

## How Chef Compliance works

Chef Compliance follows one loop,
and the loop is what makes compliance hold rather than happen once.

**Define your requirements.**
Start from a published benchmark --- a CIS Benchmark or a DISA STIG ---
expressed as Chef InSpec controls you can run,
or write your own controls for requirements specific to your organization.

**Assess your systems.**
Run those controls against the systems you're responsible for:
servers, desktops, databases, cloud accounts, containers, and network devices.

**Identify the gaps.**
Review the results by node, by profile, and by control to see what failed,
how severe each failure is, and how widely it's affecting your estate.

**Correct the configuration.**
Use Chef remediation content to apply the configuration a benchmark requires,
consistently, to every system that needs it.

**Reassess.**
Run the same controls again.
The assessment is what proves the correction worked.

**Maintain visibility.**
Repeat on a schedule.
Compliance is held rather than achieved,
and drift shows up as a control that starts failing again.

## Compliance audit

A compliance audit determines whether your systems meet the requirements of a benchmark,
and gives you the detail you need to act on the answer.

### What gets assessed

Chef Compliance assesses the systems and services your estate actually consists of:

- Server and desktop operating systems, including Linux, Windows, macOS, AIX, and Solaris
- Databases
- Cloud accounts and subscriptions
- Containers and Kubernetes
- Web servers, middleware, and applications
- Virtualization platforms and network devices

Assessment isn't limited to things you can log in to.
Chef InSpec can examine data in a database or inspect the configuration of virtual resources
through their API, so a cloud subscription is assessed the same way a server is.

### How a benchmark becomes something you can run

A benchmark such as a CIS Benchmark or a DISA STIG is a published document.
It describes, requirement by requirement, how a particular platform should be configured.

Chef expresses those requirements as Chef InSpec controls, grouped into a profile.
Each control carries an identifier, a title, a description, and an impact rating,
and produces a clear result --- pass, fail, or skip --- for every system it runs against.

Because benchmarks are revised over time,
a profile is written against a specific benchmark version.
That's why Chef tracks coverage by version rather than as a single yes or no:
knowing that a platform is covered matters less than knowing
which version of the benchmark it's covered against.

Chef provides profiles built on CIS Benchmarks and DISA STIGs,
and you can write your own controls or adapt the provided ones.

### How you run an assessment

How you run an assessment depends on how the systems are managed.
You can use more than one approach in the same estate.

| Approach | Fits | How it runs |
| --- | --- | --- |
| Compliance Phase | Nodes already managed by Chef Infra Client | Runs compliance audits as part of any Chef Infra Client run |
| Scan jobs in Chef Automate | Nodes and cloud accounts, including systems without an agent | Runs now, at a scheduled time, once, or on a recurring interval |
| Chef InSpec directly | Ad hoc checks, local development, and pipeline stages | Runs locally, or over SSH or WinRM |

The [Compliance Phase](/client/latest/features/chef_compliance_phase/) runs profiles retrieved
from Chef Automate, Chef Supermarket, a local file, GitHub, or HTTP,
and reports results to Chef Automate, the terminal, or a file on disk.
Scan frequency is configurable and defaults to once a day.

[Scan jobs](/automate/scan_jobs/) in Chef Automate are the equivalent of running Chef InSpec
against a set of targets, and send their results to compliance reporting.
They can target manually added nodes, AWS EC2 instances, AWS API regions,
Azure virtual machines, and Azure API subscriptions.
A scheduled cloud scan queries the provider each time it runs,
so instances added or removed since the last scan are picked up.

### What an assessment gives you

An assessment produces more than a pass rate.

For every control on every system, you get the result, its severity,
the profile it came from, and the Chef InSpec source of the control itself,
so that anyone reviewing a finding can see exactly what was checked.

In [Chef Automate](/automate/reports/), those results roll up three ways:

- **Nodes**: which systems passed, failed, were skipped, or were waived,
  and how failures distribute across platforms and environments
- **Profiles**: which benchmarks are in use, at which versions, and which are failing most
- **Controls**: which individual requirements are failing, their severity,
  and how many systems each affects

You can filter by platform, environment, node name, profile, control, control tag, policy group,
role, recipe, Chef tag, organization, and Chef Infra Server.
Deep filtering narrows a report to a single profile, or to one control within a profile.

### How findings turn into a gap list

The same results, read as work rather than as a score, tell you where to start.

A control failing on one system is a configuration issue.
The same control failing on two hundred systems is a fleet-wide gap, and it shows up that way:
Chef Automate surfaces the profiles and the individual controls responsible for the most failures,
so you can see where corrective effort has the most effect.

Severity lets you rank what you found.
Grouping by platform and environment tells you which part of the estate to work on first.
And because results are retained over time,
you can see whether a gap is closing, holding, or reopening.

### Evidence and reporting

Assessment results are the evidence.

Reports are dated and retained,
so you can show the state of your estate on a given day as well as how it changed.
They can be downloaded as JSON or CSV,
and a download reflects the filters and the report date you selected,
so that the evidence you export is the evidence you were looking at.

Where a failing control has been deliberately accepted,
record it as a [waiver](/inspec/latest/configure/waivers/)
rather than leaving it as an unexplained failure.
Waived nodes and controls are counted, tracked over time, and filterable,
and each waiver's detail is visible on the control it applies to.
An accepted exception stays visible as an accepted exception.

To see which benchmarks and versions have current audit coverage, see
[supported compliance standards and platforms](#supported-compliance-standards-and-platforms).

## Compliance remediation

An assessment tells you a system doesn't meet a requirement.
Remediation content helps you correct the configuration behind that requirement,
the same way, on every system that needs it.

### What remediation content is

Remediation content is curated, standards-based content
that brings a system's configuration into line with what a benchmark requires.
It's delivered as Chef Infra cookbooks,
built against the same CIS Benchmarks and DISA STIGs as the audit profiles,
and maintained by Chef as those benchmarks are revised.

Remediation content is part of [Chef Premium Content](/enterprise_chef/),
which provides ready-to-use curated content for compliance audits, remediation,
and desktop configuration.
Chef Premium Content is provided to enterprise users of Chef,
and subscribers are notified when content is updated.

### How remediation relates to benchmarks and controls

Audit content and remediation content are built from the same published benchmark,
but they do different jobs.

Audit content answers a question: does this system meet the requirement?
Remediation content addresses the subject of that question:
the configuration the requirement describes.
A failed control and the remediation for it refer to the same underlying benchmark requirement.

Because they're maintained as separate content, Chef tracks their coverage separately.
A benchmark can have audit coverage, remediation coverage, or both.
Where both exist, the available versions can differ.

**An audit version doesn't imply a matching remediation version.**
This is worth knowing before you plan work around remediation content,
and it's why the coverage tables list audit versions and remediation versions in separate columns
rather than giving a single answer for each benchmark.

### How it standardizes corrective action

Applying a fix by hand once is straightforward.
Applying the same fix to every affected system, consistently, and keeping it applied, isn't.

Remediation content addresses that in three ways:

**It's the same content everywhere.**
The corrective configuration for a benchmark requirement is defined once
and applied the same way to every system in that class,
instead of varying with whoever carried out the change.

**It goes through your existing cookbook workflow.**
Because remediation content is delivered as Chef Infra cookbooks,
it fits the review, testing, and promotion process you already use for cookbooks.
You can test it with [Chef Workstation](/workstation/latest/) before it reaches production.

**It holds, rather than applying once.**
Chef Infra Client converges:
it acts only when a system's current state doesn't match what the cookbook describes.
Re-running remediation content on a system that's already correct changes nothing,
which is what makes it usable on a schedule rather than as a one-off intervention.

### How audit and remediation work together

Audit and remediation are separate capabilities that are most useful in sequence:

1. Assess your systems with audit content and get a result for every control.
1. Identify which controls failed, their severity, and how many systems they affect.
1. Apply remediation content for the configuration behind those failures.
1. Reassess with the same audit content.
1. Confirm that the previously failing controls now pass, with a dated record of the change.
1. Maintain the cycle on a schedule, so drift surfaces as a control that starts failing again.

Reassessment is what makes this a loop rather than a list.
The audit content is what demonstrates the remediation worked,
which is why the two are used together and why neither replaces the other.

### Before you use remediation content

- **Check coverage first.**
  Remediation coverage is narrower than audit coverage,
  and available versions differ by benchmark.
  See [supported compliance standards and platforms](#supported-compliance-standards-and-platforms).
- **Confirm your entitlement.**
  Remediation content is part of Chef Premium Content,
  which is provided to enterprise users of Chef.
- **Expect content to change.**
  Benchmarks are revised, and remediation content is updated to follow them.
- **Test before production.**
  Remediation content changes system configuration.
  Test it the way you'd test any cookbook.

## Common compliance scenarios

### Assess a Linux fleet against CIS Benchmarks

**The problem.**
You run several hundred Linux systems across a few distributions and a range of releases,
and you've been asked to show they meet CIS Benchmark requirements.

**The Chef approach.**
Use the Chef InSpec profiles built on the relevant CIS Benchmarks
for the distributions and versions you run.
On nodes already managed by Chef,
turn on the Compliance Phase so the assessment runs as part of the Chef Infra Client run.
Send results to Chef Automate.

**The outcome.**
One view of every Linux system, grouped by node, profile, and control,
showing which CIS requirements pass and which don't ---
and which failures are fleet-wide rather than isolated.

See [Operating Systems](/solutions/compliance/operating_systems/) for current coverage.

### Assess Windows environments against security baselines

**The problem.**
Your Windows estate spans several Server releases and a mix of client builds,
and the security baseline for each is different.

**The Chef approach.**
Use the profiles built on the CIS Benchmark or DISA STIG for each Windows version you run.
Assess through the Compliance Phase on managed nodes,
or with Chef Automate scan jobs where nodes aren't managed by Chef Infra Client.

**The outcome.**
A per-release view of baseline conformance, filterable by platform and environment,
so a 2016 finding isn't conflated with a 2022 finding.

See [Operating Systems](/solutions/compliance/operating_systems/) and
[Desktop / Client](/solutions/compliance/desktop_client/) for current coverage.

### Find compliance gaps in databases

**The problem.**
Database configuration is in scope for your compliance requirements,
but it's managed by a different team with different tooling,
and nobody has a current picture.

**The Chef approach.**
Assess database instances with the profiles built on the relevant CIS Benchmarks.
Chef InSpec can examine data in a database directly,
so assessment doesn't depend on inspecting configuration files alone.
Use deep filtering in Chef Automate to report on one database profile,
or one control within it.

**The outcome.**
Database compliance reported the same way as everything else, in the same place,
instead of as a separate exercise.

See [Databases](/solutions/compliance/databases/) for current coverage.

### Address controls that keep failing across your estate

**The problem.**
The same handful of controls fail on hundreds of systems, assessment after assessment.
Each fix is understood; applying them consistently and keeping them applied isn't.

**The Chef approach.**
Use the top control failures view in Chef Automate
to identify which requirements account for the most failures.
Where remediation content covers the benchmark,
apply it to correct the configuration behind those controls,
then reassess with the same audit content to confirm the result.
Re-running on a schedule holds the configuration,
because Chef Infra Client acts only where a system has drifted.

**The outcome.**
Repeated failures handled once as a class rather than many times as individual incidents,
with a dated record showing when they stopped failing.

### Maintain compliance across a mixed estate

**The problem.**
Your estate spans on-premises servers, cloud accounts, desktops, databases, and containers.
Each has its own benchmark and, today, its own process.

**The Chef approach.**
Assess each class of system with the profiles built for it,
using the Compliance Phase for managed nodes
and Chef Automate scan jobs for cloud accounts and systems without an agent.
Schedule scans to recur.
Report everything into the same place.

**The outcome.**
Heterogeneity stops being a reporting problem.
Scheduled cloud scans re-query the provider on each run,
so newly created instances are assessed without anyone having to remember to add them.

### Prepare for a compliance assessment

**The problem.**
An assessment is scheduled and you need to show which systems were checked, against what,
with what result, and what was accepted as an exception.

**The Chef approach.**
Filter reports to the systems and benchmarks in scope,
select the reporting date you need,
and download the results as JSON or CSV.
Make sure accepted failures are recorded as waivers
rather than left as unexplained failures.

**The outcome.**
Evidence assembled from assessment results rather than from memory:
dated, filtered to scope, exportable, and showing both results and accepted exceptions.

## Supported compliance standards and platforms

Chef tracks audit and remediation coverage as independent dimensions.
A benchmark can have audit coverage, remediation coverage, or both,
and where both exist the available versions can differ.
Every version is listed --- version sets are never reduced to a single latest version ---
because which version of a benchmark you're covered against
is usually the question that matters.

Current coverage is **132 benchmarks**:

| Coverage | Benchmarks |
| --- | ---: |
| Audit and remediation | 60 |
| Audit only | 59 |
| Remediation only | 13 |
| **Total** | **132** |

Across those benchmarks there are 191 audit versions and 101 remediation versions,
built on CIS Benchmarks and DISA STIGs.

Browse coverage by category:

| Category | Benchmarks |
| --- | ---: |
| [Operating Systems](/solutions/compliance/operating_systems/) | 69 |
| [Desktop / Client](/solutions/compliance/desktop_client/) | 23 |
| [Databases](/solutions/compliance/databases/) | 16 |
| [Applications / Middleware](/solutions/compliance/applications_middleware/) | 9 |
| [Cloud](/solutions/compliance/cloud/) | 5 |
| [Web Servers](/solutions/compliance/web_servers/) | 5 |
| [Containers / Kubernetes](/solutions/compliance/containers_kubernetes/) | 2 |
| [Network / Infrastructure](/solutions/compliance/network_infrastructure/) | 2 |
| [Virtualization](/solutions/compliance/virtualization/) | 1 |

### How to read the coverage tables

| Term | Meaning |
| --- | --- |
| Audit + Remediation | Both audit and remediation content cover this benchmark |
| Partial Audit + Remediation | Both are present, but the version sets overlap only partly |
| Audit Ahead | Audit content covers a newer benchmark version than remediation content does |
| Remediation Ahead | Remediation content covers a newer benchmark version than audit content does |
| Audit Only | Audit content only; no current remediation content |
| Remediation Only | Remediation content only; no current audit content |

A dagger (†) on a remediation version means the version is **Inferred Current**:
it's part of Chef's current remediation content,
but version-level release evidence wasn't found.
Inferred Current doesn't mean unsupported.

Some entries have no framework prefix.
Those benchmarks aren't published by Chef under a named framework,
so no framework is shown rather than one being inferred.

## Get started

**Understand the workflow.**
Read [about the Compliance Phase](/client/latest/features/chef_compliance_phase/)
to see how compliance assessment fits into a Chef Infra Client run.

**Check your coverage.**
Find your platforms in the category pages above
and confirm which benchmark versions have audit and remediation coverage.

**Get your profiles.**
Install profiles from the [Chef Automate Profiles page](/automate/profiles/),
or upload your own.

**Run your first assessment.**
Turn on the Compliance Phase on managed nodes,
or create a [scan job](/automate/scan_jobs/) in Chef Automate for nodes and cloud accounts.
Set up [node credentials](/automate/node_credentials/) first
if you're scanning systems that aren't managed by Chef Infra Client.

**Review your findings.**
Use [compliance reporting](/automate/reports/) to see results by node, profile, and control,
and to filter down to what you need.

**Write your own controls.**
Use [Chef InSpec](/inspec/latest/) and [Chef Workstation](/workstation/latest/)
to author and test controls for requirements specific to your organization.
