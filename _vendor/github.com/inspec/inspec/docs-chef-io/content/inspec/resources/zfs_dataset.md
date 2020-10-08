+++
title = "zfs_dataset resource"
draft = false
platform = "linux"

[menu]
  [menu.inspec]
    title = "zfs_dataset"
    identifier = "inspec/resources/os/zfs_dataset.md zfs_dataset resource"
    parent = "inspec/resources/os"
+++

[\[edit on GitHub\]](https://github.com/inspec/inspec/blob/master/docs-chef-io/content/inspec/resources/zfs_dataset.md)

Use the `zfs_dataset` Chef InSpec audit resource to test the ZFS datasets on FreeBSD systems.

## Availability

### Installation

This resource is distributed along with Chef InSpec itself. You can use it automatically.

### Version

This resource first became available in v1.16.0 of InSpec.

## Syntax

A `zfs_dataset` resource block declares the ZFS dataset properties that should be tested:

    describe zfs_dataset('dataset') do
      it { should MATCHER 'value' }
    end

where

- `('dataset')` is the name of the ZFS dataset (eg: `'tank/tmp'`)
- `MATCHER` is a valid matcher for this resource
- `'value'` is the value to be tested

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test a dataset of 'tank/tmp'

    describe zfs_dataset('tank/tmp') do
      it { should be_mounted }
      its('atime') { should eq  'on' }
      its('compression') { should eq  'lz4' }
      its('exec') { should eq  'off' }
      its('readonly') { should eq  'off' }
      its('setuid') { should eq  'off' }
    end

## Matchers

This Chef InSpec audit resource has the matchers listed below, in addition to dynamically exposing all ZFS dataset properties available (see: `man zfs` for the list of supported properties). For a full list of available matchers, please visit our [matchers page](/inspec/matchers/).

### be_mounted

The `be_mounted` matcher tests if the dataset is accessible from the file system:

    it { should be_mounted }
