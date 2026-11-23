+++
title = "packages resource"
draft = false

platform = "linux"

[menu.inspec_7_1]
    title = "packages"
    identifier = "resources/core/packages.md packages resource"
    parent = "resources/core"
+++

Use the `packages` Chef InSpec audit resource to test the properties of multiple packages on the system.

## Availability

### Install

{{< readfile file="content/inspec/7.1/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.51.15 of InSpec.

## Syntax

A `packages` resource block declares a regular expression search to select packages

```ruby
describe packages(/name/) do
  its('statuses') { should cmp 'installed' }
end
```

## Properties

### statuses

The `statuses` property tests if packages are installed on the system:

```ruby
its('statuses') { should cmp 'installed' }
```

### versions

The `versions` property tests the versions of the packages installed on the system

```ruby
its('versions') { should cmp '3.4.0.2-4.el7' }
```

### architectures

The `architectures` property tests the architecture of packages installed on the system

```ruby
its('architectures') { should include 'i686' }
```

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Verify that no `xserver` packages are installed

```ruby
describe packages(/xserver/) do
  its('statuses') { should_not cmp 'installed' }
end
```

### Verify all `openssl` packages match a certain version

```ruby
describe packages(/openssl/) do
  its('versions') { should cmp '1.0.1e-42.el7' }
end
```

### Verify that both the `i686` and `x86_64` versions of `libgcc` are installed

```ruby
describe packages(/libgcc/) do
  its('architectures') { should include 'x86_64' }
  its('architectures') { should include 'i686' }
end
```

## Matchers

{{< readfile file="content/inspec/7.1/reusable/md/inspec_matchers_link.md" >}}
