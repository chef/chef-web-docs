+++
title = "alicloud_apsaradb_rds_instances Resource"
platform = "alicloud"
draft = false
gh_repo = "inspec-alicloud"

[menu.inspec]
title = "alicloud_apsaradb_rds_instances"
identifier = "inspec/resources/alicloud/alicloud_apsaradb_rds_instances Resource"
parent = "inspec/resources/alicloud"
+++

Use the `alicloud_apsaradb_rds_instances` InSpec audit resource to test properties of a collection of ApsaraDB RDS instances.

ApsaraDB RDS supports the MySQL, SQL Server, PostgreSQL, PPAS (highly compatible with Oracle) and MariaDB database engines.

## Syntax

Ensure you have exactly 3 instances.

```ruby
describe alicloud_apsaradb_rds_instances do
  its('db_instance_ids.count') { should cmp 3 }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`db_instance_ids`
: The unique IDs of the ApsaraDB RDS instances returned.

`descriptions`
: The display names of the returned instances.

`resource_groups`
: The IDs of the resource groups to which read-only instances belong.

`net_types`
: The network types of the returned instances: one of 'Internet' or 'Intranet'.

`instance_types`
: The roles of the returned instances: 'Primary'/'Readonly'/'Guard'/'Temp'.

`multiple_zone_deployments`
: Boolean values indicating whether the instances are deployed in multiple zones (MutriORsignle API call).

`network_types`
: The network types of the returned instances: one of 'Classic' or 'VPC'.

`read_only_instance_ids`
: Lists of read-only instances attached to instances returned that are primary instances.

`engines`
: The database engines the instances run, e.g. 'MySQL'.

`engine_versions`
: The versions of the database engine that the instances run.

`statuses`
: The status of the instances, e.g. 'Running'/'Rebooting' etc.

`zone_ids`
: The IDs of the zones to which the instances belong.

`instance_classes`
: The instance classes of the returned instances, e.g. 'mysql.n2.medium.1'.

`create_times`
: The times when the returned instances were created.

`vswitch_ids`
: The IDs of the vSwitches associated with the VPCs to which the returned instances belong.

`pay_types`
: The billing methods of the returned instances: 'Postpaid'/'Prepaid'.

`lock_modes`
: The lock status of the returned instances: 'Unlock'/'ManualLock'/'LockByExpiration'/'LockByRestoration'/'LockByDiskQuota'/'Released'.

`storage_types`
: The types of disk storage of the returned instances: 'local_ssd'/'ephemeral_ssd'/'cloud_ssd'/'cloud_essd'.

`vpc_ids`
: The IDs of the VPCs to which the instances belong.

`connection_modes`
: The connection modes of the returned instances: 'Standard'/'Safe'.

`vpc_cloud_instance_ids`
: The IDs of the read-only instances returned, that reside in VPCs.

`region_ids`
: The region IDs of the returned instances.

`expire_times`
: The expiration times of the returned instances.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

## Examples

**Ensure a specific instance exists.**

```ruby
describe alicloud_apsaradb_rds_instances do
  its('db_instance_ids') { should include 'rm-a1b2c3d4e5f6' }
end
```

**Use the InSpec resource to request the IDs of all ApsaraDB RDS instances, then test in-depth using `alicloud_apsaradb_rds_instance` to ensure all instances have the expected network security settings.**

```ruby
alicloud_apsaradb_rds_instances.db_instance_ids.each do |db_instance_id|
  describe alicloud_apsaradb_rds_instance(db_instance_id) do
    its('in_default_vpc') { should be false }
    its('security_ips') { should_not cmp '' }
    its('security_ips') { should_not include '0.0.0.0/0' }
  end
end
```

## Matchers

{{% inspec_matchers_link %}}

### exist

The control will pass if the describe returns at least one result.

```ruby
describe alicloud_apsaradb_rds_instances do
  it { should exist }
end
```

Use `should_not` to test the entity should not exist.

```ruby
describe alicloud_apsaradb_rds_instances do
  it { should_not exist }
end
```

### Alicloud Permissions

{{% alicloud_principal_action action="rds:DescribeDBInstances" %}}

You can find documentation at [Use RAM to manage ApsaraDB for RDS permissions](https://www.alibabacloud.com/help/doc-detail/58932.htm#section-rhd-4ll-5gb).
