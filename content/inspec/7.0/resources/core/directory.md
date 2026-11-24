+++
title = "directory resource"
draft = false

platform = "os"

[menu.inspec_7_0]
    title = "directory"
    identifier = "resources/core/directory.md directory resource"
    parent = "resources/core"
+++

Use the `directory` Chef InSpec audit resource to test if the file type is a directory. This is equivalent to using the [`file` resource](/inspec/7.0/resources/core/file/) and the `be_directory` matcher, but provides a simpler and more direct way to test directories.

## Availability

### Install

{{< readfile file="content/inspec/7.0/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `directory` resource block declares the location of the directory to be tested, and then one (or more) matchers.

```ruby
describe directory('path') do
  its('property') { should cmp 'value' }
end
```

## Properties

All of the properties available to [`file`](/inspec/7.0/resources/core/file/) may be used with `directory`.

## Matchers

{{< readfile file="content/inspec/7.0/reusable/md/inspec_matchers_link.md" >}}
