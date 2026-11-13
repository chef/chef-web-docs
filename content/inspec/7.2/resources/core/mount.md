+++
title = "mount resource"
draft = false

platform = "linux"

[menu.inspec_7_2]
    title = "mount"
    identifier = "resources/core/mount.md mount resource"
    parent = "resources/core"
+++

Use the `mount` Chef InSpec audit resource to test the mount points on FreeBSD and Linux systems.

## Availability

### Install

{{< readfile file="content/inspec/7.2/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

An `mount` resource block declares the synchronization settings that should be tested:

```ruby
describe mount('path') do
  it { should MATCHER 'value' }
end
```

where:

- `('path')` is the path to the mounted directory
- `MATCHER` is a valid matcher for this resource
- `'value'` is the value to be tested

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test a the mount point on '/'

```ruby
describe mount('/') do
  it { should be_mounted }
  its('device') { should eq  '/dev/mapper/VolGroup-lv_root' }
  its('type') { should eq  'ext4' }
  its('options') { should eq ['rw', 'mode=620'] }
end
```

## Matchers

{{< readfile file="content/inspec/7.2/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### be_mounted

The `be_mounted` matcher tests if the file is accessible from the file system:

```ruby
it { should be_mounted }
```

### device

The `device` matcher tests the device from the `fstab` table:

```ruby
its('device') { should eq  '/dev/mapper/VolGroup-lv_root' }
```

### options

The `options` matcher tests the mount options for the file system from the `fstab` table:

```ruby
its('options') { should eq ['rw', 'mode=620'] }
```

### type

The `type` matcher tests the file system type:

```ruby
its('type') { should eq  'ext4' }
```
