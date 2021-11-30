+++
title = "alicloud_ecs_instances Resource"
platform = "alicloud"
draft = false
gh_repo = "inspec-alicloud"

[menu.inspec]
title = "alicloud_ecs_instances"
identifier = "inspec/resources/alicloud/alicloud_ecs_instances Resource"
parent = "inspec/resources/alicloud"
+++

Use the `alicloud_ecs_instances` InSpec audit resource to test properties of a collection of Alicloud ECS instances.

## Syntax

An `alicloud_ecs_instances` resource block declares the tests a collection of Alicloud ECS instances.

```ruby
describe alicloud_ecs_instances
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`instance_ids`
: The unique instance IDs of the returned ECS instances.

`instance_names`
: The names of the instances.

`host_names`
: The host names of the instances.

`descriptions`
: The descriptions of the instances.

`memory`
: The memory sizes of the instances, in MiB.

`cpus`
: The numbers of vCPUs the instances have.

`cpu_options`
: The CPU options of the instances.

`gpu_specs`
: The categories of GPU for the instance types.

`image_ids`
: The IDs of the images that the instances are running.

`instance_types`
: The instance types of the instances, e.g. 'ecs.g5.large'.

`instance_type_families`
: The instance families of the instances.

`io_optimized`
: Booleans that specify whether the instances are I/O optimized.

`os_names`
: The names of the operating systems for the instances.

`os_types`
: The types of operating systems for the instances: 'windows' or 'linux'.

`instance_network_types`
: The network types of the instances: 'Classic' or 'VPC'.

`public_ip_addresses`
: The public IP addresses of the instances.

`inner_ip_addresses`
: The internal IP addresses of the instances.

`eip_addresses`
: The Elastic IP addresses associated with the instances.

`network_interfaces`
: The ENIs bound to the instances.

`vlan_ids`
: The virtual local area network (VLAN) of the instance.

`vpc_attributes`
: The VPC attributes of the instance.

`internet_max_bandwidth_out`
: The maximum outbound public bandwidth, in Mbit/s.

`internet_max_bandwidth_in`
: The maximum outbound inbound bandwidth, in Mbit/s.

`instance_charge_types`
: The billing method of the instance: 'Prepaid' or 'Postpaid'.

`internet_charge_types`
: The billing method of the EIP: 'PayByBandwidth' or 'PayByTraffic'.

`spot_price_limits`
: Maximum hourly prices for the instances, accurate to 3 decimal places.

`spot_strategies`
: The bidding policies for the preemptible instances: 'NoSpot'/'SpotWithPriceLimit'/'SpotAsPriceGo'.

`sale_cycles`
: The billing cycles of the instances, e.g. 'month'.

`creation_times`
: The time when the instance was created, e.g. '2020-12-10T04:04Z'.

`start_times`
: The times when the instances were started.

`expired_times`
: The expiration times of the instances.

`auto_release_times`
: The automatic release times of pay-as-you-go instances.

`statuses`
: The current state of the instances, for example 'running'.

`stopped_modes`
: Indicates whether the instances continue to be billed after they are stopped: 'KeepCharging'/'StopCharging'/'Not-applicable'.

`metadata_options`
: The metadata options of the instances.

`zone_ids`
: The zone ID of the instances.

`cluster_ids`
: The ID of the cluster to which the instance belongs.

`security_group_ids`
: The security group ids associated with the instance.

`deployment_set_ids`
: The IDs of the deployment sets of the instances.

`serial_numbers`
: The serial number of the instances.

`dedicated_instance_attributes`
: The attributes of the instances on dedicated hosts.

`devices_available`
: Boolean value indicating whether data disks can be attached to the instances.

`deletion_protection`
: Boolean value which indicates whether instances can be deleted.

`ram_roles`
: The RAM roles attached to the instances.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

## Examples

**Ensure that you have less than 100 ECS instances.**

```ruby
describe alicloud_ecs_instances do
  its('instance_ids.count') { should be < 100 }
end
```

**Ensure that no instances have deletion protection turned off.**

```ruby
describe alicloud_ecs_instances.where(deletion_protection: false) do
  it { should not exist }
end
```

**Ensure that instances have exactly one RAM role attached.**

```ruby
describe(alicloud_ecs_instances.where { ram_role.count != 1 }) do
  it { should not exist }
end
```

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe alicloud_ecs_instances do
  it { should exist }
end
```

```ruby
describe alicloud_ecs_instances do
  it { should_not exist }
end
```

### Alicloud Permissions

Your Principal will need the `ecs:DescribeInstances` and `ecs:DescribeInstanceRamRole` actions with Effect set to Allow.

See the [Alibaba Cloud Resource Access Management documentation](https://www.alibabacloud.com/help/doc-detail/57445.htm?spm=a2c63.p38356.b99.12.51ef1b28W18VZd) and
[documentation on authentication rules for ECS APIs](https://partners-intl.aliyun.com/help/doc-detail/25497.htm?spm=a2c63.p38356.b99.657.7b9f3481VdEA4g).
