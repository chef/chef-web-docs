+++
title = "alicloud_apsaradb_rds_instance Resource"
platform = "alicloud"
draft = false
gh_repo = "inspec-alicloud"

[menu.inspec]
title = "alicloud_apsaradb_rds_instance"
identifier = "inspec/resources/alicloud/alicloud_apsaradb_rds_instance Resource"
parent = "inspec/resources/alicloud"
+++

Use the `alicloud_apsaradb_rds_instance` InSpec audit resource to test detailed properties of an individual ApsaraDB RDS instance.

ApsaraDB RDS supports the MySQL, SQL Server, PostgreSQL, PPAS (highly compatible with Oracle) and MariaDB database engines.

## Syntax

An `alicloud_apsaradb_rds_instance` resource block uses resource parameters to search for an ApsaraDB RDS instance, and then tests that
RDS instance.  If no RDS instances match, no error is raised, but the `exists` matcher will return `false` and all properties will be `nil`.

```ruby
describe alicloud_apsaradb_rds_instance('test-instance-id') do
  it { should exist }
end
```

You can also use hash syntax:

```ruby
describe alicloud_apsaradb_rds_instance(db_instance_id: 'test-instance-id') do
  it { should exist }
end
```

## Parameters

`db_instance_id` _(required)_

: This resource accepts a single parameter, the user-supplied instance identifier.
  This can be passed either as a string if it is the only parameter, or using hash syntax, `db_instance_id: 'value'`.

`region` _(optional)_

: The Alicloud Region ID - see the [Alicloud documentation on Regions and Zones](https://www.alibabacloud.com/help/doc-detail/40654.htm).
  If provided, it must be passed as `region: 'value'`.
  If not provided, the `ALICLOUD_REGION` environment variable will be used.

See also the [Alicloud documentation on ApsaraDB RDS](https://www.alibabacloud.com/help/doc-detail/26092.htm).

## Properties

`instance_id`
: The ID of the database instance, e.g. 'rm-uf6wjk5xxxxxxxxxx'.

`description`
: The display name of the instance, e.g 'test-database'.

`instance_type`
: The role of the instance: 'Primary'/'Readonly'/'Guard'/'Temp'.

`category`
: RDS edition of the instance: 'Basic'/'HighAvailability'/'AlwaysOn'/'Finance'.

`engine`
: The database engine the instance runs, e.g. 'MySQL'.

`engine_version`
: The version of the database engine that the instance runs, e.g. '5.5'.

`allocated_storage`
: The storage capacity of the instance in GB, e.g. 10.

`storage_type`
: One of 'local_ssd'/'ephemeral_ssd'/'cloud_ssd'/'cloud_essd'.

`memory`
: The memory capacity of the instance in MB, e.g. 4096.

`cpus`
: The number of CPUs configured for the instance, e.g. 2.

`instance_class`
: The type of the instance, e.g. 'mysql.n2.medium.1'.

`pay_type`
: The billing method of the instance: 'Postpaid'/'Prepaid'.

`status`
: The status of the instance, e.g. 'Running'/'Rebooting' etc.

`network_type`
: One of 'Classic or 'VPC'.

`net_type`
: Either 'Internet' (connected over the Internet) or 'Intranet' (connected over an internal network).

`vpc_id`
: The ID of the VPC to which the instance belongs.

`in_default_vpc`
: True if the instance is in the default VPC, else false.

`zone_id`
: The ID of the zone to which the instance belongs, e.g. 'cn-hangzhou-a'.

`security_ips`
: The list of IP addresses allowed to access all databases of an instance, e.g. '10.23.12.24/16, 192.168.0.0/24'.

`security_ip_mode`
: The network isolation mode of the instance: 'normal'/'safety'.

## Examples

**Test the engine used with an ApsaraDB RDS instance.**

```ruby
describe alicloud_apsaradb_rds_instance(db_instance_id: 'alicloudrds123') do
  its ('engine')         { should eq 'mysql' }
  its ('engine_version') { should eq '5.6.37' }
end
```

**Test the storage allocated to an RDS instance.**

```ruby
describe alicloud_apsaradb_rds_instance(db_instance_id: 'alicloudrds123') do
  its ('storage_type')      { should eq 'gp2' }
  its ('allocated_storage') { should eq 10 }
end
```

**Test the network accessibility of the RDS instance.**

```ruby
describe alicloud_asparadb_rds_instance(db_instance_id: 'alicloudrds123') do
  its ('in_default_vpc') { should be false }
  its ('net_type') { should eq 'Intranet' }
  its ('security_ips') { should_not eq '' }
  its ('security_ips') { should_not include '0.0.0.0/0' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe alicloud_apsaradb_rds_instance(db_instance_id: 'AnExistingRDS') do
  it { should exist }
end
```

```ruby
describe alicloud_apsaradb_rds_instance(db_instance_id: 'ANonExistentRDS') do
  it { should_not exist }
end
```

### Alicloud Permissions

Your Principal will need the `rds:DescribeDBInstanceAttribute` and `vpc:DescribeVpcs` actions with Effect set to Allow.

You can find documentation at [Use RAM to manage ApsaraDB for RDS permissions](https://www.alibabacloud.com/help/doc-detail/58932.htm#section-rhd-4ll-5gb).
