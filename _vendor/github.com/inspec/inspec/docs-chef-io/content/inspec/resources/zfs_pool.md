+++
title = "zfs_pool resource"
draft = false
platform = "linux"

[menu]
  [menu.inspec]
    title = "zfs_pool"
    identifier = "inspec/resources/os/zfs_pool.md zfs_pool resource"
    parent = "inspec/resources/os"
+++

[\[edit on GitHub\]](https://github.com/inspec/inspec/blob/master/docs-chef-io/content/inspec/resources/zfs_pool.md)

Use the `zfs_pool` Chef InSpec audit resource to test the ZFS pools on FreeBSD systems.

## Availability

### Installation

This resource is distributed along with Chef InSpec itself. You can use it automatically.

### Version

This resource first became available in v1.16.0 of InSpec.

## Syntax

A `zfs_pool` resource block declares the ZFS pool properties that should be tested:

    describe zfs_pool('pool') do
      it { should MATCHER 'value' }
    end

where:

- `('pool')` is the name of the ZFS pool (eg: `'tank'`)
- `MATCHER` is a valid matcher for this resource
- `'value'` is the value to be tested

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test a pool of 'tank'

    describe zfs_pool('tank') do
      its('autoexpand') { should eq  'off' }
      its('failmode') { should eq  'continue' }
      its('feature@lz4_compress') { should eq  'active' }
      its('health') { should eq  'ONLINE' }
      its('listsnapshots') { should eq  'off' }
      its('readonly') { should eq  'off' }
    end

## Matchers

This Chef InSpec audit resource dynamically exposes all ZFS pool properties available (see: `man zpool` for the list of supported properties). For a full list of available matchers, please visit our [matchers page](/inspec/matchers/).
