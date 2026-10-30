+++
title = "GitHub compliance with Chef InSpec"
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/compliance/github_governance"
  parent = "overview/solutions/compliance"
  title = "Guide: GitHub compliance"
  weight = 8
+++

Assess repository governance, retain control-level evidence, manage approved exceptions, and detect drift across a GitHub organization.

This guide is for Chef InSpec practitioners, platform engineers, and governance teams implementing repository compliance.
It covers the full assessment lifecycle: define scope, prepare access, implement policy, validate results, and operate recurring assessments.
For a shorter introduction focused on repository files, see [Audit a GitHub repository with Chef InSpec](/solutions/compliance/github/).

## Overview

Chef InSpec provides an independent assessment layer for GitHub repository governance.
It compares observed configuration with executable policy and produces control-level evidence for review, reporting, and follow-up.

You need a compatible Chef InSpec installation, an approved GitHub resource pack and policy profile, a least-privilege credential, and an authoritative repository inventory.
The outputs are repository-linked results, collection status, versioned policy context, approved exceptions, and comparable observations for drift analysis.

### What GitHub compliance means

Chef InSpec assesses the current state of GitHub organizations and repositories against your governance policy.
The [GitHub resource pack](https://github.com/inspec/inspec-github-resources) extends the resource model to inspect files, collaborators, ownership configuration, rulesets, and other settings visible to the authenticated account.

The implementation consists of:

- Chef InSpec as the compliance engine.
- The GitHub resource pack, which supplies GitHub-specific resources.
- Profiles containing repository-governance controls.
- Inputs for organization, product, repository, or risk-specific requirements.
- Waivers for approved, time-bound exceptions.
- Reporters for human-readable output and machine-readable evidence.
- A scheduled execution mechanism, such as GitHub Actions or an approved enterprise scheduler.

A resource pack supplies the ability to inspect a technology; it isn't a benchmark profile.
The examples in this guide implement organization-specific policy and don't establish coverage of a published benchmark.

## What you can assess

Map every control to an approved organizational policy.
Assess properties that support a defined requirement, and confirm the resources and API permissions available in your selected resource-pack version.
The following sections describe the assessment scope; the example controls later in this guide cover a starting subset.

### Required repository files

Assess the presence and, where policy requires it, the contents of:

- `SECURITY.md`.
- `CONTRIBUTING.md`.
- `CODEOWNERS`.
- Copyright or license notices.
- Support and escalation information.
- Approved GitHub Actions workflow files.

Define accepted paths and whether organization-level defaults satisfy the requirement.
GitHub recognizes multiple [CODEOWNERS locations](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners) and [default community health files](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file).
A missing repository-local file isn't automatically a policy violation if your policy accepts an inherited alternative.

### Ownership and access

Assess whether:

- `CODEOWNERS` exists in an accepted location.
- Required paths have assigned owners.
- Owners are approved GitHub users or teams.
- Collaborators have permitted roles.
- Administrative access is restricted.
- Approval requirements match the repository's risk tier.

File presence alone doesn't establish valid ownership or required code-owner approval.
Check owner validity, path coverage, team access, and merge enforcement as separate requirements.

### Merge and delivery controls

Assess whether:

- The default branch is covered by the required ruleset.
- Pull requests require the expected number of approvals.
- Code-owner review is required where applicable.
- Required status checks are configured.
- Force pushes and branch deletion are restricted where policy requires.
- Required CI, quality, and security workflows are present.
- Relevant GitHub security features are enabled.

Inspect ruleset conditions, exclusions, enforcement, and bypass actors, including applicable organization rulesets.
A ruleset name or workflow file alone doesn't prove that a branch has the intended protection.
Account for GitHub plan availability, legacy branch protection, custom roles, and the permissions needed to observe security features.

## Plan the assessment

Create an authoritative repository inventory before writing controls.

| Inventory field | Why it matters |
| --- | --- |
| GitHub host, organization, and repository | Creates an unambiguous scope |
| Repository URL and stable repository ID | Supports comparison across assessments and renames |
| Default branch, visibility, and archived status | Defines the assessed state |
| Product or service, business owner, and technical owner | Connects evidence to accountability |
| Risk or policy tier | Determines the effective control set |
| Assessment inclusion status and exclusion reason | Makes exclusions and coverage visible |

Define explicit handling for archived repositories, forks, templates, sandboxes, temporary repositories, unowned repositories, and new repositories without product metadata.
Report unclassified repositories rather than silently excluding them.
Keep an inventory revision with each assessment.

Choose a representative test set before expanding to the organization.
Include a repository that meets policy, one with known violations, and one that the credential can't fully read.

## Prepare access and tooling

The following sections prepare credentials, install the assessment tools, and select the resource pack and policy.

### Create a least-privilege credential

Use an approved GitHub App or another credential with read-only access to the organizations and repositories in scope.
Grant only the permissions required by the selected resources and controls.
Depending on the checks, these can include repository metadata, contents, members or collaborators, administration configuration, Actions metadata, and code-security configuration.
Read access to repository contents doesn't establish access to administration or organization endpoints.

- Store credentials in the execution environment's approved secret-management facility.
- Don't put a token in `inspec.yml`, input files, or the profile repository.
- Don't print tokens in debug or workflow output.
- Don't use a developer's personal token for scheduled production assessments.
- Test access to a known private repository and the relevant organization endpoints.
- For GitHub App installation tokens, generate a fresh token for each job and account for expiration during long assessments.

The resource pack uses GitHub CLI and documents authentication with `GITHUB_TOKEN`.
Inject the credential into that environment variable when running the assessment.
Ensure that a different `GH_TOKEN` value doesn't override it.

To confirm the authenticated identity and target, run:

```shell
gh auth status
gh api 'repos/<organization>/<repository>' \
  --jq '{id, full_name, default_branch, visibility, archived}'
gh api --paginate 'repos/<organization>/<repository>/rulesets'
```

Replace `<organization>` and `<repository>` with an inventory entry.
Check the additional endpoints needed by ownership, access, and security controls.
The examples use GitHub.com; configure the host and verify resource-pack compatibility separately for GitHub Enterprise Server.

{{< warning >}}

Permission failure isn't compliance.
Missing permissions, pagination gaps, API errors, and rate limiting can produce incomplete data.
Distinguish a genuinely empty compliant set from a collection failure.
An HTTP 404 can also hide a private resource that the credential can't read.

{{< /warning >}}

### Install and verify Chef InSpec

Download a package for your operating system from [Chef downloads](https://downloads.chef.io/inspec).
Follow [Chef InSpec installation and licensing guidance](/inspec/latest/install/) for your environment.
The resource-pack README specifies Chef InSpec 6 or later; select a compatible, supported version rather than assuming an older Chef Workstation installation is sufficient.

For example, to install a downloaded Debian or Ubuntu package, run:

```shell
sudo dpkg -i ./<downloaded-inspec-package>.deb
```

On macOS, install the downloaded package with:

```shell
sudo installer -pkg ./<downloaded-inspec-package>.pkg -target /
```

Replace the placeholder with the package you downloaded and verify its integrity using your approved distribution process.
Install [GitHub CLI](https://cli.github.com/manual/installation) and Git in the same execution environment.

To confirm the installed tools, run:

```shell
inspec version
gh --version
git --version
```

Configure required license access before unattended execution.
Don't rely on an interactive license prompt in a scheduled job.

### Obtain the resource pack and policy profile

The GitHub resources are a profile-based resource pack, not a gem installation.
To use the documented local-checkout dependency method, run:

```shell
git clone https://github.com/inspec/inspec-github-resources.git
git -C inspec-github-resources checkout --detach <approved-resource-pack-commit>
inspec init profile github-compliance-profile
```

Replace `<approved-resource-pack-commit>` with a reviewed full commit ID.
Keep the resource pack and profile in sibling directories for the dependency path used below.
Promote dependency updates through profile tests, a representative test organization, result comparison, and production approval.
Record compatibility and support arrangements for your selected versions.

Choose one policy path:

- **Predefined benchmark profile:** Obtain an approved, maintained profile through its documented distribution and entitlement process.
  Record the profile and benchmark versions, automated coverage, manual checks, and required permissions.
  This guide doesn't identify a publicly distributed GitHub benchmark profile.
- **Organization-specific profile:** Convert your repository policies into controls using the resource pack.
  Preserve control IDs and map control metadata to the originating policy requirement.

## Implement the policy

Keep the policy implementation separate from repository-specific values.
The following sections provide a profile layout, inputs, and resource examples.

### Organize the profile

Use this layout for the policy repository:

```text
github-compliance-profile/
  inspec.yml
  controls/
    required_files.rb
    ownership.rb
    access.rb
    rulesets.rb
    workflows.rb
  libraries/
  inputs/
    baseline.yml
    production.yml
  waivers/
    example-repo.yml
```

Create the directories you use and remove the generated `controls/example.rb`.
Use stable control IDs, and map each control to its policy reference with descriptions or tags.
The suggested filenames organize your controls; they aren't a prepackaged benchmark.
See [profiles](/inspec/latest/profiles/) and [controls](/inspec/latest/profiles/controls/).

In `inspec.yml`, define the profile and local dependency:

```yaml
name: github-compliance-profile
title: GitHub repository governance
maintainer: Example Organization
copyright: Example Organization
copyright_email: compliance@example.com
license: Apache-2.0
summary: Assess organization-specific GitHub repository policy
version: 0.1.0
inspec_version: '>= 6.0'
depends:
  - name: inspec-github-resources
    path: ../inspec-github-resources
inputs:
  - name: repository
    type: String
    required: true
  - name: branch
    type: String
    required: true
  - name: required_files
    type: Array
    required: true
  - name: approved_owner_teams
    type: Array
    required: true
  - name: approved_admins
    type: Array
    required: true
  - name: ruleset_id
    type: Numeric
    required: true
  - name: minimum_approvals
    type: Numeric
    required: true
  - name: required_status_checks
    type: Array
    required: true
```

### Separate policy values from controls

Use inputs for the organization and repository, required files, approvals, approved owners, and status checks.
Maintain separate input sets or dependent profile layers for baseline, internal, production, and regulated repositories.

Create `inputs/production.yml`:

```yaml
repository: <organization>/<repository>
branch: <default-branch>
required_files:
  - SECURITY.md
  - CONTRIBUTING.md
  - .github/CODEOWNERS
  - LICENSE
  - SUPPORT.md
  - .github/workflows/ci.yml
approved_owner_teams:
  - '@<organization>/platform-engineering'
  - '@<organization>/application-security'
approved_admins:
  - <approved-admin-login>
ruleset_id: 12345
minimum_approvals: 2
required_status_checks:
  - build
  - unit-tests
  - security-scan
```

Replace every placeholder and the example ruleset ID with inventory and policy values.
Select the ID from the rulesets returned for the target repository and confirm its source and applicability.
The branch input must identify that repository's current default branch for the default-branch example below.
Treat the filenames, approved teams, administrators, and check names as policy choices, not universal requirements.

Keep credentials out of inputs.
For input precedence and dependent policies, see [inputs](/inspec/latest/profiles/inputs/) and [profile dependencies](/inspec/latest/profiles/depends/).

### Check required files and workflows

In `controls/required_files.rb`, use the documented `github_file` resource:

```ruby
control 'github-required-files' do
  impact 0.7
  title 'Require repository governance files and workflow definitions'
  desc 'Required files must exist on the assessed branch and contain data.'
  tag policy: 'repository-governance'

  files = input('required_files')

  describe files do
    it { should_not be_empty }
  end

  files.each do |path|
    describe github_file(input('repository'), path, input('branch')) do
      it { should exist }
      it { should be_file }
      its('size') { should be > 0 }
    end
  end
end
```

This control checks repository-local files, including the configured workflow path.
Add content checks for approved license notices, support information, or workflow configuration where your policy requires them.
A workflow file's presence doesn't prove that it runs, succeeds, or acts as a required merge check.
Use [`github_action_workflow`](https://github.com/inspec/inspec-github-resources/blob/main/docs/resources/github_action_workflow.md) for additional workflow observations and assess merge enforcement separately.

### Check ownership

In `controls/ownership.rb`, check CODEOWNERS validity and the approved team list:

```ruby
control 'github-required-codeowners' do
  impact 0.7
  title 'Require valid code ownership by approved teams'
  desc 'Code-owner teams must come from the approved organization list.'
  tag policy: 'repository-ownership'

  organization, repository = input('repository').split('/', 2)
  owners = github_codeowners(
    org: organization,
    repo: repository,
    branch: input('branch')
  )

  describe owners do
    it { should exist }
    it { should be_valid }
    its('teams') { should_not be_empty }
    its('cross_org_teams') { should be_empty }
  end

  describe (owners.teams - input('approved_owner_teams')) do
    it { should be_empty }
  end
end
```

This example requires at least one approved owner team and rejects teams outside the approved list.
It doesn't prohibit individual owners or prove that every required path has an owner.
Add those requirements separately using the documented CODEOWNERS entries and GitHub's pattern precedence.
Test overlapping patterns, unowned paths, invalid owners, and teams without sufficient repository access.

### Check administrative access

In `controls/access.rb`, compare administrator logins with your approved list:

```ruby
control 'github-approved-administrators' do
  impact 0.9
  title 'Restrict repository administrators to approved accounts'
  desc 'Administrator access must have a documented business owner.'
  tag policy: 'repository-access'

  administrators = github_repo_collaborators(input('repository'))
    .where(role_name: 'admin')

  describe (administrators.logins - input('approved_admins')) do
    it { should be_empty }
  end
end
```

An empty result passes this set comparison, so establish successful and complete collaborator collection before interpreting it.
Test insufficient-permission cases explicitly.
Extend the policy for other roles, organization owners, team-based access, outside collaborators, bots, and custom roles.
Don't infer all effective privileges from this administrator filter alone.

### Check merge requirements

In `controls/rulesets.rb`, inspect a selected ruleset and its rule parameters:

```ruby
control 'github-assessed-default-branch' do
  impact 0.9
  title 'Assess the current repository default branch'
  desc 'The inventory branch must match the default branch reported by GitHub.'
  tag policy: 'repository-delivery'

  describe github_repo(input('repository')) do
    it { should exist }
    its('default_branch') { should eq input('branch') }
  end
end

control 'github-default-branch-ruleset' do
  impact 0.9
  title 'Require active default-branch merge protections'
  desc 'The selected ruleset must enforce the configured review and check policy.'
  tag policy: 'repository-delivery'

  ruleset = github_ruleset(input('repository'), input('ruleset_id').to_i)

  describe ruleset do
    it { should exist }
    its('enforcement') { should eq 'active' }
    its('target') { should eq 'branch' }
    its('excluded_branch_patterns') { should be_empty }
    it { should have_deletion_protection }
    it { should have_force_push_protection }

    it 'includes the assessed default branch' do
      accepted = ['~DEFAULT_BRANCH', "refs/heads/#{input('branch')}"]
      expect(subject.branch_patterns & accepted).not_to be_empty
    end
  end

  review_rules = ruleset.rules.select { |rule| rule['type'] == 'pull_request' }

  describe review_rules.length do
    it { should eq 1 }
  end

  review = (review_rules.first || {}).fetch('parameters', {})

  describe review do
    its(['required_approving_review_count']) do
      should cmp >= input('minimum_approvals')
    end
    its(['require_code_owner_review']) { should eq true }
  end

  check_rules = ruleset.rules.select do |rule|
    rule['type'] == 'required_status_checks'
  end
  checks = check_rules.flat_map do |rule|
    rule.fetch('parameters', {}).fetch('required_status_checks', [])
  end
  contexts = checks.map { |check| check['context'] }

  describe input('required_status_checks') do
    it { should_not be_empty }
  end

  describe (input('required_status_checks') - contexts) do
    it { should be_empty }
  end
end
```

The example deliberately requires one selected ruleset to contain the policy and accepts only an explicit default-branch selector or its full branch reference.
It can reject valid wildcard-based or layered protection.
Adapt the logic if your policy combines multiple repository or organization rulesets.
Assess bypass actors and status-check application identities separately; matching check names alone doesn't prove that checks come from an approved application.

These controls provide starting points for the documented resource syntax, not the complete assessment scope described above.
Map remaining requirements to controls or explicit manual checks and record coverage gaps.
Use the [resource reference](https://github.com/inspec/inspec-github-resources/tree/main/docs/resources) for the exact properties available in your pinned revision.

## Validate results

The following sections cover local execution, exception handling, result interpretation, and evidence.

### Run a local assessment

To assess one repository before scheduling organization-wide runs, follow these steps:

1. Validate the profile:

   ```shell
   inspec check ./github-compliance-profile
   ```

   This checks profile structure and control syntax without assessing GitHub.
   It doesn't verify credentials, API completeness, or policy correctness.

1. Run the profile from the parent directory:

   ```shell
   mkdir -p results
   inspec exec ./github-compliance-profile \
     --input-file ./github-compliance-profile/inputs/production.yml \
     --reporter cli json:results/github-compliance.json
   ```

   Supply the credential through the execution environment.
   Chef InSpec runs locally and the resources call GitHub; this isn't an SSH scan of a repository.

1. Run the same policy against the representative test cases:

   | Test case | Expected evidence |
   | --- | --- |
   | Known-compliant repository | Checks pass under the intended policy |
   | Known policy violations | Relevant controls fail with the expected observed values |
   | Inaccessible or partially readable repository | Collection is marked incomplete, not compliant |
   | Expired exception | The waiver stops applying and the control's actual result takes effect |
   | Additional inventory or API page | The assessment includes all expected entries |

   Use isolated test repositories rather than weakening production protection.
   Resolve discrepancies before expanding scope.

### Configure time-bound waivers

Keep the control unchanged when an exception has formal approval.
Create `github-compliance-profile/waivers/example-repo.yml`:

```yaml
github-required-codeowners:
  run: false
  justification: >-
    Exception GRC-1842 for example-org/example-repo, approved by
    the governance owner while repository ownership is transferred.
  expiration_date: 2027-06-30
```

Replace the example scope, approval, and date with your exception record.
Record the control, repository or policy scope, justification, approver, approval reference, effective date, expiration date, and review owner.
Some of these fields belong in your exception system rather than in the waiver schema.

To apply the repository's exception, run:

```shell
inspec exec ./github-compliance-profile \
  --input-file ./github-compliance-profile/inputs/production.yml \
  --waiver-file ./github-compliance-profile/waivers/example-repo.yml \
  --reporter cli json:results/github-compliance-waived.json
```

`run: false` skips the control.
With `run: true`, Chef InSpec collects results, but a waived failure doesn't make the run fail.
Choose a future expiration date; after expiration, the control's actual result determines the outcome.

{{< warning >}}

Waivers apply by control ID, not by the repository named in the justification.
Run one repository at a time and select its inputs and waiver file together.
Don't share an exception file across an inventory unless every waived control is approved for every repository in that run.

{{< /warning >}}

Report waived controls separately from passing controls.
See [Chef InSpec waivers](/inspec/latest/configure/waivers/) for supported formats and fields.

### Interpret the results

| Level or state | Meaning |
| --- | --- |
| Test | A specific question about an observed value, such as whether `SECURITY.md` exists |
| Control | A policy requirement containing one or more tests; a required failed test causes the control to fail |
| Profile | The versioned policy package; a required failed control means the repository doesn't fully meet that profile |
| Passed | Collected evidence satisfies the test |
| Failed | A test doesn't meet its expectation; confirm collection before classifying a policy violation |
| Skipped | The test wasn't evaluated or was explicitly skipped; a skip isn't evidence of compliance |
| Waived | A documented exception changes execution or failure handling; it doesn't prove the requirement is met |
| Unknown or incomplete | Permissions, API errors, rate limits, truncation, or another collection problem prevent a reliable conclusion |

Unknown or incomplete is an assessment classification, not an additional native Chef InSpec test status.
Some resources can return empty values after collection errors.
Correlate results with collection diagnostics, expected inventory, and endpoint checks rather than assuming every empty value is compliant.
Don't rely on a percentage unless its denominator, exclusions, skipped controls, waived controls, and incomplete collections are visible.

### Produce machine-readable evidence

Use the [reporter](/inspec/latest/configure/reporters/) required by the consuming system instead of creating a separate assessment implementation.
The commands above retain JSON and show CLI results.
Confirm other output formats against your installed version and evidence destination; don't assume that every reporter provides a dashboard or a formal audit document.

| Evidence field | Purpose | Requirement |
| --- | --- | --- |
| Repository identity and assessed scope | Attributes evidence to the repository and branch | Required |
| Observation timestamp and collection status | Records when state was observed and whether collection completed | Required |
| Chef InSpec, profile, control, and resource-pack versions or revisions | Makes assessments reproducible and comparable | Required |
| Effective inputs and waivers | Records the applied policy and exceptions | Required |
| Result, reason, and observed configuration | Supports remediation and audit review | Required |
| Collector identity and retention identifier | Supports traceability without exposing secrets | Required for governed evidence |

Raw reporter output is machine-readable evidence.
Formal audit use also requires verified identity, execution context, coverage, retention, and integrity controls.
Use distinct paths for every repository and assessment so later runs don't overwrite earlier findings.
Protect artifacts and logs because they can contain sensitive repository metadata.

## Operate recurring assessments

The following sections describe recurring execution, product integration boundaries, and comparable drift observations.

### Automate with GitHub Actions

Store the profile in a dedicated policy repository and schedule it only after the representative tests produce the expected results.
The following workflow runs one repository-specific input set and retains artifacts even when the assessment fails.
Expand it with an explicit inventory and repository-specific jobs after verifying coverage and API capacity.

Prepare these prerequisites:

- A dedicated, trusted self-hosted Linux runner labeled `github-compliance`, with Git, GitHub CLI, and compatible Chef InSpec installed.
  Configure noninteractive license access on that runner and restrict it to trusted policy workflows.
- A repository variable named `GITHUB_RESOURCE_PACK_COMMIT` containing the approved full resource-pack commit ID.
- A secret named `GIT_COMPLIANCE_TOKEN` containing an approved read-only credential for the assessed repository.
  For GitHub Apps, replace this injection with your approved installation-token generation step.
- The profile at `github-compliance-profile/`, with `inputs/production.yml` containing real repository values.
  The local dependency remains `../inspec-github-resources`.
- An artifact retention period approved for the evidence.
  The example uses 30 days and isn't a substitute for longer-term governed retention.

Create `.github/workflows/github-compliance.yml` in that policy repository:

```yaml
name: GitHub compliance assessment
on:
  workflow_dispatch:
  schedule:
    - cron: '15 2 * * *'

permissions:
  contents: read

concurrency:
  group: github-compliance-production
  cancel-in-progress: false

jobs:
  assess:
    runs-on: [self-hosted, linux, github-compliance]
    timeout-minutes: 60
    env:
      INSPEC_PROFILE: github-compliance-profile
    steps:
      - name: Check out the policy
        uses: actions/checkout@11d5960a326750d5838078e36cf38b85af677262
        with:
          persist-credentials: false

      - name: Check out the approved resource pack
        uses: actions/checkout@11d5960a326750d5838078e36cf38b85af677262
        with:
          repository: inspec/inspec-github-resources
          ref: ${{ vars.GITHUB_RESOURCE_PACK_COMMIT }}
          path: inspec-github-resources
          persist-credentials: false

      - name: Verify tools and dependency revision
        shell: bash
        env:
          APPROVED_COMMIT: ${{ vars.GITHUB_RESOURCE_PACK_COMMIT }}
        run: |
          set -euo pipefail
          [[ "$APPROVED_COMMIT" =~ ^[0-9a-f]{40}$ ]]
          test "$(git -C inspec-github-resources rev-parse HEAD)" = "$APPROVED_COMMIT"
          inspec version
          gh --version
          mkdir -p results
          git rev-parse HEAD > results/policy-commit.txt
          git -C inspec-github-resources rev-parse HEAD > results/resource-pack-commit.txt
          inspec version > results/inspec-version.txt

      - name: Validate the profile
        run: inspec check "$INSPEC_PROFILE"

      - name: Run the assessment
        shell: bash
        env:
          GH_TOKEN: ${{ secrets.GIT_COMPLIANCE_TOKEN }}
          GITHUB_TOKEN: ${{ secrets.GIT_COMPLIANCE_TOKEN }}
        run: |
          set -euo pipefail
          test -n "$GITHUB_TOKEN"
          gh auth status
          inspec exec "$INSPEC_PROFILE" \
            --input-file "$INSPEC_PROFILE/inputs/production.yml" \
            --reporter cli json:results/github-compliance.json

      - name: Retain assessment evidence
        if: ${{ always() }}
        uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b4886f43607fa02
        with:
          name: github-compliance-${{ github.run_id }}-${{ github.run_attempt }}
          path: results/
          if-no-files-found: warn
          retention-days: 30
```

The actions are pinned to specific revisions rather than moving version tags.
Review and update these pins through your normal dependency process.
The workflow's `contents: read` permission applies to its built-in token; the assessment secret has its own separately granted access.
Keep secret access limited to the assessment step.
Never run untrusted pull request code on this credential-bearing runner.

Control failures keep the job failed; the artifact step still runs.
If execution stops before a JSON report exists, retain the workflow diagnostics and classify the assessment as incomplete rather than treating a missing report as a pass.
The example doesn't apply waivers automatically.
Add the correct `--waiver-file` only for an approved repository-specific exception.
Retain the effective inputs, waiver reference, inventory revision, collection diagnostics, and evidence metadata with each production run.

### Chef 360 Platform and Courier

Use [Chef 360 Platform documentation](/360/) for execution and recurring-job capabilities available in your deployed release.
Before selecting Courier as the execution mechanism, establish the runner environment, credential injection, scheduling behavior, exit-code handling, and evidence destination for your profile.
The GitHub CLI workflow above doesn't establish a native GitHub scanning or reporting integration with Chef 360 Platform.
Don't present Chef Automate as the GitHub scanning or visualization path without a documented integration.

### Detect drift

An assessment records repository state at one observation time.
Repeat comparable assessments to identify drift, preserving repository identity, policy versions, effective inputs, waiver status, and collection status.
Distinguish repository changes from policy changes.

| Classification | Interpretation |
| --- | --- |
| New failure | Previously passed and now fails under a comparable policy |
| Corrected | Previously failed and now passes |
| Persistent failure | Fails in consecutive comparable assessments |
| New repository | No earlier comparable observation exists |
| Policy changed | Profile or input changes explain the changed result |
| Exception granted or expired | Waiver status changed |
| Unknown | The current or previous result is incomplete |

Scheduled assessment isn't real-time monitoring.
The interval between successful assessments defines the unobserved period.
Preserve the original failure, rerun after remediation, and retain the failed-to-passed transition.

## Common practitioner patterns

The following sections apply the workflow to common governance tasks.

### Assess against a defined standard

To assess a recognized standard, follow these steps:

1. Obtain the approved profile or benchmark.
1. Pin the profile, benchmark, and dependencies.
1. Configure organization and repository scope.
1. Test a representative set.
1. Record automated coverage, manual checks, inputs, waivers, and exclusions.
1. Schedule recurring execution and retain versioned evidence.

### Implement an organizational repository policy

To turn policy statements into repeatable assessments, follow these steps:

1. Convert each statement into an observable requirement.
1. Identify the relevant GitHub property or resource.
1. Write a stable control and link its metadata to the policy reference.
1. Put variable values in inputs.
1. Test pass, fail, and inaccessible cases.

### Apply requirements by product or risk tier

To apply different requirements without duplicating every control, follow these steps:

1. Create an organization-wide baseline.
1. Assign product and policy-tier metadata to the inventory.
1. Apply tier-specific inputs or dependent profiles.
1. Use repository-specific values only where necessary.
1. Record the effective policy with each result.

### Manage approved exceptions

To keep exceptions visible and time-bound, follow these steps:

1. Keep the control unchanged.
1. Select the repository-specific waiver and set its expiration.
1. Record justification, approver, review owner, and ticket.
1. Report the outcome as waived, not passed.
1. Review and expire the exception on schedule.

### Verify that a correction remains in place

To demonstrate correction and detect later regression, follow these steps:

1. Preserve the original failed result.
1. Rerun the same policy after correction.
1. Record the failed-to-passed transition.
1. Continue scheduled assessments.
1. Report a later transition back to failed as drift.

## Operational safeguards

The following sections describe coverage reporting, API capacity, and protection of the assessment pipeline.

### Measure assessment coverage

For every run, report total repositories expected, attempted, completely assessed, partially assessed, inaccessible, excluded, and carrying expired exceptions.
A percentage without its denominator and exclusions isn't sufficient evidence.
Reconcile observed repositories with the authoritative inventory so pagination or discovery failures don't silently reduce coverage.

### Account for API behavior

Measure API requests for each repository, total requests for each organization scan, paginated calls, rate-limit consumption, retries, assessment duration, and the percentage completed.
The resource-pack README documents rate-limit controls; configure and measure them for the selected revision.
Partition large inventories when a scan can't complete reliably within API allowance or credential lifetime.
Keep collection problems separate from policy failures.

### Protect the assessment pipeline

- Require pull request review and status checks for profile and workflow changes.
- Restrict who can modify controls, workflows, inputs, and waivers.
- Pin dependencies and actions to approved revisions.
- Sign or checksum released profile artifacts where required.
- Record the exact profile revision in every result.
- Restrict evidence access, define retention, and preserve failed and incomplete runs.
- Separate read-only assessment credentials from remediation credentials.

## Readiness checklist

Before scheduling assessments across the inventory, confirm that you:

- Install and verify compatible Chef InSpec, GitHub CLI, and Git versions.
- Obtain and pin the approved resource pack and policy profile.
- Define repository inventory, policy tiers, and manual coverage gaps.
- Create and test least-privilege credentials.
- Exercise pass, fail, inaccessible, pagination, and expired-waiver cases.
- Configure inputs and repository-specific, time-bound waivers.
- Export machine-readable, repository-linked results with execution context.
- Schedule recurring assessments and preserve evidence when checks fail.
- Track coverage, failures, incomplete collection, exceptions, and drift.
- Confirm resource-pack support, benchmark distribution and entitlement where applicable, and the evidence destination.
- Confirm product integration and output formats against the deployed releases rather than assuming native reporting or dashboards.

Start with one representative repository and complete local assessment and result review before scheduling the organization-wide inventory.

## Related documentation

- [Chef InSpec documentation](/inspec/latest/)
- [Chef downloads](https://downloads.chef.io/)
- [Install Chef InSpec](/inspec/latest/install/)
- [Profiles](/inspec/latest/profiles/)
- [Controls](/inspec/latest/profiles/controls/)
- [Inputs](/inspec/latest/profiles/inputs/)
- [Profile dependencies](/inspec/latest/profiles/depends/)
- [Reporters](/inspec/latest/configure/reporters/)
- [Waivers](/inspec/latest/configure/waivers/)
- [GitHub resource pack](https://github.com/inspec/inspec-github-resources)
- [GitHub resource reference](https://github.com/inspec/inspec-github-resources/tree/main/docs/resources)
- [Chef 360 Platform documentation](/360/)
- [GitHub rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets)
- [GitHub ruleset best practices](https://learn.github.com/well-architected/library/governance/recommendations/managing-repositories-at-scale/rulesets-best-practices/)
