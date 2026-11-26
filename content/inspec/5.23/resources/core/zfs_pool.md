+++
title = "zfs_pool resource"
draft = false

platform = "linux"

[menu.inspec_5_23]
    title = "zfs_pool"
    identifier = "resources/core/zfs_pool.md zfs_pool resource"
    parent = "resources/core"
+++

Use the `zfs_pool` Chef InSpec audit resource to test the ZFS pools on FreeBSD & Linux (Centos, RHEL, Ubuntu, CloudLinux, Debian) systems.

## Availability

### Install

{{< readfile file="content/inspec/5.23/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.16.0 of InSpec.

## Syntax

A `zfs_pool` resource block declares the ZFS pool properties that should be tested:

```ruby
describe zfs_pool('pool') do
  it { should MATCHER 'value' }
end
```

where:

- `('pool')` is the name of the ZFS pool (eg: `'tank'`)
- `MATCHER` is a valid matcher for this resource
- `'value'` is the value to be tested

## Properties

This Chef InSpec audit resource dynamically exposes all ZFS pool properties available (see: `man zpool` for the list of supported properties).

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test a pool of 'tank'

```ruby
describe zfs_pool('tank') do
  its('autoexpand') { should eq  'off' }
  its('failmode') { should eq  'continue' }
  its('feature@lz4_compress') { should eq  'active' }
  its('health') { should eq  'ONLINE' }
  its('listsnapshots') { should eq  'off' }
  its('readonly') { should eq  'off' }
end
```

## Matchers

{{< readfile file="content/inspec/5.23/reusable/md/inspec_matchers_link.md" >}}
