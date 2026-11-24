+++
title = "bond resource"
draft = false

platform = "linux"

[menu.inspec_7_1]
    title = "bond"
    identifier = "resources/core/bond.md bond resource"
    parent = "resources/core"
+++

Use the `bond` Chef InSpec audit resource to test a logical, bonded network interface (that is, two or more network interfaces aggregated into a single, logical network interface). On Linux platforms, any value in the `/proc/net/bonding` directory may be tested.

## Availability

### Install

{{< readfile file="content/inspec/7.1/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `bond` resource block declares a bonded network interface, and then specifies the properties of that bonded network interface to be tested:

```ruby
describe bond('name') do
  it { should exist }
end
```

where:

- `'name'` is the name of the bonded network interface
- `{ should exist }` is a valid matcher for this resource

## Properties

### content

The `content` property returns the contents in the file that defines the bonded network interface. The values of the `content` property are arbitrary.

```ruby
its('content') { should match('value') }
```

### interfaces

The `interfaces` property tests if the named secondary interfaces are available.

```ruby
its('interfaces') { should eq ['eth0', 'eth1', ...] }
```

### mode

The `mode` property returns the Bonding Mode.

```ruby
its('mode') { should eq 'IEEE 802.3ad Dynamic link aggregation' }
```

### params

The `params` property returns arbitrary parameters for the bonded network interface.

```ruby
its('params') { should eq 'value' }
```

## Examples

### Test if eth0 is a secondary interface for bond0

```ruby
describe bond('bond0') do
  it { should exist }
  it { should have_interface 'eth0' }
end
```

### Test parameters for bond0

```ruby
describe bond('bond0') do
  its('mode') { should eq 'IEEE 802.3ad Dynamic link aggregation' }
  its('params') { should have_key 'Transmit Hash Policy' }
  its('params') { should include 'Transmit Hash Policy' => 'layer3+4 (1)' }
  its('params') { should have_key 'MII Status' }
  its('params') { should include 'MII Status' => 'up' }
end
```

## Matchers

{{< readfile file="content/inspec/7.1/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The `exist` matcher tests if the bonded network interface is available:

```ruby
it { should exist }
```

### have_interface

The `have_interface` matcher tests if the bonded network interface has one (or more) secondary interfaces:

```ruby
it { should have_interface }
```
