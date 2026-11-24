+++
title = "kernel_parameters resource"
draft = false

platform = "linux"

[menu.inspec_5_23]
    title = "kernel_parameters"
    identifier = "resources/core/kernel_parameters.md kernel_parameters resource"
    parent = "resources/core"
+++

Use the `kernel_parameters` Chef InSpec audit resource to test multiple kernel parameters on Linux platforms.
These parameters are located under `/proc/cmdline`.

## Availability

### Install

{{< readfile file="content/inspec/5.23/reusable/md/inspec_installation.md" >}}

## Syntax

A `kernel_parameters` resource block uses `where` to filter entries from the systems kernel parameters. If `where` is omitted, all entries are selected.

```ruby
describe kernel_parameters do
  its('parameters') { should include "PARAMETER_NAME" }
  its('values') { should include 1 }
end

describe kernel_parameters.where(parameter: "PARAMETER_NAME") do
  its('values') { should eq [1] }
end
```

## Properties

### parameters

The kernel parameter to test.

### values

The value of a kernel parameter.

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test the global forwarding setting using a `where` query on the kernel parameters

```ruby
describe kernel_parameters.where(parameter: "net.ipv4.conf.all.forwarding") do
  its('values') { should eq [1] }
end
```

### Match a parameter using a regular expression

```ruby
describe kernel_parameters.where(parameter: /^net./ ) do
  its('parameters') { should include 'net.ipv4.conf.all.forwarding' }
end
```

## Matchers

{{< readfile file="content/inspec/5.23/reusable/md/inspec_matchers_link.md" >}}
