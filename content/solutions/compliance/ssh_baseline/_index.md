+++
title = "The Chef Way of SSH compliance"
description = "Audit SSH configuration across a Linux fleet with Chef InSpec: write a profile, run it, read the findings, and fix or waive what fails."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/compliance/ssh_baseline"
  parent = "overview/solutions/compliance"
  title = "SSH compliance"
  weight = 5
+++

Almost every security standard requires that administrators don't log in directly as `root`
and that servers don't accept password authentication over SSH.
Both requirements are set in the SSH daemon's configuration, `/etc/ssh/sshd_config`
and any files it includes,
and both are undone by a one-line edit during an incident.

Checking that file by hand doesn't scale past a handful of hosts,
and a spreadsheet of findings quickly goes stale.

The steps below write a Chef InSpec profile that checks those requirements,
run it against your servers, and read what comes back.
It uses only core Chef InSpec resources, so you don't need a resource pack
or a Chef Automate server to complete it.

## What you'll build

A Chef InSpec profile with four controls that assert:

- Direct `root` login over SSH is disabled.
- Password authentication is disabled, including through keyboard-interactive authentication.
- The daemon allows no more than four authentication attempts on a connection.
- The settings the daemon enforces match the file, so an included file can't quietly turn password logins back on.

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
- **For remote targets:** SSH access, and an account that can escalate with `sudo`.
  On most distributions `/etc/ssh/sshd_config` is readable only by root,
  and reading the configuration the daemon enforces always requires root.

You don't need to install anything on the target.
Chef InSpec connects over SSH and reads what it needs.

## Create a profile

A profile is a directory with a known layout. Generate one:

```bash
inspec init profile ssh-baseline
```

```text
─────────────────────────── InSpec Code Generator ───────────────────────────

Creating new profile at /home/you/ssh-baseline
 • Creating file README.md
 • Creating directory /home/you/ssh-baseline/controls
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

## Write the controls

Delete the generated example and create `controls/ssh.rb`:

```ruby
control 'ssh-01-no-root-login' do
  impact 'critical'
  title 'Disable direct root login over SSH'
  desc 'Administrators must authenticate as themselves, then escalate.'
  desc 'rationale', 'Shared root logins make activity impossible to attribute to a person.'
  tag 'ssh'

  describe sshd_config do
    its('PermitRootLogin') { should cmp 'no' }
  end
end

control 'ssh-02-no-password-auth' do
  impact 'high'
  title 'Require key-based authentication'
  desc 'The SSH daemon must not accept passwords, either directly or through keyboard-interactive authentication.'
  tag 'ssh'

  describe sshd_config do
    its('PasswordAuthentication') { should cmp 'no' }
    its('KbdInteractiveAuthentication') { should cmp 'no' }
  end
end

control 'ssh-03-limit-attempts' do
  impact 'medium'
  title 'Limit authentication attempts per connection'
  desc 'The SSH daemon must not allow more than four authentication attempts.'
  tag 'ssh'

  describe sshd_config do
    its('MaxAuthTries') { should cmp <= 4 }
  end
end

control 'ssh-04-effective-auth' do
  impact 'high'
  title 'Confirm the authentication settings the daemon enforces'
  desc 'The running configuration, including any included files, must disable root login and passwords.'
  tag 'ssh'

  describe parse_config(command('sshd -T').stdout, assignment_regex: /^(\S+)\s+(.*)$/) do
    its('permitrootlogin') { should cmp 'no' }
    its('passwordauthentication') { should cmp 'no' }
    its('kbdinteractiveauthentication') { should cmp 'no' }
  end
end
```

Each part of a control does a specific job:

`control 'ssh-01-no-root-login'`
: The identifier that follows this check through every report.
  Make it a meaningful kebab-case or snake_case string that states the control's intent.
  A reviewer reading `ssh-01-no-root-login` in a report knows what failed;
  `ssh-01` tells them nothing without the profile open beside it.
  The leading number is optional, but it keeps related controls ordered in a report
  and lets you select a whole group with a pattern, such as `--controls /^ssh-0/`.
  Keep identifiers stable once you have results that refer to them.
  Renumbering costs you the ability to compare this month's results against last
  month's, and it quietly redirects any waiver that names the old identifier ---
  see [Waive an exception you've accepted](#waive-an-exception-youve-accepted).

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
  to read a different file.
  It reads only the one file: it doesn't follow `Include` lines or evaluate `Match` blocks.
  That makes it the right check for what the file records,
  but not proof of what the daemon enforces.

`its('KbdInteractiveAuthentication')`
: Turning off `PasswordAuthentication` doesn't stop every password prompt.
  When the daemon uses PAM, keyboard-interactive authentication can still ask for an account password,
  so `ssh-02-no-password-auth` checks both settings.
  Older OpenSSH releases call this setting `ChallengeResponseAuthentication`.

`describe parse_config(command('sshd -T').stdout, ...)`
: `sshd -T` prints the configuration the daemon enforces,
  after it has read every included file, with each setting name in lowercase.
  The [`parse_config` resource](/inspec/latest/resources/core/parse_config/) turns that output into properties,
  so `ssh-04-effective-auth` checks the result rather than the file.
  Many distributions start `sshd_config` with `Include /etc/ssh/sshd_config.d/*.conf`,
  and the daemon keeps the first value it reads for a setting,
  so a file in that directory overrides the main file.
  Running `sshd -T` requires root, so run this control with `--sudo`.

`its('PermitRootLogin') { should cmp 'no' }`
: The assertion.
  Use `cmp` rather than `eq` for configuration values:
  it compares without caring whether the value came back as `'no'`, `'No'`, or `'NO'`,
  and it handles numeric comparison, as `ssh-03-limit-attempts` does with `should cmp <= 4`.

Chef InSpec includes a large set of core resources for packages, services, files,
users, ports, and databases.
See the [resource reference](/inspec/latest/resources/) for the full list,
and [the controls reference](/inspec/latest/profiles/controls/) for control syntax.

## Validate the profile

Before running the profile anywhere, check that it's well-formed:

```bash
inspec check ssh-baseline
```

```text
Location :   ssh-baseline
Profile :    ssh-baseline
Controls :   4
Timestamp :  2026-11-11T16:36:13+05:30
Valid :      true

No errors, warnings, or offenses
```

`Controls : 4` confirms Chef InSpec found all four controls.
If you have a syntax error or a missing required field, this is where it surfaces ---
not halfway through a run against production.

## Run the assessment

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
| `--controls` | Run named controls only, such as `--controls ssh-01-no-root-login` |
| `--reporter` | Choose output format and destination |

The full list is in the [CLI reference](/inspec/latest/reference/cli/).

### Scale the loop with InSpec Parallel

The loop above runs hosts one after another, so a hundred hosts take a hundred
times as long as one. [InSpec Parallel](/inspec/latest/configure/parallel/)
does the same job concurrently.

List one set of options for each run in an option file, `hosts.txt`:

```text
-t ssh://admin@web01.example.com -i ~/.ssh/id_rsa --sudo --reporter cli:reports/web01.txt
-t ssh://admin@web02.example.com -i ~/.ssh/id_rsa --sudo --reporter cli:reports/web02.txt
```

Then run them together:

```bash
inspec parallel exec ssh-baseline --option-file hosts.txt --jobs 2
```

Each line holds only options --- the profile is named once on the command line.
Give every run its own `--reporter` destination,
otherwise the concurrent runs overwrite each other's output.
Use `--dry-run` to print the commands without running them.

This is also where control naming pays off a second time:
`--controls /^ssh-0/` splits a large profile across processes by ID pattern,
which works because the IDs follow a deliberate scheme.

{{< warning >}}

`inspec parallel` exits `0` once it has run every job,
even when individual runs failed their controls.
Check the per-run reports or the child exit codes in the log
rather than the exit code of the parallel command.

{{< /warning >}}

InSpec Parallel requires Chef InSpec 6 or later.

## Read the results

A run against a freshly launched Amazon Linux 2023 host, before any changes, looks like this:

```text
Profile:   SSH configuration baseline (ssh-baseline)
Version:   0.1.0
Target:    ssh://admin@web01.example.com:22
Target ID: fcd9806d-9c9b-5c6d-8d8f-5598b25b985b

  ×  ssh-01-no-root-login: Disable direct root login over SSH
     ×  SSHD Configuration PermitRootLogin is expected to cmp == "no"

     expected: no
          got:

     (compared using `cmp` matcher)

  ×  ssh-02-no-password-auth: Require key-based authentication (1 failed)
     ✔  SSHD Configuration PasswordAuthentication is expected to cmp == "no"
     ×  SSHD Configuration KbdInteractiveAuthentication is expected to cmp == "no"

     expected: no
          got:

     (compared using `cmp` matcher)

  ×  ssh-03-limit-attempts: Limit authentication attempts per connection
     ×  SSHD Configuration MaxAuthTries is expected to cmp <= 4

     expected it to be <= 4
          got:

     (compared using `cmp` matcher)

  ×  ssh-04-effective-auth: Confirm the authentication settings the daemon enforces (1 failed)
     ×  Parse Config  permitrootlogin is expected to cmp == "no"

     expected: no
          got: without-password

     (compared using `cmp` matcher)

     ✔  Parse Config  passwordauthentication is expected to cmp == "no"
     ✔  Parse Config  kbdinteractiveauthentication is expected to cmp == "no"


Profile Summary: 0 successful controls, 4 control failures, 0 controls skipped
Test Summary: 3 successful, 4 failures, 0 skipped
exit 100
```

Read it this way:

- `×` is a failure, `✔` is a pass, and `↺` is a skip.
- Each failure names the control, the property checked, what was expected,
  and what was found.
  A control that has more than one test reports how many failed, such as `(1 failed)`.
- An empty `got:` from `sshd_config` means the setting isn't present in the file at all.
  This is the common case and a real finding:
  the daemon falls back to a default or to an included file, which may or may not satisfy
  your requirement, and the main file records no intent.
- `ssh-04-effective-auth` shows what the daemon enforces.
  Here `permitrootlogin` is `without-password`, the built-in default,
  which still allows `root` to log in with a key.

The two kinds of check also disagree on keyboard-interactive authentication.
The main file doesn't set it, so `ssh-02-no-password-auth` fails,
but the daemon enforces `no` because an included file on this distribution sets it.
Neither result is wrong: one reports what the file records, the other what the daemon does.

### Check the exit code

`inspec exec` returns a specific exit code, which is what you use in a pipeline:

```bash
inspec exec ssh-baseline
echo $?
```

| Exit code | Meaning |
| --- | --- |
| `0` | Every control passed |
| `1` | Usage or general error |
| `2` | Plugin system error |
| `3` | A fatal deprecation was encountered |
| `4` | A gem dependency failed to load |
| `100` | At least one control failed |
| `101` | At least one control was skipped, and none failed |
| `130` | The run was terminated with Ctrl-C |
| `172` | The license wasn't accepted |
| `173` | The license isn't entitled to run Chef InSpec |
| `174` | No license was set |

Treat `0`, `100`, and `101` as assessment outcomes and everything else as a
problem with the run itself.
A pipeline that only checks for a non-zero exit treats a licensing or plugin
failure as if it were a compliance failure, so branch on the specific code.

A `101` can mean the profile's `supports` didn't match the target.
Running this Linux profile against a macOS machine reports
`Skipping profile: 'ssh-baseline' on unsupported platform` and exits `101` ---
which is why the profile you created set `supports` rather than leaving the default.

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

## Fix the finding and reassess

The file-based failures above are all settings missing from `sshd_config`.
Add them on the target:

```text
PermitRootLogin no
KbdInteractiveAuthentication no
MaxAuthTries 4
```

Check the syntax, then reload the daemon so the running configuration matches the file:

```bash
sudo sshd -t
sudo systemctl reload sshd
```

`sshd -t` prints nothing when the configuration is valid,
so run it before every reload.

{{< note >}}

Keep a second session open while you change SSH configuration.
If you lock yourself out, an open session is the way back in.

{{< /note >}}

Run the same profile again:

```bash
inspec exec ssh-baseline --target ssh://admin@web01.example.com --key-files ~/.ssh/id_rsa --sudo
```

```text
  ✔  ssh-01-no-root-login: Disable direct root login over SSH
     ✔  SSHD Configuration PermitRootLogin is expected to cmp == "no"
  ✔  ssh-02-no-password-auth: Require key-based authentication
     ✔  SSHD Configuration PasswordAuthentication is expected to cmp == "no"
     ✔  SSHD Configuration KbdInteractiveAuthentication is expected to cmp == "no"
  ✔  ssh-03-limit-attempts: Limit authentication attempts per connection
     ✔  SSHD Configuration MaxAuthTries is expected to cmp <= 4
  ✔  ssh-04-effective-auth: Confirm the authentication settings the daemon enforces
     ✔  Parse Config  permitrootlogin is expected to cmp == "no"
     ✔  Parse Config  passwordauthentication is expected to cmp == "no"
     ✔  Parse Config  kbdinteractiveauthentication is expected to cmp == "no"


Profile Summary: 4 successful controls, 0 control failures, 0 controls skipped
Test Summary: 7 successful, 0 failures, 0 skipped
exit 0
```

{{< warning >}}

Keep `--sudo` on the re-run.
Without it, the three `sshd_config` controls report as skipped with
`Can't read file: /etc/ssh/sshd_config`,
and `ssh-04-effective-auth` fails with an empty `got:` because `sshd -T` can't run.
That's not a finding about the host --- nothing was assessed.

{{< /warning >}}

Running the profile again is what demonstrates the fix worked.
The first run found the gap, the second run is the evidence that it's closed,
and both are dated.

### Catch an override from an included file

`ssh-04-effective-auth` earns its place when something else changes the configuration.
Suppose a provisioning tool leaves `/etc/ssh/sshd_config.d/40-legacy-access.conf` on the host,
containing one line:

```text
PasswordAuthentication yes
```

The main file still says `PasswordAuthentication no`,
but the daemon reads the included file first and keeps its value.
After a reload, the same run reports:

```text
  ✔  ssh-01-no-root-login: Disable direct root login over SSH
     ✔  SSHD Configuration PermitRootLogin is expected to cmp == "no"
  ✔  ssh-02-no-password-auth: Require key-based authentication
     ✔  SSHD Configuration PasswordAuthentication is expected to cmp == "no"
     ✔  SSHD Configuration KbdInteractiveAuthentication is expected to cmp == "no"
  ✔  ssh-03-limit-attempts: Limit authentication attempts per connection
     ✔  SSHD Configuration MaxAuthTries is expected to cmp <= 4
  ×  ssh-04-effective-auth: Confirm the authentication settings the daemon enforces (1 failed)
     ✔  Parse Config  permitrootlogin is expected to cmp == "no"
     ×  Parse Config  passwordauthentication is expected to cmp == "no"

     expected: no
          got: yes

     (compared using `cmp` matcher)

     ✔  Parse Config  kbdinteractiveauthentication is expected to cmp == "no"


Profile Summary: 3 successful controls, 1 control failure, 0 controls skipped
Test Summary: 6 successful, 1 failure, 0 skipped
exit 100
```

Every file-based control passes, and password logins are enabled.
Only the check against `sshd -T` shows the problem.
Remove or correct the included file, reload the daemon, and run the profile again.

`sshd -T` reports the configuration for connections that no `Match` block applies to.
Settings inside a `Match` block apply only to the connections it matches,
so pass the connection details with `-C` to see them:

```bash
sudo sshd -T -C user=deploy,host=web01.example.com,addr=192.0.2.10
```

With a `Match User deploy` block that sets `PasswordAuthentication yes`,
`sshd -T` alone reports `passwordauthentication no`,
and the command above reports `passwordauthentication yes`.
To check a `Match` rule in a control, use the same command with the connection details you need to verify.

## Waive an exception you've accepted

Some findings are accepted rather than fixed --- a documented exception,
or a system that can't be changed yet.
Recording that in a waiver file keeps it visible as an exception,
instead of hiding it or leaving it in the report as an unexplained failure.

Take a second host that meets the authentication requirements but runs legacy
automation needing six authentication attempts, so `ssh-03-limit-attempts`
fails there and has an approved exception on file.

Create `waivers.yml`:

```yaml
ssh-03-limit-attempts:
  justification: "Approved exception CHG-4821; legacy automation requires six attempts."
  expiration_date: 2027-06-30
  run: false
```

Apply it:

```bash
inspec exec ssh-baseline --target ssh://admin@web01.example.com --key-files ~/.ssh/id_rsa --sudo --waiver-file waivers.yml
```

```text
  ✔  ssh-01-no-root-login: Disable direct root login over SSH
     ✔  SSHD Configuration PermitRootLogin is expected to cmp == "no"
  ✔  ssh-02-no-password-auth: Require key-based authentication
     ✔  SSHD Configuration PasswordAuthentication is expected to cmp == "no"
     ✔  SSHD Configuration KbdInteractiveAuthentication is expected to cmp == "no"
  ↺  ssh-03-limit-attempts: No-op
     ↺  Skipped control due to waiver condition: Approved exception CHG-4821; legacy automation requires six attempts.
  ✔  ssh-04-effective-auth: Confirm the authentication settings the daemon enforces
     ✔  Parse Config  permitrootlogin is expected to cmp == "no"
     ✔  Parse Config  passwordauthentication is expected to cmp == "no"
     ✔  Parse Config  kbdinteractiveauthentication is expected to cmp == "no"


Profile Summary: 3 successful controls, 0 control failures, 1 control skipped
Test Summary: 6 successful, 0 failures, 1 skipped
exit 101
```

The control reports as skipped and carries your justification into the report.
It's listed as `No-op` rather than by its title,
because `run: false` stops the control body from executing at all.
Set `run` to `true` to keep running the control and collecting its result
while still marking it as waived.

Waivers are one of the strongest reasons to give controls meaningful IDs.
A waiver file matches on the control ID and nothing else,
so if controls are renumbered later --- what was `ssh-02` becomes `ssh-03` ---
a waiver still keyed on the old number silently waives whichever control now
holds that ID. The exception is applied to the wrong requirement,
and the report still looks orderly.

The reverse is also silent.
If the waiver names an ID that no longer exists,
Chef InSpec doesn't warn you: the waiver simply never applies,
the control runs, and an approved exception reappears as a failure.
An ID like `ssh-03-limit-attempts` describes what's being waived,
so the file keeps meaning something as the profile changes.

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
see [The Chef Way of custom compliance checks](/solutions/compliance/custom_compliance_checks/).

## Related

- [Chef InSpec documentation](/inspec/latest/)
- [Chef InSpec resources](/inspec/latest/resources/)
- [Profile structure](/inspec/latest/profiles/)
- [Chef InSpec CLI reference](/inspec/latest/reference/cli/)
- [Compliance solution overview](/solutions/compliance/)
