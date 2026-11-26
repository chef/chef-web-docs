+++
title = "command resource"
draft = false

platform = "os"

[menu.inspec_6_8]
    title = "command"
    identifier = "resources/core/command.md command resource"
    parent = "resources/core"
+++

Use the `command` Chef InSpec audit resource to test an arbitrary command that's run on the system.

## Availability

### Install

{{< readfile file="content/inspec/6.8/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `command` resource block declares a command to be run, one (or more) expected values, and the location to which that output is sent:

```ruby
describe command('command') do
  it { should exist }
  its('property') { should eq 'value' }
end
```

where:

- `'command'` must specify a command to be run
- `'property'` is one of `exit_status`, `stderr`, or `stdout`
- `'output'` tests the output of the command run on the system versus the output value stated in the test

## Property Examples

The following examples show how to use this Chef InSpec audit resource.

### exit_status

The `exit_status` property tests the exit status for the command:

```ruby
its('exit_status') { should eq 123 }
```

### stderr

The `stderr` property tests results of the command as returned in standard error (stderr):

```ruby
its('stderr') { should eq 'error' }
```

### stdout

The `stdout` property tests results of the command as returned in standard output (stdout). The following example shows matching output using a regular expression:

```ruby
describe command('echo 1') do
   its('stdout') { should match (/[0-9]/) }
end
```

### Test standard output (stdout)

```ruby
describe command('echo hello') do
  its('stdout') { should eq "hello\n" }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end
```

### Test standard error (stderr)

```ruby
describe command('>&2 echo error') do
  its('stdout') { should eq '' }
  its('stderr') { should eq "error\n" }
  its('exit_status') { should eq 0 }
end
```

### Test an exit status code

```ruby
describe command('exit 123') do
  its('stdout') { should eq '' }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 123 }
end
```

### Test if the command shell exists

```ruby
describe command('/bin/sh').exist? do
  it { should eq true }
end
```

### Test for a command that shouldn't exist

```ruby
describe command('this isn't existing').exist? do
  it { should eq false }
end
```

### Test for PostgreSQL database running a RC, development, or beta release

```ruby
describe command('psql -V') do
  its('stdout') { should eq '/RC/' }
  its('stdout') { should_not eq '/DEVEL/' }
  its('stdout') { should_not eq '/BETA/' }
end
```

### Verify NTP

The following example shows how to use the `file` audit resource to verify if the `ntp.conf` and `leap-seconds` files are present, and then the `command` resource to verify if NTP is installed and running:

```ruby
describe file('/etc/ntp.conf') do
   it { should be_file }
end

describe file('/etc/ntp.leapseconds') do
  it { should be_file }
end

describe command('pgrep ntp') do
   its('exit_status') { should eq 0 }
end
```

### Verify WiX

Wix includes several tools -- such as `candle` (preprocesses and compiles source files into object files), `light` (links and binds object files to an installer database), and `heat` (harvests files from various input formats). The following example uses a whitespace array and the `file` audit resource to verify if these three tools are present:

```ruby
%w(
  candle.exe
  heat.exe
  light.exe
).each do |utility|
  describe file("C:/wix/##{utility}") do
    it { should be_file }
  end
end
```

### Timing Out Long-Running Commands

On target platforms that support the feature, the command resource takes an optional `timeout:` parameter which specifies how long the command may run in seconds before erroring out and failing the control.

```ruby
describe command("find / -owner badguy", timeout: 300) do
  its("stdout") { should be_empty }
end
```

This example would run the `find` command for up to 300 seconds, then give up and fail the control if it exceeded that time.

Aside from setting the value on a per-resource basis, you may also use the `--command-timeout` CLI option to globally set a command timeout. The CLI option takes precedence over any per-resource `timeout:` options.

Currently supported target platforms include:

- Local Unix-like OSes, including macOS
- SSH targets
- Windows targets using WinRM

Any target platforms not listed aren't supported at this time.

On unsupported platforms, the timeout value is ignored and the command will run indefinitely.

### Redacting Sensitive Commands

By default the command that's ran is shown in the Chef InSpec output. This can be problematic if the command contains sensitive arguments such as a password. These sensitive parts can be redacted by passing in `redact_regex` and a regular expression to redact. Optionally, you can use 2 capture groups to fine tune what's redacted.

The following examples show how to use `redact_regex`:

```ruby
# Example without capture groups
describe command('myapp -p secret_password -d no_redact', redact_regex: /-p .* -d/) do
  its('exit_status') { should cmp 0 }
end

# Result (no capture groups used)
Command: `myapp REDACTED no_redact`
   ✔  exit_status should cmp == 0

# Example with capture groups
# Each set of parenthesis is a capture group.
# Anything in the two capture groups won't be 'REDACTED'
describe command('myapp -p secret_password -d no_redact', redact_regex: /(-p ).*( -d)/) do
  its('exit_status') { should cmp 0 }
end

# Result (capture groups used)
Command: `myapp -p REDACTED -d no_redact`
   ✔  exit_status should cmp == 0
```

For more info/help on regular expressions, we recommend [RegExr](https://regexr.com/)

## Matchers

{{< readfile file="content/inspec/6.8/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The `exist` matcher tests if a command may be run on the system:

```ruby
it { should exist }
```
