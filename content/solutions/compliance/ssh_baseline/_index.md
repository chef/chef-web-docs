+++
title = "Audit SSH configuration across a Linux fleet"
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/compliance/ssh_baseline"
  parent = "overview/solutions/compliance"
  title = "Guide: Audit SSH configuration"
  weight = 5
+++

Almost every security standard requires that administrators don't log in directly as `root`
and that servers don't accept password authentication over SSH.
Both requirements are set in a single file, `/etc/ssh/sshd_config`,
and both are undone by a one-line edit during an incident.

Checking that file by hand doesn't scale past a handful of hosts,
and a spreadsheet of findings goes stale the day after you build it.

This guide walks through writing a Chef InSpec profile that checks those requirements,
running it against your servers, and reading what comes back.
It uses only core Chef InSpec resources, so you don't need a resource pack
or a Chef Automate server to complete it.

## What you'll build

A Chef InSpec profile with three controls that assert:

- Direct `root` login over SSH is disabled.
- Password authentication is disabled.
- The daemon allows no more than four authentication attempts on a connection.

By the end you'll be able to run that profile against one host or many,
get a pass or fail result for each control,
save the results as a JSON file you can keep as evidence,
and record an approved exception so it doesn't show up as a failure.

The same pattern works for any configuration requirement you can express as a check ---
SSH is the example, not the limit.

## Before you begin

You need:

- **Chef InSpec**, from [Chef Workstation](/workstation/latest/) or a
  [standalone install](/inspec/latest/install/).
  Run `inspec version` to confirm it's available.
  If you haven't accepted the Chef license yet, the first run prompts you to.
- **A Linux target to assess.** This can be the machine you're working on,
  or a remote host you can reach over SSH.
- **For remote targets:** SSH access, and an account that can read `/etc/ssh/sshd_config`.
  That file is usually world-readable, but if yours isn't, you need an account
  that can escalate with `sudo`.

You don't need to install anything on the target.
Chef InSpec connects over SSH and reads what it needs.

## Step 1: Create a profile

A profile is a directory with a known layout. Generate one:

```bash
inspec init profile ssh-baseline
```

```text
─────────────────────────── InSpec Code Generator ───────────────────────────

Creating new profile at ./ssh-baseline
 • Creating file README.md
 • Creating directory ./ssh-baseline/controls
 • Creating file controls/example.rb
 • Creating file inspec.yml
```

`inspec.yml` holds the profile's metadata and `controls/` holds the checks.
Open `ssh-baseline/inspec.yml` and describe what this profile is for:

```yaml
name: ssh-baseline
title: SSH configuration baseline
maintainer: Example Organization, Inc.
copyright: Example Organization, Inc.
copyright_email: compliance@example.com
license: Apache-2.0
summary: Verify that the OpenSSH daemon is configured to organization requirements
version: 0.1.0
supports:
  - platform-family: linux
```

The `supports` entry matters more than it looks.
It tells Chef InSpec which platforms these controls apply to.
Run the profile against something that isn't Linux and Chef InSpec skips it
instead of reporting misleading failures.

For every field you can set here, see
[the inspec.yml reference](/inspec/latest/profiles/inspec_yml/).

## Step 2: Write the controls

Delete the generated example and create `controls/ssh.rb`:

```ruby
control 'ssh-01' do
  impact 'critical'
  title 'Disable direct root login over SSH'
  desc 'Administrators must authenticate as themselves, then escalate.'
  desc 'rationale', 'Shared root logins make activity impossible to attribute to a person.'
  tag 'ssh'

  describe sshd_config do
    its('PermitRootLogin') { should cmp 'no' }
  end
end

control 'ssh-02' do
  impact 'high'
  title 'Require key-based authentication'
  desc 'Password authentication must be disabled on the SSH daemon.'
  tag 'ssh'

  describe sshd_config do
    its('PasswordAuthentication') { should cmp 'no' }
  end
end

control 'ssh-03' do
  impact 'medium'
  title 'Limit authentication attempts per connection'
  desc 'The SSH daemon must not allow more than four authentication attempts.'
  tag 'ssh'

  describe sshd_config do
    its('MaxAuthTries') { should cmp <= 4 }
  end
end
```

Each part of a control does a specific job:

`control 'ssh-01'`
: The identifier that follows this check through every report.
  Keep it stable --- if you renumber controls later, you lose the ability to compare
  this month's results against last month's.

`impact`
: How serious a failure is.
  Accepts `none`, `low`, `medium`, `high`, and `critical`, or a float from `0.0` to `1.0`.
  This is what lets a reviewer sort hundreds of findings by what matters.

`title` and `desc`
: What the control checks and why.
  The two-argument form, `desc 'rationale', '...'`, adds a labeled section
  that a reviewer sees alongside the result.

`describe sshd_config`
: The [`sshd_config` resource](/inspec/latest/resources/core/sshd_config/).
  It parses `/etc/ssh/sshd_config` and exposes each setting as a property,
  so you don't have to write text parsing.
  Pass a path --- `sshd_config('/etc/ssh/sshd_config.d/10-custom.conf')` ---
  if your configuration lives somewhere else.

`its('PermitRootLogin') { should cmp 'no' }`
: The assertion.
  Use `cmp` rather than `eq` for configuration values:
  it compares without caring whether the value came back as `'no'`, `'No'`, or `'NO'`,
  and it handles numeric comparison, as `ssh-03` does with `should cmp <= 4`.

Chef InSpec includes a large set of core resources for packages, services, files,
users, ports, and databases.
See the [resource reference](/inspec/latest/resources/) for the full list,
and [the controls reference](/inspec/latest/profiles/controls/) for control syntax.

## Step 3: Validate the profile

Before running the profile anywhere, check that it's well-formed:

```bash
inspec check ssh-baseline
```

```text
Location :   ssh-baseline
Profile :    ssh-baseline
Controls :   3
Timestamp :  2026-02-11T09:14:22+00:00
Valid :      true

No errors, warnings, or offenses
```

`Controls : 3` confirms Chef InSpec found all three controls.
If you have a syntax error or a missing required field, this is where it surfaces ---
not halfway through a run against production.

## Step 4: Run the assessment

Against the machine you're on:

```bash
inspec exec ssh-baseline
```

Against a remote host over SSH:

```bash
inspec exec ssh-baseline --target ssh://admin@web01.example.com --key-files ~/.ssh/id_rsa --sudo
```

Against several hosts, loop over your inventory:

```bash
for host in web01 web02 db01; do
  inspec exec ssh-baseline \
    --target "ssh://admin@${host}.example.com" \
    --key-files ~/.ssh/id_rsa \
    --sudo \
    --reporter "json:results-${host}.json"
done
```

Flags worth knowing while you're developing:

| Flag | What it does |
| --- | --- |
| `--target`, `-t` | The target to assess, as `ssh://user@host`, `winrm://`, or `docker://` |
| `--key-files`, `-i` | SSH private key to authenticate with |
| `--sudo` | Escalate privileges on the target |
| `--controls` | Run named controls only, such as `--controls ssh-01` |
| `--reporter` | Choose output format and destination |

The full list is in the [CLI reference](/inspec/latest/reference/cli/).

## Step 5: Read the results

A run against a host that doesn't meet two of the three requirements looks like this:

```text
Profile:   SSH configuration baseline (ssh-baseline)
Version:   0.1.0
Target:    ssh://admin@web01.example.com

  ×  ssh-01: Disable direct root login over SSH
     ×  SSHD Configuration PermitRootLogin is expected to cmp == "no"

     expected: no
          got:

     (compared using `cmp` matcher)

  ×  ssh-02: Require key-based authentication
     ×  SSHD Configuration PasswordAuthentication is expected to cmp == "no"

     expected: no
          got:

     (compared using `cmp` matcher)

  ✔  ssh-03: Limit authentication attempts per connection
     ✔  SSHD Configuration MaxAuthTries is expected to cmp <= 4


Profile Summary: 1 successful control, 2 control failures, 0 controls skipped
Test Summary: 1 successful, 2 failures, 0 skipped
```

Read it this way:

- `×` is a failure, `✔` is a pass, and `↺` is a skip.
- Each failure names the control, the property checked, what was expected,
  and what was found.
- An empty `got:` means the setting isn't present in the file at all.
  This is the common case and a real finding:
  the daemon falls back to its built-in default, which may or may not satisfy
  your requirement, and nothing records the intent.

### Check the exit code

`inspec exec` returns a specific exit code, which is what you use in a pipeline:

```bash
inspec exec ssh-baseline
echo $?
```

| Exit code | Meaning |
| --- | --- |
| `0` | Every control passed |
| `100` | At least one control failed |
| `101` | At least one control was skipped, and none failed |
| `1` | Usage or general error |

A `101` usually means the profile's `supports` didn't match the target.
Running this Linux profile against a macOS machine reports
`Skipping profile: 'ssh-baseline' on unsupported platform` and exits `101` ---
which is why Step 1 set `supports` rather than leaving the default.

### Keep the results

The CLI output is for you. For evidence, write a structured file:

```bash
inspec exec ssh-baseline --reporter cli json:results.json
```

That prints to the terminal and writes `results.json` at the same time.
The JSON includes each control's ID, its impact as a number, and the status of every test,
so you can feed it into a ticketing system or keep it as a dated record.
Only one reporter can write to standard output at a time.

Other formats, including `html2`, `junit2`, and `yaml`, are in the
[reporters reference](/inspec/latest/configure/reporters/).

## Step 6: Fix the finding and reassess

The two failures above are both settings missing from `sshd_config`.
Add them on the target:

```text
PermitRootLogin no
PasswordAuthentication no
```

Then reload the daemon so the running configuration matches the file:

```bash
sudo systemctl reload sshd
```

{{< note >}}

Keep a second session open while you change SSH configuration.
If you lock yourself out, an open session is the way back in.

{{< /note >}}

Run the same profile again:

```bash
inspec exec ssh-baseline --target ssh://admin@web01.example.com --key-files ~/.ssh/id_rsa
```

```text
  ✔  ssh-01: Disable direct root login over SSH
     ✔  SSHD Configuration PermitRootLogin is expected to cmp == "no"
  ✔  ssh-02: Require key-based authentication
     ✔  SSHD Configuration PasswordAuthentication is expected to cmp == "no"
  ✔  ssh-03: Limit authentication attempts per connection
     ✔  SSHD Configuration MaxAuthTries is expected to cmp <= 4


Profile Summary: 3 successful controls, 0 control failures, 0 controls skipped
Test Summary: 3 successful, 0 failures, 0 skipped
```

Running the profile again is what demonstrates the fix worked.
The first run found the gap, the second run is the evidence that it's closed,
and both are dated.

## Step 7: Waive an exception you've accepted

Some findings are accepted rather than fixed --- a documented exception,
or a system that can't be changed yet.
Recording that in a waiver file keeps it visible as an exception,
instead of hiding it or leaving it in the report as an unexplained failure.

Create `waivers.yml`:

```yaml
ssh-03:
  justification: "Approved exception CHG-4821; legacy automation requires six attempts."
  expiration_date: 2027-06-30
  run: false
```

Apply it:

```bash
inspec exec ssh-baseline --waiver-file waivers.yml
```

```text
  ↺  ssh-03: Limit authentication attempts per connection
     ↺  Skipped control due to waiver condition: Approved exception CHG-4821; legacy automation requires six attempts.


Profile Summary: 0 successful controls, 2 control failures, 1 control skipped
```

The control reports as skipped and carries your justification into the report.
`run: false` stops the control from executing at all.
Set it to `true` to keep running the control and collecting its result
while still marking it as waived.

{{< note >}}

`expiration_date` must be in the future.
Once it passes, the waiver stops applying and the control reports as a failure again.
That's the intended behavior --- an expired exception is one that needs re-approval ---
but it does mean a waiver can start failing a pipeline on a date nobody is watching for.

{{< /note >}}

Waivers also accept JSON and CSV.
See [the waivers reference](/inspec/latest/configure/waivers/).

## Where to go next

**Run it on a schedule instead of by hand.**
Turn on the [Compliance Phase](/client/latest/features/chef_compliance_phase/)
so Chef Infra Client runs your profile on every node as part of its normal run,
or create a [scan job](/automate/scan_jobs/) in Chef Automate for nodes
and cloud accounts.
A check you run once answers a question;
a check you run on a schedule is what catches configuration drift.

**Collect results centrally.**
Point runs at Chef Automate to get [compliance reporting](/automate/reports/)
across your fleet, with history by node, profile, and control.

**Start from a published benchmark instead of your own controls.**
Writing your own controls makes sense for organization-specific requirements.
For CIS Benchmarks and DISA STIGs, Chef publishes prebuilt audit content ---
see [supported compliance standards and platforms](/solutions/compliance/#supported-compliance-standards-and-platforms)
to find your platform.

**Fix findings with remediation content.**
For benchmarks Chef covers, remediation content corrects the configuration
behind a failing control.
See [compliance remediation](/solutions/compliance/#compliance-remediation).

**Check technologies beyond the operating system.**
Core resources cover much of a host.
For cloud accounts, Kubernetes clusters, and container runtimes,
see [Build custom compliance checks with Chef InSpec](/solutions/compliance/extend/).

## Related

- [Chef InSpec documentation](/inspec/latest/)
- [Chef InSpec resources](/inspec/latest/resources/)
- [Profile structure](/inspec/latest/profiles/)
- [Chef InSpec CLI reference](/inspec/latest/reference/cli/)
- [Compliance solution overview](/solutions/compliance/)
