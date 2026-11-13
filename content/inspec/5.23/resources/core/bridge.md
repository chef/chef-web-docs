+++
title = "bridge resource"
draft = false

platform = "linux"

[menu.inspec_5_23]
    title = "bridge"
    identifier = "resources/core/bridge.md bridge resource"
    parent = "resources/core"
+++

Use the `bridge` Chef InSpec audit resource to test basic network bridge properties, such as `name`, if an interface is defined, and the associations for any defined interface.

## Availability

### Install

{{< readfile file="content/inspec/5.23/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `bridge` resource block declares the bridge to be tested and what interface it should be associated with:

```ruby
describe bridge('br0') do
  it { should exist }
  it { should have_interface 'eth0' }
end
```

- On Linux platforms, any value in the `/sys/class/net/{interface}/bridge` directory may be tested
- On the Windows platform, the `Get-NetAdapter` cmdlet is associated with the `Get-NetAdapterBinding` cmdlet and returns the `ComponentID ms_bridge` value as a JSON object

## Properties

### interfaces

The `interfaces` property returns the named interfaces.

```ruby
its('interfaces') { should include('foo') }
```

## Matchers

{{< readfile file="content/inspec/5.23/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The `exist` matcher tests if the network bridge is available:

```ruby
it { should exist }
```

### have_interface

The `have_interface` matcher tests if the named interface is defined for the network bridge:

```ruby
it { should have_interface 'eth0' }
```
