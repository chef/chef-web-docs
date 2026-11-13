+++
title = "windows_feature resource"
draft = false

platform = "windows"

[menu.inspec_7_3]
    title = "windows_feature"
    identifier = "resources/core/windows_feature.md windows_feature resource"
    parent = "resources/core"
+++

Use the `windows_feature` Chef InSpec audit resource to test features on Windows using the `Get-WindowsFeature` cmdlet.

## Availability

### Install

{{< readfile file="content/inspec/7.3/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `windows_feature` resource block declares the name of the Windows feature, tests if that feature is installed, and then returns information about that feature:

```ruby
describe windows_feature('feature_name') do
  it { should be_installed }
end
```

where:

- `('feature_name')` must specify a Windows feature name, such as `DHCP Server` or `IIS-Webserver`
- `be_installed` is a valid matcher for this resource

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test the DHCP feature (Attempts PowerShell then DISM)

```ruby
describe windows_feature('DHCP') do
  it{ should be_installed }
end
```

### Test the IIS-WebServer feature using DISM

```ruby
describe windows_feature('IIS-WebServer', DISM) do
  it{ should be_installed }
end
```

### Test the NetFx3 feature using DISM

```ruby
describe windows_feature('NetFx3', :dism) do
  it{ should be_installed }
end
```

## Matchers

{{< readfile file="content/inspec/7.3/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### be_installed

The `be_installed` matcher tests if the named Windows feature is installed:

```ruby
it { should be_installed }
```
