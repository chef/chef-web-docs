+++
title = "AWS Driver Resources"
description = "DESCRIPTION"
draft = false

aliases = "/provisioning_aws.html"


  
    
    
    
    
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/provisioning_aws.rst)

<meta name="robots" content="noindex">

{{% EOL_provisioning %}}

{{% provisioning_summary %}}

{{% resources_provisioning %}}

The following driver-specific resources are available for Amazon Web
Services (AWS) and Chef Provisioning:

-   `aws_auto_scaling_group`
-   `aws_cache_cluster`
-   `aws_cache_replication_group`
-   `aws_cache_subnet_group`
-   `aws_cloudsearch_domain`
-   `aws_cloudwatch_alarm`
-   `aws_dhcp_options`
-   `aws_ebs_volume`
-   `aws_eip_address`
-   `aws_elasticsearch_domain`
-   `aws_iam_instance_profile`
-   `aws_iam_role`
-   `aws_image`
-   `aws_instance`
-   `aws_internet_gateway`
-   `aws_key_pair`
-   `aws_launch_configuration`
-   `aws_load_balancer`
-   `aws_nat_gateway`
-   `aws_network_acl`
-   `aws_network_interface`
-   `aws_rds_instance`
-   `aws_rds_parameter_group`
-   `aws_rds_subnet_group`
-   `aws_route_table`
-   `aws_route53_hosted_zone`
-   `aws_route53_record_set`
-   `aws_s3_bucket`
-   `aws_security_group`
-   `aws_server_certificate`
-   `aws_sns_topic`
-   `aws_sqs_queue`
-   `aws_subnet`
-   `aws_vpc`
-   `aws_vpc_peering_connection`

Common Actions
==============

Every Chef Provisioning Amazon Web Services (AWS) driver-specific
resource has the following actions:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Action</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>:create</code></td>
<td>Default. Use to create the specified object in Amazon Web Services (AWS).</td>
</tr>
<tr class="even">
<td><code>:destroy</code></td>
<td>Use to destroy the specified object in Amazon Web Services (AWS).</td>
</tr>
<tr class="odd">
<td><code>:purge</code></td>
<td>Use to remove chargable items related to an object in Amazon Web Services (AWS).</td>
</tr>
<tr class="even">
<td><code>:nothing</code></td>
<td>Use to do nothing.</td>
</tr>
</tbody>
</table>

aws_auto_scaling_group
=========================

The `aws_auto_scaling_group` resource is a driver-specific resource used
by Chef Provisioning. Use the `aws_auto_scaling_group` resource to
manage auto scaling groups for Amazon EC2 instances. Auto Scaling
ensures that the correct number of Amazon EC2 instances are available.
Each auto scaling group is set to a minimum size, along with a maximum
that a group does not exceed.

Syntax
------

A `aws_auto_scaling_group` resource block declares auto scaling groups
used for Amazon EC2 instances. For example:

``` ruby
aws_auto_scaling_group 'name' do
  availability_zones ['us-west-1a']
  desired_capacity 2
  min_size 1
  max_size 3
  launch_configuration 'ref-launch-configuration'
  load_balancers 'ref-load-balancer'
  options subnets: 'ref-subnet'
end
```

The full syntax for all of the properties that are available to the
`aws_auto_scaling_group` resource is:

``` ruby
aws_auto_scaling_group 'name' do
  availability_zones            Array
  desired_capacity              Integer
  min_size                      Integer
  max_size                      Integer
  launch_configuration          String
  load_balancers                Array
  options                       Hash
end
```

where

-   `aws_auto_scaling_group` is the resource
-   `name` is the name of the resource block and also the name of the
    auto scaling group in Amazon EC2
-   `availability_zones`, `desired_capacity`, `max_size`, `min_size`,
    `launch_configuration`, `load_balancers`, and `options` are
    properties of this resource, with the Ruby type shown. See
    "Properties" section below for more information about all of the
    properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>availability_zones</code></p></td>
<td><p><strong>Ruby Type:</strong> Array</p>
<p>Use to specify an array of availability zones to be associated with this auto scaling group. For example: <code>['us-west-1a', 'us-west-1b', 'us-west-1c']</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="odd">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="even">
<td><p><code>desired_capacity</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer</p>
<p>Use to specify the desired number of machines in the auto scaling group. For example: <code>2</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>launch_configuration</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of a launch configuration.</p></td>
</tr>
<tr class="odd">
<td><p><code>load_balancers</code></p></td>
<td><p><strong>Ruby Type:</strong> Array</p>
<p>Use to specify the name of a load balancer.</p></td>
</tr>
<tr class="even">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>max_size</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer</p>
<p>Use to specify the maximum number of machines in the auto scaling group. For example: <code>5</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>min_size</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer</p>
<p>Use to specify the minimim number of machines in the auto scaling group. For example: <code>1</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the auto scaling group.</p></td>
</tr>
<tr class="even">
<td><p><code>options</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Use to specify a Hash of options to be applied to this auto scaling group.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Define an auto scaling group**

{{% resource_provisioning_aws_launch_config_auto_scale %}}

**Destroy auto scaling group and associated launch configuration**

{{% resource_provisioning_aws_launch_config_auto_scale_destroy %}}

aws_cache_cluster
===================

The `aws_cache_cluster` resource is a driver-specific resource used by
Chef Provisioning. Use the `aws_cache_cluster` resource to manage [cache
clusters](http://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/WhatIs.html)
in Amazon ElastiCache.

Syntax
------

A `aws_cache_cluster` resource block manages cache clusters in Amazon
ElastiCache. For example:

``` ruby
aws_cache_cluster 'name' do
  az_mode 'single-az'
  engine 'name'
  engine_version '1.2.3'
  node_type 'cache.m3.large'
  number_nodes 10
  preferred_availability_zones [
    'PreferredAvailabilityZones.member.1=us-east-1a',
    'PreferredAvailabilityZones.member.2=us-east-1c',
    'PreferredAvailabilityZones.member.3=us-east-1d'
  ]
  subnet_group_name 'subnet-1'
end
```

The full syntax for all of the properties that are available to the
`aws_cache_cluster` resource is:

``` ruby
aws_cache_cluster 'name' do
  az_mode                       String
  cluster_name                  String  # defaults to 'name' if not specified
  engine                        String
  engine_version                String
  node_type                     String
  number_nodes                  Integer
  preferred_availability_zone   String
  preferred_availability_zones  String, Array
  security_groups               String, Array
  subnet_group_name             String
end
```

where

-   `aws_cache_cluster` is the resource
-   `name` is the name of the resource block
-   `az_mode`, `engine`, `engine_version`, `node_type`, `number_nodes`,
    `preferred_availability_zones`, and `subnet_group_name` are
    properties of this resource, with the Ruby type shown. See
    "Properties" section below for more information about all of the
    properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="even">
<td><p><code>az_mode</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify if nodes in this group are created in a single availability zone or across multiple availability zones. This property is supported only for Memcached cache clusters. Possible values: <code>single-az</code>, <code>cross-az</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="even">
<td><p><code>cluster_name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the cache cluster.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>engine</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the cache engine for the cache cluster.</p></td>
</tr>
<tr class="odd">
<td><p><code>engine_version</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the version number of the cache engine.</p></td>
</tr>
<tr class="even">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>node_type</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the compute and memory capacity of the nodes in the cache replication group. The possible values depend on the type of nodes: general purpose volumes, provisioned volumes, or magnetic volumes. For example: <code>cache.t2.small</code>, <code>cache.r3.2xlarge</code>, or <code>cache.m3.large</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>number_nodes</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer</p>
<p>Use to specify the initial number of cache nodes for a cache cluster. If Memcached is available, valid values are between <code>1</code> and <code>20</code>. Default value: <code>1</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>preferred_availability_zone</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the preferred availability zone for this cache cluster. Use this property <strong>or</strong> use <code>preferred_availability_zones</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>preferred_availability_zones</code></p></td>
<td><p><strong>Ruby Type:</strong> String, Array</p>
<p>Use to specify an array of identifiers for Amazon EC2 availability zones available to this cache cluster. Use this property <strong>or</strong> use <code>preferred_availability_zone</code>. For example:</p>
<div class="sourceCode" id="cb1"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb1-1"><a href="#cb1-1"></a>preferred_availability_zones [</span>
<span id="cb1-2"><a href="#cb1-2"></a>  <span class="st">&#39;PreferredAvailabilityZones.member.1=us-east-1a&#39;</span>,</span>
<span id="cb1-3"><a href="#cb1-3"></a>  <span class="st">&#39;PreferredAvailabilityZones.member.2=us-east-1c&#39;</span>,</span>
<span id="cb1-4"><a href="#cb1-4"></a>  <span class="st">&#39;PreferredAvailabilityZones.member.3=us-east-1d&#39;</span></span>
<span id="cb1-5"><a href="#cb1-5"></a>]</span></code></pre></div></td>
</tr>
<tr class="odd">
<td><p><code>security_groups</code></p></td>
<td><p><strong>Ruby Type:</strong> String, Array, AwsSecurityGroup, AWS::EC2::SecurityGroup</p>
<p>Use to specify an array of identifiers for Amazon Virtual Private Cloud (VPC) security groups that are associated with this cache replication group.</p></td>
</tr>
<tr class="even">
<td><p><code>subnet_group_name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the cache subnet group that to use with this cache replication group.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Define a VPC, subnets, and security group for a cache cluster**

{{% resource_provisioning_aws_cache_cluster_create %}}

aws_cache_replication_group
==============================

The `aws_cache_replication_group` resource is a driver-specific resource
used by Chef Provisioning. Use the `aws_cache_replication_group`
resource to manage [replication groups for cache
clusters](http://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/WhatIs.html)
in Amazon ElastiCache. A replication group is a collection of nodes,
with a primary read/write cluster and up to five secondary, read-only
clusters.

Syntax
------

A `aws_cache_replication_group` resource block manages replication
groups for cache clusters in Amazon Web Services (AWS). For example:

``` ruby
aws_cache_replication_group 'name' do
  automatic_failover true
  engine 'name'
  engine_version '1.2.3'
  node_type 'cache.m3.large'
  number_cache_clusters 3
  preferred_availability_zones [
    'PreferredAvailabilityZones.member.1=us-east-1a',
    'PreferredAvailabilityZones.member.2=us-east-1c',
    'PreferredAvailabilityZones.member.3=us-east-1d'
  ]
  subnet_group_name 'subnet-1'
end
```

The full syntax for all of the properties that are available to the
`aws_cache_replication_group` resource is:

``` ruby
aws_cache_replication_group 'name' do
  az_mode                       String
  automatic_failover            true, false
  description                   String
  engine                        String
  engine_version                String
  group_name                    String  # defaults to 'name' if not specified
  node_type                     String
  number_cache_clusters         Integer
  preferred_availability_zones  String, Array
  security_groups               String, Array
  subnet_group_name             String
end
```

where

-   `aws_cache_replication_group` is the resource
-   `name` is the name of the resource block
-   `automatic_failover`, `engine`, `engine_version`, `node_type`,
    `number_cache_clusters`, `preferred_availability_zones`, and
    `subnet_group_name` are properties of this resource, with the Ruby
    type shown. See "Properties" section below for more information
    about all of the properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>automatic_failover</code></p></td>
<td><p><strong>Ruby Type:</strong> true, false</p>
<p>Use to specify if a read-only replica is automatically promoted to read/write primary if the existing primary fails. Set to <code>true</code> to enable automatic failover for this cache replication group.</p></td>
</tr>
<tr class="even">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="odd">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="even">
<td><p><code>description</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the description for a cache replication group.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>engine</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the cache engine used for the cache clusters in this cache replication group.</p></td>
</tr>
<tr class="odd">
<td><p><code>engine_version</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the version number of the cache engine used for the cache clusters in this cache replication group.</p></td>
</tr>
<tr class="even">
<td><p><code>group_name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the cache parameter group to be associated with this cache replication group. If this value is not specified, the default cache parameter group for the specified <code>engine</code> will be used.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>node_type</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the compute and memory capacity of the nodes in the cache replication group. The possible values depend on the type of nodes: general purpose volumes, provisioned volumes, or magnetic volumes. For example: <code>cache.t2.small</code>, <code>cache.r3.2xlarge</code>, or <code>cache.m3.large</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>number_cache_clusters</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer</p>
<p>Use to specify the initial number of cache clusters for a cache replication group. If <code>automatic_failover</code> is <code>true</code>, this number must be at least <code>2</code>. Maximum value: <code>6</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>preferred_availability_zones</code></p></td>
<td><p><strong>Ruby Type:</strong> String, Array</p>
<p>Use to specify an array of identifiers for Amazon EC2 availability zones into which the cache clusters associated with this cache replication group will be created. For example:</p>
<div class="sourceCode" id="cb1"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb1-1"><a href="#cb1-1"></a>preferred_availability_zones [</span>
<span id="cb1-2"><a href="#cb1-2"></a>  <span class="st">&#39;PreferredAvailabilityZones.member.1=us-east-1a&#39;</span>,</span>
<span id="cb1-3"><a href="#cb1-3"></a>  <span class="st">&#39;PreferredAvailabilityZones.member.2=us-east-1c&#39;</span>,</span>
<span id="cb1-4"><a href="#cb1-4"></a>  <span class="st">&#39;PreferredAvailabilityZones.member.3=us-east-1d&#39;</span></span>
<span id="cb1-5"><a href="#cb1-5"></a>]</span></code></pre></div></td>
</tr>
<tr class="odd">
<td><p><code>security_groups</code></p></td>
<td><p><strong>Ruby Type:</strong> String, Array, AwsSecurityGroup, AWS::EC2::SecurityGroup</p>
<p>Use to specify an array of identifiers for Amazon Virtual Private Cloud (VPC) security groups that are associated with this cache replication group.</p></td>
</tr>
<tr class="even">
<td><p><code>subnet_group_name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the cache subnet group that to use with this cache replication group.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Manage replication groups for cache clusters in Amazon Web Services
(AWS)**

``` ruby
aws_cache_replication_group 'name' do
  automatic_failover true
  engine 'name'
  engine_version '1.2.3'
  node_type 'cache.m3.large'
  number_cache_clusters 3
  preferred_availability_zones [
    'PreferredAvailabilityZones.member.1=us-east-1a',
    'PreferredAvailabilityZones.member.2=us-east-1c',
    'PreferredAvailabilityZones.member.3=us-east-1d'
  ]
  subnet_group_name 'subnet-1'
end
```

aws_cache_subnet_group
=========================

The `aws_cache_subnet_group` resource is a driver-specific resource used
by Chef Provisioning. Use the `aws_cache_subnet_group` resource to
manage a [cache subnet
group](http://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/ManagingVPC.CreatingSubnetGroup.html),
which is a collection of subnets that may be designated for cache
clusters in Amazon Virtual Private Cloud (VPC).

Syntax
------

A `aws_cache_subnet_group` resource block manages cache subnet groups in
Amazon Web Services (AWS). For example:

``` ruby
aws_cache_subnet_group 'name' do
  description 'Description of cache subnet group.'
  subnets [ 'subnet', 'subnet' ]
end
```

The full syntax for all of the properties that are available to the
`aws_cache_subnet_group` resource is:

``` ruby
aws_cache_subnet_group 'name' do
  description                   String
  group_name                    String  # defaults to 'name' if not specified
  subnets                       String, Array
end
```

where

-   `aws_cache_subnet_group` is the resource
-   `name` is the name of the resource block (and is the same as the
    `group_name` property if `group_name` is not specified in the
    resource block)
-   `description` and `subnets` are properties of this resource, with
    the Ruby type shown. See "Properties" section below for more
    information about all of the properties that may be used with this
    resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>description</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the description of a cache subnet group.</p></td>
</tr>
<tr class="even">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="odd">
<td><p><code>group_name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of a cache subnet group.</p></td>
</tr>
<tr class="even">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>subnets</code></p></td>
<td><p><strong>Ruby Type:</strong> String, Array, AwsSubnet, AWS::EC2::Subnet</p>
<p>Use to specify an array of subnets that are associated with this cache subnet group.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Define a cache subnet group for a cache cluster**

{{% resource_provisioning_aws_cache_cluster_create %}}

aws_cloudsearch_domain
========================

The `aws_cloudsearch_domain` resource is a driver-specific resource used
by Chef Provisioning. Use the `aws_cloudsearch_domain` resource to
manage [full-text searching for
domains](https://aws.amazon.com/cloudsearch/) in Amazon CloudSearch.

Syntax
------

A `aws_cloudsearch_domain` resource block manages an Amazon CloudSearch
domain. For example:

``` ruby
aws_cloudsearch_domain 'ref-cs-domain' do
  instance_type 'search.m1.small'
  partition_count 2
  replication_count 2
  index_fields [{:index_field_name => 'foo',
                 :index_field_type => 'text'}]
end
```

The full syntax for all of the properties that are available to the
`aws_cloudsearch_domain` resource is:

``` ruby
aws_cloudsearch_domain 'name' do
  access_policies               String
  index_fields                  Array
  instance_type                 String
  multi_az                      true, false
  partition_count               Integer
  replication_count             Integer
end
```

where

-   `aws_cloudsearch_domain` is the resource
-   `name` is the name of the resource block
-   `access_policies`, `index_fields`, `instance_type`, `multi_az`,
    `partition_count`, and `replication_count` are properties of this
    resource, with the Ruby type shown. See "Properties" section below
    for more information about all of the properties that may be used
    with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>access_policies</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The <a href="http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-access.html">access policies</a> for a domain.</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>index_fields</code></p></td>
<td><p><strong>Ruby Type:</strong> Array</p>
<p>An array that specifies <a href="http://docs.aws.amazon.com/cloudsearch/latest/developerguide/API_IndexField.html">the desired index fields</a>. Must include the following keys: <code>index_field_name</code> and <code>index_field_type</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>instance_type</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The instance type: <code>search.m1.small</code>, <code>search.m3.medium</code>, <code>search.m3.large</code>, <code>search.m3.xlarge</code>, or <code>search.m3.2xlarge</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>multi_az</code></p></td>
<td><p><strong>Ruby Type:</strong> true, false | <strong>Default Value:</strong> <code>false</code></p>
<p>Specifies if the Amazon CloudSearch domain is deployed to multiple availability zones.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The name of the domain.</p></td>
</tr>
<tr class="odd">
<td><p><code>partition_count</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer</p>
<p>The number of pre-configured partitions for the domain.</p></td>
</tr>
<tr class="even">
<td><p><code>replication_count</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer</p>
<p>The number of replicas for each partition.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Define a cloudsearch domain**

``` ruby
aws_cloudsearch_domain 'ref-cs-domain' do
  instance_type 'search.m1.small'
  partition_count 2
  replication_count 2
  index_fields [{:index_field_name => 'foo',
                 :index_field_type => 'text'}]
end
```

aws_cloudwatch_alarm
======================

The `aws_cloudwatch_alarm` resource is a driver-specific resource used
by Chef Provisioning. Use the `aws_cloudwatch_alarm` resource to manage
[CloudWatch
alarm](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-cloudwatch-createalarm.html/)
in Amazon CloudWatch.

Syntax
------

A `aws_cloudwatch_alarm` resource block manages an Amazon CloudWatch
alarm. For example:

``` ruby
aws_cloudwatch_alarm 'my-test-alert' do
  namespace 'AWS/EC2'
  metric_name 'CPUUtilization'
  comparison_operator 'GreaterThanThreshold'
  evaluation_periods 1
  period 60
  statistic 'Average'
  threshold 80
end
```

The full syntax for all of the properties that are available to the
`aws_cloudwatch_alarm` resource is:

``` ruby
aws_cloudwatch_alarm 'name' do
  namespace                    String
  metric_name                  String
  comparison_operator          String
  evaluation_periods           Integer
  period                       Integer,Float
  statistic                    String
  threshold                    Integer, Float
  insufficient_data_actions    Array
  ok_actions                   Array
  alarm_actions                Array
  actions_enabled              true, false
  alarm_description            String
  unit                         String
end
```

where

-   `aws_cloudwatch_alarm` is the resource
-   `name` is the name of the resource block
-   `namespace`, `metric_name`, `comparison_operator`,
    `evaluation_periods`, `period`, `statistic`, `threshold`,
    `insufficient_data_actions`, `ok_actions`, `alarm_actions`,
    `actions_enabled`, `alarm_description` and `unit` are properties of
    this resource, with the Ruby type shown. See "Properties" section
    below for more information about all of the properties that may be
    used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>namespace</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The <a href="http://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-namespaces.html">namespace for</a> for a cloudwatch.</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>metric_name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The <a href="http://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/working_with_metrics.html">metric for</a> for a cloudwatch.</p></td>
</tr>
<tr class="odd">
<td><p><code>comparison_operator</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The arithmetic operation to use when comparing the specified statistic and threshold. The specified statistic value is used as the first operand. Valid values: <code>GreaterThanOrEqualToThreshold</code>, <code>GreaterThanThreshold</code>, <code>LessThanThreshold</code> and <code>LessThanOrEqualToThreshold</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>evaluation_periods</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer</p>
<p>The number of periods over which data is compared to the specified threshold. Valid Range: Minimum value of <code>1</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The name of the cloudwatch alarm.</p></td>
</tr>
<tr class="odd">
<td><p><code>period</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer, Float</p>
<p>The period, in seconds, over which the statistic is applied. Valid Range: Minimum value of <code>1</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>statistic</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The statistic for the metric associated with the alarm, other than percentile. For percentile statistics, use <code>ExtendedStatistic</code>. Valid Values: <code>SampleCount</code>, <code>Average</code>, <code>Sum</code>, <code>Minimum</code> and <code>Maximum</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>threshold</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer, Float</p>
<p>The value to compare with the specified statistic.</p></td>
</tr>
<tr class="even">
<td><p><code>insufficient_data_actions</code></p></td>
<td><p><strong>Ruby Type:</strong> Array</p>
<p>The actions to execute when this alarm transitions to the <code>INSUFFICIENT_DATA</code> state from any other state. Each action is specified as an Amazon Resource Name (ARN).</p></td>
</tr>
<tr class="odd">
<td><p><code>ok_actions</code></p></td>
<td><p><strong>Ruby Type:</strong> Array</p>
<p>The actions to execute when this alarm transitions to the <code>OK</code> state from any other state. Each action is specified as an Amazon Resource Name (ARN).</p></td>
</tr>
<tr class="even">
<td><p><code>alarm_actions</code></p></td>
<td><p><strong>Ruby Type:</strong> Array</p>
<p>The actions to execute when this alarm transitions to the <code>ALARM</code> state from any other state. Each action is specified as an Amazon Resource Name (ARN).</p></td>
</tr>
<tr class="odd">
<td><p><code>actions_enabled</code></p></td>
<td><p><strong>Ruby Type:</strong> true, false</p>
<p>Indicates whether actions should be executed during any changes to the alarm state.</p></td>
</tr>
<tr class="even">
<td><p><code>alarm_description</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The description of the alarm.</p></td>
</tr>
<tr class="odd">
<td><p><code>unit</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The unit of the metric associated with the alarm. Valid Values: <code>Seconds</code>, <code>Microseconds</code>, <code>Milliseconds</code>, <code>Bytes</code>, <code>Kilobytes</code>, <code>Megabytes</code>, <code>Gigabytes</code>, <code>Terabytes</code>, <code>Bits</code>, <code>Kilobits</code>, <code>Megabits</code>, <code>Gigabits</code>, <code>Terabits</code>, <code>Percent</code>, <code>Count</code>, <code>Bytes/Second</code>, <code>Kilobytes/Second</code>, <code>Megabytes/Second</code>, <code>Gigabytes/Second</code>, <code>Terabytes/Second</code>, <code>Bits/Second`,</code>Kilobits/Second<code>,</code>Megabits/Second<code>,</code>Gigabits/Second<code>,</code>Terabits/Second<code>,</code>Count/Second<code>and</code>None``.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Define a cloudwatch alarm**

``` ruby
aws_cloudwatch_alarm 'my-test-alert' do
  namespace 'AWS/EC2'
  metric_name 'CPUUtilization'
  comparison_operator 'GreaterThanThreshold'
  evaluation_periods 1
  period 60
  statistic 'Average'
  threshold 80
end
```

aws_dhcp_options
==================

The `aws_dhcp_options` resource is a driver-specific resource used by
Chef Provisioning. Use the `aws_dhcp_options` resource to manage the
[option
sets](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_DHCP_Options.html)
for the Dynamic Host Configuration Protocol (DHCP) protocol. Option sets
are associated with the Amazon Web Services (AWS) account and may be
used across all instances in Amazon Virtual Private Cloud (VPC).

Syntax
------

A `aws_dhcp_options` resource block manages DHCP options for Amazon Web
Services (AWS). For example:

``` ruby
aws_dhcp_options 'name' do
  domain_name          'example.com'
  domain_name_servers  %w(8.8.8.8 8.8.4.4)
  ntp_servers          %w(8.8.8.8 8.8.4.4)
  netbios_name_servers %w(8.8.8.8 8.8.4.4)
  netbios_node_type    2
  aws_tags :chef_type => 'aws_dhcp_options'
end
```

The full syntax for all of the properties that are available to the
`aws_dhcp_options` resource is:

``` ruby
aws_dhcp_options 'name' do
  dhcp_options_id               String
  domain_name                   String
  domain_name_servers           Array
  ntp_servers                   Array
  netbios_name_servers          Array
  netbios_node_type             Integer
end
```

where

-   `aws_dhcp_options` is the resource
-   `name` is the name of the resource block and also the name of an
    option set for the Dynamic Host Configuration Protocol (DHCP)
    protocol
-   `domain_name`, `domain_name_servers`, `netbios_name_servers`,
    `netbios_node_type`, and `ntp_servers` are properties of this
    resource, with the Ruby type shown. See "Properties" section below
    for more information about all of the properties that may be used
    with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>dhcp_options_id</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the identifier for the the Dynamic Host Configuration Protocol (DHCP) options set.</p></td>
</tr>
<tr class="even">
<td><p><code>domain_name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the domain name. For example: <code>example.com</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>domain_name_servers</code></p></td>
<td><p><strong>Ruby Type:</strong> Array</p>
<p>Use to specify an array that contains up to four IP addresses for domain name servers. Default value: <code>AmazonProvidedDNS</code>. For example: <code>%w(8.8.8.8 8.8.4.4)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the Dynamic Host Configuration Protocol (DHCP) options set.</p></td>
</tr>
<tr class="odd">
<td><p><code>netbios_name_servers</code></p></td>
<td><p><strong>Ruby Type:</strong> Array</p>
<p>Use to specify an array that contains up to four IP addresses of NetBIOS name servers. For example: <code>%w(8.8.8.8 8.8.4.4)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>netbios_node_type</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer</p>
<p>Use to specify the NetBIOS node type. Possible values: <code>1</code>, <code>2</code>, <code>4</code>, or <code>8</code>. Recommended value: <code>2</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>ntp_servers</code></p></td>
<td><p><strong>Ruby Type:</strong> Array</p>
<p>Use to specify an array that contains up to four IP addresses for Network Time Protocol (NTP) servers. For example: <code>%w(8.8.8.8 8.8.4.4)</code>.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Create an option set**

``` ruby
aws_dhcp_options 'ref-dhcp-options' do
  domain_name 'example.com'
  domain_name_servers %w(8.8.8.8 8.8.4.4)
  netbios_name_servers %w(8.8.8.8 8.8.4.4)
  netbios_node_type 2
  aws_tags :chef_type => 'aws_dhcp_options'
end
```

**Destroy an option set**

``` ruby
aws_dhcp_options 'ref-dhcp-options' do
  action :destroy
end
```

aws_ebs_volume
================

The `aws_ebs_volume` resource is a driver-specific resource used by Chef
Provisioning. Use the `aws_ebs_volume` resource to manage a [block-level
storage
device](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumes.html)
that is attached to an Amazon EC2 instance.

Syntax
------

A `aws_ebs_volume` resource block manages Amazon Elastic Block Store
(EBS) volumes. For example:

``` ruby
aws_ebs_volume 'name' do
  machine 'ref-machine1'
  availability_zone 'a'
  size 100
  iops 3000
  volume_type 'io1'
  encrypted true
  device '/dev/sda2'
  aws_tags :chef_type => 'aws_ebs_volume'
end
```

The full syntax for all of the properties that are available to the
`aws_ebs_volume` resource is:

``` ruby
aws_ebs_volume 'name' do
  availability_zone             String
  device                        String
  encrypted                     true, false
  iops                          Integer
  machine                       String
  size                          Integer
  snapshot                      String
  volume_id                     String
  volume_type                   String
end
```

where

-   `aws_ebs_volume` is the resource
-   `name` is the name of the resource block and also the name of a
    block-level storage device that is attached to an Amazon EC2
    instance
-   `availability_zone`, `device`, `encrypted`, `iops`, `machine`,
    `size`, and `volume_type` are properties of this resource, with the
    Ruby type shown. See "Properties" section below for more information
    about all of the properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>availability_zone</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the availability zone in which the block-level storage device is created.</p></td>
</tr>
<tr class="even">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="odd">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="even">
<td><p><code>device</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the device to which the block-level storage device is attached. For example: <code>'/dev/xvdg'</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>encrypted</code></p></td>
<td><p><strong>Ruby Type:</strong> true, false</p>
<p>Use to specify that a block-level storage device should be encrypted.</p></td>
</tr>
<tr class="odd">
<td><p><code>iops</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer</p>
<p>Required for provisioned volumes. Use to specify the maximum number of input/output operations per second (IOPS) that the block-level storage device will support.</p></td>
</tr>
<tr class="even">
<td><p><code>machine</code></p></td>
<td><p><strong>Ruby Type:</strong> String, false, AwsInstance, AWS::EC2::Instance</p>
<p>Use to specify the machine to be provisioned.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the block-level storage device. Because the name of a Amazon Virtual Private Cloud (VPC) instance is not guaranteed to be unique for an account at Amazon Web Services (AWS), Chef Provisioning will store the associated identifier on the Chef Infra Server using the <code>data/aws_ebs_volume/&lt;name&gt;</code> data bag.</p></td>
</tr>
<tr class="odd">
<td><p><code>size</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer</p>
<p>Use to specify the size (in gigabytes) of the block-level storage device.</p></td>
</tr>
<tr class="even">
<td><p><code>snapshot</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of a <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSSnapshots.html">snapshot</a> of the block-level storage device. A snapshot is an incremental backups; only blocks on a device that have changed after the most recent snapshot are saved. A snapshot may be deleted; only data exclusive to that snapshot is deleted. The active snapshot contains all of the information needed to restore data to a new block-level storage device.</p></td>
</tr>
<tr class="odd">
<td><p><code>volume_id</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the identifier for the block-level storage device.</p></td>
</tr>
<tr class="even">
<td><p><code>volume_type</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the volume type for the block-level storage device: <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html#EBSVolumeTypes_gp2">general purpose volumes</a>, <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html#EBSVolumeTypes_piops">provisioned volumes</a>, or <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html#EBSVolumeTypes_standard">magnetic volumes</a>.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Manage EBS volume**

``` ruby
aws_ebs_volume 'ref-volume-ebs' do
  availability_zone 'a'
  size 1
end
```

**Attach to a machine**

``` ruby
aws_ebs_volume 'ref-volume-ebs' do
  machine 'ref-machine-1'
  device '/dev/xvdf'
end
```

**Reattach to a different device**

``` ruby
aws_ebs_volume 'ref-volume-ebs' do
  device '/dev/xvdg'
end
```

**Reattach to a different machine**

``` ruby
aws_ebs_volume 'ref-volume-ebs' do
  machine 'ref-machine-2'
  device '/dev/xvdf'
end
```

**Skip a reattach attempt**

``` ruby
aws_ebs_volume 'ref-volume-ebs' do
  machine 'ref-machine-2'
  device '/dev/xvdf'
end
```

**Create and attach**

``` ruby
aws_ebs_volume 'ref-volume-ebs-2' do
  availability_zone 'a'
  size 1
  machine 'ref-machine-1'
  device '/dev/xvdf'
end
```

**Detach**

``` ruby
aws_ebs_volume 'ref-volume-ebs' do
  machine false
end
```

**Destroy volumes for batch of machines, along with keys**

{{% resource_provisioning_aws_ebs_volume_delete_machine_and_keys %}}

aws_eip_address
=================

The `aws_eip_address` resource is a driver-specific resource used by
Chef Provisioning. Use the `aws_eip_address` resource to manage [an
elastic IP
address](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html),
a static IP address designed for dynamic cloud computing that is
associated with an Amazon Web Services (AWS) account.

Syntax
------

A `aws_eip_address` resource block manages elastic IP addresses. For
example:

``` ruby
aws_eip_address 'name' do
  machine 'ref-machine1'
  associate_to_vpc true
  public_ip '205.32.21.0'
end
```

The full syntax for all of the properties that are available to the
`aws_eip_address` resource is:

``` ruby
aws_eip_address 'name' do
  associate_to_vpc              true, false
  machine                       String, false
  public_ip                     String
end
```

where

-   `aws_eip_address` is the resource
-   `name` is the name of the resource block and also the name of an
    Amazon Elastic IP Address (EIP)
-   `associate_to_vpc`, `machine`, and `public_ip` are properties of
    this resource, with the Ruby type shown. See "Properties" section
    below for more information about all of the properties that may be
    used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>associate_to_vpc</code></p></td>
<td><p><strong>Ruby Type:</strong> true, false</p>
<p>Use to associate an elastic IP address to a virtual network that is defined in Amazon Virtual Private Cloud (VPC).</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>machine</code></p></td>
<td><p><strong>Ruby Type:</strong> String, false</p>
<p>Use to specify the machine to be provisioned.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of an elastic IP address.</p></td>
</tr>
<tr class="odd">
<td><p><code>public_ip</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the public IP address to associate with a Chef resource. This will default to the <code>name</code> of the resource block if that value is an IP address. If an IP address is already allocated to an Amazon Web Services (AWS) account, Chef will ensure that it is linked.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Associate elastic IP address**

``` ruby
aws_eip_address 'frontend_ip' do
  public_ip '205.32.21.0'
end
```

**Associate elastic IP address with a machine**

``` ruby
require 'chef/provisioning/aws_driver'

with_driver 'aws::us-west-2' do

  machine "SRV_OR_Web_1" do
    machine_options :bootstrap_options => {
      :key_name => 'Tst_Prov'
    }
  end

  aws_eip_address 'Web_IP_1' do
    machine 'SRV_OR_Web_1'
  end
end
```

**Associate elastic IP address to a machine's VPC**

``` ruby
aws_eip_address 'Web_IP_1' do
  machine 'SRV_OR_Web_1'
  associate_to_vpc true
end
```

aws_elasticsearch_domain
==========================

The `aws_elasticsearch_domain` resource is a driver-specific resource
used by Chef Provisioning. Use the `aws_elasticsearch_domain` resource
to manage [an Elasticsearch
domain](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticsearch-domain.html),
an Amazon Elasticsearch Service (Amazon ES) domain that encapsulates the
Amazon ES engine instances associated with an Amazon Web Services (AWS)
account.

Syntax
------

A `aws_elasticsearch_domain` resource block manages Amazon ES engine
instances. For example:

``` ruby
aws_elasticsearch_domain "ref-es-domain" do
  instance_type "t2.small.elasticsearch"
  ebs_enabled true
  volume_size 10
  automated_snapshot_start_hour 2
  elasticsearch_version '5.5'
end
```

The full syntax for all of the properties that are available to the
`aws_elasticsearch_domain` resource is:

``` ruby
aws_elasticsearch_domain 'name' do
  instance_type                     String
  ebs_enabled                       true, false
  volume_size                       Integer
  automated_snapshot_start_hour     Integer
  elasticsearch_version             String, Integer
end
```

where

-   `aws_elasticsearch_domain` is the resource
-   `name` is the name of the resource block and also the name of an
    Amazon Elasticsearch Domain
-   `instance_type`, `ebs_enabled`, `volume_size`,
    `automated_snapshot_start_hour` and `elasticsearch_version` are
    properties of this resource, with the Ruby type shown. See
    "Properties" section below for more information about all of the
    properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>instance_type</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The instance type: <code>t2.small.elasticsearch</code>, <code>t2.medium.elasticsearch</code> etc.</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>ebs_enabled</code></p></td>
<td><p><strong>Ruby Type:</strong> true, false</p>
<p>Use to specify the elastic block size enable/disable.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of an Elasticsearch domain.</p></td>
</tr>
<tr class="odd">
<td><p><code>volume_size</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer</p>
<p>Use to specify the volume size to associate with a Chef resource.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Create Elasticsearch domain address**

``` ruby
aws_elasticsearch_domain "ref-es-domain" do
  instance_type "t2.small.elasticsearch"
  ebs_enabled true
  volume_size 10
  automated_snapshot_start_hour 2
  elasticsearch_version '5.5'
end
```

aws_iam_instance_profile
===========================

The `aws_iam_instance_profile` resource is a driver-specific resource
used by Chef Provisioning. Use the `aws_iam_instance_profile` resource
to manage [an IAM instance
profile](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html),
An instance profile is a container for an IAM role that you can use to
pass role information to an EC2 instance when the instance starts.

Syntax
------

A `aws_iam_instance_profile` resource block manages Amazon IAM instance
profile role. For example:

``` ruby
aws_iam_instance_profile 'test-profile' do
  path "/"
  role "test-role"
end
```

The full syntax for all of the properties that are available to the
`aws_elasticsearch_domain` resource is:

``` ruby
aws_iam_instance_profile 'name' do
  path                     String
  role                     String, AwsIamRole, ::Aws::IAM::Role
end
```

where

-   `aws_iam_instance_profile` is the resource
-   `name` is the name of the resource block and also the name of an
    Amazon IAM instance profile
-   `path` and `role` are properties of this resource, with the Ruby
    type shown. See "Properties" section below for more information
    about all of the properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>path</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>If you are using the IAM API or AWS Command Line Interface (AWS CLI) to create IAM entities, you can also give the entity an optional path. For example, you could use the nested path <code>/division_abc/subdivision_xyz/product_1234/engineering/</code> to match your company's organizational structure.</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>role</code></p></td>
<td><p><strong>Ruby Type:</strong> String, AwsIamRole, ::Aws::IAM::Role</p>
<p>A set of permissions that grant access to actions and resources in AWS. These permissions are attached to the role, not to an IAM user or group.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><code>name</code></td>
<td><strong>Ruby Type:</strong> String</td>
</tr>
</tbody>
</table>

Examples
--------

**Create IAM instance profile**

``` ruby
aws_iam_instance_profile 'test-profile' do
  path "/"
  role "test-role"
end
```

aws_iam_role
==============

The `aws_iam_role` resource is a driver-specific resource used by Chef
Provisioning. Use the `aws_iam_role` resource to manage [an IAM
Role](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html), An
IAM role is similar to a user, in that it is an AWS identity with
permission policies that determine what the identity can and cannot do
in AWS. However, instead of being uniquely associated with one person, a
role is intended to be assumable by anyone who needs it. Also, a role
does not have any credentials (password or access keys) associated with
it. Instead, if a user is assigned to a role, access keys are created
dynamically and provided to the user.

Syntax
------

A `aws_iam_role` resource block manages Amazon IAM role. For example:

``` ruby
aws_iam_role "iam-test" do
  path "/"
  assume_role_policy_document ec2_principal
  inline_policies a: iam_role_policy, b: rds_role_policy
end
```

The full syntax for all of the properties that are available to the
`aws_iam_role` resource is:

``` ruby
aws_iam_role 'name' do
  path                          String
  assume_role_policy_document   String
  inline_policies               Hash
end
```

where

-   `aws_iam_role` is the resource
-   `name` is the name of the resource block and also the name of the
    role to create
-   `path`, `assume_role_policy_document` and `inline_policies` are
    properties of this resource, with the Ruby type shown. See
    "Properties" section below for more information about all of the
    properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>path</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>If you are using the IAM API or AWS Command Line Interface (AWS CLI) to create IAM entities, you can also give the entity an optional path. For example, you could use the nested path <code>/division_abc/subdivision_xyz/product_1234/engineering/</code> to match your company's organizational structure.</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>assume_role_policy_document</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The policy that grants an entity permission to assume the role.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The name of the resource block and also the name of the role to create.</p></td>
</tr>
<tr class="odd">
<td><code>inline_policies</code></td>
<td><strong>Ruby Type:</strong> Hash Inline policies which <strong>only</strong> apply to this role, unlike managed policies which can be shared between users, groups and roles.</td>
</tr>
</tbody>
</table>

Examples
--------

**Create IAM role**

``` ruby
ec2_principal = '{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Principal": {"Service": "ec2.amazonaws.com"},
    "Action": "sts:AssumeRole"
  }]
}'

iam_role_policy = '{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iam:*",
      "Resource": "*"
    }
  ]
}'

rds_role_policy = '{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1441787971000",
      "Effect": "Allow",
      "Action": [
          "rds:*"
      ],
      "Resource": [
          "*"
      ]
    }
  ]
}'

aws_iam_role "iam-test" do
  path "/"
  assume_role_policy_document ec2_principal
  inline_policies a: iam_role_policy, b: rds_role_policy
end

aws_iam_role "iam-test" do
  path "/"
  assume_role_policy_document ec2_principal
  inline_policies a: iam_role_policy
end

aws_iam_role "iam-test" do
  path "/"
  assume_role_policy_document ec2_principal
  inline_policies b: rds_role_policy
end

aws_iam_role "iam-test" do
  path "/"
  assume_role_policy_document ec2_principal
  inline_policies Hash.new
end
```

**Delete IAM role**

``` ruby
aws_iam_role "iam-test" do
  action :destroy
end
```

machine_image
==============

The `machine_image` resource is a driver-specific resource used by Chef
Provisioning. Use the `machine_image` resource to manage Amazon Machine
Images (AMI)
[images](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html)
that exist in Amazon EC2. An image includes a template for the root
volume of an instance (operating system, application server,
application, for example), launch permissions, and a block mapping
device that attaches volumes to the instance when it is launched.

Syntax
------

A `machine_image` resource block manages Amazon Web Services (AWS)
images. For example:

``` ruby
machine_image 'name' do
  image_id 'image-1'
end
```

The full syntax for all of the properties that are available to the
`aws_image` resource is:

``` ruby
machine_image 'name' do
  image_id                      String
end
```

where

-   `machine_image` is the resource
-   `name` is the name of the resource block and also the name of an
    Amazon Machine Images (AMI) image
-   `image_id` is a property of this resource, with the Ruby type shown.
    See "Properties" section below for more information about all of the
    properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>image_id</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the image identifier.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of an image.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Create instance with default values, then create image from instance
and delete the instance**

``` ruby
machine_image 'ref-machine_image'
```

**Create image with provided image ID and other values set**

``` ruby
require 'chef/provisioning/aws_driver'

with_driver 'aws::us-west-2' do

 machine_image 'ref-machine_image' do
    machine_options bootstrap_options: {
      subnet_id: 'subnet-c3c2f6e8',
      security_group_ids: 'sg-b5f9ead2',
      image_id: 'ami-695f587f',
      instance_type: 't2.micro'
    }
 end
```

**Create image from image-id**

``` ruby
machine_image 'ref-machine_image2' do
  from_image 'ami-695f587f'
end
```

**Delete created image**

``` ruby
machine_image 'ref-machine_image' do
    action :destroy
end
```

machine
=======

The `machine` resource is a driver-specific resource used by Chef
Provisioning. Use the `machine` resource to manage an instance in Amazon
EC2.

Syntax
------

A `machine` resource block manages Amazon Web Services (AWS) images. For
example:

``` ruby
machine 'name' do
  instance_id 'instance-1'
end
```

The full syntax for all of the properties that are available to the
`machine` resource is:

``` ruby
machine 'name' do
  instance_id                   String
end
```

where

-   `machine` is the resource
-   `name` is the name of the resource block and also the name of an
    instance in Amazon EC2
-   `instance_id` is a property of this resource, with the Ruby type
    shown. See "Properties" section below for more information about all
    of the properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>instance_id</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the instance identifier.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the instance.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Create instance with default values, and register with chef-server**

``` ruby
machine 'ref-machine'
```

**Create instance with provided options**

``` ruby
require 'chef/provisioning/aws_driver'

with_driver 'aws::us-west-2' do

 machine 'ref-machine' do
    machine_options bootstrap_options: {
      subnet_id: 'subnet-c3c2f6e8',
      security_group_ids: 'sg-b5f9ead2',
      image_id: 'ami-695f587f',
      instance_type: 't2.micro'
    }
 end
```

**Create instance from image-id**

``` ruby
machine 'ref-machine' do
  from_image 'ami-695f587f'
end
```

**Create instance with tag entries**

``` ruby
machine 'ref-machine-1' do
  action :allocate
end

machine 'ref-machine-1' do
  machine_options aws_tags: {:marco => 'polo', :happyhappy => 'joyjoy'}
  converge false
end
```

aws_internet_gateway
======================

The `aws_internet_gateway` resource is a driver-specific resource used
by Chef Provisioning. Use the `aws_internet_gateway` resource to
configure an internet gateway for a defined virtual network within
Amazon Virtual Private Cloud (VPC) (the networking layer of Amazon EC2).

An internet gateway is a horizontally scaled, redundant, and highly
available component within Amazon Virtual Private Cloud (VPC) that
enables communication between instances within a defined virtual network
and the Internet.

Syntax
------

A `aws_internet_gateway` resource block manages internet gateways. For
example:

``` ruby
aws_internet_gateway 'name' do
  internet_gateway_id '1234567890'
end
```

The full syntax for all of the properties that are available to the
`aws_internet_gateway` resource is:

``` ruby
aws_internet_gateway 'name' do
  internet_gateway_id           String
  vpc                           String, AwsVpc, ::Aws::EC2::Vpc
end
```

where

-   `aws_internet_gateway` is the resource
-   `name` is the name of the resource block and also the name of an
    internet gateway for a defined virtual network within Amazon Virtual
    Private Cloud (VPC)
-   `internet_gateway_id` and <span class="title-ref">vpc</span> are
    properties of this resource, with the Ruby type shown. See
    "Properties" section below for more information about all of the
    properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="even">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="odd">
<td><p><code>internet_gateway_id</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the identifier for an internet gateway.</p></td>
</tr>
<tr class="even">
<td><p><code>vpc</code></p></td>
<td><p><strong>Ruby Type:</strong> String, AwsVpc, ::Aws::EC2::Vpc</p>
<p>Use to specify the identifier for a vpc.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the internet gateway.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Create an internet gateway**

``` ruby
aws_internet_gateway 'name' do
  internet_gateway_id '1234567890'
end
```

**Create an internet gateway with VPC attached**

``` ruby
aws_internet_gateway 'name' do
  vpc 'vpc-1e9b5078'
end
```

aws_key_pair
==============

The `aws_key_pair` resource is a driver-specific resource used by Chef
Provisioning. Use the `aws_key_pair` resource to manage key pairs in
Amazon EC2.

Syntax
------

A `aws_key_pair` resource block manages key pairs. For example:

``` ruby
aws_key_pair 'name' do
  private_key_options({
    :format => :pem,
    :type => :rsa,
    :regenerate_if_different => true
  })
  allow_overwrite true
end
```

The full syntax for all of the properties that are available to the
`aws_key_pair` resource is:

``` ruby
aws_key_pair 'name' do
  allow_overwrite               true, false
  private_key_options()         Hash
  private_key_path              String
  public_key_path               String
end
```

where

-   `aws_key_pair` is the resource
-   `name` is the name of the resource block
-   `allow_overwrite` and `private_key_options` are properties of this
    resource, with the Ruby type shown. See "Properties" section below
    for more information about all of the properties that may be used
    with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>allow_overwrite</code></p></td>
<td><p><strong>Ruby Type:</strong> true, false</p>
<p>Use to allow a public or private key to be overwritten.</p></td>
</tr>
<tr class="even">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="odd">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="even">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>private_key_options</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Use to specify a Hash that defines a list of parameters for the <code>private_key</code> resource that is used to generate this key.</p></td>
</tr>
<tr class="odd">
<td><p><code>private_key_path</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the path to the private key to use. The private key will be generated if it does not exist.</p></td>
</tr>
<tr class="even">
<td><p><code>public_key_path</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the path to the public key to use. The public key will be generated if it does not exist.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Create a private key, regenerate it if necessary**

``` ruby
aws_key_pair 'ref-key-pair' do
  private_key_options({
    :format => :pem,
    :type => :rsa,
    :regenerate_if_different => true
  })
  allow_overwrite true
end
```

**Destroy volumes for batch of machines, along with keys**

{{% resource_provisioning_aws_ebs_volume_delete_machine_and_keys %}}

**Set up a VPC, route table, key pair, and machine**

{{% resource_provisioning_aws_route_table_define_vpc_key_machine %}}

aws_launch_configuration
==========================

The `aws_launch_configuration` resource is a driver-specific resource
used by Chef Provisioning. Use the `aws_launch_configuration` resource
to manage Amazon Machine Images (AMI) [instance
types](http://aws.amazon.com/amazon-linux-ami/instance-type-matrix/),
also known as pre-configured templates for instances in Amazon EC2.

Syntax
------

A `aws_launch_configuration` resource block manages launch
configurations. For example:

``` ruby
aws_launch_configuration 'ref-launch-configuration' do
  image 'ref-machine_image1'
  instance_type 't1.micro'
  options security_groups: 'ref-sg1'
end
```

The full syntax for all of the properties that are available to the
`aws_launch_configuration` resource is:

``` ruby
aws_launch_configuration 'ref-launch-configuration' do
  image                         String
  instance_type                 String
  options                       Hash
end
```

where

-   `aws_launch_configuration` is the resource
-   `name` is the name of the resource block and also the name of an
    Amazon Machine Images (AMI) instance type
-   `image`, `instance_type`, and `options` are properties of this
    resource, with the Ruby type shown. See "Properties" section below
    for more information about all of the properties that may be used
    with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>image</code></p></td>
<td><p><strong>Ruby Type:</strong> String, AWS::EC2::Image</p>
<p>Use to specify the Amazon Machine Images (AMI)</p></td>
</tr>
<tr class="odd">
<td><p><code>instance_type</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the Amazon Machine Images (AMI) instance type. For example: <code>T2</code>, <code>M4</code>, or <code>C3</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the Amazon Machine Images (AMI).</p></td>
</tr>
<tr class="even">
<td><p><code>options</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Use to specify a Hash that contains a list of options used by this resource. Default value: <code>{ }</code>.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Define an AMI instance type**

``` ruby
aws_launch_configuration 'ref-launch-configuration' do
  image 'ref-machine_image1'
  instance_type 't1.micro'
  options security_groups: 'ref-sg1'
end
```

**Define an auto scaling group**

{{% resource_provisioning_aws_launch_config_auto_scale %}}

**Destroy auto scaling group and associated launch configuration**

{{% resource_provisioning_aws_launch_config_auto_scale_destroy %}}

aws_load_balancer
===================

The `aws_load_balancer` resource is a driver-specific resource used by
Chef Provisioning. Use the `aws_load_balancer` resource to manage load
balancers that exist in Amazon Elastic Load Balancing (ELB).

Syntax
------

A `aws_load_balancer` resource block manages load balancers in Amazon
Web Services (AWS). For example:

``` ruby
aws_load_balancer 'name' do
  load_balancer_id 'lb-1'
end
```

The full syntax for all of the properties that are available to the
`aws_load_balancer` resource is:

``` ruby
aws_load_balancer 'name' do
  load_balancer_id              String
end
```

where

-   `aws_load_balancer` is the resource
-   `name` is the name of the resource block and also the name of a load
    balancer in Amazon Elastic Load Balancing (ELB)
-   `load_balancer_id` is an properties of this resource, with the Ruby
    type shown. See "Properties" section below for more information
    about all of the properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>load_balancer_id</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the identifier for the load balancer.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the load balancer.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Define a load balancer**

``` ruby
machine 'machine-1'

machine 'machine-2'

load_balancer "aws-loadbalancer" do
    machines ['machine-1', "machine-2"]
    load_balancer_options ({
      security_groups: ['sec-group'],
      :listeners => [
        {
          instance_port: 8080,
          protocol: 'HTTPS',
          instance_protocol: 'HTTP',
          port: 443,
          server_certificate: {arn: "arn:aws:iam::112368887283:server-certificate/test-cert1"}
        },
        {
          :port => 8443,
          :protocol => :https,
          :instance_port => 80,
          :instance_protocol => :http,
          :server_certificate => {arn: "arn:aws:iam::112368887283:server-certificate/test-cert1"}
        }
      ],
      sticky_sessions: {
        cookie_name: 'app-cookie',
        ports: [80]
      },
      health_check: {
        healthy_threshold: 3,
        unhealthy_threshold: 4,
        interval: 12,
        timeout: 5,
        target: 'HTTPS:443/_status'
      },
      aws_tags: { name: "webserver", company: "chef" }
    })
end
```

aws_nat_gateway
=================

The `aws_nat_gateway` resource is a driver-specific resource used by
Chef Provisioning. Use the `aws_nat_gateway` resource to configure a NAT
gateway for a defined virtual network within Amazon Virtual Private
Cloud (VPC) (the networking layer of Amazon EC2).

An AWS nat gateway, enable instances in a private subnet to connect to
the Internet or other AWS services, but prevent the Internet from
initiating a connection with those instances.

Syntax
------

A `aws_nat_gateway` resource block manages NAT gateways. For example:

``` ruby
aws_nat_gateway 'nat-gateway' do
  subnet 'subnet-9afc3fa7'
  eip_address '34.194.48.38'
end
```

The full syntax for all of the properties that are available to the
`aws_nat_gateway` resource is:

``` ruby
aws_nat_gateway 'name' do
  subnet           String, AwsSubnet, ::Aws::EC2::Subnet
  eip_address      String, ::Aws::OpsWorks::Types::ElasticIp, AwsEipAddress, nil
  nat_gateway_id   String
end
```

where

-   `aws_nat_gateway` is the resource
-   `name` is the name of the resource block and also the name of a NAT
    gateway for a defined virtual network within Amazon Virtual Private
    Cloud (VPC)
-   `nat_gateway_id` is a property of this resource, with the Ruby type
    shown. See "Properties" section below for more information about all
    of the properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="even">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> <code>Chef::Provisioning::Driver</code></p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="odd">
<td><p><code>nat_gateway_id</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the identifier for a NAT gateway.</p></td>
</tr>
<tr class="even">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> <code>Chef::Provisioning::ManagedEntryStore</code></p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the NAT gateway.</p></td>
</tr>
<tr class="even">
<td><p><code>eip_address</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>An elastic IP address for the NAT gateway. Options: <code>::Aws::OpsWorks::Types::ElasticIp</code>, <code>AwsEipAddress</code>, <code>nil</code></p></td>
</tr>
<tr class="odd">
<td><p><code>subnet</code></p></td>
<td><p><strong>Ruby Type:</strong> String, AwsSubnet, ::Aws::EC2::Subnet</p>
<p>A subnet to attach to the NAT gateway</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Create a NAT gateway**

``` ruby
aws_nat_gateway 'name' do
  subnet 'subnet-9afc3fa7'
  eip_address '34.194.48.38'
end
```

**Delete a NAT gateway**

``` ruby
aws_nat_gateway 'nat-04aa0160019231f2e' do
    action :destroy
end
```

aws_network_acl
=================

The `aws_network_acl` resource is a driver-specific resource used by
Chef Provisioning. Use the `aws_network_acl` resource to manage network
ACLs.

Syntax
------

A `aws_network_acl` resource block typically declares ACLs for networks.
For example:

``` ruby
aws_network_acl 'name' do
  vpc 'ref-vpc'
  inbound_rules '0.0.0.0/0' => [ 22, 80 ]
  outbound_rules [
    {:port => 22..22, :protocol => :tcp, :destinations => ['0.0.0.0/0'] }
  ]
  aws_tags :chef_type => 'aws_security_group'
end
```

The full syntax for all of the properties that are available to the
`network_acl` resource is:

``` ruby
aws_network_acl 'name' do
  inbound_rules                 Array, Hash
  network_acl_id                String
  outbound_rules                Array, Hash
  vpc                           String, AwsVpc, AWS::EC2::VPC
end
```

where

-   `aws_network_acl` is the resource
-   `name` is the name of the resource block
-   `inbound_rules`, `network_acl_id`, `outbound_rules`, and `vpc` are
    properties of this resource, with the Ruby type shown. See
    "Properties" section below for more information about all of the
    properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>inbound_rules</code></p></td>
<td><p><strong>Ruby Type:</strong> Array, Hash</p>
<p>Use to specify inbound rules. Rules must be specified in one of the following formats:</p>
<div class="sourceCode" id="cb1"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb1-1"><a href="#cb1-1"></a>[</span>
<span id="cb1-2"><a href="#cb1-2"></a>  { <span class="st">port: </span><span class="dv">22</span>, <span class="st">protocol: :tcp</span>, <span class="st">sources: </span>[&lt;source&gt;, &lt;source&gt;, ...] }</span>
<span id="cb1-3"><a href="#cb1-3"></a>]</span></code></pre></div>
<p>or:</p>
<div class="sourceCode" id="cb2"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb2-1"><a href="#cb2-1"></a>{</span>
<span id="cb2-2"><a href="#cb2-2"></a>  &lt;permitted_source&gt; =&gt; &lt;port&gt;,</span>
<span id="cb2-3"><a href="#cb2-3"></a>  ...</span>
<span id="cb2-4"><a href="#cb2-4"></a>}</span></code></pre></div>
<p>where</p>
<ul>
<li><code>port</code> is the port number or range. For example: <code>80</code> (number) or <code>1024..2048</code> (range)</li>
<li><code>protocol</code> is the protocol to be used. For example: <code>:http</code> or <code>:tcp</code></li>
<li><code>sources</code> is an IP address (or a classless inter-domain routing (CIDR) of IP addresses), a security group to be authorized, and/or a load balancer to be authorized.</li>
</ul>
<p>For example, IP addresses:</p>
<div class="sourceCode" id="cb3"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb3-1"><a href="#cb3-1"></a>inbound_rules <span class="st">&#39;1.2.3.4&#39;</span> =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb4"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb4-1"><a href="#cb4-1"></a>inbound_rules <span class="st">&#39;1.2.3.4/24&#39;</span> =&gt; <span class="dv">80</span></span></code></pre></div>
<p>Security groups:</p>
<div class="sourceCode" id="cb5"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb5-1"><a href="#cb5-1"></a>inbound_rules <span class="st">&#39;mysecuritygroup&#39;</span></span></code></pre></div>
<div class="sourceCode" id="cb6"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb6-1"><a href="#cb6-1"></a>inbound_rules { <span class="st">security_group: &#39;mysecuritygroup&#39;</span> }</span></code></pre></div>
<div class="sourceCode" id="cb7"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb7-1"><a href="#cb7-1"></a>inbound_rules <span class="st">&#39;sg-1234abcd&#39;</span> =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb8"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb8-1"><a href="#cb8-1"></a>inbound_rules aws_security_group(<span class="st">&#39;mysecuritygroup&#39;</span>) =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb9"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb9-1"><a href="#cb9-1"></a>inbound_rules <span class="dt">AWS</span>.ec2.security_groups.first =&gt; <span class="dv">80</span></span></code></pre></div>
<p>and load balancers:</p>
<div class="sourceCode" id="cb10"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb10-1"><a href="#cb10-1"></a>inbound_rules { <span class="st">load_balancer: &#39;myloadbalancer&#39;</span> } =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb11"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb11-1"><a href="#cb11-1"></a>inbound_rules <span class="st">&#39;elb-1234abcd&#39;</span> =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb12"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb12-1"><a href="#cb12-1"></a>inbound_rules load_balancer(<span class="st">&#39;myloadbalancer&#39;</span>) =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb13"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb13-1"><a href="#cb13-1"></a>inbound_rules <span class="dt">AWS</span>.ec2.security_groups.first =&gt; <span class="dv">80</span></span></code></pre></div></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the network ACL.</p></td>
</tr>
<tr class="odd">
<td><p><code>network_acl_id</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the identifier for the network ACL.</p></td>
</tr>
<tr class="even">
<td><p><code>outbound_rules</code></p></td>
<td><p><strong>Ruby Type:</strong> Array, Hash</p>
<p>Use to specify outbound rules. Rules must be specified in one of the following formats:</p>
<div class="sourceCode" id="cb14"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb14-1"><a href="#cb14-1"></a>[</span>
<span id="cb14-2"><a href="#cb14-2"></a>  { <span class="st">port: </span><span class="dv">22</span>, <span class="st">protocol: :tcp</span>, <span class="st">sources: </span>[&lt;source&gt;, &lt;source&gt;, ...] }</span>
<span id="cb14-3"><a href="#cb14-3"></a>]</span></code></pre></div>
<p>or:</p>
<div class="sourceCode" id="cb15"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb15-1"><a href="#cb15-1"></a>{</span>
<span id="cb15-2"><a href="#cb15-2"></a>  &lt;permitted_source&gt; =&gt; &lt;port&gt;,</span>
<span id="cb15-3"><a href="#cb15-3"></a>  ...</span>
<span id="cb15-4"><a href="#cb15-4"></a>}</span></code></pre></div>
<p>where</p>
<ul>
<li><code>port</code> is the port number or range. For example: <code>80</code> (number) or <code>1024..2048</code> (range)</li>
<li><code>protocol</code> is the protocol to be used. For example: <code>:http</code> or <code>:tcp</code></li>
<li><code>sources</code> is an IP address (or a classless inter-domain routing (CIDR) of IP addresses), a security group to be authorized, and/or a load balancer to be authorized.</li>
</ul>
<p>For example, IP addresses:</p>
<div class="sourceCode" id="cb16"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb16-1"><a href="#cb16-1"></a>outbound_rules <span class="st">&#39;1.2.3.4&#39;</span> =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb17"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb17-1"><a href="#cb17-1"></a>outbound_rules <span class="st">&#39;1.2.3.4/24&#39;</span> =&gt; <span class="dv">80</span></span></code></pre></div>
<p>Security groups:</p>
<div class="sourceCode" id="cb18"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb18-1"><a href="#cb18-1"></a>outbound_rules <span class="st">&#39;mysecuritygroup&#39;</span></span></code></pre></div>
<div class="sourceCode" id="cb19"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb19-1"><a href="#cb19-1"></a>outbound_rules { <span class="st">security_group: &#39;mysecuritygroup&#39;</span> }</span></code></pre></div>
<div class="sourceCode" id="cb20"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb20-1"><a href="#cb20-1"></a>outbound_rules <span class="st">&#39;sg-1234abcd&#39;</span> =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb21"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb21-1"><a href="#cb21-1"></a>outbound_rules aws_security_group(<span class="st">&#39;mysecuritygroup&#39;</span>) =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb22"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb22-1"><a href="#cb22-1"></a>outbound_rules <span class="dt">AWS</span>.ec2.security_groups.first =&gt; <span class="dv">80</span></span></code></pre></div>
<p>and load balancers:</p>
<div class="sourceCode" id="cb23"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb23-1"><a href="#cb23-1"></a>outbound_rules { <span class="st">load_balancer: &#39;myloadbalancer&#39;</span> } =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb24"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb24-1"><a href="#cb24-1"></a>outbound_rules <span class="st">&#39;elb-1234abcd&#39;</span> =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb25"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb25-1"><a href="#cb25-1"></a>outbound_rules load_balancer(<span class="st">&#39;myloadbalancer&#39;</span>) =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb26"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb26-1"><a href="#cb26-1"></a>outbound_rules <span class="dt">AWS</span>.ec2.security_groups.first =&gt; <span class="dv">80</span></span></code></pre></div></td>
</tr>
<tr class="odd">
<td><p><code>vpc</code></p></td>
<td><p><strong>Ruby Type:</strong> String, AwsVpc, AWS::EC2::VPC</p>
<p>Required when creating a route table. Use to specify the Amazon Virtual Private Cloud (VPC) to which this route table is associated. This may be the name of an <code>aws_vpc</code> resource block that exists elsewhere in a cookbook, an actual <code>aws_vpc</code> resource block that exists in this recipe, or the name of the main route table in Amazon Virtual Private Cloud (VPC).</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Define a network acl**

``` ruby
aws_network_acl 'test_net_acl_1' do
   vpc 'vpc-40894c26'
   inbound_rules(
     [
       { rule_number: 100, rule_action: :allow, protocol: "-1", cidr_block: '0.0.0.0/0' }
     ]
   )
   outbound_rules(
     [
       { rule_number: 100, rule_action: :allow, protocol: "-1", cidr_block: '0.0.0.0/0' }
     ]
   )
end
```

**Update network acl for outbound rule**

``` ruby
aws_network_acl 'test_net_acl_1' do
   outbound_rules(
     [
       { rule_number: 100, rule_action: :allow, protocol: "-1", cidr_block: '0.0.0.0/0' },
       { rule_number: 200,
         rule_action: :allow,
         protocol: "6",
         port_range:
           {
             :from => 443,
             :to => 443
           },
         cidr_block: '172.31.0.0/24'
       }
     ]
   )
end
```

**Delete network acl**

``` ruby
aws_network_acl 'test_net_acl_1' do
  action: destroy
end
```

aws_network_interface
=======================

The `aws_network_interface` resource is a driver-specific resource used
by Chef Provisioning. Use the `aws_network_interface` resource to manage
a network interface in Amazon EC2.

Syntax
------

A `aws_network_interface` resource block manages network interfaces in
Amazon Web Services (AWS). For example:

``` ruby
aws_network_interface 'name' do
  machine 'ref-machine-eni-1'
  device_index 2
  subnet 'ref-subnet-eni'
  security_groups ['ref-sg1-eni']
  description 'ref-eni-desc'
end
```

The full syntax for all of the properties that are available to the
`aws_network_interface` resource is:

``` ruby
aws_network_interface 'name' do
  description                   String
  device_index                  Integer
  machine                       String, false
  network_interface_id          String
  private_ip_address            String
  subnet                        String
  security_groups               Array
end
```

where

-   `aws_network_interface` is the resource
-   `name` is the name of the resource block and also the name of a
    network interface in Amazon EC2
-   `description`, `device_index`, `machine`, `security_groups`, and
    `subnet` are properties of this resource, with the Ruby type shown.
    See "Properties" section below for more information about all of the
    properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>description</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the description for the network interface.</p></td>
</tr>
<tr class="even">
<td><p><code>device_index</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer</p>
<p>Use to specify the attachment order position for the network interface.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>machine</code></p></td>
<td><p><strong>Ruby Type:</strong> String, false, AwsInstance, AWS::EC2::Instance</p>
<p>Use to specify the name of the Amazon Web Services (AWS) instance that this network interface is associated with.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the network interface.</p></td>
</tr>
<tr class="odd">
<td><p><code>network_interface_id</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the identifier for the network interface.</p></td>
</tr>
<tr class="even">
<td><p><code>private_ip_address</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to assign a private IP address to the network interface. This IP address will be used as the primary IP address.</p></td>
</tr>
<tr class="odd">
<td><p><code>security_groups</code></p></td>
<td><p><strong>Ruby Type:</strong> Array</p>
<p>Use to specify one (or more) security group identifiers to be associated with the network interface.</p></td>
</tr>
<tr class="even">
<td><p><code>subnet</code></p></td>
<td><p><strong>Ruby Type:</strong> String, AWS::EC2::Subnet, AwsSubnet</p>
<p>Use to specify the identifier of the subnet to be associated with the network interface.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Define a network interface**

``` ruby
aws_network_interface 'ref-eni-1' do
  machine 'ref-machine-eni-1'
  subnet 'ref-subnet-eni'
  security_groups ['ref-sg1-eni']
  description 'ref-eni-desc'
end
```

aws_rds_instance
==================

The `aws_rds_instance` resource is a driver-specific resource used by
Chef Provisioning. Use the `aws_rds_instance` resource to manage [a
database instance](https://aws.amazon.com/rds/) using Amazon Relational
Database Service (RDS).

Syntax
------

A `aws_rds_instance` resource block manages remote database instances.
For example:

``` ruby
aws_rds_instance 'rds-instance' do
  engine 'postgres'
  publicly_accessible false
  db_instance_class 'db.t1.micro'
  master_username 'user'
  master_user_password 'password'
  multi_az false
  db_subnet_group_name 'db-subnet-group'
end
```

The full syntax for all of the properties that are available to the
`aws_rds_instance` resource is:

``` ruby
aws_rds_instance 'name' do
  additional_options            Hash
  allocated_storage             Integer
  db_instance_class             String
  db_instance_identifier        String
  db_name                       String
  db_subnet_group_name          String
  engine                        String
  engine_version                String
  iops                          Integer
  master_user_password          String
  master_username               String
  multi_az                      true, false
  port                          Integer
  publicly_accessible           true, false
end
```

where

-   `aws_rds_instance` is the resource
-   `name` is the name of the resource block
-   `additional_options`, `allocated_storage`, `db_instance_class`,
    `db_instance_identifier`, `db_name`, `db_subnet_group_name`,
    `engine`, `engine_version`, `iops`, `master_user_password`,
    `master_username`, `multi_az`, `port`, and `publicly_accessible` are
    properties of this resource, with the Ruby type shown. See
    "Properties" section below for more information about all of the
    properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>additional_options</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>A Hash of <a href="http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/RDS/Client.html#create_db_instance-instance_method">options to be passed</a> to the API for Amazon Relational Database Service (RDS). Default value: <code>{ }</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>allocated_storage</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer</p>
<p>The size (in gigabytes) allocated to the relational database.</p></td>
</tr>
<tr class="odd">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="even">
<td><p><code>db_instance_class</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The size of the instance on which the relational database is run. For example: <code>db.t1.small</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>db_instance_identifier</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The identifier for the relational database.</p></td>
</tr>
<tr class="even">
<td><p><code>db_name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The name of the relational database. This value varies, depending on the <a href="http://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html">selected database engine</a>.</p></td>
</tr>
<tr class="odd">
<td><p><code>db_subnet_group_name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The name of the database subnet to which the relational database belongs.</p></td>
</tr>
<tr class="even">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="odd">
<td><p><code>engine</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The name of the relational database. For example: <code>postgres</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>engine_version</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The version of the relational database. For example: <code>9.2</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>iops</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer</p>
<p>The number of provisioned I/O operations per second for the allocated disk.</p></td>
</tr>
<tr class="even">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>master_user_password</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The password for the database super user.</p></td>
</tr>
<tr class="even">
<td><p><code>master_username</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The username for the database super user.</p></td>
</tr>
<tr class="odd">
<td><p><code>multi_az</code></p></td>
<td><p><strong>Ruby Type:</strong> true, false | <strong>Default Value:</strong> <code>false</code></p>
<p>Use to specify if the database instance is deployed to multiple availability zones.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The name of the instance.</p></td>
</tr>
<tr class="odd">
<td><p><code>port</code></p></td>
<td><p><strong>Ruby Type:</strong> Integer</p>
<p>The port number on which the database accepts connections.</p></td>
</tr>
<tr class="even">
<td><p><code>publicly_accessible</code></p></td>
<td><p><strong>Ruby Type:</strong> true, false | <strong>Default Value:</strong> <code>false</code></p>
<p>Use to specify that a relational database instance has DNS name that resolves to a routable public IP address.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Manage remote database instances**

``` ruby
aws_rds_instance 'rds-instance' do
  engine 'postgres'
  publicly_accessible false
  db_instance_class 'db.t1.micro'
  master_username 'user'
  master_user_password 'password'
  multi_az false
  db_subnet_group_name 'db-subnet-group'
end
```

aws_rds_parameter_group
==========================

The `aws_rds_parameter_group` resource is a driver-specific resource
used by Chef Provisioning. Use the `aws_rds_parameter_group` resource to
manage [a database parameter
group](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithParamGroups.html)
using Amazon Relational Database Service (RDS).

Syntax
------

A `aws_rds_parameter_group` resource block manages remote database
parameter group. For example:

``` ruby
aws_rds_parameter_group "db-parameter-group-with-parameters" do
  db_parameter_group_family "postgres9.4"
  description "testing provisioning"
  parameters [{:parameter_name => "max_connections", :parameter_value => "250", :apply_method => "pending-reboot"}]
end
```

The full syntax for all of the properties that are available to the
`aws_rds_parameter_group` resource is:

``` ruby
aws_rds_parameter_group 'name' do
  db_parameter_group_family            String
  description                          String
  parameters                           Array
end
```

where

-   `aws_rds_parameter_group` is the resource
-   `name` is the name of the resource block
-   `db_parameter_group_family`, `description` and `parameters` are
    properties of this resource, with the Ruby type shown. See
    "Properties" section below for more information about all of the
    properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>db_parameter_group_family</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The name of the DB parameter group family that this DB cluster parameter group is compatible with.</p></td>
</tr>
<tr class="even">
<td><p><code>description</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The customer-specified description for this DB cluster parameter group.</p></td>
</tr>
<tr class="odd">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="even">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The name of the instance.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Manage remote database parameter group**

``` ruby
aws_rds_parameter_group 'db-parameter-group-with-parameters' do
  db_parameter_group_family "postgres9.4"
  description "testing provisioning"
  parameters [{:parameter_name => "max_connections", :parameter_value => "250", :apply_method => "pending-reboot"}]
end
```

aws_rds_subnet_group
=======================

The `aws_rds_subnet_group` resource is a driver-specific resource used
by Chef Provisioning. Use the `aws_rds_subnet_group` resource to manage
[a collection of
subnets](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.html)
that exist in an Amazon Virtual Private Cloud (VPC) that is passed to
the Amazon Relational Database Service (RDS) instance. At least two
subnets must be specified.

Syntax
------

A `aws_rds_subnet_group` resource block manages subnets for relational
databases. For example:

``` ruby
aws_rds_subnet_group 'db-subnet-group' do
  db_subnet_group_description 'description'
  subnets ['subnet', 'subnet2' ]
end
```

The full syntax for all of the properties that are available to the
`aws_rds_subnet_group` resource is:

``` ruby
aws_rds_subnet_group 'name' do
  description                   String
  subnets                       String, Array, AwsSubnet, AWS::EC2::Subnet
end
```

where

-   `aws_rds_subnet_group` is the resource
-   `name` is the name of the resource block
-   `description` and `subnets` are properties of this resource, with
    the Ruby type shown. See "Properties" section below for more
    information about all of the properties that may be used with this
    resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="even">
<td><p><code>description</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The description of the subnet group.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The name of the subnet group.</p></td>
</tr>
<tr class="even">
<td><p><code>subnets</code></p></td>
<td><p><strong>Ruby Type:</strong> String, Array, AwsSubnet, AWS::EC2::Subnet</p>
<p>The subnets to be associated with the relational database service. At least two subnets must be specified.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Manage subnets for relational databases**

``` ruby
aws_rds_subnet_group 'db-subnet-group' do
  db_subnet_group_description 'description'
  subnets [ 'subnet', 'subnet2' ]
end
```

aws_route53_hosted_zone
==========================

The `aws_route53_hosted_zone` resource is a driver-specific resource
used by Chef Provisioning. Use the `aws_route53_hosted_zone` resource to
manage [a route53 hosted
zone](http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/AboutHZWorkingWith.html)
for a domain (such as example.com), and then you create resource record
sets to tell the Domain Name System how you want traffic to be routed
for that domain.

Syntax
------

A `aws_route53_hosted_zone` resource block manages hosted zone that
holds information about how you want to route traffic on the internet
for a domain, such as example.com, and its subdomains (apex.example.com,
acme.example.com).

``` ruby
aws_route53_hosted_zone "name" do
   comment  "testcomment"
end
```

The full syntax for all of the properties that are available to the
`aws_route53_hosted_zone` resource is:

``` ruby
aws_route53_hosted_zone 'name' do
  comment                   String
  aws_route53_zone_id       String
end
```

where

-   `aws_route53_hosted_zone` is the resource
-   `name` is the name of the resource block or the `zone_name`
-   `comment` and `aws_route53_zone_id` are properties of this resource,
    with the Ruby type shown. See "Properties" section below for more
    information about all of the properties that may be used with this
    resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="even">
<td><p><code>comment</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The comment included in the <code>CreateHostedZoneRequest</code> element. String &lt;= 256 characters.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The name of the domain.</p></td>
</tr>
<tr class="even">
<td><p><code>aws_route53_zone_id</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The resource name and the AWS ID have to be related here, since they're tightly coupled elsewhere.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Manages hosted zone that route traffic on the internet for a domain**

``` ruby
aws_route53_hosted_zone "name" do
   comment  "testcomment"
end
```

aws_route53_record_set
=========================

The `aws_route53_record_set` resource is a driver-specific resource used
by Chef Provisioning. Use the `aws_route53_record_set` resource to
manage [a route53 record
sets](http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/rrsets-working-with.html)
for a hosted zone.

Syntax
------

A `aws_route53_record_set` resource block manages resource record set
that contains information about how you want to route traffic for one
domain (such as example.com) or subdomain (such as www.example.com or
test.example.com). Resource record sets are stored in the hosted zone
for your domain.

``` ruby
aws_route53_hosted_zone "feegle.com" do
  record_sets {
    aws_route53_record_set "some-hostname CNAME" do
      rr_name "some-api-host.feegle.com"
      type "CNAME"
      ttl 3600
      resource_records ["some-other-host"]
    end
  }
end
```

The full syntax for all of the properties that are available to the
`aws_route53_record_set` resource is:

``` ruby
aws_route53_hosted_zone "name" do
  record_sets {
    aws_route53_record_set "record-set-name" do
      rr_name           String
      type              String
      ttl               Integer
      resource_records  Array
    end
  }
end
```

where

-   `aws_route53_record_set` is the resource under hosted zone.
-   `name` is the name of the resource block or the `zone_name`
-   `rr_name`, `type`, `ttl` and `resource_records` are properties of
    this resource, with the Ruby type shown. See "Properties" section
    below for more information about all of the properties that may be
    used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="even">
<td><p><code>rr_name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The resource record name.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The name of the hosted zone.</p></td>
</tr>
<tr class="even">
<td><p><code>aws_route53_zone_id</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The resource name and the AWS ID have to be related here, since they're tightly coupled elsewhere.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Manages resource record set on hosted zone that route traffic on the
internet for a domain**

``` ruby
aws_route53_hosted_zone "feegle.com" do
  record_sets {
    aws_route53_record_set "some-hostname CNAME" do
      rr_name "some-api-host.feegle.com"
      type "CNAME"
      ttl 3600
      resource_records ["some-other-host"]
    end
  }
end
```

aws_route_table
=================

The `aws_route_table` resource is a driver-specific resource used by
Chef Provisioning. Use the `aws_route_table` resource to [define a route
table](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Route_Tables.html)
within Amazon Virtual Private Cloud (VPC) (the networking layer of
Amazon EC2).

Syntax
------

A `aws_route_table` resource block manages route tables. For example:

``` ruby
aws_route_table 'name' do
  vpc 'ref-vpc'
  routes '0.0.0.0/0' => :internet_gateway
  aws_tags :chef_type => 'aws_route_table'
end
```

The full syntax for all of the properties that are available to the
`aws_route_table` resource is:

``` ruby
aws_route_table 'name' do
  ignore_route_targets          String, Array
  route_table_id                String
  routes                        Hash
  virtual_private_gateways      String, Array
  vpc                           String
end
```

where

-   `aws_route_table` is the resource
-   `name` is the name of the resource block and also the name of a
    route table in Amazon Virtual Private Cloud (VPC)
-   `routes`, and `vpc` are attributes of this resource, with the Ruby
    type shown. See "Properties" section below for more information
    about all of the properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>ignore_route_targets</code></p></td>
<td><p><strong>Ruby Type:</strong> String, Array</p>
<p>Use to specify a regular expression that describes one (or more) route targets that should be ignored. This property uses a regular expression because the full identifier for the instance or network interface is not known ahead of time. For example, in many cases a route for network address translation will points at the network interface that is attached to the network address translation. For example: <code>['^eni-']</code> to ignore all network interface routes (the ID prefix for all network interface routes is <code>eni</code>).</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the route table.</p></td>
</tr>
<tr class="odd">
<td><p><code>route_table_id</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the identifier for the route table.</p></td>
</tr>
<tr class="even">
<td><p><code>routes</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Use to specify a Hash that contains all of the routes associated with a route table. The destination (on the left side of the <code>=&gt;</code>) must be a classless inter-domain routing (CIDR) block. The target (on the right side of the <code>=&gt;</code>) may be the identifier for an internet gateway, an instance name, the identifier for network interface, a Chef Provisioning machine name, or a Chef Provisioning resource. For example:</p>
<div class="sourceCode" id="cb1"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb1-1"><a href="#cb1-1"></a>main_routes {</span>
<span id="cb1-2"><a href="#cb1-2"></a>  <span class="st">&#39;10.0.0.0/8&#39;</span> =&gt; <span class="st">&#39;internal_vpn&#39;</span>,</span>
<span id="cb1-3"><a href="#cb1-3"></a>  <span class="st">&#39;0.0.0.0/0&#39;</span> =&gt; <span class="st">:internet_gateway</span></span>
<span id="cb1-4"><a href="#cb1-4"></a>}</span></code></pre></div></td>
</tr>
<tr class="odd">
<td><p><code>virtual_private_gateways</code></p></td>
<td><p><strong>Ruby Type:</strong> String, Array</p>
<p>Use to specify an array that contains one (or more) virtual private gateway identifiers. For example:</p>
<div class="sourceCode" id="cb2"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb2-1"><a href="#cb2-1"></a>virtual_private_gateways [<span class="st">&#39;vgw-abcd1234&#39;</span>, <span class="st">&#39;vgw-abcd5678&#39;</span>]</span></code></pre></div></td>
</tr>
<tr class="even">
<td><p><code>vpc</code></p></td>
<td><p><strong>Ruby Type:</strong> String, AwsVpc, AWS::EC2::VPC</p>
<p>Required when creating a route table. Use to specify the Amazon Virtual Private Cloud (VPC) to which this route table is associated. This may be the name of an <code>aws_vpc</code> resource block that exists elsewhere in a cookbook, an actual <code>aws_vpc</code> resource block that exists in this recipe, or the name of the main route table in Amazon Virtual Private Cloud (VPC).</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Define a route table**

``` ruby
aws_route_table 'route-table' do
  vpc 'vpc'
  routes '0.0.0.0/0' => :internet_gateway
end
```

**Set up a VPC, route table, key pair, and machine**

{{% resource_provisioning_aws_route_table_define_vpc_key_machine %}}

aws_s3_bucket
===============

The `aws_s3_bucket` resource is a driver-specific resource used by Chef
Provisioning. Use the `aws_s3_bucket` resource to create an Amazon
Simple Storage Service (S3) bucket in which any amount of data is
stored, retrievable at any time from anywhere.

Syntax
------

A `aws_s3_bucket` resource block manages Amazon Simple Storage Service
(S3) buckets. For example:

``` ruby
aws_s3_bucket 'name' do
  enable_website_hosting true
  options({ :acl => 'private' })
  website_options :index_document => { :suffix => 'index.html' },
                  :error_document => { :key => 'not_found.html' }
end
```

The full syntax for all of the properties that are available to the
`aws_s3_bucket` resource is:

``` ruby
aws_s3_bucket 'name' do
  enable_website_hosting        true, false
  options                       Hash
  website_options               Hash
end
```

where

-   `aws_s3_bucket` is the resource
-   `name` is the name of the resource block and also the name of an
    Amazon Simple Storage Service (S3) bucket
-   `enable_website_hosting`, and `options` are properties of this
    resource, with the Ruby type shown. See "Properties" section below
    for more information about all of the properties that may be used
    with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>enable_website_hosting</code></p></td>
<td><p><strong>Ruby Type:</strong> true, false | <strong>Default Value:</strong> <code>false</code></p>
<p>Use to specify if an Amazon Simple Storage Service (S3) bucket is configured for for static website hosting.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the Amazon Simple Storage Service (S3) bucket.</p></td>
</tr>
<tr class="odd">
<td><p><code>options</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Use to specify a Hash that contains options for this resource. Default value: <code>{ }</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>website_options</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Use to specify a Hash that contains details about support for the index and custom error documents. Default value: <code>{ }</code>.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Add an Amazon S3 bucket**

``` ruby
require 'chef/provisioning/aws_driver'
with_driver 'aws'

aws_s3_bucket 'aws-bucket' do
  enable_website_hosting true
  website_options :index_document => {
    :suffix => "index.html"
  },
  :error_document => {
    :key => "not_found.html"
  }
end
```

**Delete an Amazon S3 bucket**

``` ruby
require 'chef/provisioning/aws_driver'
with_driver 'aws'

aws_s3_bucket 'aws-bucket' do
  action :destroy
end
```

aws_security_group
====================

The `aws_security_group` resource is a driver-specific resource used by
Chef Provisioning. Use the `aws_security_group` resource to define and
manage a security group in Amazon Web Services (AWS).

Syntax
------

A `aws_security_group` resource manages security groups in Amazon Web
Services (AWS). For example:

``` ruby
aws_security_group 'name' do
  vpc 'ref-vpc'
  inbound_rules '0.0.0.0/0' => [ 22, 80 ]
  outbound_rules [
    {:port => 22..22, :protocol => :tcp, :destinations => ['0.0.0.0/0'] }
  ]
  aws_tags :chef_type => 'aws_security_group'
end
```

The full syntax for all of the properties that are available to the
`aws_security_group` resource is:

``` ruby
aws_security_group 'name' do
  aws_tags                      Hash
  description                   String
  inbound_rules                 Hash, Array
  outbound_rules                Hash, Array
  security_group_id             String
  vpc                           String
end
```

where

-   `aws_security_group` is the resource
-   `name` is the name of the resource block and also the name of a
    security group in Amazon Web Services (AWS)
-   `inbound_rules`, `outbound_rules`, and `vpc` are properties of this
    resource, with the Ruby type shown. See "Properties" section below
    for more information about all of the properties that may be used
    with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>For example:</p>
<div class="sourceCode" id="cb1"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb1-1"><a href="#cb1-1"></a>aws_tags { <span class="st">:chef_type</span> =&gt; <span class="st">&#39;aws_security_group&#39;</span> }</span></code></pre></div></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>description</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify a description for the Amazon Web Services (AWS) security group.</p></td>
</tr>
<tr class="even">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="odd">
<td><p><code>inbound_rules</code></p></td>
<td><p><strong>Ruby Type:</strong> Array, Hash</p>
<p>Use to specify inbound rules. Rules must be specified in one of the following formats:</p>
<div class="sourceCode" id="cb2"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb2-1"><a href="#cb2-1"></a>[</span>
<span id="cb2-2"><a href="#cb2-2"></a>  { <span class="st">port: </span><span class="dv">22</span>, <span class="st">protocol: :tcp</span>, <span class="st">sources: </span>[&lt;source&gt;, &lt;source&gt;, ...] }</span>
<span id="cb2-3"><a href="#cb2-3"></a>]</span></code></pre></div>
<p>or:</p>
<div class="sourceCode" id="cb3"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb3-1"><a href="#cb3-1"></a>{</span>
<span id="cb3-2"><a href="#cb3-2"></a>  &lt;permitted_source&gt; =&gt; &lt;port&gt;,</span>
<span id="cb3-3"><a href="#cb3-3"></a>  ...</span>
<span id="cb3-4"><a href="#cb3-4"></a>}</span></code></pre></div>
<p>where</p>
<ul>
<li><code>port</code> is the port number or range. For example: <code>80</code> (number) or <code>1024..2048</code> (range)</li>
<li><code>protocol</code> is the protocol to be used. For example: <code>:http</code> or <code>:tcp</code></li>
<li><code>sources</code> is an IP address (or a classless inter-domain routing (CIDR) of IP addresses), a security group to be authorized, and/or a load balancer to be authorized.</li>
</ul>
<p>For example, IP addresses:</p>
<div class="sourceCode" id="cb4"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb4-1"><a href="#cb4-1"></a>inbound_rules <span class="st">&#39;1.2.3.4&#39;</span> =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb5"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb5-1"><a href="#cb5-1"></a>inbound_rules <span class="st">&#39;1.2.3.4/24&#39;</span> =&gt; <span class="dv">80</span></span></code></pre></div>
<p>Security groups:</p>
<div class="sourceCode" id="cb6"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb6-1"><a href="#cb6-1"></a>inbound_rules <span class="st">&#39;mysecuritygroup&#39;</span></span></code></pre></div>
<div class="sourceCode" id="cb7"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb7-1"><a href="#cb7-1"></a>inbound_rules { <span class="st">security_group: &#39;mysecuritygroup&#39;</span> }</span></code></pre></div>
<div class="sourceCode" id="cb8"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb8-1"><a href="#cb8-1"></a>inbound_rules <span class="st">&#39;sg-1234abcd&#39;</span> =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb9"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb9-1"><a href="#cb9-1"></a>inbound_rules aws_security_group(<span class="st">&#39;mysecuritygroup&#39;</span>) =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb10"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb10-1"><a href="#cb10-1"></a>inbound_rules <span class="dt">AWS</span>.ec2.security_groups.first =&gt; <span class="dv">80</span></span></code></pre></div>
<p>and load balancers:</p>
<div class="sourceCode" id="cb11"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb11-1"><a href="#cb11-1"></a>inbound_rules { <span class="st">load_balancer: &#39;myloadbalancer&#39;</span> } =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb12"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb12-1"><a href="#cb12-1"></a>inbound_rules <span class="st">&#39;elb-1234abcd&#39;</span> =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb13"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb13-1"><a href="#cb13-1"></a>inbound_rules load_balancer(<span class="st">&#39;myloadbalancer&#39;</span>) =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb14"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb14-1"><a href="#cb14-1"></a>inbound_rules <span class="dt">AWS</span>.ec2.security_groups.first =&gt; <span class="dv">80</span></span></code></pre></div></td>
</tr>
<tr class="even">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the Amazon Web Services (AWS) security group.</p></td>
</tr>
<tr class="even">
<td><p><code>outbound_rules</code></p></td>
<td><p><strong>Ruby Type:</strong> Array, Hash</p>
<p>Use to specify outbound rules. Rules must be specified in one of the following formats:</p>
<div class="sourceCode" id="cb15"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb15-1"><a href="#cb15-1"></a>[</span>
<span id="cb15-2"><a href="#cb15-2"></a>  { <span class="st">port: </span><span class="dv">22</span>, <span class="st">protocol: :tcp</span>, <span class="st">sources: </span>[&lt;source&gt;, &lt;source&gt;, ...] }</span>
<span id="cb15-3"><a href="#cb15-3"></a>]</span></code></pre></div>
<p>or:</p>
<div class="sourceCode" id="cb16"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb16-1"><a href="#cb16-1"></a>{</span>
<span id="cb16-2"><a href="#cb16-2"></a>  &lt;permitted_source&gt; =&gt; &lt;port&gt;,</span>
<span id="cb16-3"><a href="#cb16-3"></a>  ...</span>
<span id="cb16-4"><a href="#cb16-4"></a>}</span></code></pre></div>
<p>where</p>
<ul>
<li><code>port</code> is the port number or range. For example: <code>80</code> (number) or <code>1024..2048</code> (range)</li>
<li><code>protocol</code> is the protocol to be used. For example: <code>:http</code> or <code>:tcp</code></li>
<li><code>sources</code> is an IP address (or a classless inter-domain routing (CIDR) of IP addresses), a security group to be authorized, and/or a load balancer to be authorized.</li>
</ul>
<p>For example, IP addresses:</p>
<div class="sourceCode" id="cb17"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb17-1"><a href="#cb17-1"></a>outbound_rules <span class="st">&#39;1.2.3.4&#39;</span> =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb18"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb18-1"><a href="#cb18-1"></a>outbound_rules <span class="st">&#39;1.2.3.4/24&#39;</span> =&gt; <span class="dv">80</span></span></code></pre></div>
<p>Security groups:</p>
<div class="sourceCode" id="cb19"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb19-1"><a href="#cb19-1"></a>outbound_rules <span class="st">&#39;mysecuritygroup&#39;</span></span></code></pre></div>
<div class="sourceCode" id="cb20"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb20-1"><a href="#cb20-1"></a>outbound_rules { <span class="st">security_group: &#39;mysecuritygroup&#39;</span> }</span></code></pre></div>
<div class="sourceCode" id="cb21"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb21-1"><a href="#cb21-1"></a>outbound_rules <span class="st">&#39;sg-1234abcd&#39;</span> =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb22"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb22-1"><a href="#cb22-1"></a>outbound_rules aws_security_group(<span class="st">&#39;mysecuritygroup&#39;</span>) =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb23"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb23-1"><a href="#cb23-1"></a>outbound_rules <span class="dt">AWS</span>.ec2.security_groups.first =&gt; <span class="dv">80</span></span></code></pre></div>
<p>and load balancers:</p>
<div class="sourceCode" id="cb24"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb24-1"><a href="#cb24-1"></a>outbound_rules { <span class="st">load_balancer: &#39;myloadbalancer&#39;</span> } =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb25"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb25-1"><a href="#cb25-1"></a>outbound_rules <span class="st">&#39;elb-1234abcd&#39;</span> =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb26"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb26-1"><a href="#cb26-1"></a>outbound_rules load_balancer(<span class="st">&#39;myloadbalancer&#39;</span>) =&gt; <span class="dv">80</span></span></code></pre></div>
<div class="sourceCode" id="cb27"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb27-1"><a href="#cb27-1"></a>outbound_rules <span class="dt">AWS</span>.ec2.security_groups.first =&gt; <span class="dv">80</span></span></code></pre></div></td>
</tr>
<tr class="odd">
<td><p><code>vpc</code></p></td>
<td><p><strong>Ruby Type:</strong> String, AwsVpc, AWS::EC2::VPC</p>
<p>Use to specify the identifier for the Amazon Virtual Private Cloud (VPC).</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Delete a security group**

``` ruby
aws_security_group 'test-sg' do
  vpc 'test-vpc'
  action :delete
end
```

**Add inbound and outbound rules**

``` ruby
aws_security_group 'test-sg' do
  vpc 'test-vpc'
  inbound_rules '0.0.0.0/0'                   => 22,
                'other-sg'                    => 1024..2048,
                { load_balancer: 'other-lb' } => 1024..2048
  outbound_rules 443        => '0.0.0.0/0',
                 2048..4096 => 'other-sg',
                 2048..4096 => { load_balancer: 'other-lb' }
end
```

**Add and edit inbound rules**

``` ruby
aws_security_group 'test-sg' do
  vpc 'test-vpc'
  inbound_rules '0.0.0.0/0' => 80,
                'other-sg'  => [ 80, 1024..2048 ],
                '127.0.0.1' => 1024..2048,
                { load_balancer: 'other-lb' } => 1024..2048
end
```

**Add and edit outbound rules**

``` ruby
aws_security_group 'test-sg' do
  vpc 'test-vpc'
  outbound_rules 80                 => '0.0.0.0/0',
                 [ 80, 2048..4096 ] => 'other-sg',
                 2048..4096         => '127.0.0.1',
                 1024..2048         => { load_balancer: 'other-lb' }
end
```

**Add rules for specific ports, sources, and destinations**

``` ruby
aws_security_group 'test-sg' do
  vpc 'test-vpc'
  inbound_rules [
    { port: 80, sources: [ '0.0.0.0/0' ] },
    { port: [ 80, 1024..2048 ], sources: [ 'other-sg' ] },
    { port: 1024..2048, sources: [ '127.0.0.1' ] },
    { port: 1024..2048, sources: [ { load_balancer: 'other-lb' } ] }
  ]
  outbound_rules [
    { port: 80, destinations: [ '0.0.0.0/0', 'other-sg' ] },
    { port: [ 80, 2048..4096 ], destinations: [ 'other-sg' ] },
    { port: 2048..4096, destinations: [ 'other-sg', '127.0.0.1' ] },
    { port: 1024..2048, destinations: [ { load_balancer: 'other-lb' } ] }
  ]
end
```

**Define a security group for a cache cluster**

{{% resource_provisioning_aws_cache_cluster_create %}}

**Define a security group for a batch of machines**

{{% resource_provisioning_aws_security_group_machine_batch %}}

aws_server_certificate
========================

The `aws_server_certificate` resource is a driver-specific resource used
by Chef Provisioning. Use the `aws_server_certificate` resource to
[manage server
certificates](http://docs.aws.amazon.com/IAM/latest/UserGuide/ManagingServerCerts.html)
in Amazon EC2.

Syntax
------

A `aws_server_certificate` resource block manages server certificates in
Amazon Web Services (AWS). For example:

``` ruby
server_certificate 'name' do
  certificate_body 'file://public_key.pem'
  private_key 'file://private_key.pem'
end
```

The full syntax for all of the properties that are available to the
`aws_server_certificate` resource is:

``` ruby
aws_server_certificate 'name' do
  certificate_body              String
  private_key                   String
end
```

where

-   `aws_server_certificate` is the resource
-   `name` is the name of the resource block
-   `certificate_body` and `private_key` are properties of this
    resource, with the Ruby type shown. See "Properties" section below
    for more information about all of the properties that may be used
    with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="even">
<td><p><code>certificate_body</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the contents of the public key certificate in PEM-encoded format.</p></td>
</tr>
<tr class="odd">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="even">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify name of the server certificate.</p></td>
</tr>
<tr class="odd">
<td><p><code>private_key</code></p></td>
<td><p><strong>Ruby Type:</strong></p>
<p>Use to specify contents of the private key in PEM-encoded format.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Create certificate with certificate_body**

``` ruby
require 'chef/provisioning/aws_driver'

with_driver 'aws::us-west-1'
      cert_string = <<-CERT
-----BEGIN CERTIFICATE-----
MIICyjCCAbICAnyXMA0GCSqGSIb3DQEBDQUAMCcxJTAjBgNVBAMTHENoZWZQcm92
aXNpb25pbmdJbnRlcm1lZGlhdGUwHhcNMTcwODI0MTY0NTQyWhcNMjIwODIzMTY0
NTQyWjAuMQ4wDAYDVQQDEwVhbGljZTEcMBoGCSqGSIb3DQEJARYNYWxpY2VAY2hl
Zi5pbzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKxeXpigv/i4OWPB
kIBV3+HrKnEh05uEaq4UfJw0p6opKs4hyc92SvcFge4YBcLRbzhyMY5fUZAJXEla
csb6lEs2DMlW/KZGvfSMts2tVNbFVSsIsuSfhHVr9kemE42RPrtsO/0chOk2P/dl
P/KvXRF9AtEQe27/CWnJywCkP6tT6baZM6X+GGgAPUHvxN4BmJzz6uHpMVH+rBbb
t9ruLoSdX0zbaTRLesBC5Hc8uK2wzvDx0pUj+aKcWg5mtPBT6yReH6D5ePV2Jf10
9FGKMqPN6tOO6ZyAIWuKx3v09JzxmWGxNEyR65SNiI+ft092UFEKXYfgK58HZlWj
pBcOsHECAwEAATANBgkqhkiG9w0BAQ0FAAOCAQEAY1KXZv35hUER0WZz7JMKlvhI
-----END CERTIFICATE-----
CERT

      private_key_string = <<-KEY
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEArF5emKC/+Lg5Y8GQgFXf4esqcSHTm4RqrhR8nDSnqikqziHJ
z3ZK9wWB7hgFwtFvOHIxjl9RkAlcSVpyxvqUSzYMyVb8pka99Iy2za1U1sVVKwiy
5J+EdWv2R6YTjZE+u2w7/RyE6TY/92U/8q9dEX0C0RB7bv8JacnLAKQ/q1Pptpkz
pf4YaAA9Qe/E3gGYnPPq4ekxUf6sFtu32u4uhJ1fTNtpNEt6wELkdzy4rbDO8PHS
lSP5opxaDma08FPrJF4foPl49XYl/XT0UYoyo83q047pnIAha4rHe/T0nPGZYbE0
TJHrlI2Ij5+3T3ZQUQpdh+ArnwdmVaOkFw6wcQIDAQABAoIBAEz8TTXQPk3BQmiq
sHaRZFBML4Wd/RwttVQQ9GL0JZqbjnHIp5FQnUTdId4Mvq33yrwkTLvxGMXDWIOu
sSrsCkXZWzal8mv1lqveGVuduhG+yz5QQU5ZbNjhInt30q3dHG6rddOj5D0hLMq7
XyduaZwBALwNp4O4xySHq3Ka6ZEESpnY5o0hjclS7hAsiFnSW1/jI+yx
-----END RSA PRIVATE KEY-----
KEY

      certificate_chain_string = <<-CHAIN
-----BEGIN CERTIFICATE-----
MIICuzCCAaMCAgh0MA0GCSqGSIb3DQEBDQUAMB8xHTAbBgNVBAMTFENoZWZQcm92
aXNpb25pbmdSb290MB4XDTE3MDgyNDE2NDUwNloXDTIyMDgyMzE2NDUwNlowJzEl
MCMGA1UEAxMcQ2hlZlByb3Zpc2lvbmluZ0ludGVybWVkaWF0ZTCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBANl0H4XaW5iendZmf7r+QgztzwoEzuG1gyXO
SmO+gvrreo9C/lf6zA7x2tfWVs/bBIILpeJxOz1OzAid12o39bAREGxhcUNjQAcP
My82JmZpbu/xc6m2HoG9ycuM845MMp/dPO+iXZ6WEOHWTkdwu6u7HvxJAzMjvtOl
wLonJNlHDQ3toVLYb2PbiHxivqdTiNxdTATctKkzfU9An3XcPtBlPz2C6BVEjpIc
owlrA4UwTQLMFVCUhDKZvsO11UP2fhCjI0FIu7I1VEeWwEuZwdnhGsFg0IfH8YoE
VjioKcaKQm1Re517lePyLE3fw+sEH1+8osxE+xVT/5EMxqdU2jMCAwEAATANBgkq
hkiG9w0BAQ0FAAOCAQEAQIXWBs8m8U3Vp0rrGP5fIXqw680rf0Dhe9vz5ZnS7oJh
7/OWQtOG1YqsUNLMvbTUnilILgrckET280trfDg3/ucAwb5ScrBD3yja6CeGN5fo
gtw2MXUV3eA9ByAD4XKIWSvaROdHj+5wiCKWKMGvrSEPay5xEJm54VcALXHGk+Vf
jFNHTa/YFrlDXXupmI8HCYKwXrcooNcLuIkEmZIPX99s1vjFVT8oRdYLwFGt7AVC
ufkpMTlf/J9WjsabI5O+fzJYgdVm7QUq8Dg3tiM0RcZtO2cWus4DZl/KQkZx84f1
WGXzC2zbuS6DI9QPgkLeQ11O2kaeMqkNy6Tzr88XfA==
-----END CERTIFICATE-----
CHAIN

      aws_server_certificate "test-cert" do
        certificate_body cert_string
        private_key private_key_string
      end
```

**Create certificate with certificate_chain**

``` ruby
aws_server_certificate "test-cert1" do
            certificate_body cert_string
            private_key private_key_string
            certificate_chain certificate_chain_string
end
```

aws_sns_topic
===============

The `aws_sns_topic` resource is a driver-specific resource used by Chef
Provisioning. Use the `aws_sns_topic` resource to create a topic in
Amazon Simple Notification Service (SNS). A topic is a communication
channel through which messages are sent and an access point through
which publishers and subscribers communicate.

Syntax
------

A `aws_sns_topic` resource block manages topics in Amazon Simple
Notification Service (SNS). For example:

``` ruby
aws_sns_topic 'seapower' do
  arn 'arn:aws:sns:us-west-1:5060091557628:seapower'
end
```

The full syntax for all of the properties that are available to the
`aws_sns_topic` resource is:

``` ruby
aws_sns_topic 'name' do
  arn                           String
end
```

where

-   `aws_sns_topic` is the resource
-   `name` is the name of the resource block and also the name of a
    topic in Amazon Simple Notification Service (SNS)
-   `arn` and `name` are attributes of this resource, with the Ruby type
    shown. See "Properties" section below for more information about all
    of the properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>arn</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the Amazon Resource Name (ARN). When a topic is created, Amazon Simple Notification Service (SNS) will assign a unique Amazon Resource Name (ARN) to the topic, which will include the service name, region, and Amazon Web Services (AWS) identifier of the user and topic name. For example, a topic named <code>seapower</code> with a user account ID of <code>5060091557628</code> that is hosted in the <code>US West</code> region would be similar to: <code>arn:aws:sns:us-west-1:5060091557628:seapower</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="odd">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="even">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the unique name of an Amazon Simple Notification Service (SNS) topic. Must be a string of alphanumeric characters, hyphens (<code>-</code>), and/or underscores (<code>_</code>) that does not exceed 256 characters. (If a topic name is deleted, it may be reused as the name of a new topic.)</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Create an SNS topic**

``` ruby
aws_sns_topic 'seapower' do
  arn 'arn:aws:sns:us-west-1:5060091557628:seapower'
end
```

**Delete an SNS topic**

``` ruby
aws_sns_topic 'ref-sns-topic' do
  action :destroy
end
```

aws_sqs_queue
===============

The `aws_sqs_queue` resource is a driver-specific resource used by Chef
Provisioning. Use the `aws_sqs_queue` resource to create a queue in
Amazon Simple Queue Service (SQS). Amazon Simple Queue Service (SQS)
offers reliable and scalable hosted queues for storing messages as they
travel between distributed components of applications and without
requiring each component to be always available.

Syntax
------

A `aws_sqs_queue` resource block manages queues in Amazon Simple Queue
Service (SQS). For example:

``` ruby
aws_sqs_queue 'name' do
  options({ :delay_seconds => 1 })
end
```

The full syntax for all of the properties that are available to the
`aws_sqs_queue` resource is:

``` ruby
aws_sqs_queue 'name' do
  options                       Hash
end
```

where

-   `aws_sqs_queue` is the resource
-   `name` is the name of the resource block and also the name of a
    queue in Amazon Simple Queue Service (SQS)
-   `options` is a property of this resource, with the Ruby type shown.
    See "Properties" section below for more information about all of the
    properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the Amazon Simple Queue Service (SQS) queue.</p></td>
</tr>
<tr class="even">
<td><p><code>options</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Use to specify a Hash that <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_GetQueueAttributes.html">contains one (or more) attributes</a> for the Amazon Simple Queue Service (SQS) queue. For example:</p>
<div class="sourceCode" id="cb1"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb1-1"><a href="#cb1-1"></a>options({ <span class="st">:delay_seconds</span> =&gt; <span class="dv">1</span> })</span></code></pre></div></td>
</tr>
</tbody>
</table>

Examples
--------

**Create an SQS queue**

``` ruby
aws_sqs_queue 'ref-sqs-queue'
```

**Delete an SQS queue**

``` ruby
aws_sqs_queue 'ref-sqs-queue' do
  action :destroy
end
```

aws_subnet
===========

The `aws_subnet` resource is a driver-specific resource used by Chef
Provisioning. Use the `aws_subnet` resource to configure a subnet within
a defined virtual network in Amazon Virtual Private Cloud (VPC) (the
networking layer of Amazon EC2).

This defined virtual network is dedicated to a specific Amazon Web
Services (AWS) account and is logically isolated from other defined
virtual network in Amazon Web Services (AWS). One (or more) subnets may
exist within this defined virtual network.

Syntax
------

A `aws_subnet` resource block manages subnets in Amazon Web Services
(AWS). For example:

``` ruby
aws_subnet 'name' do
  vpc 'ref-vpc'
  cidr_block '10.0.0.0/24'
  availability_zone 'us-west-1a'
  map_public_ip_on_launch true
  route_table 'ref-public'
  aws_tags :chef_type => 'aws_subnet'
end
```

The full syntax for all of the properties that are available to the
`aws_subnet` resource is:

``` ruby
aws_subnet 'name' do
  availability_zone             String
  cidr_block                    String
  map_public_ip_on_launch       true, false
  route_table                   String
  subnet_id                     String
  vpc                           String
end
```

where

-   `aws_subnet` is the resource
-   `name` is the name of the resource block and also the name of a
    subnet within a defined virtual network in Amazon Virtual Private
    Cloud (VPC)
-   `availability_zone`, `cidr_block`, `map_public_ip_on_launch`,
    `route_table`, `vpc` are properties of this resource, with the Ruby
    type shown. See "Properties" section below for more information
    about all of the properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>availability_zone</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the availability zone for the subnet. For example: <code>us-east-1a</code> or <code>us-east-1b</code>. Default value: selected automatically by Amazon Web Services (AWS).</p></td>
</tr>
<tr class="even">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="odd">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="even">
<td><p><code>cidr_block</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Required. Use to specify the classless inter-domain routing (CIDR) block of IP address that are associated with a subnet. This must be a subset of the IP addresses in the defined virtual network and must not overlap with any other IP addresses used by any other subnet within this defined virtual network. For example, <code>'10.0.0.0/24'</code> will give 256 addresses and <code>'10.0.0.0/16'</code> will give 65536.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>map_public_ip_on_launch</code></p></td>
<td><p><strong>Ruby Type:</strong> true, false | <strong>Default Value:</strong> <code>false</code></p>
<p>Use to specify if public IP addresses are assigned to new instances in this subnet by default.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the subnet.</p></td>
</tr>
<tr class="odd">
<td><p><code>network_acl</code></p></td>
<td><p><strong>Ruby Type:</strong> String, AwsNetworkAcl, AWS::EC2::NetworkACL</p>
<p>Use to specify a network ACL to be associated with this subnet.</p></td>
</tr>
<tr class="even">
<td><p><code>route_table</code></p></td>
<td><p><strong>Ruby Type:</strong> String, AwsRouteTable, AWS::EC2::RouteTable</p>
<p>Use to specify the route table associated with this subnet. This may be the name of an <code>aws_route_table</code> resource block that exists elsewhere in a cookbook, an actual <code>aws_route_table</code> resource block that exists in this recipe, or the name of the main route table in Amazon Virtual Private Cloud (VPC). Default value: <code>:default_to_main</code>, which will detach any explicit route table that may be associated with this subnet, and then use the subnet that exists for the defined virtual network in which this subnet exists.</p></td>
</tr>
<tr class="odd">
<td><p><code>subnet_id</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the identifier for the subnet.</p></td>
</tr>
<tr class="even">
<td><p><code>vpc</code></p></td>
<td><p><strong>Ruby Type:</strong> String, AwsVpc, AWS::EC2::VPC</p>
<p>Use to specify the identifier for the Amazon Virtual Private Cloud (VPC).</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Remove the default subnet**

``` ruby
aws_subnet 'default' do
  availability_zone availability_zone
  action :destroy
end
```

**Add a public subnet**

``` ruby
aws_subnet 'public-#{availability_zone}' do
  availability_zone availability_zone
  cidr_block '10.0.#{128+class_c}.0/24'
  route_table 'public-routes'
  map_public_ip_on_launch true
end
```

**Define a subnet for a cache cluster**

{{% resource_provisioning_aws_cache_cluster_create %}}

**Define subnets for a batch of machines**

{{% resource_provisioning_aws_security_group_machine_batch %}}

aws_vpc
========

The `aws_vpc` resource is a driver-specific resource used by Chef
Provisioning. Use the `aws_vpc` resource to [launch resources into a
defined virtual network](http://aws.amazon.com/documentation/vpc/) with
Amazon Virtual Private Cloud (VPC) (the networking layer of Amazon EC2).

This defined virtual network is dedicated to a specific Amazon Web
Services (AWS) account and is logically isolated from other defined
virtual network in Amazon Web Services (AWS). Amazon EC2 instances may
be launched into the defined virtual network and it may be configured
for specific IP address ranges, subnets, routing tables, network
gateways, and security settings.

Use this resource along with the

-   `aws_subnet` resource to define instances that are contained within
    walled-off sub-sections of a defined virtual network
-   `aws_security_group` resource to define which instances can talk to
    each other
-   `aws_route_table` resource to define where traffic is located when
    an instance in a subnet talks to a specific IP address

Syntax
------

A `aws_vpc` resource block typically declares VPCs in Amazon Web
Services (AWS). For example:

``` ruby
aws_vpc 'name' do
  cidr_block '10.0.0.0/24'
  internet_gateway true
  instance_tenancy :default
  main_routes '0.0.0.0/0' => :internet_gateway
  dhcp_options 'ref-dhcp-options'
  enable_dns_support true
  enable_dns_hostnames true
  aws_tags :chef_type => 'aws_vpc'
end
```

The full syntax for all of the properties that are available to the
`aws_vpc` resource is:

``` ruby
aws_vpc 'name' do
  cidr_block                    String
  dhcp_options                  String
  enable_dns_hostnames          true, false
  enable_dns_support            true, false
  internet_gateway              true, false
  instance_tenancy              Symbol
  main_route_table              String
  main_routes                   Hash
  vpc_id                        String
end
```

where

-   `aws_vpc` is the resource
-   `name` is the name of the resource block and also the name of the
    defined virtual network in Amazon Virtual Private Cloud (VPC)
-   `cidr_block`, `dhcp_options`, `enable_dns_hostnames`,
    `enable_dns_support`, `internet_gateway`, `instance_tenancy`, and
    `main_routes` are properties of this resource, with the Ruby type
    shown. See "Properties" section below for more information about all
    of the properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="even">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="odd">
<td><p><code>cidr_block</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Required. Use to specify the classless inter-domain routing (CIDR) block of IP address that are associated with a defined virtual network. For example, <code>'10.0.0.0/24'</code> will give 256 addresses and <code>'10.0.0.0/16'</code> will give 65536.</p></td>
</tr>
<tr class="even">
<td><p><code>dhcp_options</code></p></td>
<td><p><strong>Ruby Type:</strong> AwsDhcpOptions, AWS::EC2::DHCPOptions, String</p>
<p>Use to specify the DHCP options for the defined virtual network.</p></td>
</tr>
<tr class="odd">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="even">
<td><p><code>enable_dns_hostnames</code></p></td>
<td><p><strong>Ruby Type:</strong> true</p>
<p>Use to specify if instances launched in a defined virtual network are assigned DNS hostnames. Possible values: <code>true</code> or <code>false</code>. When <code>true</code>, <code>enable_dns_support</code> must also be set to <code>true</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>enable_dns_support</code></p></td>
<td><p><strong>Ruby Type:</strong> true</p>
<p>Use to specify if DNS resolution is supported for a defined virtual network. When <code>false</code>, resolution of public DNS hostnames to IP addresses is disabled. When <code>true</code>, queries made to either the DNS server provided by Amazon Web Services (AWS) (and located at the 169.254.169.253 IP address) or the reserved IP address at the base of the defined virtual network range (plus two) will be resolved successfully. For example, a reserved IP address of <code>10.0.0.0/16</code> is located at <code>10.0.0.2</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>instance_tenancy</code></p></td>
<td><p><strong>Ruby Type:</strong> Symbol</p>
<p>Use to specify if an instance that runs in the defined virtual network instance will run on hardware that is dedicated to a single customer and is physically isolated at the host hardware level from non-dedicated instances. Set to <code>:default</code> when the instance runs on shared hardware. Set to <code>:dedicated</code> when the instance runs on dedicated hardware. Default value: <code>:default</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>internet_gateway</code></p></td>
<td><p><strong>Ruby Type:</strong> String, AWS::EC2::InternetGateway</p>
<p>Use to specify if a defined virtual network has an internet gateway. Possible values: <code>true</code> or <code>false</code>. When <code>true</code>, an internet gateway is created and attached to the defined virtual network. When <code>false</code>, an internet gateway is deleted when the <code>Owned</code> tag on the internet gateway is <code>true</code> and is detached if the tag is <code>false</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>main_route_table</code></p></td>
<td><p><strong>Ruby Type:</strong> String, AwsRouteTable, AWS::EC2::RouteTable</p>
<p>Use to specify the main route table. This may be the name of an <code>aws_route_table</code> resource block that exists elsewhere in a cookbook, an actual <code>aws_route_table</code> resource block that exists in this recipe, or the name of the main route table in Amazon Virtual Private Cloud (VPC).</p>
<p>Use <code>main_route_table</code> by itself (without specifying <code>main_routes</code>) to update the main route association to point to the specified route table. In this situation, use the <code>aws_route_table</code> resource to manage the route table itself.</p></td>
</tr>
<tr class="odd">
<td><p><code>main_routes</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Use to specify a Hash that defines the routes for the main route table. The destination (on the left side of the <code>=&gt;</code>) must be a classless inter-domain routing (CIDR) block. The target (on the right side of the <code>=&gt;</code>) may be the identifier for an internet gateway, an instance name, the identifier for network interface, a Chef Provisioning machine name, or a Chef Provisioning resource.</p>
<p>For example:</p>
<div class="sourceCode" id="cb1"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb1-1"><a href="#cb1-1"></a>main_routes {</span>
<span id="cb1-2"><a href="#cb1-2"></a><span class="st">&#39;10.0.0.0/8&#39;</span> =&gt; <span class="st">&#39;internal_vpn&#39;</span>,</span>
<span id="cb1-3"><a href="#cb1-3"></a><span class="st">&#39;0.0.0.0/0&#39;</span> =&gt; <span class="st">:internet_gateway</span></span>
<span id="cb1-4"><a href="#cb1-4"></a>}</span></code></pre></div>
<p>Use <code>main_routes</code> by itself (without specifying <code>main_route_table</code>) to update the default route table that is created when Amazon Web Services (AWS) creates Amazon Virtual Private Cloud (VPC).</p></td>
</tr>
<tr class="even">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="odd">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the name of the defined virtual network. Because the name of a Amazon Virtual Private Cloud (VPC) instance is not guaranteed to be unique for an account at Amazon Web Services (AWS), Chef Provisioning will store the associated identifier on the Chef Infra Server using the <code>data/aws_vpc/&lt;name&gt;</code> data bag.</p></td>
</tr>
<tr class="even">
<td><p><code>vpc_id</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the identifier for the Amazon Virtual Private Cloud (VPC).</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Add a defined virtual network (VPC)**

``` ruby
aws_vpc 'test-vpc' do
  cidr_block '10.0.0.0/24'
  internet_gateway true
end
```

**Add a defined virtual network (VPC) with route table**

``` ruby
aws_vpc 'provisioning-vpc' do
  cidr_block '10.0.0.0/24'
  internet_gateway true
  main_routes '0.0.0.0/0' => :internet_gateway
end
```

**Delete a VPC that has a defined route table**

An Amazon Virtual Private Cloud (VPC) cannot be deleted when it has a
non-main route table attached to it. To delete an Amazon Virtual Private
Cloud (VPC), first restore the `default` route table, and then delete
the Amazon Virtual Private Cloud (VPC) and the associated non-main route
table. For example:

``` ruby
aws_vpc 'ref-vpc' do
  main_route_table lazy {
    self.aws_object.route_tables.select {|r| !r.main?}.first
  }
  only_if { !self.aws_object.nil? }
end

aws_route_table 'ref-main-route-table' do
  action :destroy
end

aws_vpc 'ref-vpc' do
  action :destroy
end
```

**Set up a VPC, route table, key pair, and machine**

{{% resource_provisioning_aws_route_table_define_vpc_key_machine %}}

**Define a VPC for a cache cluster**

{{% resource_provisioning_aws_cache_cluster_create %}}

**Define a VPC for a batch of machines**

{{% resource_provisioning_aws_security_group_machine_batch %}}

aws_vpc_peering_connection
=============================

The `aws_vpc_peering_connection` resource is a driver-specific resource
used by Chef Provisioning. Use the `aws_vpc_peering_connection` resource
to create a connection between two VPCs that enables you to route
traffic between them using private IPv4 addresses or IPv6 addresses.

Syntax
------

A `aws_vpc_peering_connection` resource block manages an AWS peering
connection by specifying which VPCs to peer. For example:

``` ruby
aws_vpc_peering_connection 'test_peering_connection' do
  vpc 'test_vpc'
  peer_vpc 'test_vpc_2'
end
```

The full syntax for all of the properties that are available to the
`aws_vpc_peering_connection` resource is:

``` ruby
aws_vpc_peering_connection 'name' do
  vpc                           String, AwsVpc, ::Aws::EC2::Vpc
  peer_vpc                      String, AwsVpc, ::Aws::EC2::Vpc
  peer_owner_id                 String
  vpc_peering_connection_id     String
end
```

where

-   `aws_vpc_peering_connection` is the resource
-   `name` is the name of the resource block and also the name of this
    peering connection
-   `vpc`, `peer_vpc`, `peer_owner_id` and `vpc_peering_connection_id`
    are attributes of this resource, with the Ruby type shown. See
    "Properties" section below for more information about all of the
    properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>vpc</code></p></td>
<td><p><strong>Ruby Type:</strong> String, AwsVpc, ::Aws::EC2::Vpc</p>
<p>Use to specify the local VPC to peer.</p></td>
</tr>
<tr class="even">
<td><p><code>aws_tags</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Specify a Hash of Amazon Web Services (AWS) tags.</p>
<p>{{% resources_provisioning_aws_attributes_aws_tag_example %}}</p></td>
</tr>
<tr class="odd">
<td><p><code>chef_server</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>The Chef Infra Server on which IDs are located.</p></td>
</tr>
<tr class="even">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="odd">
<td><p><code>managed_entry_store</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::ManagedEntryStore</p>
<p>The managed entry store. For example: <code>Chef::Provisioning.chef_managed_entry_store(self.chef_server)</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The name of this peering connection.</p></td>
</tr>
<tr class="odd">
<td><p><code>peer_vpc</code></p></td>
<td><p><strong>Ruby Type:</strong> String, AwsVpc, ::Aws::EC2::Vpc</p>
<p>Use to specify the VPC to peer</p></td>
</tr>
<tr class="even">
<td><p><code>peer_owner_id</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the target VPC account ID to peer. If this value is not specified, it will be assumed that the target VPC belongs to the current account.</p></td>
</tr>
<tr class="odd">
<td><p><code>vpc_peering_connection_id</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the VPC peering connection ID.</p></td>
</tr>
</tbody>
</table>

Examples
--------

**Manages An AWS peering connection, specifying which VPC to peer**

``` ruby
aws_vpc_peering_connection 'test_peering_connection' do
  vpc 'test_vpc'
  peer_vpc 'test_vpc_2'
end
```

**Delete a VPC peering connection**

``` ruby
aws_vpc_peering_connection 'test_peering_connection3' do
  action :destroy
end
```
