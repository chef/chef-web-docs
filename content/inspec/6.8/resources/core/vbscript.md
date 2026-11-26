+++
title = "vbscript resource"
draft = false

platform = "windows"

[menu.inspec_6_8]
    title = "vbscript"
    identifier = "resources/core/vbscript.md vbscript resource"
    parent = "resources/core"
+++

Use the `vbscript` Chef InSpec audit resource to test a VBScript on the Windows platform.

## Availability

### Install

{{< readfile file="content/inspec/6.8/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `vbscript` resource block tests the output of a VBScript on the Windows platform:

```ruby
describe vbscript('script contents') do
  its('stdout') { should eq 'output' }
end
```

where:

- `'script_name'` is the name of the VBScript to test
- `('output')` is the expected output of the VBScript

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test a VBScript

A VBScript file similar to:

```ruby
script = <<-EOH
  WScript.Echo "hello"
EOH
```

may be tested for multiple lines:

```ruby
describe vbscript(script) do
  its('stdout') { should eq "hello\r\n" }
end
```

and tested for whitespace removal from standard output:

```ruby
describe vbscript(script) do
  its('strip') { should eq "hello" }
end
```

## Matchers

{{< readfile file="content/inspec/6.8/reusable/md/inspec_matchers_link.md" >}}
