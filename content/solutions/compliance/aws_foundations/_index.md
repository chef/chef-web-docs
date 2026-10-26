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
- No attached IAM policy grants `*` actions on `*` resources.
- No security group allows unrestricted inbound access on port 22 or 3389.

By the end you'll be able to run that profile against an AWS account,
get a pass or fail result for each control,
save the results as a JSON file you can keep as evidence,
and record an approved exception so it doesn't show up as a failure.

[Extend the profile to more of the account](#extend-the-profile-to-more-of-the-account)
then adds two deeper S3 checks to the same profile,
using the same pattern you'd follow for any other AWS service.

{{< note >}}

**What was run, and where.**
The generator output, the vendoring output, and the `inspec check` and `inspec detect` output
in this guide were produced on Chef InSpec 5.24.7 from Chef Workstation.
Assessment results shown for a run against a live AWS account are illustrative and
are labeled where they appear.
Exit codes come from the [Chef InSpec CLI reference](/inspec/latest/reference/cli/),
and resource properties, matchers, and permissions come from the
[AWS resource pack reference](/inspec/resource_packs/aws/).

{{< /note >}}

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

### Permissions each resource requires

If you'd rather grant specific permissions than attach `ReadOnlyAccess`,
the AWS resource pack reference lists the actions each resource needs:

| Resource | Actions documented for it |
| --- | --- |
| [`aws_s3_buckets`](/inspec/resource_packs/aws/aws_s3_buckets/) | `S3:Client:ListBucketsOutput` |
| [`aws_s3_bucket`](/inspec/resource_packs/aws/aws_s3_bucket/) | `S3:Client:GetBucketAclOutput`, `S3:Client:GetBucketLocationOutput`, `S3:Client:GetBucketLoggingOutput`, `S3:Client:GetBucketPolicyOutput`, `S3:Client:GetBucketEncryptionOutput` |
| [`aws_iam_policies`](/inspec/resource_packs/aws/aws_iam_policies/) | `IAM:Client:ListPoliciesResponse` |
| [`aws_iam_policy`](/inspec/resource_packs/aws/aws_iam_policy/) | `IAM:Client:GetGroupPolicyResponse`, `IAM:Client:ListPoliciesResponse`, `IAM:Client:ListEntitiesForPolicyResponse` |
| [`aws_security_groups`](/inspec/resource_packs/aws/aws_security_groups/) | `EC2:Client:DescribeSecurityGroupsResult` |
| [`aws_security_group`](/inspec/resource_packs/aws/aws_security_group/) | `EC2:Client:DescribeSecurityGroupsResult` |

A missing permission surfaces as an AWS API error on the control that needed it,
not as a failing assertion.
Grant read access before you interpret any result as a finding.

## Get the AWS resource pack

Checking a host uses Chef InSpec's core resources.
Checking AWS objects --- an S3 bucket, an IAM policy, a security group ---
needs the [AWS resource pack](/inspec/resource_packs/aws/), a separately
distributed set of resources for AWS.

The AWS pack covers EC2, IAM, RDS, Lambda, VPC and networking, CloudFront,
CloudWatch, SSM, WAF, and API Gateway.
See the pack's own documentation for the full resource list with properties
and matchers for each one.

A resource pack isn't a benchmark and doesn't assess anything on its own.
It gives you the resources to write controls with;
the controls themselves are content you own and maintain.
For Chef's published AWS benchmark content, see
[supported compliance standards and platforms](/solutions/compliance/#supported-compliance-standards-and-platforms).

`inspec init profile --platform aws` declares the pack as a dependency; Step 2 fetches it.

## Step 1: Create a profile

Generate a profile pre-configured for AWS:

```shell
inspec init profile --platform aws aws-baseline
```

```text
─────────────────────────── InSpec Code Generator ───────────────────────────

Creating new profile at ./aws-baseline
 • Creating file README.md
 • Creating directory ./aws-baseline/controls
 • Creating file controls/example.rb
 • Creating file inputs.yml
 • Creating file inspec.yml
```

Two entries in the generated `aws-baseline/inspec.yml` are what make this an AWS profile:

```yaml
depends:
  - name: inspec-aws
    url: https://github.com/inspec/inspec-aws/archive/main.tar.gz
supports:
  - platform: aws
```

`depends` brings the `aws_*` resources into scope for your controls.
`supports` restricts the profile to AWS targets, so running it against a Linux host skips it
instead of reporting failures that mean nothing.
Both are described in the [profile dependencies reference](/inspec/latest/profiles/depends/)
and the [profile platforms reference](/inspec/latest/profiles/platforms/).

Describe what the profile is for in the same file, leaving `depends` and `supports` in place:

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

## Step 2: Vendor the dependency

Declaring the pack isn't the same as having it.
The pack is fetched over the network, so pull it down before you rely on the profile:

```shell
inspec vendor aws-baseline
```

```text
Dependencies for profile aws-baseline successfully vendored to ./aws-baseline/vendor
```

This writes a `vendor/` directory holding the pack and an `inspec.lock` file recording
exactly what was fetched:

```yaml
---
lockfile_version: 1
depends:
- name: inspec-aws
  resolved_source:
    url: https://github.com/inspec/inspec-aws/archive/main.tar.gz
    sha256: 320aa0f4231ff47bda2444a6e94d1dcd47f78b883791395dc0a4c25c475c09ec
  version_constraints: []
```

The dependency URL points at `main`, so its contents change over time.
The `sha256` pins the archive this profile resolved against;
commit `inspec.lock` with the profile and your runs stay reproducible until you
re-vendor on purpose with `inspec vendor --overwrite`.

Skip this step and the next command fails rather than downloading the pack implicitly:

```text
×  ./inspec.yml:0:0: Your profile needs to be vendored with `inspec vendor`.
```

## Step 3: Set credentials

Set AWS credentials as environment variables:

```shell
export AWS_REGION=us-east-1
export AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY_ID>
export AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_ACCESS_KEY>
```

Add `AWS_SESSION_TOKEN` if you authenticate with multi-factor authentication, or set
`AWS_PROFILE` to use a named profile from `~/.aws/credentials`.
The [AWS CLI environment variable reference](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)
documents each one.

{{< warning >}}

Keep credentials out of the profile.
Nothing in `inspec.yml`, `inputs.yml`, or `controls/` should contain an access key,
and none of those files should be committed with one.
Credentials belong in your environment or in `~/.aws/credentials`,
both of which stay outside the profile directory.

{{< /warning >}}

Confirm Chef InSpec can load the AWS transport:

```shell
inspec detect -t aws://
```

```text
────────────────────────────── Platform Details ──────────────────────────────

Name:      aws
Families:  cloud, api
Release:   train-aws: v0.2.36, aws-sdk-core: v3.246.0
```

The `Release` line reports the versions of the AWS transport and SDK in your installation,
so expect different numbers from a different Chef InSpec release.

{{< note >}}

On Chef InSpec 5.24.7, `inspec detect -t aws://` returned these platform details with no
credentials set at all.
Treat it as confirmation that the AWS transport loaded, not as proof that your credentials
work --- the first run of the profile is what exercises them.

{{< /note >}}

## Step 4: Write the controls

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

  aws_iam_policies.where(only_attached: true).policy_names.each do |policy_name|
    describe aws_iam_policy(policy_name) do
      it { should_not have_statement(Effect: 'Allow', Action: '*', Resource: '*') }
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

Two details decide how much these controls actually cover:

**`be_public` reads bucket-level configuration only.**
It reports a bucket as public if an ACL grants access to the `AllUsers` or
`AuthenticatedUsers` group, or if a bucket policy has effect `Allow` with principal `*`.
It doesn't inspect object ACLs, so a private bucket holding public objects still passes
`aws-01`.

**`have_statement` matches literal values and doesn't expand wildcards.**
`aws-02` finds policies granting full administrative access.
A policy with `"Action": "s3:*"` doesn't match a test for `Action: '*'`, so add a separate
assertion for each wildcard form you care about.
The [`aws_iam_policy` reference](/inspec/resource_packs/aws/aws_iam_policy/) describes the
matching rules in full.

## Step 5: Validate the profile

Before running the profile against a real account, check that it's well-formed:

```shell
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

`Controls : 3` confirms Chef InSpec parsed all three controls.
A Ruby syntax error, an undeclared input, or a dependency you haven't vendored surfaces
here rather than part way through a run against production.

## Step 6: Run the assessment

The target is the AWS account, not a machine, so there's nothing to connect to
over SSH:

```shell
inspec exec aws-baseline -t aws://
```

To assess a specific region using a named credentials profile, give both in the target:

```shell
inspec exec aws-baseline -t aws://us-east-2/auditing
```

Against a different account or role, change credentials and repeat the same
command --- the profile doesn't change for each account.

If no usable credentials are available, the run stops with an AWS error instead of
reporting failed controls.
This output was captured on Chef InSpec 5.24.7 with the AWS environment variables unset:

```text
Error retrieving instance profile credentials: Failed to open TCP connection to 169.254.169.254:80 ...
ERROR: It appears that you have not set your AWS credentials.
unable to sign request without credentials set
```

Resolve that before reading anything into a result.

## Step 7: Read the results

A run against an account with a public bucket and an open security group
looks like this.
This output is illustrative:

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

### Exit codes

`inspec exec` sets an exit code describing the outcome, which is what a pipeline acts on:

| Exit code | Meaning |
| --- | --- |
| `0` | Normal exit, all tests passed |
| `1` | Usage or general error |
| `100` | Normal exit, at least one test failed |
| `101` | Normal exit, at least one test skipped but none failed |
| `172` | Chef license not accepted |

A missing-credentials failure returns `1`, not `100` ---
the difference between a broken run and a real finding.
The complete list of codes is in the
[Chef InSpec CLI reference](/inspec/latest/reference/cli/).

### Keep the results

For evidence, write a structured file at the same time:

```shell
inspec exec aws-baseline -t aws:// --reporter cli json:results.json
```

The JSON includes each control's ID, its impact as a number, and the status
of every test, so you can feed it into a ticketing system or keep it as a
dated record.
Only one reporter can write to standard output at a time.
Other formats are in the [reporters reference](/inspec/latest/configure/reporters/).

## Step 8: Fix a finding and reassess

The bucket finding above is a configuration change in AWS, not in the
profile. Remove public access from the bucket with
[S3 Block Public Access](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html),
then run the same profile again:

```shell
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

{{< note >}}

Correct AWS findings with AWS tooling.
Nothing in the AWS resource pack changes a configuration --- it reads the AWS APIs and
reports what it finds --- and Chef's remediation cookbooks cover operating system and
platform benchmarks, not cloud provider APIs.
See [compliance remediation](/solutions/compliance/#compliance-remediation) for what
remediation content covers.

{{< /note >}}

## Step 9: Waive an exception you've accepted

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

```shell
inspec exec aws-baseline -t aws:// --waiver-file waivers.yml
```

The control reports as skipped and carries your justification into the
report, the same way a waiver works for any Chef InSpec profile.
See [the waivers reference](/inspec/latest/configure/waivers/) for the full
file format, and
[Step 7 of the SSH guide](/solutions/compliance/ssh_baseline/#step-7-waive-an-exception-youve-accepted)
for another worked example.

## Extend the profile to more of the account

The three controls above check one thing for each service.
Adding more follows the same shape: list objects with the plural resource,
assert against each one with the singular resource.

S3 is a useful example because bucket exposure isn't only about public access.
Add these controls to `controls/aws.rb`:

```ruby
control 'aws-04' do
  impact 'high'
  title 'S3 buckets must have default encryption enabled'
  desc 'Default server-side encryption means objects are encrypted at rest without relying on the caller to request it.'
  tag 'aws', 's3'

  aws_s3_buckets.bucket_names.each do |bucket_name|
    describe aws_s3_bucket(bucket_name) do
      it { should have_default_encryption_enabled }
    end
  end
end

control 'aws-05' do
  impact 'high'
  title 'S3 bucket policies must deny plaintext HTTP requests'
  desc 'Without an explicit deny on unencrypted transport, objects can be read over plain HTTP.'
  tag 'aws', 's3'

  aws_s3_buckets.bucket_names.each do |bucket_name|
    describe aws_s3_bucket(bucket_name) do
      it { should have_secure_transport_enabled }
    end
  end
end
```

`have_secure_transport_enabled` looks for a bucket policy that explicitly denies requests
where `aws:SecureTransport` is false, so a bucket with no policy at all fails `aws-05`.
That's the correct result, but it means `aws-05` reports on buckets nobody has configured
yet, not only on buckets configured wrongly.

Re-run `inspec check` after adding controls.
`Controls : 5` confirms both were parsed.

A bucket that fails `aws-04` needs
[default bucket encryption](https://docs.aws.amazon.com/AmazonS3/latest/userguide/default-bucket-encryption.html).
One that fails `aws-05` needs a policy statement denying requests where
`aws:SecureTransport` is false.

The same approach works for the rest of the account.
Every resource in the [AWS resource pack](/inspec/resource_packs/aws/) lists its
properties and matchers, and the ones you need depend on which requirements you're
assessing.

## Run it on a schedule with Chef Automate

Running the profile by hand answers the question for today.
Because accounts change constantly, the useful version of this assessment runs again
without anybody remembering to run it.

Chef Automate assesses an AWS account through an AWS API node manager, which is the
account-level equivalent of a node:

1. In Chef Automate, on the **Settings** tab, go to the **Node Integrations** page and add
   an AWS API node manager with credentials for the account you want to assess.
   The [node integrations documentation](/automate/node_integrations/) covers the setup and
   states that this scanning path needs at least the global `ReadOnlyAccess` permission.
1. Upload the profile from the [Chef Automate Profiles page](/automate/profiles/).
1. Create a [scan job](/automate/scan_jobs/) that runs the profile against the AWS API node
   manager, and set it to recur.
   Scan jobs accept `aws-api` regions as a target, which is the same account-level target as
   `-t aws://`.
1. Review results in [compliance reporting](/automate/reports/), filtered by profile and
   control.

A scheduled cloud scan queries the provider each time it runs, so accounts and resources
added since the last scan are picked up without editing the profile.

The two execution paths differ in where results land, not in what gets checked.
A direct `inspec exec` run prints to your terminal and writes whatever file your
`--reporter` names; a scan job stores results in Chef Automate, with history for each run.

The [Compliance Phase](/client/latest/features/chef_compliance_phase/) is the third
execution path, and it isn't the right one here ---
it runs profiles during a Chef Infra Client run on a node, and an AWS account has no node
to run on.
Use scan jobs for cloud accounts, and the Compliance Phase for the servers inside them.

## Where to go next

**Start from a published benchmark instead of your own controls.**
Chef publishes prebuilt audit content built on the CIS AWS Foundations
Benchmark --- see
[supported compliance standards and platforms](/solutions/compliance/#supported-compliance-standards-and-platforms)
to check current coverage before writing your own controls for a
requirement it may already cover.

**Assess the instances as well as the account.**
This profile checks the account's configuration.
The EC2 instances inside it are assessed as hosts ---
see [Audit SSH configuration across a Linux fleet](/solutions/compliance/ssh_baseline/)
and [Operating Systems](/solutions/compliance/operating_systems/) for the benchmarks Chef
publishes.

**Check other cloud providers or container platforms.**
See [Build custom compliance checks with Chef InSpec](/solutions/compliance/extend/)
for the Azure, GCP, Kubernetes, and other resource packs, and how each is
added to a profile.

## Related

- [AWS resource pack documentation](/inspec/resource_packs/aws/)
- [Profile dependencies](/inspec/latest/profiles/depends/)
- [Chef InSpec CLI reference](/inspec/latest/reference/cli/)
- [Waivers reference](/inspec/latest/configure/waivers/)
- [Chef Automate node integrations](/automate/node_integrations/)
- [Chef Automate scan jobs](/automate/scan_jobs/)
- [Audit SSH configuration across a Linux fleet](/solutions/compliance/ssh_baseline/)
- [Cloud benchmark coverage](/solutions/compliance/cloud/)
- [Compliance solution overview](/solutions/compliance/)
