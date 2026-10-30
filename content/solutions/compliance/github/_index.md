+++
title = "Audit a GitHub repository with Chef InSpec"
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/compliance/github"
  parent = "overview/solutions/compliance"
  title = "Guide: Audit a GitHub repository"
  weight = 7
+++

Repository governance changes as teams add collaborators, edit workflows, and update merge requirements.
Checking those settings by hand gives you a point-in-time answer, but it doesn't give you a repeatable assessment or comparable evidence.

Chef InSpec compares repository configuration with executable policy and reports the result of each check.
The [GitHub resource pack](https://github.com/inspec/inspec-github-resources) extends Chef InSpec with resources for GitHub repositories, files, collaborators, and rulesets.
You write controls that express your organization's requirements, supply repository-specific values as inputs, and retain the results for review.

This guide starts with three repository-file requirements.
It then explains how to retain evidence, manage approved exceptions, and repeat assessments to detect drift.
These are organization-specific checks, not a published compliance benchmark or a complete GitHub governance assessment.
For the organization-wide workflow, including access, ownership, and merge requirements, see [GitHub compliance with Chef InSpec](/solutions/compliance/github_governance/).

## What you'll build

A Chef InSpec profile that checks whether one GitHub repository contains:

- A repository-local security policy at `SECURITY.md`.
- Contribution instructions at `CONTRIBUTING.md`.
- A code owners file at `.github/CODEOWNERS`.

The profile checks the branch you specify.
It doesn't validate file contents, owner identities, access permissions, or merge enforcement.
Those requirements need additional controls.

Chef InSpec assesses configuration; it doesn't replace GitHub enforcement, scan application code for vulnerabilities, or automatically correct repository settings.
Scheduled assessments also don't provide a complete history of changes between runs.

## Before you begin

You need:

- [Chef InSpec](/inspec/latest/install/) and any required license configuration.
  The resource-pack README specifies Chef InSpec 6 or later; confirm compatibility with the resource-pack revision you approve.
- [GitHub CLI](https://cli.github.com/) and Git on the machine that runs Chef InSpec.
  The resource pack uses GitHub CLI to read GitHub configuration.
- One test repository and the branch you want to assess.
- An approved read-only credential that can read the repository's metadata and contents.
  For private repositories, grant access to the specific repositories in scope.
  Follow [GitHub's authentication guidance](https://docs.github.com/en/rest/authentication/authenticating-to-the-rest-api) for your credential type.
- An approved revision of the GitHub resource pack.
  Review its documentation and your support requirements before using it in production.

To confirm that the tools are available, run:

```shell
inspec version
gh --version
git --version
```

Configure the execution environment to supply the credential in `GITHUB_TOKEN`, as the resource-pack README describes.
Use your approved secret store rather than putting the token in a profile, input file, shell script, or command-line argument.
Don't print the token in logs.
Make sure GitHub CLI doesn't select a different credential, such as a `GH_TOKEN` value that takes precedence.

To verify access to the selected repository, run:

```shell
gh auth status
gh api 'repos/<organization>/<repository>' \
  --jq '{full_name, default_branch, visibility, archived}'
```

Replace `<organization>` and `<repository>` with the repository owner and name.
Record the default branch and confirm that the returned repository is the one you intend to assess.
Successful metadata access doesn't establish access to every file or administration setting.
Test the endpoints your controls need.

{{< warning >}}

Missing permissions, API failures, and rate limits can produce incomplete observations.
An inaccessible resource isn't evidence that a repository meets policy.
The file checks in this guide don't distinguish every collection error from a missing file, so investigate access and API errors before classifying a finding.

{{< /warning >}}

## Define the assessment scope

Start with one repository whose expected results you know.
Record the following information before extending the assessment to an organization:

| Inventory field | Why you need it |
| --- | --- |
| GitHub host, owner, repository name, and stable repository ID | Identify the assessed repository across runs and renames |
| Branch and observation time | State what you assessed and when |
| Visibility, archived status, and fork status | Apply explicit inclusion and exclusion rules |
| Business owner, technical owner, and policy tier | Connect requirements and findings to an accountable team |
| Inclusion status and exclusion reason | Make coverage gaps visible |

Define how to handle archived repositories, forks, templates, sandboxes, and repositories without an assigned owner.
Report unclassified or inaccessible repositories instead of silently removing them from the inventory.

The example requires files at the listed repository-local paths.
GitHub recognizes other locations and, for some community health files, organization defaults.
If your policy accepts those alternatives, extend the controls to assess them before treating a missing local file as a policy violation.
See [GitHub's community health file guidance](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file) and [CODEOWNERS documentation](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners).

## Create the profile

To create a profile with a local resource-pack dependency, follow these steps:

1. In a working directory, clone the resource pack and select an approved commit:

   ```shell
   git clone https://github.com/inspec/inspec-github-resources.git
   git -C inspec-github-resources checkout --detach <approved-resource-pack-commit>
   ```

   Replace `<approved-resource-pack-commit>` with the full commit ID you reviewed and tested.
   Record that ID with your assessment evidence.
   Don't use a moving branch without review for scheduled production runs.

1. In the same working directory, generate the policy profile:

   ```shell
   inspec init profile github-compliance-profile
   ```

1. Replace `github-compliance-profile/inspec.yml` with:

   ```yaml
   name: github-compliance-profile
   title: GitHub repository file baseline
   maintainer: Example Organization
   copyright: Example Organization
   copyright_email: compliance@example.com
   license: Apache-2.0
   summary: Check repository-local governance files
   version: 0.1.0
   inspec_version: '>= 6.0'
   depends:
     - name: inspec-github-resources
       path: ../inspec-github-resources
   inputs:
     - name: repository
       description: Repository owner and name
       type: String
       required: true
     - name: branch
       description: Branch to assess
       type: String
       required: true
   ```

   The dependency path assumes that the profile and resource-pack directories share a parent directory.
   This follows the resource pack's documented local-checkout installation method.
   A resource pack supplies resources, not benchmark controls.
   For dependency options, see [profile dependencies](/inspec/latest/profiles/depends/).

1. Remove the generated example control:

   ```shell
   rm github-compliance-profile/controls/example.rb
   ```

1. Create `github-compliance-profile/controls/required_files.rb`:

   ```ruby
   repository = input('repository')
   branch = input('branch')

   {
     'github-required-security' => 'SECURITY.md',
     'github-required-contributing' => 'CONTRIBUTING.md',
     'github-required-codeowners' => '.github/CODEOWNERS',
   }.each do |control_id, path|
     control control_id do
       impact 0.7
       title "Require #{path} in the assessed repository"
       desc 'Organization policy requires repository-local governance files.'

       describe github_file(repository, path, branch) do
         it { should exist }
         it { should be_file }
         its('size') { should be > 0 }
       end
     end
   end
   ```

   The [`github_file` resource](https://github.com/inspec/inspec-github-resources/blob/main/docs/resources/github_file.md) reads the specified file and branch through GitHub.
   Each control requires an existing, nonempty file rather than a directory at that path.
   Keep control IDs stable so you can compare results and apply waivers.
   Choose impact values and policy descriptions that match your organization's requirements.

1. Create `github-compliance-profile/inputs.yml`:

   ```yaml
   repository: <organization>/<repository>
   branch: <branch-name>
   ```

   Replace the placeholders with the repository owner, repository name, and branch you verified.
   Keep credentials out of this file.
   Use separate input files for repositories or policy tiers when their requirements differ.
   See [Chef InSpec inputs](/inspec/latest/profiles/inputs/).

## Validate and run the assessment

To check the profile and collect results, follow these steps:

1. Validate the profile structure and control syntax:

   ```shell
   inspec check github-compliance-profile
   ```

   Profile validation doesn't establish GitHub access or prove that the controls produce correct results.

1. Create an evidence directory and run the profile:

   ```shell
   mkdir -p results
   inspec exec github-compliance-profile \
     --input-file github-compliance-profile/inputs.yml \
     --reporter cli json:results/github-compliance.json
   ```

   Chef InSpec runs locally and the resource pack calls GitHub through GitHub CLI.
   You don't need an SSH target or software installed in the assessed repository.
   The CLI reporter displays results, and the JSON reporter writes the same assessment to a file.
   Use a unique evidence path for each repository and run so later assessments don't overwrite earlier evidence.

1. Review the control results and investigate collection errors:

   | Outcome | Interpretation |
   | --- | --- |
   | Passed | The collected values satisfy the file checks |
   | Failed | A check doesn't meet the expected value; verify collection before deciding whether policy is violated |
   | Skipped | The check wasn't evaluated; a skip isn't evidence of compliance |
   | Waived | An approved exception changes execution or failure handling; it doesn't prove the requirement is met |
   | Incomplete collection | You can't reliably determine repository state; investigate access, rate limits, and API errors |

   Incomplete collection is an operational classification, not an additional native Chef InSpec test status.
   Don't report the repository as compliant just because some controls pass.
   These three controls don't establish whether GitHub enforces ownership or review requirements.

Before scheduling assessments, test a repository with the required files, a repository with known violations, and a repository that the credential can't fully read.
Confirm that the inaccessible case doesn't become a reported compliance success.
Use test repositories rather than weakening a production repository to create failures.

For result formats and CLI options, see [reporters](/inspec/latest/configure/reporters/) and the [Chef InSpec CLI reference](/inspec/latest/reference/cli/).

## Record an approved exception

Use a waiver for a reviewed, time-bound exception rather than changing a control to make one repository pass.
To apply an exception to the code owners requirement, follow these steps:

1. Create `github-compliance-profile/waivers.yml`:

   ```yaml
   github-required-codeowners:
     run: false
     justification: >-
       Exception GRC-1842 for example-org/example-repo, approved by
       the repository governance owner while ownership is transferred.
     expiration_date: 2027-06-30
   ```

   Replace the repository, approval reference, approver, and expiration date with the approved exception.
   Record the effective date and review owner in your exception record.
   Choose a future expiration date.

1. Run the same repository assessment with the waiver:

   ```shell
   inspec exec github-compliance-profile \
     --input-file github-compliance-profile/inputs.yml \
     --waiver-file github-compliance-profile/waivers.yml \
     --reporter cli json:results/github-compliance-waived.json
   ```

   `run: false` skips the waived control.
   With `run: true`, Chef InSpec executes the control and reports its results, but a waived failure doesn't make the run fail.
   An expired waiver no longer applies; the actual check determines the result.

{{< warning >}}

Chef InSpec applies this waiver by control ID, not by the repository named in its justification.
Keep this example to one repository for each run, and select the input and waiver files together.
Reusing the waiver for another repository also waives its control.

{{< /warning >}}

For supported fields and formats, see [waivers](/inspec/latest/configure/waivers/).
Report waived controls separately from controls that meet policy.

## Retain evidence and detect drift

JSON results provide control-level evidence, but an audit record also needs scope and execution context.
Store the following information with each assessment:

- Repository identity, branch, observation time, and collection status.
- Chef InSpec version, profile version and revision, and resource-pack commit.
- Effective inputs, exclusions, and approved waivers.
- Control results, observed values, and reasons for failures or incomplete collection.
- Execution identity and an evidence retention reference, without credentials or other secrets.

Protect results with your organization's access, retention, and integrity controls.
Keep failed and incomplete runs, not just successful assessments.

To confirm a correction, rerun the same policy against the same repository and preserve both results.
For recurring assessments, configure your approved scheduler to prepare the tested tools, inject credentials, validate the profile, run the assessment, and retain evidence even when checks fail.
If you use GitHub Actions, pin approved actions and dependencies, restrict workflow changes, and use an execution environment with Chef InSpec and GitHub CLI installed.
This guide doesn't define a supported GitHub-specific Chef Automate or Chef 360 Platform integration.

Compare runs only after accounting for policy and scope changes:

| Change | Interpretation |
| --- | --- |
| Passed to failed under the same policy | A new finding or configuration drift |
| Failed to passed under the same policy | A correction |
| Failed in consecutive comparable runs | A persistent finding |
| Changed profile, inputs, or branch | A scope or policy change that needs separate interpretation |
| Granted or expired waiver | An exception change |
| Missing or incomplete observation | Unknown state, not compliance |

An assessment observes a point in time.
The interval between successful assessments remains unobserved.

## Extend the policy across repositories

The resource pack also documents resources for repository collaborators, code owners, workflows, and rulesets.
Use their documented properties to add checks for approved owners, permitted roles, pull request approvals, required status checks, and restrictions on force pushes or branch deletion.
Confirm additional API permissions and GitHub feature availability for every control.

For merge controls, inspect the applicable ruleset and its enforcement behavior rather than inferring protection from a file's presence.
See [GitHub rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets).
A `CODEOWNERS` file alone doesn't require code-owner approval, and a workflow file alone doesn't establish a required status check.

Before expanding to an organization-wide inventory:

- Assign every repository a policy tier and an owner.
- Keep policy values in inputs and stable requirements in controls.
- Select repository-specific waivers explicitly.
- Verify pagination and inventory completeness.
- Measure API usage, duration, retries, and rate-limit consumption.
- Review the resource pack's rate-limit configuration and test representative scan sizes.
- Report expected, attempted, completed, partially assessed, inaccessible, and excluded repositories.

Review profile, dependency, input, and waiver changes through the same controlled process as your assessment workflow.
Don't present an assessment percentage without its denominator, exclusions, exceptions, and incomplete results.

## Related documentation

- [GitHub resource pack and resource reference](https://github.com/inspec/inspec-github-resources)
- [Chef InSpec profiles](/inspec/latest/profiles/)
- [Chef InSpec controls](/inspec/latest/profiles/controls/)
- [Build custom compliance checks with Chef InSpec](/solutions/compliance/extend/)
- [Chef Compliance overview](/solutions/compliance/)
