+++
title = "alicloud_disk Resource"
platform = "alicloud"
draft = false
gh_repo = "inspec-alicloud"

[menu.inspec]
title = "alicloud_disk"
identifier = "inspec/resources/alicloud/alicloud_disk Resource"
parent = "inspec/resources/alicloud"
+++

Use the `alicloud_disk` InSpec audit resource to test properties of a single Alicloud Elastic Block Storage (EBS) cloud disk.

## Syntax

Ensure a cloud disk exists

```ruby
describe alicloud_disk('d-d7ohfbhzs8cli0iacz7j') do
  it { should exist }
end
```

You may also use hash syntax to pass the disk name

```ruby
describe alicloud_disk(disk_name: 'd-vol') do
  it { should exist }
end
```

## Parameters

This resource accepts a single parameter, either the cloud disk ID or name. Only one of these must be provided.

`disk_id` _(required if `disk_name` not provided)_

: The disk ID which uniquely identifies the disk.  
  This can be passed as either a string, a `disk_id: 'value'` key-value entry in a hash, or an `id: 'value'` key-value entry in a hash.  
  (`id` is an alias for `disk_id`).

`disk_name` _(required if `disk_id` not provided)_

: The disk name which uniquely identifies the disk.  
  This must be passed as a `disk_name: 'value'` key-value entry in a hash, or a `name: 'value'` key-value entry in a hash.  
  (`name` is an alias for `disk_name`).

See also the [Alicloud documentation on cloud disks](https://www.alibabacloud.com/help/doc-detail/25383.htm).

## Properties

`id`
: The ID of the cloud disk.

`name`
: The name of the cloud disk.

`description`
: The description of the cloud disk.

`size`
: The size of the cloud disk, in GiBs.

`category`
: The category of the cloud disk. Valid values: cloud, cloud_efficiency, cloud_ssd, cloud_essd, local_ssd_pro, local_hdd_pro, ephemeral, ephemeral_ssd.

`encrypted`
: Boolean that indicates whether the cloud disk was encrypted.

`kms_key_id`
: The ID of the KMS key used by the cloud disk.

`enable_auto_snapshot`
: Boolean that indicates whether the automatic snapshot policy feature was enabled for the cloud disk.

`delete_auto_snapshot`
: Boolean that indicates whether automatic snapshots of the cloud disk are deleted when the disk is released.

`delete_with_instance`
: Boolean that indicates whether the cloud disk is released when its associated instance is released.

## Examples

**Test that a cloud disk does not exist.**

```ruby
describe alicloud_disk(disk_name: 'data_vol') do
  it { should_not exist }
end
```

**Test that a cloud disk is encrypted.**

```ruby
describe alicloud_disk(disk_name: 'secure_data_vol') do
  it { should be_encrypted }
end
```

**Test that a cloud disk has the correct size.**

```ruby
describe alicloud_disk(name: 'data_vol') do
  its('size') { should cmp 32 }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe alicloud_disk(name: 'data_vol') do
  it { should exist }
end
```

```ruby
describe alicloud_disk(name: 'data_vol') do
  it { should_not exist }
end
```

#### be_encrypted

The `be_encrypted` matcher tests if the described cloud disk is encrypted.

```ruby
it { should be_encrypted }
```

### Alicloud Permissions

Your Principal will need the `ecs:DescribeDisks` action with Effect set to Allow.

See the [Alibaba Cloud Resource Access Management documentation](https://www.alibabacloud.com/help/doc-detail/57445.htm?spm=a2c63.p38356.b99.12.51ef1b28W18VZd) and
[documentation on authentication rules for ECS APIs](https://partners-intl.aliyun.com/help/doc-detail/25497.htm?spm=a2c63.p38356.b99.657.7b9f3481VdEA4g).
