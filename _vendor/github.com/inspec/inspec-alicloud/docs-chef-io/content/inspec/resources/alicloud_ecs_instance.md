+++
title = "alicloud_ecs_instance Resource"
platform = "alicloud"
draft = false
gh_repo = "inspec-alicloud"

[menu.inspec]
title = "alicloud_ecs_instance"
identifier = "inspec/resources/alicloud/alicloud_ecs_instance Resource"
parent = "inspec/resources/alicloud"
+++

Use the `alicloud_ecs_instance` InSpec audit resource to test properties of a single Alicloud ECS instance.

## Syntax

An `alicloud_ecs_instance` resource block declares the tests for a single Alicloud ECS instance by instance id.

```ruby
describe alicloud_ecs_instance('i-01a2349e94458a507') do
  it { should exist }
end
```

## Parameters

`instance_id` _(required)_

: The ID of the ECS instance. This can be passed either as a string or as an `instance_id: 'value'` key-value entry in a hash.

: ```ruby
  describe alicloud_ecs_instance(instance_id: 'i-01a2349e94458a507') do
    it { should exist }
  end
  ```

See also the [documentation on Alicloud ECS instances](https://www.alibabacloud.com/help/doc-detail/25374.htm?spm=a2c63.l28256.b99.60.36277453JrAX8s).

## Properties

`instance_id`
: The unique instance ID of the ECS instance.

`instance_name`
: The name of the instance.

`host_name`
: The host name of the instance.

`description`
: The description of the instance.

`memory`
: The memory size of the instance, in MiB.

`cpu`
: The number of vCPUs.

`instance_network_type`
: The network type of the instance: 'Classic' or 'VPC'.

`public_ip_address`
: The public IP address of the instance.

`eip_address`
: The Elastic IP address associated with the instance.

`inner_ip_address`
: The internal IP address of the classic network-type instance.

`expired_time`
: The expiration time of the instance, e.g. '2020-12-10T04:04Z'.

`image_id`
: The ID of the image that the instance is running.

`instance_type`
: The instance type of the instance, e.g. 'ecs.g5.large'.

`vlan_id`
: The virtual local area network (VLAN) of the instance.

`vpc_attributes`
: The VPC attributes of the instance.

`status`
: The current state of the ECS Instance, for example 'running'.

`io_optimized`
: Boolean that specifies whether the instance is I/O optimized.

`zone_id`
: The zone ID of the instance.

`cluster_id`
: The ID of the cluster to which the instance belongs.

`stopped_mode`
: Indicates whether the instance continues to be billed after it is stopped: 'KeepCharging'/'StopCharging'/'Not-applicable'.

`dedicated_host_attribute`
: Details about dedicated hosts: an array consiting of the DedicatedHostClusterId, DedicatedHostId, and DedicatedHostName parameters.

`security_group_ids`
: The security group ids associated with the instance.

`operation_locks`
: The reasons why the instance was locked.

`instance_charge_type`
: The billing method of the instance: 'Prepaid' or 'Postpaid'.

`internet_charge_type`
: The billing method of the EIP: 'PayByBandwidth' or 'PayByTraffic'.

`internet_max_bandwidth_\out`
: The maximum outbound public bandwidth, in Mbit/s.

`internet_max_bandwidth_in`
: The maximum outbound inbound bandwidth, in Mbit/s.

`serial_number`
: The serial number of the instance.

`creation_time`
: The time when the instance was created, e.g. '2020-12-10T04:04Z'.

`region_id`
: The region ID of the instance.

`credit_specification`
: The performance mode of the burstable instance: 'Standard' or 'Unlimited'.

`deletion_protection`
: Boolean value which indicates whether you can delete the instance.

`ram_roles`
: The RAM roles attached to the instance.

## Examples

**Test that an ECS instance is running, it is using the correct image ID, and its deletion protection is turned on.**

```ruby
describe alicloud_ecs_instance('i-090c29e4f4c165b74') do
  it { should be_running }
  its('image_id') { should eq 'ubuntu_18_04_64_20G_alibase_20190624.vhd' }
  its('deletion_protection') { should be true }
end
```

**Test that an ECS instance has exactly one RAM role attached.**

```ruby
describe alicloud_ecs_instance('i-090c29e4f4c165b74') do
  its('ram_roles.count') { should eq 1 }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
it { should exist }
```

```ruby
it { should_not exist }
```

### Alicloud Permissions

Your Principal will need the `ecs:DescribeInstances`, `ecs:DescribeInstanceAttribute` and `ecs:DescribeInstanceRamRole` actions with Effect set to Allow.

{{< readfile file="content/inspec/resources/reusable/md/alibaba_access_management_doc.md" >}}
{{< readfile file="content/inspec/resources/reusable/md/alibaba_authentication_ecs_api_doc.md" >}}
