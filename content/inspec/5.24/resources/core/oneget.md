+++
title = "oneget resource"
draft = false

platform = "windows"

[menu.inspec_5_24]
    title = "oneget"
    identifier = "resources/core/oneget.md oneget resource"
    parent = "resources/core"
+++

Use the `oneget` Chef InSpec audit resource to test if the named package and/or package version is installed on the system. This resource uses Oneget, which is `part of the Windows Management Framework 5.0 and Windows 10 <https://github.com/OneGet/oneget>`. This resource uses the `Get-Package` cmdlet to return all of the package names in the Oneget repository.

## Availability

### Install

{{< readfile file="content/inspec/5.24/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `oneget` resource block declares a package and (optionally) a package version:

```ruby
describe oneget('name') do
  it { should be_installed }
end
```

where:

- `('name')` must specify the name of a package, such as `'VLC'`
- `be_installed` is a valid matcher for this resource

## Properties

### version

The `version` property tests if the named package version is on the system:

```ruby
its('version') { should eq '1.2.3' }
```

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test if VLC is installed

```ruby
describe oneget('VLC') do
  it { should be_installed }
end
```

## Matchers

{{< readfile file="content/inspec/5.24/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### be_installed

The `be_installed` matcher tests if the named package is installed on the system:

```ruby
it { should be_installed }
```
