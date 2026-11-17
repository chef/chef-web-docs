+++
title = "bash resource"
draft = false

platform = "linux"

[menu.inspec_7_2]
    title = "bash"
    identifier = "resources/core/bash.md bash resource"
    parent = "resources/core"
+++

Use the `bash` Chef InSpec audit resource to test an arbitrary command that's run on the system using a Bash script.

## Availability

### Install

{{< readfile file="content/inspec/7.2/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `command` resource block declares a command to be run, one (or more) expected outputs, and the location to which that output is sent:

```ruby
describe bash('command') do
  it { should exist }
  its('property') { should eq 'expected value' }
end
```

where:

- `'command'` must specify a command to be run
- `'property'` is one of `exit_status`, `stderr`, or `stdout`
- `'expected value'` tests the output of the command run on the system versus the expected output stated in the test

For example:

```ruby
describe bash('ls -al /') do
  its('stdout') { should match /bin/ }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end
```

## Properties

### exit_status

The `exit_status` property returns the exit status for the command.

```ruby
its('exit_status') { should eq 0 }
```

### stderr

The `stderr` property returns results of the command as returned in standard error (stderr).

```ruby
its('stderr') { should eq '' }
```

### stdout

The `stdout` property returns the results of the command as returned in standard output (stdout).

```ruby
its('stdout') { should match /bin/ }
```

## Matchers

{{< readfile file="content/inspec/7.2/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

If an absolute path is provided, the `exist` matcher tests if the command exists on the filesystem at the specified location. Otherwise, the `exist` matcher tests if the command is found in the PATH.

```ruby
it { should exist }
```
