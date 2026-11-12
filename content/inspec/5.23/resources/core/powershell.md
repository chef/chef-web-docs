+++
title = "powershell resource"
draft = false

platform = "windows"

[menu.inspec_5_23]
    title = "powershell"
    identifier = "resources/core/powershell.md powershell resource"
    parent = "resources/core"
+++

Use the `powershell` Chef InSpec audit resource to test a Powershell script on the Windows platform.

## Availability

### Install

{{< readfile file="content/inspec/5.23/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `powershell` resource block declares a Powershell script to be tested, and then compares the output of that command to the matcher in the test:

```ruby
script = <<-EOH
  # a PowerShell script
EOH

describe powershell(script) do
  its('property') { should eq 'output' }
end
```

where:

- `'script'` must specify a Powershell script to be run
- `'matcher'` is one of `exit_status`, `stderr`, or `stdout`
- `'output'` tests the output of the command run on the system versus the output value stated in the test

## Properties

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

The `stdout` property tests results of the command as returned in standard output (stdout):

```ruby
its('stdout') { should eq '/^1$/' }
```

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Get all groups of Administrator user

```ruby
script = <<-EOH
  # find user
  $user = Get-WmiObject Win32_UserAccount -filter "Name = 'Administrator'"
  # get related groups
  $groups = $user.GetRelated('Win32_Group') | Select-Object -Property Caption, Domain, Name, LocalAccount, SID, SIDType, Status
  $groups | ConvertTo-Json
EOH

describe powershell(script) do
  its('stdout') { should_not eq '' }
end
```

### Write-Output 'hello'

The following Powershell script:

```ruby
script = <<-EOH
  Write-Output 'hello'
EOH
```

can be tested in the following ways.

For a newline:

```ruby
describe powershell(script) do
  its('stdout') { should eq "hello\r\n" }
  its('stderr') { should eq '' }
end
```

Removing whitespace `\r\n` from `stdout`:

```ruby
describe powershell(script) do
  its('strip') { should eq "hello" }
end
```

No newline:

```ruby
describe powershell("'hello' | Write-Host -NoNewLine") do
  its('stdout') { should eq 'hello' }
  its('stderr') { should eq '' }
end
```

## Matchers

{{< readfile file="content/inspec/5.23/reusable/md/inspec_matchers_link.md" >}}
