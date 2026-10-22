+++
title = "Audit an AWS account against security baseline"
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/compliance/aws_foundations"
  parent = "overview/solutions/compliance"
  title = "Guide: Audit an AWS account"
  weight = 6
+++

A publicly readable S3 bucket, an IAM policy with wildcard permissions, or a security group
open to `0.0.0.0/0` can sit in an AWS account for months before anyone notices --- nothing
about the AWS console tells you these violate your baseline, and checking by hand doesn't
scale past a handful of accounts.

This guide walks through writing a Chef InSpec profile with the **AWS resource pack**,
running it against an AWS account, and reading what comes back.
It uses the same pattern as
[Audit SSH configuration across a Linux fleet](/solutions/compliance/ssh_baseline/),
applied to a cloud account instead of a host ---
if you haven't written a Chef InSpec profile before, start there first.

## What you'll build

A Chef InSpec profile with three controls that assert:

- No S3 bucket in the account is publicly readable or writable.
- No IAM policy grants `*` action permissions on `*` resources.
- No security group allows unrestricted inbound access on port 22 or 3389.

By the end you'll be able to run that profile against an AWS account,
get a pass or fail result for each control,
save the results as a JSON file you can keep as evidence,
and record an approved exception so it doesn't show up as a failure.

The same pattern works for any AWS resource the pack covers ---
these three checks are the example, not the limit.

## Before you begin

You need:

- **Chef InSpec**, from [Chef Workstation](/workstation/latest/) or a
  [standalone install](/inspec/latest/install/).
  Run `inspec version` to confirm it's available.
- **An AWS account** to assess, and credentials for it.
  An account with the AWS-managed `ReadOnlyAccess` policy is enough for every
  control in this guide.
- **AWS credentials available as environment variables.**
  This guide uses the standard AWS SDK credential chain, the same one the
  AWS CLI uses, so anything that already works with `aws` works here.

You don't need to install anything in the AWS account.
Chef InSpec connects to the AWS API and reads what it needs.

## Get the AWS resource pack

Checking a host uses Chef InSpec's core resources.
Checking AWS objects --- an S3 bucket, an IAM policy, a security group ---
needs the [AWS resource pack](/inspec/resource_packs/aws/), a separately
distributed set of resources for AWS.

The AWS pack covers EC2, IAM, RDS, Lambda, VPC and networking, CloudFront,
CloudWatch, SSM, WAF, and API Gateway.
See the pack's own documentation for the full resource list with properties
and matchers for each one.

Unlike archive- or gem-distributed packs, the AWS pack is wired up for you by
`inspec init profile`, which is the first step below.

## Step 1: Create a profile

Generate a profile pre-configured for AWS:

```bash
inspec init profile --platform aws aws-baseline
```

```text
─────────────────────────── InSpec Code Generator ───────────────────────────

Creating new profile at ./aws-baseline
 • Creating file README.md
 • Creating directory ./aws-baseline/controls
 • Creating file controls/example.rb
 • Creating file inspec.yml
```

`--platform aws` adds the AWS resource pack as a dependency and sets
`supports: platform-name: aws` in `inspec.yml`, so the profile only runs
against an AWS target.

Open `aws-baseline/inspec.yml` and describe what this profile is for:

```yaml
name: aws-baseline
title: AWS account security baseline
maintainer: Example Organization, Inc.
copyright: Example Organization, Inc.
copyright_email: compliance@example.com
license: Apache-2.0
summary: Verify AWS S3, IAM, and security group configuration against organization requirements
version: 0.1.0
```

For every field you can set here, see
[the inspec.yml reference](/inspec/latest/profiles/inspec_yml/).

## Step 2: Set credentials and confirm connectivity

Set AWS credentials as environment variables:

```bash
export AWS_REGION=us-east-1
export AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY_ID>
export AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_ACCESS_KEY>
```

Confirm Chef InSpec can reach the account before you write any controls:

```bash
inspec detect -t aws://
```

```text
== Platform Details
Name: aws
Families: cloud, api
Release: aws-sdk-v2.10.125
```

If this fails, it's a credentials or permissions problem, not a profile problem ---
resolve it here before moving on.

## Step 3: Write the controls

Delete the generated example and create `controls/aws.rb`:

```ruby
control 'aws-01' do
  impact 'critical'
  title 'S3 buckets must not be publicly accessible'
  desc 'A bucket open to the public can expose its contents to anyone on the internet.'
  tag 'aws', 's3'

  aws_s3_buckets.bucket_names.each do |bucket_name|
    describe aws_s3_bucket(bucket_name) do
      it { should_not be_public }
    end
  end
end

control 'aws-02' do
  impact 'critical'
  title 'IAM policies must not grant wildcard permissions'
  desc 'A policy allowing Action: "*" on Resource: "*" grants more access than almost any role needs.'
  tag 'aws', 'iam'

  aws_iam_policies.where(attached: true).entry_names.each do |policy_name|
    describe aws_iam_policy(policy_name) do
      its('allow_actions') { should_not include '*' }
    end
  end
end

control 'aws-03' do
  impact 'high'
  title 'Security groups must not allow unrestricted remote administration'
  desc 'SSH (22) and RDP (3389) open to 0.0.0.0/0 let anyone on the internet attempt a login.'
  tag 'aws', 'ec2'

  aws_security_groups.group_ids.each do |sg_id|
    describe aws_security_group(sg_id) do
      it { should_not allow_in(port: 22, ipv4_range: '0.0.0.0/0') }
      it { should_not allow_in(port: 3389, ipv4_range: '0.0.0.0/0') }
    end
  end
end
```

Each part of a control does a specific job:

`control 'aws-01'`
: The identifier that follows this check through every report.
  Keep it stable --- if you renumber controls later, you lose the ability to compare
  this month's results against last month's.

`impact`
: How serious a failure is.
  Accepts `none`, `low`, `medium`, `high`, and `critical`, or a float from `0.0` to `1.0`.

`aws_s3_buckets`, `aws_iam_policies`, `aws_security_groups`
: Plural resources from the AWS pack that list every matching object in the
  account, so a control checks the whole account instead of one bucket you
  have to name in advance.
  Each singular resource --- `aws_s3_bucket`, `aws_iam_policy`,
  `aws_security_group` --- then inspects one object by name or ID.

`should_not allow_in(port: 22, ipv4_range: '0.0.0.0/0')`
: A matcher specific to the AWS pack's `aws_security_group` resource ---
  this kind of target-specific matcher is exactly what a resource pack
  provides that core resources can't.

See the [AWS resource pack documentation](/inspec/resource_packs/aws/)
for the full set of AWS resources, and
[the controls reference](/inspec/latest/profiles/controls/) for control syntax.

## Step 4: Validate the profile

Before running the profile against a real account, check that it's well-formed:

```bash
inspec check aws-baseline
```

```text
Location :   aws-baseline
Profile :    aws-baseline
Controls :   3
Timestamp :  2026-02-11T09:14:22+00:00
Valid :      true

No errors, warnings, or offenses
```

## Step 5: Run the assessment

The target is the AWS account, not a machine, so there's nothing to connect to
over SSH:

```bash
inspec exec aws-baseline -t aws://
```

Against a different account or role, change credentials and repeat the same
command --- the profile doesn't change for each account.

## Step 6: Read the results

A run against an account with a public bucket and an open security group
looks like this:

```text
Profile:   AWS account security baseline (aws-baseline)
Version:   0.1.0
Target:    aws://

  ×  aws-01: S3 buckets must not be publicly accessible
     ×  AWS S3 Bucket audit-logs-example is expected not to be public

  ✔  aws-02: IAM policies must not grant wildcard permissions

  ×  aws-03: Security groups must not allow unrestricted remote administration
     ×  AWS Security Group sg-0123456789abcdef0 is expected not to allow in {:port=>22, :ipv4_range=>"0.0.0.0/0"}


Profile Summary: 1 successful control, 2 control failures, 0 controls skipped
Test Summary: 1 successful, 2 failures, 0 skipped
```

Read it the same way as any Chef InSpec run:
`×` is a failure, `✔` is a pass, and each failure names the control, the
object checked, and what was expected.
Because `aws_s3_buckets` and `aws_security_groups` iterate every object in
the account, a single control can report multiple failures, one for each
bucket or security group that doesn't meet the requirement.

For evidence, write a structured file at the same time:

```bash
inspec exec aws-baseline -t aws:// --reporter cli json:results.json
```

The JSON includes each control's ID, its impact as a number, and the status
of every test, so you can feed it into a ticketing system or keep it as a
dated record.
Other formats are in the [reporters reference](/inspec/latest/configure/reporters/).

{{< note >}}

**Collecting results centrally.**
Point AWS scan jobs at Chef Automate and the same report view used for
host assessments ---
grouped by node, profile, and control --- covers cloud accounts too.
_(Screenshot of an AWS scan result in Chef Automate's compliance reporting goes here.)_

{{< /note >}}

## Step 7: Fix a finding and reassess

The bucket finding above is a configuration change in AWS, not in the
profile. Remove public access from the bucket, then run the same profile
again:

```bash
inspec exec aws-baseline -t aws://
```

```text
  ✔  aws-01: S3 buckets must not be publicly accessible
  ✔  aws-02: IAM policies must not grant wildcard permissions
  ×  aws-03: Security groups must not allow unrestricted remote administration


Profile Summary: 2 successful controls, 1 control failure, 0 controls skipped
```

Running the profile again is what demonstrates the fix worked.
The first run found the gap, the second run is the evidence that it's closed,
and both are dated.

## Step 8: Waive an exception you've accepted

Some findings are accepted rather than fixed --- for example, a security
group intentionally open for a documented reason.
Create `waivers.yml`:

```yaml
aws-03:
  justification: "Approved exception CHG-5102; bastion host requires direct SSH access."
  expiration_date: 2027-06-30
  run: false
```

Apply it:

```bash
inspec exec aws-baseline -t aws:// --waiver-file waivers.yml
```

The control reports as skipped and carries your justification into the
report, the same way a waiver works for any Chef InSpec profile.
See [the waivers reference](/inspec/latest/configure/waivers/) for the full
file format, and
[Step 7 of the SSH guide](/solutions/compliance/ssh_baseline/#step-7-waive-an-exception-youve-accepted)
for another worked example.

## Where to go next

**Run it on a schedule instead of by hand.**
Create an [AWS scan job](/automate/scan_jobs/) in Chef Automate, targeting
either manually added accounts or every account in an AWS API region.
A scheduled cloud scan queries the provider each time it runs, so accounts
and resources added since the last scan are picked up automatically.

**Collect results centrally.**
Point scan jobs at Chef Automate to get
[compliance reporting](/automate/reports/) across every AWS account, with
history by node, profile, and control.

**Check more of the account.**
This guide covers three controls.
The [AWS resource pack](/inspec/resource_packs/aws/) covers far more of the
account --- EC2, RDS, Lambda, CloudTrail, and more --- see its documentation
for the full resource list.

**Start from a published benchmark instead of your own controls.**
Chef publishes prebuilt audit content built on the CIS AWS Foundations
Benchmark --- see
[supported compliance standards and platforms](/solutions/compliance/#supported-compliance-standards-and-platforms)
to check current coverage before writing your own controls for a
requirement it may already cover.

**Check other cloud providers or container platforms.**
See [Build custom compliance checks with Chef InSpec](/solutions/compliance/extend/)
for the Azure, GCP, Kubernetes, and other resource packs, and how each is
added to a profile.

## Related

- [AWS resource pack documentation](/inspec/resource_packs/aws/)
- [Chef InSpec CLI reference](/inspec/latest/reference/cli/)
- [Waivers reference](/inspec/latest/configure/waivers/)
- [Audit SSH configuration across a Linux fleet](/solutions/compliance/ssh_baseline/)
- [Compliance solution overview](/solutions/compliance/)
