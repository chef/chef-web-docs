+++
title = "The Chef way of GCP compliance"
description = "Audit a Google Cloud project against a security baseline with Chef InSpec and the GCP resource pack: check Cloud Storage buckets, firewall rules, and IAM bindings."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/compliance/gcp_foundations"
  parent = "overview/solutions/compliance"
  title = "GCP compliance"
  weight = 6
+++

A Cloud Storage bucket readable by `allUsers`, a firewall rule that opens SSH to `0.0.0.0/0`,
or a service account holding the Owner role can sit in a Google Cloud project for months
before anyone notices.
Nothing in the Google Cloud console tells you these violate your baseline,
and checking by hand doesn't scale past a handful of projects.

The steps below write a Chef InSpec profile with the **GCP resource pack**,
run it against a Google Cloud project, and read what comes back.
It uses the same pattern as
[The Chef way of SSH compliance](/solutions/compliance/ssh_baseline/),
applied to a cloud project instead of a host.
If you haven't written a Chef InSpec profile before, start there first.

## What you'll build

A Chef InSpec profile with three controls that assert:

- No Cloud Storage bucket grants access to `allUsers` or `allAuthenticatedUsers`.
- No ingress firewall rule open to `0.0.0.0/0` allows SSH (22) or RDP (3389).
- No service account holds the basic Owner or Editor role on the project.

By the end you'll be able to run that profile against a Google Cloud project,
get a pass or fail result for each control,
save the results as a JSON file you can keep as evidence,
and record an approved exception so it doesn't show up as a failure.

[Extend the profile to more of the project](#extend-the-profile-to-more-of-the-project)
then adds two more checks to the same profile,
using the same pattern you'd follow for any other Google Cloud service.

{{< note >}}

**Where the details come from.**
Resource names, properties, and matchers on this page come from the
[GCP resource pack reference](/inspec/resource_packs/gcp/).
The generated `inspec.yml` and `inputs.yml` come from the Chef InSpec
`inspec init profile --platform gcp` template.
Exit codes come from the [Chef InSpec CLI reference](/inspec/latest/reference/cli/).
Assessment results shown for a run against a live Google Cloud project are illustrative and
are labeled where they appear.

{{< /note >}}

## Before you begin

You need:

- **Chef InSpec**, from [Chef Workstation](/workstation/latest/) or a
  [standalone install](/inspec/latest/install/).
  Run `inspec version` to confirm it's available.
- **A Google Cloud project** to assess, and its project ID.
- **The [Google Cloud SDK](https://cloud.google.com/sdk/docs/)**, which provides the `gcloud` command.
- **A service account** for Chef InSpec to authenticate as, with a JSON key.
  Google Cloud recommends service accounts over user accounts for automated access.
- **The APIs your controls call, turned on in the project.**
  The controls on this page use the Compute Engine API, the Cloud Storage API,
  and the Cloud Resource Manager API.

You don't need to install anything in the project.
Chef InSpec connects to the Google Cloud APIs and reads what it needs.

### APIs and roles each resource requires

The GCP resource pack reference lists the API each resource depends on.
If an API is turned off, the resource returns an `Access Not Configured` error instead of data.

| Resource | API documented for it |
| --- | --- |
| [`google_storage_buckets`](/inspec/resource_packs/gcp/google_storage_buckets/) | Cloud Storage |
| [`google_storage_bucket_iam_policy`](/inspec/resource_packs/gcp/google_storage_bucket_iam_policy/) | Cloud Storage |
| [`google_compute_firewalls`](/inspec/resource_packs/gcp/google_compute_firewalls/) | Compute Engine |
| [`google_compute_firewall`](/inspec/resource_packs/gcp/google_compute_firewall/) | Compute Engine |
| [`google_project_iam_policy`](/inspec/resource_packs/gcp/google_project_iam_policy/) | Cloud Resource Manager |

The service account also needs read access to what the controls inspect.
The **Viewer** role (`roles/viewer`) covers listing buckets and firewall rules,
and the **Security Reviewer** role (`roles/iam.securityReviewer`) covers reading IAM policies.
Grant both on the project you're assessing.

A missing permission or a turned-off API surfaces as a Google Cloud API error on the control
that needed it, not as a failing assertion.
Resolve those before you interpret any result as a finding.

## Get the GCP resource pack

Checking a host uses Chef InSpec's core resources.
Checking Google Cloud objects---a bucket, a firewall rule, an IAM policy---needs
the [GCP resource pack](/inspec/resource_packs/gcp/), a separately
distributed set of resources for Google Cloud.

The GCP pack covers Compute Engine, Cloud Storage, Cloud SQL, GKE, IAM,
Cloud KMS, Cloud Logging, Pub/Sub, BigQuery, and Vertex AI.
See the pack's own documentation for the full resource list with properties
and matchers for each one.

A resource pack isn't a benchmark and doesn't assess anything on its own.
It gives you the resources to write controls with;
the controls themselves are content you own and maintain.
For Chef's published Google Cloud benchmark content, see
[supported compliance standards and platforms](/solutions/compliance/#supported-compliance-standards-and-platforms).

`inspec init profile --platform gcp` declares the pack as a dependency; Step 2 fetches it.

## Step 1: Create a profile

Generate a profile pre-configured for Google Cloud:

```shell
inspec init profile --platform gcp gcp-baseline
```

The generator creates `README.md`, `inspec.yml`, `inputs.yml`,
a `controls/` directory with an example control, and a `libraries/` directory.

Three entries in the generated `gcp-baseline/inspec.yml` are what make this a Google Cloud profile:

```yaml
inputs:
  - name: gcp_project_id
    required: true
    description: 'The GCP project identifier.'
depends:
  - name: inspec-gcp
    url: https://github.com/inspec/inspec-gcp/archive/main.tar.gz
supports:
  - platform: gcp
```

`inputs` declares the project ID that every control reads, so the same profile runs against any
project without editing the controls.
`depends` brings the `google_*` resources into scope for your controls.
`supports` restricts the profile to Google Cloud targets, so running it against a Linux host skips it
instead of reporting failures that mean nothing.
These are described in the [inputs reference](/inspec/latest/profiles/inputs/),
the [profile dependencies reference](/inspec/latest/profiles/depends/),
and the [profile platforms reference](/inspec/latest/profiles/platforms/).

Describe what the profile is for in the same file, leaving `inputs`, `depends`, and `supports` in place:

```yaml
name: gcp-baseline
title: Google Cloud project security baseline
maintainer: Example Organization, Inc.
copyright: Example Organization, Inc.
copyright_email: compliance@example.com
license: Apache-2.0
summary: Verify Cloud Storage, firewall, and IAM configuration against organization requirements
version: 0.1.0
```

Then set the project to assess in `gcp-baseline/inputs.yml`:

```yaml
gcp_project_id: '<PROJECT_ID>'
```

For every field you can set in `inspec.yml`, see
[the inspec.yml reference](/inspec/latest/profiles/inspec_yml/).

## Step 2: Vendor the dependency

Declaring the pack isn't the same as having it.
The pack is fetched over the network, so pull it down before you rely on the profile:

```shell
inspec vendor gcp-baseline
```

This writes a `vendor/` directory holding the pack and an `inspec.lock` file recording
exactly what was fetched, including a `sha256` for the archive.

The dependency URL points at `main`, so its contents change over time.
The `sha256` in `inspec.lock` pins the archive this profile resolved against;
commit `inspec.lock` with the profile and your runs stay reproducible until you
re-vendor on purpose with `inspec vendor --overwrite`.

## Step 3: Set credentials

Create a service account in the project, grant it the roles listed in
[Before you begin](#apis-and-roles-each-resource-requires), and download a JSON key for it.
Google's
[service account documentation](https://cloud.google.com/iam/docs/service-accounts-create)
covers each step.

Point Chef InSpec at the key file:

```shell
export GOOGLE_APPLICATION_CREDENTIALS=<PATH_TO_KEY_FILE>
```

Replace `<PATH_TO_KEY_FILE>` with the full path to the downloaded JSON key,
for example `~/.config/gcloud/inspec-audit.json`.

For a quick local trial, you can authenticate as yourself instead with
`gcloud auth application-default login`.
Use a service account for anything that runs on a schedule.

{{< warning >}}

Keep credentials out of the profile.
Nothing in `inspec.yml`, `inputs.yml`, or `controls/` should contain a service account key,
and the key file shouldn't be stored in or committed with the profile directory.
A service account key is a long-lived credential, so store it the way you'd store a password.

{{< /warning >}}

Confirm Chef InSpec can load the Google Cloud transport:

```shell
inspec detect -t gcp://
```

The platform details report `gcp` as the platform name.
Treat this as confirmation that the Google Cloud transport loaded,
and use the first run of the profile to confirm that your credentials work.

## Step 4: Write the controls

Delete the generated example control and create `controls/gcp.rb`:

```ruby
gcp_project_id = input('gcp_project_id')

control 'gcp-01' do
  impact 'critical'
  title 'Cloud Storage buckets must not be publicly accessible'
  desc 'A bucket that grants a role to allUsers or allAuthenticatedUsers exposes its contents to anyone with a Google account or anyone at all.'
  tag 'gcp', 'storage'

  google_storage_buckets(project: gcp_project_id).bucket_names.each do |bucket_name|
    google_storage_bucket_iam_policy(bucket: bucket_name).bindings.each do |binding|
      describe binding do
        its('members') { should_not include 'allUsers' }
        its('members') { should_not include 'allAuthenticatedUsers' }
      end
    end
  end
end

control 'gcp-02' do
  impact 'high'
  title 'Firewall rules must not allow unrestricted remote administration'
  desc 'SSH (22) and RDP (3389) open to 0.0.0.0/0 let anyone on the internet attempt a login.'
  tag 'gcp', 'compute'

  google_compute_firewalls(project: gcp_project_id).where(firewall_direction: 'INGRESS').firewall_names.each do |firewall_name|
    firewall = google_compute_firewall(project: gcp_project_id, name: firewall_name)
    next unless firewall.source_ranges.to_a.include?('0.0.0.0/0')

    describe firewall do
      it { should_not allow_port_protocol('22', 'tcp') }
      it { should_not allow_port_protocol('3389', 'tcp') }
    end
  end
end

control 'gcp-03' do
  impact 'high'
  title 'Service accounts must not hold the Owner or Editor role'
  desc 'Basic roles grant broad access to every service in the project; service accounts should use narrower roles.'
  tag 'gcp', 'iam'

  google_project_iam_policy(project: gcp_project_id).bindings.each do |binding|
    next unless %w(roles/owner roles/editor).include?(binding.role)

    describe binding do
      its('members') { should_not include a_string_starting_with('serviceAccount:') }
    end
  end
end
```

Each part of a control does a specific job:

`gcp_project_id = input('gcp_project_id')`
: Reads the project ID from `inputs.yml`, or from the command line, once for the whole file.
  Every resource on this page takes the project as a parameter.

`control 'gcp-01'`
: The identifier that follows this check through every report.
  Keep it stable---if you renumber controls later, you lose the ability to compare
  this month's results against last month's.

`impact`
: How serious a failure is.
  Accepts `none`, `low`, `medium`, `high`, and `critical`, or a float from `0.0` to `1.0`.

`google_storage_buckets`, `google_compute_firewalls`
: Plural resources from the GCP pack that list every matching object in the
  project, so a control checks the whole project instead of one bucket you
  have to name in advance.
  Each singular resource then inspects one object by name.
  `where(firewall_direction: 'INGRESS')` filters the list to inbound rules before the loop runs.

`google_storage_bucket_iam_policy`, `google_project_iam_policy`
: Return the IAM policy for a bucket or a project as a list of bindings,
  each with a `role` and the `members` granted that role.

`should_not allow_port_protocol('22', 'tcp')`
: A matcher specific to the GCP pack's `google_compute_firewall` resource---this
  kind of target-specific matcher is exactly what a resource pack
  provides that core resources can't.

See the [GCP resource pack documentation](/inspec/resource_packs/gcp/)
for the full set of Google Cloud resources, and
[the controls reference](/inspec/latest/profiles/controls/) for control syntax.

Two details decide how much these controls actually cover:

**`gcp-01` reads bucket-level IAM only.**
It doesn't inspect object ACLs on buckets that still use fine-grained access control,
so a private bucket holding a public object still passes `gcp-01`.
Turning on uniform bucket-level access for every bucket removes object ACLs
and makes bucket IAM the only access path.

**`gcp-02` only checks rules open to exactly `0.0.0.0/0`.**
A rule open to a broad but narrower range, such as `0.0.0.0/1`, isn't selected by the
`next unless` line and doesn't fail.
Add each range your organization treats as unrestricted to that check.

## Step 5: Validate the profile

Before running the profile against a real project, check that it's well-formed:

```shell
inspec check gcp-baseline
```

The output reports `Controls : 3` and `Valid : true` when Chef InSpec parsed all three controls.
A Ruby syntax error, an undeclared input, or a dependency you haven't vendored surfaces
here rather than part way through a run against production.

## Step 6: Run the assessment

The target is the Google Cloud project, not a machine, so there's nothing to connect to
over SSH:

```shell
inspec exec gcp-baseline -t gcp:// --input-file gcp-baseline/inputs.yml
```

To assess a different project, override the input on the command line
instead of editing `inputs.yml`:

```shell
inspec exec gcp-baseline -t gcp:// --input gcp_project_id=<OTHER_PROJECT_ID>
```

The service account needs the same roles in every project you assess.

If no usable credentials are available, or a required API is turned off,
the run stops with a Google Cloud error instead of reporting failed controls.
Resolve that before reading anything into a result.

## Step 7: Read the results

A run against a project with a public bucket and an open firewall rule
looks like this.
This output is illustrative:

```text
Profile:   Google Cloud project security baseline (gcp-baseline)
Version:   0.1.0
Target:    gcp://inspec-audit@<PROJECT_ID>.iam.gserviceaccount.com

  ×  gcp-01: Cloud Storage buckets must not be publicly accessible
     ×  members is expected not to include "allUsers"

  ×  gcp-02: Firewall rules must not allow unrestricted remote administration
     ×  Firewall allow-ssh-anywhere is expected not to allow port protocol "22" and "tcp"

  ✔  gcp-03: Service accounts must not hold the Owner or Editor role


Profile Summary: 1 successful control, 2 control failures, 0 controls skipped
Test Summary: 3 successful, 2 failures, 0 skipped
```

Read it the same way as any Chef InSpec run:
`×` is a failure, `✔` is a pass, and each failure names the control, the
object checked, and what was expected.
Because the controls iterate every bucket, firewall rule, and IAM binding in
the project, a single control can report multiple failures, one for each
object that doesn't meet the requirement.

### Exit codes

`inspec exec` sets an exit code describing the outcome, which is what a pipeline acts on:

| Exit code | Meaning |
| --- | --- |
| `0` | Normal exit, all tests passed |
| `1` | Usage or general error |
| `100` | Normal exit, at least one test failed |
| `101` | Normal exit, at least one test skipped but none failed |
| `172` | Chef license not accepted |

An authentication failure or a turned-off API isn't a finding.
Treat any exit code other than `0`, `100`, or `101` as a broken run, not as evidence.
The complete list of codes is in the
[Chef InSpec CLI reference](/inspec/latest/reference/cli/).

### Keep the results

For evidence, write a structured file at the same time:

```shell
inspec exec gcp-baseline -t gcp:// --input-file gcp-baseline/inputs.yml --reporter cli json:results.json
```

The JSON includes each control's ID, its impact as a number, and the status
of every test, so you can feed it into a ticketing system or keep it as a
dated record.
Only one reporter can write to standard output at a time.
Other formats are in the [reporters reference](/inspec/latest/configure/reporters/).

## Step 8: Fix a finding and reassess

The bucket finding above is a configuration change in Google Cloud, not in the
profile.
Remove the `allUsers` binding from the bucket and turn on
[public access prevention](https://cloud.google.com/storage/docs/public-access-prevention),
then run the same profile again:

```shell
inspec exec gcp-baseline -t gcp:// --input-file gcp-baseline/inputs.yml
```

```text
  ✔  gcp-01: Cloud Storage buckets must not be publicly accessible
  ×  gcp-02: Firewall rules must not allow unrestricted remote administration
  ✔  gcp-03: Service accounts must not hold the Owner or Editor role


Profile Summary: 2 successful controls, 1 control failure, 0 controls skipped
```

Running the profile again is what demonstrates the fix worked.
The first run found the gap, the second run is the evidence that it's closed,
and both are dated.

{{< note >}}

Correct Google Cloud findings with Google Cloud tooling.
Nothing in the GCP resource pack changes a configuration---it reads the Google Cloud APIs and
reports what it finds---and Chef's remediation cookbooks cover operating system and
platform benchmarks, not cloud provider APIs.
See [compliance remediation](/solutions/compliance/#compliance-remediation) for what
remediation content covers.

{{< /note >}}

## Step 9: Waive an exception you've accepted

Some findings are accepted rather than fixed---for example, a firewall rule
intentionally open for a documented reason.
Because `gcp-02` uses one control ID while checking firewall rules in the project,
waiving it skips the entire control, including SSH and RDP checks for other rules.
Use this waiver only when the approved exception covers the project-wide assessment.
For an exception limited to one firewall rule, don't use this project-wide waiver.
Create `waivers.yml`:

```yaml
gcp-02:
  justification: "Approved project-wide exception CHG-5307; SSH and RDP checks for all ingress firewall rules are waived during the migration window."
  expiration_date: 2027-06-30
  run: false
```

Apply it:

```shell
inspec exec gcp-baseline -t gcp:// --input-file gcp-baseline/inputs.yml --waiver-file waivers.yml
```

The control reports as skipped and carries your justification into the
report, the same way a waiver works for any Chef InSpec profile.
See [the waivers reference](/inspec/latest/configure/waivers/) for the full
file format, and
[Step 7 of SSH compliance](/solutions/compliance/ssh_baseline/#step-7-waive-an-exception-youve-accepted)
for another worked example.

## Extend the profile to more of the project

The three controls above check one thing for each service.
Adding more follows the same shape: list objects with the plural resource,
assert against each one with the singular resource.
Add these controls to `controls/gcp.rb`:

```ruby
control 'gcp-04' do
  impact 'medium'
  title 'Cloud Storage buckets must have object versioning enabled'
  desc 'Versioning keeps prior copies of objects so accidental or malicious overwrites can be recovered.'
  tag 'gcp', 'storage'

  google_storage_buckets(project: gcp_project_id).bucket_names.each do |bucket_name|
    describe google_storage_bucket(name: bucket_name) do
      its('versioning.enabled') { should cmp true }
    end
  end
end

control 'gcp-05' do
  impact 'medium'
  title 'Ingress firewall rules must have logging enabled'
  desc 'Firewall Rules Logging records which connections each rule allowed or denied, which you need to investigate an incident.'
  tag 'gcp', 'compute'

  google_compute_firewalls(project: gcp_project_id).where(firewall_direction: 'INGRESS').firewall_names.each do |firewall_name|
    describe google_compute_firewall(project: gcp_project_id, name: firewall_name) do
      its('log_config_enabled?') { should be true }
    end
  end
end
```

`versioning.enabled` and `log_config_enabled?` are documented in the
[`google_storage_bucket`](/inspec/resource_packs/gcp/google_storage_bucket/) and
[`google_compute_firewall`](/inspec/resource_packs/gcp/google_compute_firewall/) references.
A bucket that has never had versioning configured doesn't return `versioning.enabled`,
so it fails `gcp-04` the same way as a bucket with versioning turned off.

Re-run `inspec check` after adding controls.
`Controls : 5` confirms both were parsed.

A bucket that fails `gcp-04` needs
[object versioning](https://cloud.google.com/storage/docs/using-object-versioning) turned on.
A rule that fails `gcp-05` needs
[Firewall Rules Logging](https://cloud.google.com/firewall/docs/using-firewall-rules-logging) turned on.

The same approach works for the rest of the project.
Every resource in the [GCP resource pack](/inspec/resource_packs/gcp/) lists its
properties, and the ones you need depend on which requirements you're assessing.

## Run it on a schedule with Chef Automate

Running the profile by hand answers the question for today.
Because projects change constantly, the useful version of this assessment runs again
without anybody remembering to run it.

Chef Automate assesses a Google Cloud project through a GCP API node manager, which creates a
node reference for the project tied to a service account credential:

1. In Chef Automate, on the **Settings** tab, go to the **Node Integrations** page and add
   a **Google Cloud** node manager with the JSON key of your service account.
   The [node integrations documentation](/automate/node_integrations/) lists the fields
   the key must contain.
1. Upload the profile from the [Chef Automate Profiles page](/automate/profiles/).
1. Create a [scan job](/automate/scan_jobs/) that runs the profile against the project
   reference the node manager created, and set it to recur.
1. Review results in [compliance reporting](/automate/reports/), filtered by profile and
   control.

A scheduled cloud scan queries the provider each time it runs, so buckets, firewall rules,
and IAM bindings added since the last scan are picked up without editing the profile.

The two execution paths differ in where results land, not in what gets checked.
A direct `inspec exec` run prints to your terminal and writes whatever file your
`--reporter` names; a scan job stores results in Chef Automate, with history for each run.

The [Compliance Phase](/client/latest/features/chef_compliance_phase/) is the third
execution path, and it isn't the right one here---it runs profiles during a Chef Infra Client
run on a node, and a Google Cloud project has no node to run on.
Use scan jobs for cloud projects, and the Compliance Phase for the Compute Engine instances inside them.

## Where to go next

**Start from a published benchmark instead of your own controls.**
Chef publishes prebuilt audit content built on the CIS Google Cloud Platform Foundations
Benchmark---see
[supported compliance standards and platforms](/solutions/compliance/#supported-compliance-standards-and-platforms)
to check current coverage before writing your own controls for a
requirement it may already cover.

**Assess the instances as well as the project.**
This profile checks the project's configuration.
The Compute Engine instances inside it are assessed as hosts---see
[The Chef way of SSH compliance](/solutions/compliance/ssh_baseline/)
and [Operating Systems](/premium_content/operating_systems/) for the benchmarks Chef
publishes.

**Check other cloud providers or container platforms.**
See [The Chef way of AWS compliance](/solutions/compliance/aws_foundations/),
[The Chef way of Azure compliance](/solutions/compliance/azure_foundations/),
and [The Chef way of custom compliance checks](/solutions/compliance/extend/)
for the Kubernetes and other resource packs, and how each is added to a profile.

## Related

- [GCP resource pack documentation](/inspec/resource_packs/gcp/)
- [Profile inputs](/inspec/latest/profiles/inputs/)
- [Profile dependencies](/inspec/latest/profiles/depends/)
- [Chef InSpec CLI reference](/inspec/latest/reference/cli/)
- [Waivers reference](/inspec/latest/configure/waivers/)
- [Chef Automate node integrations](/automate/node_integrations/)
- [Chef Automate scan jobs](/automate/scan_jobs/)
- [The Chef way of SSH compliance](/solutions/compliance/ssh_baseline/)
- [Cloud benchmark coverage](/premium_content/cloud/)
- [Compliance solution overview](/solutions/compliance/)
