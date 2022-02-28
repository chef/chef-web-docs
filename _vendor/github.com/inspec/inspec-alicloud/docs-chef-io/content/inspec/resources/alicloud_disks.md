+++
title = "alicloud_disks Resource"
platform = "alicloud"
draft = false
gh_repo = "inspec-alicloud"

[menu.inspec]
title = "alicloud_disks"
identifier = "inspec/resources/alicloud/alicloud_disks Resource"
parent = "inspec/resources/alicloud"
+++

Use the `alicloud_disks` InSpec audit resource to test properties of a collection of Alicloud EBS cloud disks.

Cloud disks are persistent block storage volumes for use with Alicloud ECS instances in the Alibaba Cloud.

## Syntax

 Ensure you have exactly 3 cloud disks

```ruby
describe alicloud_disks do
  its('ids.count') { should cmp 3 }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: The IDs of the cloud disks.

`names`
: The names of each cloud disk.

`descriptions`
: The description of each cloud disk.

`sizes`
: The size of each cloud disk, in GiBs.

`categories`
: The category of each cloud disk. Valid values: cloud, cloud_efficiency, cloud_ssd, cloud_essd, local_ssd_pro, local_hdd_pro, ephemeral, ephemeral_ssd.

`encrypted_disks`
: Boolean that indicates whether each cloud disk was encrypted.

`kms_key_ids`
: The ID of the KMS key used by each cloud disk.

`enable_auto_snapshot`
: Boolean that indicates whether the automatic snapshot policy feature was enabled for each cloud disk.

`delete_auto_snapshot`
: Boolean that indicates whether automatic snapshots of the cloud disk are deleted when each disk is released.

`delete_with_instance`
: Boolean that indicates whether each cloud disk is released when its associated instance is released.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

## Examples

**Ensure a specific cloud disk exists.**

```ruby
describe alicloud_disks do
  its('ids') { should include 'd-a1b2c3d4e5f6g7h8' }
end
```

**Use the InSpec resource to request the IDs of all cloud disks, then test in-depth using `alicloud_disk` to ensure all volumes are encrypted, have a sensible size, and have snapshots enabled.**

```ruby
alicloud_disks.ids.each do |disk_id|
  describe alicloud_disk(disk_id: disk_id) do
    it                          { should be_encrypted }
    its('size')                 { should be > 10 }
    its('enable_auto_snapshot') { should be true }
  end
end
```

**Another way to check that enable auto snapshot is turned on for all disks.**

```ruby
describe alicloud_disks.where(enable_auto_snapshot: false) do
  it { should_not exist }
  its('ids') { should cmp [] }
end
```

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe alicloud_ebs_volumes do
  it { should exist }
end
```

```ruby
describe alicloud_ebs_volumes do
  it { should_not exist }
end
```

### Alicloud Permissions

Your Principal will need the `ecs:DescribeDisks` action with Effect set to Allow.

See the [Alibaba Cloud Resource Access Management documentation](https://www.alibabacloud.com/help/doc-detail/57445.htm?spm=a2c63.p38356.b99.12.51ef1b28W18VZd) and
[documentation on authentication rules for ECS APIs](https://partners-intl.aliyun.com/help/doc-detail/25497.htm?spm=a2c63.p38356.b99.657.7b9f3481VdEA4g).
