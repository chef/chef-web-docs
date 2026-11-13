+++
title = "windows_hotfix resource"
draft = false

platform = "windows"

[menu.inspec_6_8]
    title = "windows_hotfix"
    identifier = "resources/core/windows_hotfix.md windows_hotfix resource"
    parent = "resources/core"
+++

Use the `windows_hotfix` Chef InSpec audit resource to test if the hotfix has been installed on a Windows system.

## Availability

### Install

{{< readfile file="content/inspec/6.8/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.39.1 of InSpec.

## Syntax

A `windows_hotfix` resource block declares a hotfix to validate:

```ruby
describe windows_hotfix('name') do
  it { should be_installed }
end
```

where:

- `('name')` must specify the name of a hotfix, such as `'KB4012213'`
- `be_installed` is a valid matcher for this resource

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test if KB4012213 is installed

```ruby
describe windows_hotfix('KB4012213') do
  it { should be_installed }
end
```

### Test that a hotfix isn't installed

```ruby
describe windows_hotfix('KB9999999') do
  it { should_not be_installed }
end
```

## Matchers

{{< readfile file="content/inspec/6.8/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### be_installed

The `be_installed` matcher tests if the named hotfix is installed on the system:

```ruby
it { should be_installed }
```
