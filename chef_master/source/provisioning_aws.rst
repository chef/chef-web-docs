=====================================================
AWS Driver Resources
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/provisioning_aws.rst>`__

.. warning:: .. tag notes_provisioning

             This functionality is available with Chef provisioning and is packaged in the Chef development kit. Chef provisioning is a framework that allows clusters to be managed by the chef-client and the Chef server in the same way nodes are managed: with recipes. Use Chef provisioning to describe, version, deploy, and manage clusters of any size and complexity using a common set of tools.

             .. end_tag

.. tag provisioning_summary

Chef provisioning is a collection of resources that enable the creation of machines and machine infrastructures using the chef-client. It has a plugin model that allows bootstrap operations to be done against any infrastructure, such as VirtualBox, DigitalOcean, Amazon EC2, LXC, bare metal, and more.

Chef provisioning is built around two major components: the **machine** resource and drivers.

.. end_tag

.. tag resources_provisioning

A driver-specific resource is a statement of configuration policy that:

* Describes the desired state for a configuration item that is created using Chef provisioning
* Declares the steps needed to bring that item to the desired state
* Specifies a resource type---such as ``package``, ``template``, or ``service``
* Lists additional details (also known as properties), as necessary
* Are grouped into recipes, which describe working configurations

.. end_tag

The following driver-specific resources are available for Amazon Web Services (AWS) and Chef provisioning:

* ``aws_auto_scaling_group``
* ``aws_cache_cluster``
* ``aws_cache_replication_group``
* ``aws_cache_subnet_group``
* ``aws_cloudsearch_domain``
* ``aws_dhcp_options``
* ``aws_ebs_volume``
* ``aws_eip_address``
* ``aws_image``
* ``aws_instance``
* ``aws_internet_gateway``
* ``aws_key_pair``
* ``aws_launch_configuration``
* ``aws_load_balancer``
* ``aws_network_acl``
* ``aws_network_interface``
* ``aws_rds_instance``
* ``aws_rds_subnet_group``
* ``aws_route_table``
* ``aws_s3_bucket``
* ``aws_security_group``
* ``aws_server_certificate``
* ``aws_sns_topic``
* ``aws_sqs_queue``
* ``aws_subnet``
* ``aws_vpc``

Common Actions
=====================================================
Every Chef provisioning Amazon Web Services (AWS) driver-specific resource has the following actions:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Action
     - Description
   * - ``:create``
     - Default. Use to create the specified object in Amazon Web Services (AWS).
   * - ``:destroy``
     - Use to destroy the specified object in Amazon Web Services (AWS).
   * - ``:purge``
     - Use to remove chargable items related to an object in Amazon Web Services (AWS).
   * - ``:nothing``
     - Use to do nothing.

aws_auto_scaling_group
=====================================================
The ``aws_auto_scaling_group`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_auto_scaling_group`` resource to manage auto scaling groups for Amazon EC2 instances. Auto Scaling ensures that the correct number of Amazon EC2 instances are available. Each auto scaling group is set to a minimum size, along with a maximum that a group does not exceed.

Syntax
-----------------------------------------------------
A ``aws_auto_scaling_group`` resource block declares auto scaling groups used for Amazon EC2 instances. For example:

.. code-block:: ruby

   aws_auto_scaling_group 'name' do
     availability_zones ['us-west-1a']
     desired_capacity 2
     min_size 1
     max_size 3
     launch_configuration 'ref-launch-configuration'
     load_balancers 'ref-load-balancer'
     options subnets: 'ref-subnet'
   end

The full syntax for all of the properties that are available to the ``aws_auto_scaling_group`` resource is:

.. code-block:: ruby

   aws_auto_scaling_group 'name' do
     availability_zones            Array
     desired_capacity              Integer
     min_size                      Integer
     max_size                      Integer
     launch_configuration          String
     load_balancers                Array
     options                       Hash
   end

where

* ``aws_auto_scaling_group`` is the resource
* ``name`` is the name of the resource block and also the name of the auto scaling group in Amazon EC2
* ``availability_zones``, ``desired_capacity``, ``max_size``, ``min_size``, ``launch_configuration``, ``load_balancers``, and ``options`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``availability_zones``
     - **Ruby Type:** Array

       Use to specify an array of availability zones to be associated with this auto scaling group. For example: ``['us-west-1a', 'us-west-1b', 'us-west-1c']``.
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``desired_capacity``
     - **Ruby Type:** Integer

       Use to specify the desired number of machines in the auto scaling group. For example: ``2``.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``launch_configuration``
     - **Ruby Type:** String

       Use to specify the name of a launch configuration.
   * - ``load_balancers``
     - **Ruby Type:** Array

       Use to specify the name of a load balancer.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``max_size``
     - **Ruby Type:** Integer

       Use to specify the maximum number of machines in the auto scaling group. For example: ``5``.
   * - ``min_size``
     - **Ruby Type:** Integer

       Use to specify the minimim number of machines in the auto scaling group. For example: ``1``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of the auto scaling group.
   * - ``options``
     - **Ruby Type:** Hash

       Use to specify a Hash of options to be applied to this auto scaling group.

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Define an auto scaling group**

.. tag resource_provisioning_aws_launch_config_auto_scale

.. To define an auto scaling group:

The following example uses the ``aws_launch_config`` resource to create an image and instance type, and then the ``aws_auto_scaling_group`` resource to build out a group of machines:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'

   with_driver 'aws::eu-west-1' do
     aws_launch_config 'launch-config-name' do
       image 'ami-f0b11187'
       instance_type 't1.micro'
     end

     aws_auto_scaling_group 'auto-scaling-group-name' do
       desired_capacity 3
       min_size 1
       max_size 5
       launch_config 'launch-config-name'
     end
   end

.. end_tag

**Destroy auto scaling group and associated launch configuration**

.. tag resource_provisioning_aws_launch_config_auto_scale_destroy

.. To destroy an auto scaling group:

The following example destroys an auto scaling group and the associated launch configuration:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'

   with_driver 'aws::eu-west-1' do
     aws_auto_scaling_group 'my-awesome-auto-scaling-group' do
       action :destroy
     end

     aws_launch_config 'my-sweet-launch-config' do
       action :destroy
     end
   end

.. end_tag

aws_cache_cluster
=====================================================
The ``aws_cache_cluster`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_cache_cluster`` resource to manage `cache clusters <http://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/WhatIs.html>`__ in Amazon ElastiCache.

Syntax
-----------------------------------------------------
A ``aws_cache_cluster`` resource block manages cache clusters in Amazon ElastiCache. For example:

.. code-block:: ruby

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

The full syntax for all of the properties that are available to the ``aws_cache_cluster`` resource is:

.. code-block:: ruby

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

where

* ``aws_cache_cluster`` is the resource
* ``name`` is the name of the resource block
* ``az_mode``, ``engine``, ``engine_version``, ``node_type``, ``number_nodes``, ``preferred_availability_zones``, and ``subnet_group_name`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``az_mode``
     - **Ruby Type:** String

       Use to specify if nodes in this group are created in a single availability zone or across multiple availability zones. This property is supported only for Memcached cache clusters. Possible values: ``single-az``, ``cross-az``.
   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``cluster_name``
     - **Ruby Type:** String

       Use to specify the name of the cache cluster.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``engine``
     - **Ruby Type:** String

       Use to specify the name of the cache engine for the cache cluster.
   * - ``engine_version``
     - **Ruby Type:** String

       Use to specify the version number of the cache engine.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``node_type``
     - **Ruby Type:** String

       Use to specify the compute and memory capacity of the nodes in the cache replication group. The possible values depend on the type of nodes: general purpose volumes, provisioned volumes, or magnetic volumes. For example: ``cache.t2.small``, ``cache.r3.2xlarge``, or ``cache.m3.large``.
   * - ``number_nodes``
     - **Ruby Type:** Integer

       Use to specify the initial number of cache nodes for a cache cluster. If Memcached is available, valid values are between ``1`` and ``20``. Default value: ``1``.
   * - ``preferred_availability_zone``
     - **Ruby Type:** String

       Use to specify the preferred availability zone for this cache cluster. Use this property **or** use ``preferred_availability_zones``.
   * - ``preferred_availability_zones``
     - **Ruby Types:** String, Array

       Use to specify an array of identifiers for Amazon EC2 availability zones available to this cache cluster. Use this property **or** use ``preferred_availability_zone``. For example:

       .. code-block:: ruby

          preferred_availability_zones [
            'PreferredAvailabilityZones.member.1=us-east-1a',
            'PreferredAvailabilityZones.member.2=us-east-1c',
            'PreferredAvailabilityZones.member.3=us-east-1d'
          ]

   * - ``security_groups``
     - **Ruby Type:** String, Array, AwsSecurityGroup, AWS::EC2::SecurityGroup

       Use to specify an array of identifiers for Amazon Virtual Private Cloud (VPC) security groups that are associated with this cache replication group.
   * - ``subnet_group_name``
     - **Ruby Type:** String

       Use to specify the name of the cache subnet group that to use with this cache replication group.

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Define a VPC, subnets, and security group for a cache cluster**

.. tag resource_provisioning_aws_cache_cluster_create

.. To define a VPC, subnets, and security group for a cache cluster:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'
   with_driver 'aws::us-east-1'

   aws_vpc 'test' do
     cidr_block '10.0.0.0/24'
   end

   aws_subnet 'public-test' do
     vpc 'test'
     availability_zone 'us-east-1a'
     cidr_block '10.0.0.0/24'
   end

   aws_cache_subnet_group 'test-ec' do
     description 'My awesome group'
     subnets [ 'public-test' ]
   end

   aws_security_group 'test-sg' do
     vpc 'test'
   end

   aws_cache_cluster 'my-cluster-mem' do
     az_mode 'single-az'
     number_nodes 2
     node_type 'cache.t2.micro'
     engine 'memcached'
     engine_version '1.4.14'
     security_groups ['test-sg']
     subnet_group_name 'test-ec'
   end

.. end_tag

aws_cache_replication_group
=====================================================
The ``aws_cache_replication_group`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_cache_replication_group`` resource to manage `replication groups for cache clusters <http://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/WhatIs.html>`__ in Amazon ElastiCache. A replication group is a collection of nodes, with a primary read/write cluster and up to five secondary, read-only clusters.

Syntax
-----------------------------------------------------
A ``aws_cache_replication_group`` resource block manages replication groups for cache clusters in Amazon Web Services (AWS). For example:

.. code-block:: ruby

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

The full syntax for all of the properties that are available to the ``aws_cache_replication_group`` resource is:

.. code-block:: ruby

   aws_cache_replication_group 'name' do
     az_mode                       String
     automatic_failover            TrueClass, FalseClass
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

where

* ``aws_cache_replication_group`` is the resource
* ``name`` is the name of the resource block
* ``automatic_failover``, ``engine``, ``engine_version``, ``node_type``, ``number_cache_clusters``, ``preferred_availability_zones``, and ``subnet_group_name`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``automatic_failover``
     - **Ruby Type:** TrueClass, FalseClass

       Use to specify if a read-only replica is automatically promoted to read/write primary if the existing primary fails. Set to ``true`` to enable automatic failover for this cache replication group.
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``description``
     - **Ruby Type:** String

       Use to specify the description for a cache replication group.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``engine``
     - **Ruby Type:** String

       Use to specify the name of the cache engine used for the cache clusters in this cache replication group.
   * - ``engine_version``
     - **Ruby Type:** String

       Use to specify the version number of the cache engine used for the cache clusters in this cache replication group.
   * - ``group_name``
     - **Ruby Type:** String

       Use to specify the name of the cache parameter group to be associated with this cache replication group. If this value is not specified, the default cache parameter group for the specified ``engine`` will be used.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``node_type``
     - **Ruby Type:** String

       Use to specify the compute and memory capacity of the nodes in the cache replication group. The possible values depend on the type of nodes: general purpose volumes, provisioned volumes, or magnetic volumes. For example: ``cache.t2.small``, ``cache.r3.2xlarge``, or ``cache.m3.large``.
   * - ``number_cache_clusters``
     - **Ruby Type:** Integer

       Use to specify the initial number of cache clusters for a cache replication group. If ``automatic_failover`` is ``true``, this number must be at least ``2``. Maximum value: ``6``.
   * - ``preferred_availability_zones``
     - **Ruby Type:** String, Array

       Use to specify an array of identifiers for Amazon EC2 availability zones into which the cache clusters associated with this cache replication group will be created. For example:

       .. code-block:: ruby

          preferred_availability_zones [
            'PreferredAvailabilityZones.member.1=us-east-1a',
            'PreferredAvailabilityZones.member.2=us-east-1c',
            'PreferredAvailabilityZones.member.3=us-east-1d'
          ]

   * - ``security_groups``
     - **Ruby Type:** String, Array, AwsSecurityGroup, AWS::EC2::SecurityGroup

       Use to specify an array of identifiers for Amazon Virtual Private Cloud (VPC) security groups that are associated with this cache replication group.
   * - ``subnet_group_name``
     - **Ruby Type:** String

       Use to specify the name of the cache subnet group that to use with this cache replication group.

Examples
-----------------------------------------------------
None.

aws_cache_subnet_group
=====================================================
The ``aws_cache_subnet_group`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_cache_subnet_group`` resource to manage a `cache subnet group <http://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/ManagingVPC.CreatingSubnetGroup.html>`__, which is a collection of subnets that may be designated for cache clusters in Amazon Virtual Private Cloud (VPC).

Syntax
-----------------------------------------------------
A ``aws_cache_subnet_group`` resource block manages cache subnet groups in Amazon Web Services (AWS). For example:

.. code-block:: ruby

   aws_cache_subnet_group 'name' do
     description 'Description of cache subnet group.'
     subnets [ 'subnet', 'subnet' ]
   end

The full syntax for all of the properties that are available to the ``aws_cache_subnet_group`` resource is:

.. code-block:: ruby

   aws_cache_subnet_group 'name' do
     description                   String
     group_name                    String  # defaults to 'name' if not specified
     subnets                       String, Array
   end

where

* ``aws_cache_subnet_group`` is the resource
* ``name`` is the name of the resource block (and is the same as the ``group_name`` property if ``group_name`` is not specified in the resource block)
* ``description`` and ``subnets`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``description``
     - **Ruby Type:** String

       Use to specify the description of a cache subnet group.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``group_name``
     - **Ruby Type:** String

       Use to specify the name of a cache subnet group.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``subnets``
     - **Ruby Type:** String, Array, AwsSubnet, AWS::EC2::Subnet

       Use to specify an array of subnets that are associated with this cache subnet group.

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Define a cache subnet group for a cache cluster**

.. tag resource_provisioning_aws_cache_cluster_create

.. To define a VPC, subnets, and security group for a cache cluster:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'
   with_driver 'aws::us-east-1'

   aws_vpc 'test' do
     cidr_block '10.0.0.0/24'
   end

   aws_subnet 'public-test' do
     vpc 'test'
     availability_zone 'us-east-1a'
     cidr_block '10.0.0.0/24'
   end

   aws_cache_subnet_group 'test-ec' do
     description 'My awesome group'
     subnets [ 'public-test' ]
   end

   aws_security_group 'test-sg' do
     vpc 'test'
   end

   aws_cache_cluster 'my-cluster-mem' do
     az_mode 'single-az'
     number_nodes 2
     node_type 'cache.t2.micro'
     engine 'memcached'
     engine_version '1.4.14'
     security_groups ['test-sg']
     subnet_group_name 'test-ec'
   end

.. end_tag

aws_cloudsearch_domain
=====================================================
The ``aws_cloudsearch_domain`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_cloudsearch_domain`` resource to manage `full-text searching for domains <https://aws.amazon.com/cloudsearch/>`__ in Amazon CloudSearch.

Syntax
-----------------------------------------------------
A ``aws_cloudsearch_domain`` resource block manages an Amazon CloudSearch domain. For example:

.. code-block:: ruby

   aws_cloudsearch_domain 'ref-cs-domain' do
     instance_type 'search.m1.small'
     partition_count 2
     replication_count 2
     index_fields [{:index_field_name => 'foo',
                    :index_field_type => 'text'}]
   end

The full syntax for all of the properties that are available to the ``aws_cloudsearch_domain`` resource is:

.. code-block:: ruby

   aws_cloudsearch_domain 'name' do
     access_policies               String
     cloudsearch_api_version       Integer
     index_fields                  Array
     instance_type                 String
     mutli_az                      TrueClass, FalseClass
     partition_count               Integer
     replication_count             Integer
   end

where

* ``aws_cloudsearch_domain`` is the resource
* ``name`` is the name of the resource block
* ``access_policies``, ``cloudsearch_api_version``, ``index_fields``, ``instance_type``, ``mutli_az``, ``partition_count``, and ``replication_count`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``access_policies``
     - **Ruby Type:** String

       The `access policies <http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-access.html>`__ for a domain.
   * - ``cloudsearch_api_version``
     - **Ruby Type:** Integer

       The version of the Amazon CloudSearch API to use when communicating with Amazon Web Services (AWS). Default value: ``20130101``. This value may be changed to the ``20110201`` API version for domains that are not accessible using the ``20130101`` API version.
   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``index_fields``
     - **Ruby Type:** Array

       An array that specifies `the desired index fields <http://docs.aws.amazon.com/cloudsearch/latest/developerguide/API_IndexField.html>`__. Must include the following keys: ``index_field_name`` and ``index_field_type``.
   * - ``instance_type``
     - **Ruby Type:** String

       The instance type: ``search.m1.small``, ``search.m3.medium``, ``search.m3.large``, ``search.m3.xlarge``, or ``search.m3.2xlarge``.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``mutli_az``
     - **Ruby Type:** TrueClass, FalseClass

       Specifies if the Amazon CloudSearch domain is deployed to multiple availability zones. Default value: ``false``.
   * - ``name``
     - **Ruby Type:** String

       The name of the domain.
   * - ``partition_count``
     - **Ruby Type:** Integer

       The number of pre-configured partitions for the domain.
   * - ``replication_count``
     - **Ruby Type:** Integer

       The number of replicas for each partition.

Examples
-----------------------------------------------------
None.

aws_dhcp_options
=====================================================
The ``aws_dhcp_options`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_dhcp_options`` resource to manage the `option sets <http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_DHCP_Options.html>`__ for the Dynamic Host Configuration Protocol (DHCP) protocol. Option sets are associated with the Amazon Web Services (AWS) account and may be used across all instances in Amazon Virtual Private Cloud (VPC).

Syntax
-----------------------------------------------------
A ``aws_dhcp_options`` resource block manages DHCP options for Amazon Web Services (AWS). For example:

.. code-block:: ruby

   aws_dhcp_options 'name' do
     domain_name          'example.com'
     domain_name_servers  %w(8.8.8.8 8.8.4.4)
     ntp_servers          %w(8.8.8.8 8.8.4.4)
     netbios_name_servers %w(8.8.8.8 8.8.4.4)
     netbios_node_type    2
     aws_tags :chef_type => 'aws_dhcp_options'
   end

The full syntax for all of the properties that are available to the ``aws_dhcp_options`` resource is:

.. code-block:: ruby

   aws_dhcp_options 'name' do
     dhcp_options_id               String
     domain_name                   String
     domain_name_servers           Array
     ntp_servers                   Array
     netbios_name_servers          Array
     netbios_node_type             Integer
   end

where

* ``aws_dhcp_options`` is the resource
* ``name`` is the name of the resource block and also the name of an option set for the Dynamic Host Configuration Protocol (DHCP) protocol
* ``domain_name``, ``domain_name_servers``, ``netbios_name_servers``, ``netbios_node_type``, and ``ntp_servers`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``dhcp_options_id``
     - **Ruby Type:** String

       Use to specify the identifier for the the Dynamic Host Configuration Protocol (DHCP) options set.
   * - ``domain_name``
     - **Ruby Type:** String

       Use to specify the domain name. For example: ``example.com``.
   * - ``domain_name_servers``
     - **Ruby Type:** Array

       Use to specify an array that contains up to four IP addresses for domain name servers. Default value: ``AmazonProvidedDNS``. For example: ``%w(8.8.8.8 8.8.4.4)``.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of the Dynamic Host Configuration Protocol (DHCP) options set.
   * - ``netbios_name_servers``
     - **Ruby Type:** Array

       Use to specify an array that contains up to four IP addresses of NetBIOS name servers. For example: ``%w(8.8.8.8 8.8.4.4)``.
   * - ``netbios_node_type``
     - **Ruby Type:** Integer

       Use to specify the NetBIOS node type. Possible values: ``1``, ``2``, ``4``, or ``8``. Recommended value: ``2``.
   * - ``ntp_servers``
     - **Ruby Type:** Array

       Use to specify an array that contains up to four IP addresses for Network Time Protocol (NTP) servers. For example: ``%w(8.8.8.8 8.8.4.4)``.

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Create an option set**

.. To create an option set:

.. code-block:: ruby

   aws_dhcp_options 'ref-dhcp-options' do
     domain_name 'example.com'
     domain_name_servers %w(8.8.8.8 8.8.4.4)
     netbios_name_servers %w(8.8.8.8 8.8.4.4)
     netbios_node_type 2
     aws_tags :chef_type => 'aws_dhcp_options'
   end

**Destroy an option set**

.. To delete an option set:

.. code-block:: ruby

   aws_dhcp_options 'ref-dhcp-options' do
     action :destroy
   end

aws_ebs_volume
=====================================================
The ``aws_ebs_volume`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_ebs_volume`` resource to manage a `block-level storage device <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumes.html>`__ that is attached to an Amazon EC2 instance.

Syntax
-----------------------------------------------------
A ``aws_ebs_volume`` resource block manages Amazon Elastic Block Store (EBS) volumes. For example:

.. code-block:: ruby

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

The full syntax for all of the properties that are available to the ``aws_ebs_volume`` resource is:

.. code-block:: ruby

   aws_ebs_volume 'name' do
     availability_zone             String
     device                        String
     encrypted                     TrueClass, FalseClass
     iops                          Integer
     machine                       String
     size                          Integer
     snapshot                      String
     volume_id                     String
     volume_type                   String
   end

where

* ``aws_ebs_volume`` is the resource
* ``name`` is the name of the resource block and also the name of a block-level storage device that is attached to an Amazon EC2 instance
* ``availability_zone``, ``device``, ``encrypted``, ``iops``, ``machine``, ``size``, and ``volume_type`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``availability_zone``
     - **Ruby Type:** String

       Use to specify the availability zone in which the block-level storage device is created.
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``device``
     - **Ruby Type:** String

       Use to specify the device to which the block-level storage device is attached. For example: ``'/dev/xvdg'``.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``encrypted``
     - **Ruby Type:** TrueClass, FalseClass

       Use to specify that a block-level storage device should be encrypted.
   * - ``iops``
     - **Ruby Type:** Integer

       Required for provisioned volumes. Use to specify the maximum number of input/output operations per second (IOPS) that the block-level storage device will support.
   * - ``machine``
     - **Ruby Type:** String, FalseClass, AwsInstance, AWS::EC2::Instance

       Use to specify the machine to be provisioned.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of the block-level storage device. Because the name of a Amazon Virtual Private Cloud (VPC) instance is not guaranteed to be unique for an account at Amazon Web Services (AWS), Chef provisioning will store the associated identifier on the Chef server using the ``data/aws_ebs_volume/<name>`` data bag.
   * - ``size``
     - **Ruby Type:** Integer

       Use to specify the size (in gigabytes) of the block-level storage device.
   * - ``snapshot``
     - **Ruby Type:** String

       Use to specify the name of a `snapshot <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSSnapshots.html>`__ of the block-level storage device. A snapshot is an incremental backups; only blocks on a device that have changed after the most recent snapshot are saved. A snapshot may be deleted; only data exclusive to that snapshot is deleted. The active snapshot contains all of the information needed to restore data to a new block-level storage device.
   * - ``volume_id``
     - **Ruby Type:** String

       Use to specify the identifier for the block-level storage device.
   * - ``volume_type``
     - **Ruby Type:** String

       Use to specify the volume type for the block-level storage device: `general purpose volumes <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html#EBSVolumeTypes_gp2>`__, `provisioned volumes <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html#EBSVolumeTypes_piops>`__, or `magnetic volumes <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html#EBSVolumeTypes_standard>`__.

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Create**

.. To create a machine:

.. code-block:: ruby

   aws_ebs_volume 'ref-volume-ebs' do
     availability_zone 'a'
     size 1
   end

**Attach to a machine**

.. To attach to a machine:

.. code-block:: ruby

   aws_ebs_volume 'ref-volume-ebs' do
     machine 'ref-machine-1'
     device '/dev/xvdf'
   end

**Reattach to a different device**

.. To reattach to a device:

.. code-block:: ruby

   aws_ebs_volume 'ref-volume-ebs' do
     device '/dev/xvdg'
   end

**Reattach to a different machine**

.. To reattach to a machine:

.. code-block:: ruby

   aws_ebs_volume 'ref-volume-ebs' do
     machine 'ref-machine-2'
     device '/dev/xvdf'
   end

**Skip a reattach attempt**

.. To skip a reattach attempt:

.. code-block:: ruby

   aws_ebs_volume 'ref-volume-ebs' do
     machine 'ref-machine-2'
     device '/dev/xvdf'
   end

**Create and attach**

.. To create and attach an EBS volume:

.. code-block:: ruby

   aws_ebs_volume 'ref-volume-ebs-2' do
     availability_zone 'a'
     size 1
     machine 'ref-machine-1'
     device '/dev/xvdf'
   end

**Detach**

.. To detach an EBS volume:

.. code-block:: ruby

   aws_ebs_volume 'ref-volume-ebs' do
     machine false
   end

**Destroy volumes for batch of machines, along with keys**

.. tag resource_provisioning_aws_ebs_volume_delete_machine_and_keys

.. To destroy a named group of machines along with keys:

The following example destroys an Amazon Elastic Block Store (EBS) volume for the specified batch of machines, along with any associated public and/or private keys:

.. code-block:: ruby

   ['ref-volume-ebs', 'ref-volume-ebs-2'].each { |volume|
     aws_ebs_volume volume do
       action :destroy
     end
   }

   machine_batch do
     machines 'ref-machine-1', 'ref-machine-2'
     action :destroy
   end

   aws_key_pair 'ref-key-pair-ebs' do
     action :destroy
   end

.. end_tag

aws_eip_address
=====================================================
The ``aws_eip_address`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_eip_address`` resource to manage an `an elastic IP address <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html>`__, a static IP address designed for dynamic cloud computing that is associated with an Amazon Web Services (AWS) account.

Syntax
-----------------------------------------------------
A ``aws_eip_address`` resource block manages elastic IP addresses. For example:

.. code-block:: ruby

   aws_eip_address 'name' do
     machine 'ref-machine1'
     associate_to_vpc true
     public_ip '205.32.21.0'
   end

The full syntax for all of the properties that are available to the ``aws_eip_address`` resource is:

.. code-block:: ruby

   aws_eip_address 'name' do
     associate_to_vpc              TrueClass, FalseClass
     machine                       String, FalseClass
     public_ip                     String
   end

where

* ``aws_eip_address`` is the resource
* ``name`` is the name of the resource block and also the name of an Amazon Elastic IP Address (EIP)
* ``associate_to_vpc``, ``machine``, and ``public_ip`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``associate_to_vpc``
     - **Ruby Type:** TrueClass, FalseClass

       Use to associate an elastic IP address to a virtual network that is defined in Amazon Virtual Private Cloud (VPC).
   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``machine``
     - **Ruby Type:** String, FalseClass

       Use to specify the machine to be provisioned.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of an elastic IP address.
   * - ``public_ip``
     - **Ruby Type:** String

       Use to specify the public IP address to associate with a Chef resource. This will default to the ``name`` of the resource block if that value is an IP address. If an IP address is already allocated to an Amazon Web Services (AWS) account, Chef will ensure that it is linked.

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Associate elastic IP address**

.. To associate an elastic IP address:

.. code-block:: ruby

   aws_eip_address 'frontend_ip' do
     public_ip '205.32.21.0'
   end

**Associate elastic IP address with a machine**

.. To associate an elastic IP address with a machine:

.. code-block:: ruby

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

**Associate elastic IP address to a machine's VPC**

.. To associate an elastic IP address to the VPC associated with a machine:

.. code-block:: ruby

   aws_eip_address 'Web_IP_1' do
     machine 'SRV_OR_Web_1'
     associate_to_vpc true
   end

aws_image
=====================================================
The ``aws_image`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_image`` resource to manage Amazon Machine Images (AMI) `images <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html>`__ that exist in Amazon EC2. An image includes a template for the root volume of an instance (operating system, application server, application, for example), launch permissions, and a block mapping device that attaches volumes to the instance when it is launched.

Syntax
-----------------------------------------------------
A ``aws_image`` resource block manages Amazon Web Services (AWS) images. For example:

.. code-block:: ruby

   aws_image 'name' do
     image_id 'image-1'
   end

The full syntax for all of the properties that are available to the ``aws_image`` resource is:

.. code-block:: ruby

   aws_image 'name' do
     image_id                      String
   end

where

* ``aws_image`` is the resource
* ``name`` is the name of the resource block and also the name of an Amazon Machine Images (AMI) image
* ``image_id`` is a property of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``image_id``
     - **Ruby Type:** String

       Use to specify the image identifier.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of an image.

Examples
-----------------------------------------------------
None.

aws_instance
=====================================================
The ``aws_instance`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_instance`` resource to manage an instance in Amazon EC2.

Syntax
-----------------------------------------------------
A ``aws_instance`` resource block manages Amazon Web Services (AWS) images. For example:

.. code-block:: ruby

   aws_instance 'name' do
     instance_id 'instance-1'
   end

The full syntax for all of the properties that are available to the ``aws_instance`` resource is:

.. code-block:: ruby

   aws_instance 'name' do
     instance_id                   String
   end

where

* ``aws_instance`` is the resource
* ``name`` is the name of the resource block and also the name of an instance in Amazon EC2
* ``instance_id`` is a property of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``instance_id``
     - **Ruby Type:** String

       Use to specify the instance identifier.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of the instance.

Examples
-----------------------------------------------------
None.

aws_internet_gateway
=====================================================
The ``aws_internet_gateway`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_internet_gateway`` resource to configure an internet gateway for a defined virtual network within Amazon Virtual Private Cloud (VPC) (the networking layer of Amazon EC2).

An internet gateway is a horizontally scaled, redundant, and highly available component within Amazon Virtual Private Cloud (VPC) that enables communication between instances within a defined virtual network and the Internet.

Syntax
-----------------------------------------------------
A ``aws_internet_gateway`` resource block manages internet gateways. For example:

.. code-block:: ruby

   aws_internet_gateway 'name' do
     internet_gateway_id '1234567890'
   end

The full syntax for all of the properties that are available to the ``aws_internet_gateway`` resource is:

.. code-block:: ruby

   aws_internet_gateway 'name' do
     internet_gateway_id           String
   end

where

* ``aws_internet_gateway`` is the resource
* ``name`` is the name of the resource block and also the name of an internet gateway for a defined virtual network within Amazon Virtual Private Cloud (VPC)
* ``internet_gateway_id`` is a property of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``internet_gateway_id``
     - **Ruby Type:** String

       Use to specify the identifier for an internet gateway.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of the internet gateway.

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Create an internet gateway**

.. To create an internet gateway:

.. code-block:: ruby

   aws_internet_gateway 'name' do
     internet_gateway_id '1234567890'
   end

aws_key_pair
=====================================================
The ``aws_key_pair`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_key_pair`` resource to manage key pairs in Amazon EC2.

Syntax
-----------------------------------------------------
A ``aws_key_pair`` resource block manages key pairs. For example:

.. code-block:: ruby

   aws_key_pair 'name' do
     private_key_options({
       :format => :pem,
       :type => :rsa,
       :regenerate_if_different => true
     })
     allow_overwrite true
   end

The full syntax for all of the properties that are available to the ``aws_key_pair`` resource is:

.. code-block:: ruby

   aws_key_pair 'name' do
     allow_overwrite               TrueClass, FalseClass
     private_key_options()         Hash
     private_key_path              String
     public_key_path               String
   end

where

* ``aws_key_pair`` is the resource
* ``name`` is the name of the resource block
* ``allow_overwrite`` and ``private_key_options`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``allow_overwrite``
     - **Ruby Type:** TrueClass, FalseClass

       Use to allow a public or private key to be overwritten.
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``private_key_options``
     - **Ruby Type:** Hash

       Use to specify a Hash that defines a list of parameters for the ``private_key`` resource that is used to generate this key.
   * - ``private_key_path``
     - **Ruby Type:** String

       Use to specify the path to the private key to use. The private key will be generated if it does not exist.
   * - ``public_key_path``
     - **Ruby Type:** String

       Use to specify the path to the public key to use. The public key will be generated if it does not exist.

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Create a private key, regenerate it if necessary**

.. To create a key pair:

.. code-block:: ruby

   aws_key_pair 'ref-key-pair' do
     private_key_options({
       :format => :pem,
       :type => :rsa,
       :regenerate_if_different => true
     })
     allow_overwrite true
   end

**Destroy volumes for batch of machines, along with keys**

.. tag resource_provisioning_aws_ebs_volume_delete_machine_and_keys

.. To destroy a named group of machines along with keys:

The following example destroys an Amazon Elastic Block Store (EBS) volume for the specified batch of machines, along with any associated public and/or private keys:

.. code-block:: ruby

   ['ref-volume-ebs', 'ref-volume-ebs-2'].each { |volume|
     aws_ebs_volume volume do
       action :destroy
     end
   }

   machine_batch do
     machines 'ref-machine-1', 'ref-machine-2'
     action :destroy
   end

   aws_key_pair 'ref-key-pair-ebs' do
     action :destroy
   end

.. end_tag

**Set up a VPC, route table, key pair, and machine**

.. tag resource_provisioning_aws_route_table_define_vpc_key_machine

.. To define a VPC, route table, key pair, and machine:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'

   with_driver 'aws::eu-west-1'

   aws_vpc 'test-vpc' do
     cidr_block '10.0.0.0/24'
     internet_gateway true
   end

   aws_route_table 'ref-public1' do
     vpc 'test-vpc'
     routes '0.0.0.0/0' => :internet_gateway
   end

   aws_key_pair 'ref-key-pair'

   m = machine 'test' do
     machine_options bootstrap_options: { key_name: 'ref-key-pair' }
   end

.. end_tag

aws_launch_configuration
=====================================================
The ``aws_launch_configuration`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_launch_configuration`` resource to manage Amazon Machine Images (AMI) `instance types <http://aws.amazon.com/amazon-linux-ami/instance-type-matrix/>`__, also known as pre-configured templates for instances in Amazon EC2.

Syntax
-----------------------------------------------------
A ``aws_launch_configuration`` resource block manages launch configurations. For example:

.. code-block:: ruby

   aws_launch_configuration 'ref-launch-configuration' do
     image 'ref-machine_image1'
     instance_type 't1.micro'
     options security_groups: 'ref-sg1'
   end

The full syntax for all of the properties that are available to the ``aws_launch_configuration`` resource is:

.. code-block:: ruby

   aws_launch_configuration 'ref-launch-configuration' do
     image                         String
     instance_type                 String
     options                       Hash
   end

where

* ``aws_launch_configuration`` is the resource
* ``name`` is the name of the resource block and also the name of an Amazon Machine Images (AMI) instance type
* ``image``, ``instance_type``, and ``options`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``image``
     - **Ruby Type:** String, AWS::EC2::Image

       Use to specify the Amazon Machine Images (AMI)
   * - ``instance_type``
     - **Ruby Type:** String

       Use to specify the Amazon Machine Images (AMI) instance type. For example: ``T2``, ``M4``, or ``C3``.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of the Amazon Machine Images (AMI).
   * - ``options``
     - **Ruby Type:** Hash

       Use to specify a Hash that contains a list of options used by this resource. Default value: ``{ }``.

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Define an AMI instance type**

.. To define an AMI instance type:

.. code-block:: ruby

   aws_launch_configuration 'ref-launch-configuration' do
     image 'ref-machine_image1'
     instance_type 't1.micro'
     options security_groups: 'ref-sg1'
   end

**Define an auto scaling group**

.. tag resource_provisioning_aws_launch_config_auto_scale

.. To define an auto scaling group:

The following example uses the ``aws_launch_config`` resource to create an image and instance type, and then the ``aws_auto_scaling_group`` resource to build out a group of machines:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'

   with_driver 'aws::eu-west-1' do
     aws_launch_config 'launch-config-name' do
       image 'ami-f0b11187'
       instance_type 't1.micro'
     end

     aws_auto_scaling_group 'auto-scaling-group-name' do
       desired_capacity 3
       min_size 1
       max_size 5
       launch_config 'launch-config-name'
     end
   end

.. end_tag

**Destroy auto scaling group and associated launch configuration**

.. tag resource_provisioning_aws_launch_config_auto_scale_destroy

.. To destroy an auto scaling group:

The following example destroys an auto scaling group and the associated launch configuration:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'

   with_driver 'aws::eu-west-1' do
     aws_auto_scaling_group 'my-awesome-auto-scaling-group' do
       action :destroy
     end

     aws_launch_config 'my-sweet-launch-config' do
       action :destroy
     end
   end

.. end_tag

aws_load_balancer
=====================================================
The ``aws_load_balancer`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_load_balancer`` resource to manage load balancers that exist in Amazon Elastic Load Balancing (ELB).

Syntax
-----------------------------------------------------
A ``aws_load_balancer`` resource block manages load balancers in Amazon Web Services (AWS). For example:

.. code-block:: ruby

   aws_load_balancer 'name' do
     load_balancer_id 'lb-1'
   end

The full syntax for all of the properties that are available to the ``aws_load_balancer`` resource is:

.. code-block:: ruby

   aws_load_balancer 'name' do
     load_balancer_id              String
   end

where

* ``aws_load_balancer`` is the resource
* ``name`` is the name of the resource block and also the name of a load balancer in Amazon Elastic Load Balancing (ELB)
* ``load_balancer_id`` is an properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``load_balancer_id``
     - **Ruby Type:** String

       Use to specify the identifier for the load balancer.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of the load balancer.

Examples
-----------------------------------------------------
None.

aws_network_acl
=====================================================
The ``aws_network_acl`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_network_acl`` resource to manage network ACLs.

Syntax
-----------------------------------------------------
A ``aws_network_acl`` resource block typically declares ACLs for networks. For example:

.. code-block:: ruby

   aws_network_acl 'name' do
     vpc 'ref-vpc'
     inbound_rules '0.0.0.0/0' => [ 22, 80 ]
     outbound_rules [
       {:port => 22..22, :protocol => :tcp, :destinations => ['0.0.0.0/0'] }
     ]
     aws_tags :chef_type => 'aws_security_group'
   end

The full syntax for all of the properties that are available to the ``network_acl`` resource is:

.. code-block:: ruby

   aws_network_acl 'name' do
     inbound_rules                 Array, Hash
     network_acl_id                String
     outbound_rules                Array, Hash
     vpc                           String, AwsVpc, AWS::EC2::VPC
   end

where

* ``aws_network_acl`` is the resource
* ``name`` is the name of the resource block
* ``inbound_rules``, ``network_acl_id``, ``outbound_rules``, and ``vpc`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``inbound_rules``
     - **Ruby Type:** Array, Hash

       Use to specify inbound rules. Rules must be specified in one of the following formats:

       .. code-block:: ruby

          [
            { port: 22, protocol: :tcp, sources: [<source>, <source>, ...] }
          ]

       or:

       .. code-block:: ruby

          {
            <permitted_source> => <port>,
            ...
          }

       where

       * ``port`` is the port number or range. For example: ``80`` (number) or ``1024..2048`` (range)
       * ``protocol`` is the protocol to be used. For example: ``:http`` or ``:tcp``
       * ``sources`` is an IP address (or a classless inter-domain routing (CIDR) of IP addresses), a security group to be authorized, and/or a load balancer to be authorized.

       For example, IP addresses:

       .. code-block:: ruby

          inbound_rules '1.2.3.4' => 80

       .. code-block:: ruby

          inbound_rules '1.2.3.4/24' => 80

       Security groups:

       .. code-block:: ruby

          inbound_rules 'mysecuritygroup'

       .. code-block:: ruby

          inbound_rules { security_group: 'mysecuritygroup' }

       .. code-block:: ruby

          inbound_rules 'sg-1234abcd' => 80

       .. code-block:: ruby

          inbound_rules aws_security_group('mysecuritygroup') => 80

       .. code-block:: ruby

          inbound_rules AWS.ec2.security_groups.first => 80

       and load balancers:

       .. code-block:: ruby

          inbound_rules { load_balancer: 'myloadbalancer' } => 80

       .. code-block:: ruby

          inbound_rules 'elb-1234abcd' => 80

       .. code-block:: ruby

          inbound_rules load_balancer('myloadbalancer') => 80

       .. code-block:: ruby

          inbound_rules AWS.ec2.security_groups.first => 80

   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of the network ACL.
   * - ``network_acl_id``
     - **Ruby Type:** String

       Use to specify the identifier for the network ACL.
   * - ``outbound_rules``
     - **Ruby Type:** Array, Hash

       Use to specify outbound rules. Rules must be specified in one of the following formats:

       .. code-block:: ruby

          [
            { port: 22, protocol: :tcp, sources: [<source>, <source>, ...] }
          ]

       or:

       .. code-block:: ruby

          {
            <permitted_source> => <port>,
            ...
          }

       where

       * ``port`` is the port number or range. For example: ``80`` (number) or ``1024..2048`` (range)
       * ``protocol`` is the protocol to be used. For example: ``:http`` or ``:tcp``
       * ``sources`` is an IP address (or a classless inter-domain routing (CIDR) of IP addresses), a security group to be authorized, and/or a load balancer to be authorized.

       For example, IP addresses:

       .. code-block:: ruby

          outbound_rules '1.2.3.4' => 80

       .. code-block:: ruby

          outbound_rules '1.2.3.4/24' => 80

       Security groups:

       .. code-block:: ruby

          outbound_rules 'mysecuritygroup'

       .. code-block:: ruby

          outbound_rules { security_group: 'mysecuritygroup' }

       .. code-block:: ruby

          outbound_rules 'sg-1234abcd' => 80

       .. code-block:: ruby

          outbound_rules aws_security_group('mysecuritygroup') => 80

       .. code-block:: ruby

          outbound_rules AWS.ec2.security_groups.first => 80

       and load balancers:

       .. code-block:: ruby

          outbound_rules { load_balancer: 'myloadbalancer' } => 80

       .. code-block:: ruby

          outbound_rules 'elb-1234abcd' => 80

       .. code-block:: ruby

          outbound_rules load_balancer('myloadbalancer') => 80

       .. code-block:: ruby

          outbound_rules AWS.ec2.security_groups.first => 80

   * - ``vpc``
     - **Ruby Type:** String, AwsVpc, AWS::EC2::VPC

       Required when creating a route table. Use to specify the Amazon Virtual Private Cloud (VPC) to which this route table is associated. This may be the name of an ``aws_vpc`` resource block that exists elsewhere in a cookbook, an actual ``aws_vpc`` resource block that exists in this recipe, or the name of the main route table in Amazon Virtual Private Cloud (VPC).

Examples
-----------------------------------------------------
None.

aws_network_interface
=====================================================
The ``aws_network_interface`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_network_interface`` resource to manage a network interface in Amazon EC2.

Syntax
-----------------------------------------------------
A ``aws_network_interface`` resource block manages network interfaces in Amazon Web Services (AWS). For example:

.. code-block:: ruby

   aws_network_interface 'name' do
     machine 'ref-machine-eni-1'
     device_index 2
     subnet 'ref-subnet-eni'
     security_groups ['ref-sg1-eni']
     description 'ref-eni-desc'
   end

The full syntax for all of the properties that are available to the ``aws_network_interface`` resource is:

.. code-block:: ruby

   aws_network_interface 'name' do
     description                   String
     device_index                  Integer
     machine                       String, FalseClass
     network_interface_id          String
     private_ip_address            String
     subnet                        String
     security_groups               Array
   end

where

* ``aws_network_interface`` is the resource
* ``name`` is the name of the resource block and also the name of a network interface in Amazon EC2
* ``description``, ``device_index``, ``machine``, ``security_groups``, and ``subnet`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``description``
     - **Ruby Type:** String

       Use to specify the description for the network interface.
   * - ``device_index``
     - **Ruby Type:** Integer

       Use to specify the attachment order position for the network interface.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``machine``
     - **Ruby Type:** String, FalseClass, AwsInstance, AWS::EC2::Instance

       Use to specify the name of the Amazon Web Services (AWS) instance for which this network interface is associated.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of the network interface.
   * - ``network_interface_id``
     - **Ruby Type:** String

       Use to specify the identifier for the network interface.
   * - ``private_ip_address``
     - **Ruby Type:** String

       Use to assign a private IP address to the network interface. This IP address will be used as the primary IP address.
   * - ``security_groups``
     - **Ruby Type:** Array

       Use to specify one (or more) security group identifiers to be associated with the network interface.
   * - ``subnet``
     - **Ruby Type:** String, AWS::EC2::Subnet, AwsSubnet

       Use to specify the identifier of the subnet to be associated with the network interface.

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Define a network interface**

.. To define a network interface:

.. code-block:: ruby

   aws_network_interface 'ref-eni-1' do
     machine 'ref-machine-eni-1'
     subnet 'ref-subnet-eni'
     security_groups ['ref-sg1-eni']
     description 'ref-eni-desc'
   end

aws_rds_instance
=====================================================
The ``aws_rds_instance`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_rds_instance`` resource to manage `a database instance <https://aws.amazon.com/rds/>`__ using Amazon Relational Database Service (RDS).

Syntax
-----------------------------------------------------
A ``aws_rds_instance`` resource block manages remote database instances. For example:

.. code-block:: ruby

   aws_rds_instance 'rds-instance' do
     engine 'postgres'
     publicly_accessible false
     db_instance_class 'db.t1.micro'
     master_username 'user'
     master_user_password 'password'
     multi_az false
     db_subnet_group_name 'db-subnet-group'
   end

The full syntax for all of the properties that are available to the ``aws_rds_instance`` resource is:

.. code-block:: ruby

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
     multi_az                      TrueClass, FalseClass
     port                          Integer
     publicly_accessible           TrueClass, FalseClass
   end

where

* ``aws_rds_instance`` is the resource
* ``name`` is the name of the resource block
* ``additional_options``, ``allocated_storage``, ``db_instance_class``, ``db_instance_identifier``, ``db_name``, ``db_subnet_group_name``, ``engine``, ``engine_version``, ``iops``, ``master_user_password``, ``master_username``, ``multi_az``, ``port``, and ``publicly_accessible`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``additional_options``
     - **Ruby Type:** Hash

       A Hash of `options to be passed <http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/RDS/Client.html#create_db_instance-instance_method>`__ to the API for Amazon Relational Database Service (RDS). Default value: ``{ }``.
   * - ``allocated_storage``
     - **Ruby Type:** Integer

       The size (in gigabytes) allocated to the relational database.
   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``db_instance_class``
     - **Ruby Type:** String

       The size of the instance on which the relational database is run. For example: ``db.t1.small``.
   * - ``db_instance_identifier``
     - **Ruby Type:** String

       The identifier for the relational database.
   * - ``db_name``
     - **Ruby Type:** String

       The name of the relational database. This value varies, depending on the `selected database engine <http://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html>`__.
   * - ``db_subnet_group_name``
     - **Ruby Type:** String

       The name of the database subnet to which the relational database belongs.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``engine``
     - **Ruby Type:** String

       The name of the relational database. For example: ``postgres``.
   * - ``engine_version``
     - **Ruby Type:** String

       The version of the relational database. For example: ``9.2``.
   * - ``iops``
     - **Ruby Type:** Integer

       The number of provisioned I/O operations per second for the allocated disk.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``master_user_password``
     - **Ruby Type:** String

       The password for the database super user.
   * - ``master_username``
     - **Ruby Type:** String

       The username for the database super user.
   * - ``multi_az``
     - **Ruby Type:** TrueClass, FalseClass

       Use to specify if the database instance is deployed to multiple availability zones. Default value: ``false``.
   * - ``name``
     - **Ruby Type:** String

       The name of the instance.
   * - ``port``
     - **Ruby Type:** Integer

       The port number on which the database accepts connections.
   * - ``publicly_accessible``
     - **Ruby Type:** TrueClass, FalseClass

       Use to specify that a relational database instance has DNS name that resolves to a routable public IP address. Default value: ``false``.

Examples
-----------------------------------------------------
None.

aws_rds_subnet_group
=====================================================
The ``aws_rds_subnet_group`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_rds_subnet_group`` resource to manage `a collection of subnets <http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.html>`__ that exist in an Amazon Virtual Private Cloud (VPC) that is passed to the Amazon Relational Database Service (RDS) instance. At least two subnets must be specified.

Syntax
-----------------------------------------------------
A ``aws_rds_subnet_group`` resource block manages subnets for relational databases. For example:

.. code-block:: ruby

   aws_rds_subnet_group 'db-subnet-group' do
     db_subnet_group_description 'description'
     subnets ['subnet', 'subnet2.aws_object.id' ]
   end

The full syntax for all of the properties that are available to the ``aws_rds_subnet_group`` resource is:

.. code-block:: ruby

   aws_rds_subnet_group 'name' do
     description                   String
     subnets                       String, Array, AwsSubnet, AWS::EC2::Subnet
   end

where

* ``aws_rds_subnet_group`` is the resource
* ``name`` is the name of the resource block
* ``description`` and ``subnets`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``description``
     - **Ruby Type:** String

       The description of the subnet group.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       The name of the subnet group.
   * - ``subnets``
     - **Ruby Type:** String, Array, AwsSubnet, AWS::EC2::Subnet

       The subnets to be associated with the relational database service. At least two subnets must be specified.

Examples
-----------------------------------------------------
None.

aws_route_table
=====================================================
The ``aws_route_table`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_route_table`` resource to `define a route table <http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Route_Tables.html>`__ within Amazon Virtual Private Cloud (VPC) (the networking layer of Amazon EC2).

Syntax
-----------------------------------------------------
A ``aws_route_table`` resource block manages route tables. For example:

.. code-block:: ruby

   aws_route_table 'name' do
     vpc 'ref-vpc'
     routes '0.0.0.0/0' => :internet_gateway
     aws_tags :chef_type => 'aws_route_table'
   end

The full syntax for all of the properties that are available to the ``aws_route_table`` resource is:

.. code-block:: ruby

   aws_route_table 'name' do
     ignore_route_targets          String, Array
     route_table_id                String
     routes                        Hash
     virtual_private_gateways      String, Array
     vpc                           String
   end

where

* ``aws_route_table`` is the resource
* ``name`` is the name of the resource block and also the name of a route table in Amazon Virtual Private Cloud (VPC)
* ``routes``, and ``vpc`` are attributes of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``ignore_route_targets``
     - **Ruby Type:** String, Array

       Use to specify a regular expression that describes one (or more) route targets that should be ignored. This property uses a regular expression because the full identifier for the instance or network interface is not known ahead of time. For example, in many cases a route for network address translation will points at the network interface that is attached to the network address translation. For example: ``['^eni-']`` to ignore all network interface routes (the ID prefix for all network interface routes is ``eni``).
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of the route table.
   * - ``route_table_id``
     - **Ruby Type:** String

       Use to specify the identifier for the route table.
   * - ``routes``
     - **Ruby Type:** Hash

       Use to specify a Hash that contains all of the routes associated with a route table. The destination (on the left side of the ``=>``) must be a classless inter-domain routing (CIDR) block. The target (on the right side of the ``=>``) may be the identifier for an internet gateway, an instance name, the identifier for network interface, a Chef provisioning machine name, or a Chef provisioning resource. For example:

       .. code-block:: ruby

          main_routes {
            '10.0.0.0/8' => 'internal_vpn',
            '0.0.0.0/0' => :internet_gateway
          }

   * - ``virtual_private_gateways``
     - **Ruby Type:** String, Array

       Use to specify an array that contains one (or more) virtual private gateway identifiers. For example:

       .. code-block:: ruby

          virtual_private_gateways ['vgw-abcd1234', 'vgw-abcd5678']

   * - ``vpc``
     - **Ruby Type:** String, AwsVpc, AWS::EC2::VPC

       Required when creating a route table. Use to specify the Amazon Virtual Private Cloud (VPC) to which this route table is associated. This may be the name of an ``aws_vpc`` resource block that exists elsewhere in a cookbook, an actual ``aws_vpc`` resource block that exists in this recipe, or the name of the main route table in Amazon Virtual Private Cloud (VPC).

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Define a route table**

.. To define a route table:

.. code-block:: ruby

   aws_route_table 'route-table' do
     vpc 'vpc'
     routes '0.0.0.0/0' => :internet_gateway
   end

**Set up a VPC, route table, key pair, and machine**

.. tag resource_provisioning_aws_route_table_define_vpc_key_machine

.. To define a VPC, route table, key pair, and machine:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'

   with_driver 'aws::eu-west-1'

   aws_vpc 'test-vpc' do
     cidr_block '10.0.0.0/24'
     internet_gateway true
   end

   aws_route_table 'ref-public1' do
     vpc 'test-vpc'
     routes '0.0.0.0/0' => :internet_gateway
   end

   aws_key_pair 'ref-key-pair'

   m = machine 'test' do
     machine_options bootstrap_options: { key_name: 'ref-key-pair' }
   end

.. end_tag

aws_s3_bucket
=====================================================
The ``aws_s3_bucket`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_s3_bucket`` resource to create an Amazon Simple Storage Service (S3) bucket in which any amount of data is stored, retrievable at any time from anywhere.

Syntax
-----------------------------------------------------
A ``aws_s3_bucket`` resource block manages Amazon Simple Storage Service (S3) buckets. For example:

.. code-block:: ruby

   aws_s3_bucket 'name' do
     enable_website_hosting true
     options({ :acl => 'private' })
     website_options :index_document => { :suffix => 'index.html' },
                     :error_document => { :key => 'not_found.html' }
   end

The full syntax for all of the properties that are available to the ``aws_s3_bucket`` resource is:

.. code-block:: ruby

   aws_s3_bucket 'name' do
     enable_website_hosting        TrueClass, FalseClass
     options                       Hash
     website_options               Hash
   end

where

* ``aws_s3_bucket`` is the resource
* ``name`` is the name of the resource block and also the name of an Amazon Simple Storage Service (S3) bucket
* ``enable_website_hosting``, and ``options`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``enable_website_hosting``
     - **Ruby Type:** TrueClass, FalseClass

       Use to specify if an Amazon Simple Storage Service (S3) bucket is configured for for static website hosting. Default value: ``false``.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of the Amazon Simple Storage Service (S3) bucket.
   * - ``options``
     - **Ruby Type:** Hash

       Use to specify a Hash that contains options for this resource. Default value: ``{ }``.
   * - ``website_options``
     - **Ruby Type:** Hash

       Use to specify a Hash that contains details about support for the index and custom error documents. Default value: ``{ }``.

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Add an Amazon S3 bucket**

.. To add an Amazon S3 bucket:

.. code-block:: ruby

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

**Delete an Amazon S3 bucket**

.. To delete an Amazon S3 bucket:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'
   with_driver 'aws'

   aws_s3_bucket 'aws-bucket' do
     action :destroy
   end

aws_security_group
=====================================================
The ``aws_security_group`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_security_group`` resource to define and manage a security group in Amazon Web Services (AWS).

Syntax
-----------------------------------------------------
A ``aws_security_group`` resource manages security groups in Amazon Web Services (AWS). For example:

.. code-block:: ruby

   aws_security_group 'name' do
     vpc 'ref-vpc'
     inbound_rules '0.0.0.0/0' => [ 22, 80 ]
     outbound_rules [
       {:port => 22..22, :protocol => :tcp, :destinations => ['0.0.0.0/0'] }
     ]
     aws_tags :chef_type => 'aws_security_group'
   end

The full syntax for all of the properties that are available to the ``aws_security_group`` resource is:

.. code-block:: ruby

   aws_security_group 'name' do
     aws_tags                      Hash
     description                   String
     inbound_rules                 Hash, Array
     outbound_rules                Hash, Array
     security_group_id             String
     vpc                           String
   end

where

* ``aws_security_group`` is the resource
* ``name`` is the name of the resource block and also the name of a security group in Amazon Web Services (AWS)
* ``inbound_rules``, ``outbound_rules``, and ``vpc`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       For example:

       .. code-block:: ruby

          aws_tags { :chef_type => 'aws_security_group' }

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``description``
     - **Ruby Type:** String

       Use to specify a description for the Amazon Web Services (AWS) security group.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``inbound_rules``
     - **Ruby Type:** Array, Hash

       Use to specify inbound rules. Rules must be specified in one of the following formats:

       .. code-block:: ruby

          [
            { port: 22, protocol: :tcp, sources: [<source>, <source>, ...] }
          ]

       or:

       .. code-block:: ruby

          {
            <permitted_source> => <port>,
            ...
          }

       where

       * ``port`` is the port number or range. For example: ``80`` (number) or ``1024..2048`` (range)
       * ``protocol`` is the protocol to be used. For example: ``:http`` or ``:tcp``
       * ``sources`` is an IP address (or a classless inter-domain routing (CIDR) of IP addresses), a security group to be authorized, and/or a load balancer to be authorized.

       For example, IP addresses:

       .. code-block:: ruby

          inbound_rules '1.2.3.4' => 80

       .. code-block:: ruby

          inbound_rules '1.2.3.4/24' => 80

       Security groups:

       .. code-block:: ruby

          inbound_rules 'mysecuritygroup'

       .. code-block:: ruby

          inbound_rules { security_group: 'mysecuritygroup' }

       .. code-block:: ruby

          inbound_rules 'sg-1234abcd' => 80

       .. code-block:: ruby

          inbound_rules aws_security_group('mysecuritygroup') => 80

       .. code-block:: ruby

          inbound_rules AWS.ec2.security_groups.first => 80

       and load balancers:

       .. code-block:: ruby

          inbound_rules { load_balancer: 'myloadbalancer' } => 80

       .. code-block:: ruby

          inbound_rules 'elb-1234abcd' => 80

       .. code-block:: ruby

          inbound_rules load_balancer('myloadbalancer') => 80

       .. code-block:: ruby

          inbound_rules AWS.ec2.security_groups.first => 80

   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of the Amazon Web Services (AWS) security group.
   * - ``outbound_rules``
     - **Ruby Type:** Array, Hash

       Use to specify outbound rules. Rules must be specified in one of the following formats:

       .. code-block:: ruby

          [
            { port: 22, protocol: :tcp, sources: [<source>, <source>, ...] }
          ]

       or:

       .. code-block:: ruby

          {
            <permitted_source> => <port>,
            ...
          }

       where

       * ``port`` is the port number or range. For example: ``80`` (number) or ``1024..2048`` (range)
       * ``protocol`` is the protocol to be used. For example: ``:http`` or ``:tcp``
       * ``sources`` is an IP address (or a classless inter-domain routing (CIDR) of IP addresses), a security group to be authorized, and/or a load balancer to be authorized.

       For example, IP addresses:

       .. code-block:: ruby

          outbound_rules '1.2.3.4' => 80

       .. code-block:: ruby

          outbound_rules '1.2.3.4/24' => 80

       Security groups:

       .. code-block:: ruby

          outbound_rules 'mysecuritygroup'

       .. code-block:: ruby

          outbound_rules { security_group: 'mysecuritygroup' }

       .. code-block:: ruby

          outbound_rules 'sg-1234abcd' => 80

       .. code-block:: ruby

          outbound_rules aws_security_group('mysecuritygroup') => 80

       .. code-block:: ruby

          outbound_rules AWS.ec2.security_groups.first => 80

       and load balancers:

       .. code-block:: ruby

          outbound_rules { load_balancer: 'myloadbalancer' } => 80

       .. code-block:: ruby

          outbound_rules 'elb-1234abcd' => 80

       .. code-block:: ruby

          outbound_rules load_balancer('myloadbalancer') => 80

       .. code-block:: ruby

          outbound_rules AWS.ec2.security_groups.first => 80

   * - ``vpc``
     - **Ruby Type:** String, AwsVpc, AWS::EC2::VPC

       Use to specify the identifier for the Amazon Virtual Private Cloud (VPC).

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Delete a security group**

.. To delete a security group:

.. code-block:: ruby

   aws_security_group 'test-sg' do
     vpc 'test-vpc'
     action :delete
   end

**Add inbound and outbound rules**

.. To add inbound and outbound rules:

.. code-block:: ruby

   aws_security_group 'test-sg' do
     vpc 'test-vpc'
     inbound_rules '0.0.0.0/0'                   => 22,
                   'other-sg'                    => 1024..2048,
                   { load_balancer: 'other-lb' } => 1024..2048
     outbound_rules 443        => '0.0.0.0/0',
                    2048..4096 => 'other-sg',
                    2048..4096 => { load_balancer: 'other-lb' }
   end

**Add and edit inbound rules**

.. To add and edit inbound rules:

.. code-block:: ruby

   aws_security_group 'test-sg' do
     vpc 'test-vpc'
     inbound_rules '0.0.0.0/0' => 80,
                   'other-sg'  => [ 80, 1024..2048 ],
                   '127.0.0.1' => 1024..2048,
                   { load_balancer: 'other-lb' } => 1024..2048
   end

**Add and edit outbound rules**

.. To add and edit outbound rules:

.. code-block:: ruby

   aws_security_group 'test-sg' do
     vpc 'test-vpc'
     outbound_rules 80                 => '0.0.0.0/0',
                    [ 80, 2048..4096 ] => 'other-sg',
                    2048..4096         => '127.0.0.1',
                    1024..2048         => { load_balancer: 'other-lb' }
   end

**Add rules for specific ports, sources, and destinations**

.. To add rules for specific ports, sources, and destinations:

.. code-block:: ruby

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

**Define a security group for a cache cluster**

.. tag resource_provisioning_aws_cache_cluster_create

.. To define a VPC, subnets, and security group for a cache cluster:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'
   with_driver 'aws::us-east-1'

   aws_vpc 'test' do
     cidr_block '10.0.0.0/24'
   end

   aws_subnet 'public-test' do
     vpc 'test'
     availability_zone 'us-east-1a'
     cidr_block '10.0.0.0/24'
   end

   aws_cache_subnet_group 'test-ec' do
     description 'My awesome group'
     subnets [ 'public-test' ]
   end

   aws_security_group 'test-sg' do
     vpc 'test'
   end

   aws_cache_cluster 'my-cluster-mem' do
     az_mode 'single-az'
     number_nodes 2
     node_type 'cache.t2.micro'
     engine 'memcached'
     engine_version '1.4.14'
     security_groups ['test-sg']
     subnet_group_name 'test-ec'
   end

.. end_tag

**Define a security group for a batch of machines**

.. tag resource_provisioning_aws_security_group_machine_batch

.. To define a VPC, subnets, and security group for a batch of machines:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'

   with_driver 'aws::eu-west-1'
     aws_vpc 'provisioning-vpc' do
       cidr_block '10.0.0.0/24'
       internet_gateway true
       main_routes '0.0.0.0/0' => :internet_gateway
     end

     aws_subnet 'provisioning-vpc-subnet-a' do
       vpc 'provisioning-vpc'
       cidr_block '10.0.0.0/26'
       availability_zone 'eu-west-1a'
       map_public_ip_on_launch true
     end

     aws_subnet 'provisioning-vpc-subnet-b' do
       vpc 'provisioning-vpc'
       cidr_block '10.0.0.128/26'
       availability_zone 'eu-west-1a'
       map_public_ip_on_launch true
     end

   machine_batch do
     machines %w(mario-a mario-b)
     action :destroy
   end

   machine_batch do
     machine 'mario-a' do
       machine_options bootstrap_options: { subnet: 'provisioning-vpc-subnet-a' }
     end

     machine 'mario-b' do
       machine_options bootstrap_options: { subnet: 'provisioning-vpc-subnet-b' }
     end
   end

   aws_security_group 'provisioning-vpc-security-group' do
     inbound_rules [
       {:port => 2223, :protocol => :tcp, :sources => ['10.0.0.0/24'] },
       {:port => 80..100, :protocol => :udp, :sources => ['1.1.1.0/24'] }
     ]
     outbound_rules [
       {:port => 2223, :protocol => :tcp, :destinations => ['1.1.1.0/16'] },
       {:port => 8080, :protocol => :tcp, :destinations => ['2.2.2.0/24'] }
     ]
     vpc 'provisioning-vpc'
   end

.. end_tag

aws_server_certificate
=====================================================
The ``aws_server_certificate`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_server_certificate`` resource to `manage server certificates <http://docs.aws.amazon.com/IAM/latest/UserGuide/ManagingServerCerts.html>`__ in Amazon EC2.

Syntax
-----------------------------------------------------
A ``aws_server_certificate`` resource block manages server certificates in Amazon Web Services (AWS). For example:

.. code-block:: ruby

   server_certificate 'name' do
     certificate_body 'file://public_key.pem'
     private_key 'file://private_key.pem'
   end

The full syntax for all of the properties that are available to the ``aws_server_certificate`` resource is:

.. code-block:: ruby

   aws_server_certificate 'name' do
     certificate_body              String
     private_key                   String
   end

where

* ``aws_server_certificate`` is the resource
* ``name`` is the name of the resource block
* ``certificate_body`` and ``private_key`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``certificate_body``
     - **Ruby Type:** String

       Use to specify the contents of the public key certificate in PEM-encoded format.
   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify name of the server certificate.
   * - ``private_key``
     - **Ruby Type:**

       Use to specify contents of the private key in PEM-encoded format.

Examples
-----------------------------------------------------
None.

aws_sns_topic
=====================================================
The ``aws_sns_topic`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_sns_topic`` resource to create a topic in Amazon Simple Notification Service (SNS). A topic is a communication channel through which messages are sent and an access point through which publishers and subscribers communicate.

Syntax
-----------------------------------------------------
A ``aws_sns_topic`` resource block manages topics in Amazon Simple Notification Service (SNS). For example:

.. code-block:: ruby

   aws_sns_topic 'seapower' do
     arn 'arn:aws:sns:us-west-1:5060091557628:seapower'
   end

The full syntax for all of the properties that are available to the ``aws_sns_topic`` resource is:

.. code-block:: ruby

   aws_sns_topic 'name' do
     arn                           String
   end

where

* ``aws_sns_topic`` is the resource
* ``name`` is the name of the resource block and also the name of a topic in Amazon Simple Notification Service (SNS)
* ``arn`` and ``name`` are attributes of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``arn``
     - **Ruby Type:** String

       Use to specify the Amazon Resource Name (ARN). When a topic is created, Amazon Simple Notification Service (SNS) will assign a unique Amazon Resource Name (ARN) to the topic, which will include the service name, region, and Amazon Web Services (AWS) identifier of the user and topic name. For example, a topic named ``seapower`` with a user account ID of ``5060091557628`` that is hosted in the ``US West`` region would be similar to: ``arn:aws:sns:us-west-1:5060091557628:seapower``.
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the unique name of an Amazon Simple Notification Service (SNS) topic. Must be a string of alphanumeric characters, hyphens (``-``), and/or underscores (``_``) that does not exceed 256 characters. (If a topic name is deleted, it may be reused as the name of a new topic.)

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Create an SNS topic**

.. To create an SNS topic:

.. code-block:: ruby

   aws_sns_topic 'seapower' do
     arn 'arn:aws:sns:us-west-1:5060091557628:seapower'
   end

**Delete an SNS topic**

.. To delete an SNS topic:

.. code-block:: ruby

   aws_sns_topic 'ref-sns-topic' do
     action :destroy
   end

aws_sqs_queue
=====================================================
The ``aws_sqs_queue`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_sqs_queue`` resource to create a queue in Amazon Simple Queue Service (SQS). Amazon Simple Queue Service (SQS) offers reliable and scalable hosted queues for storing messages as they travel between distributed components of applications and without requiring each component to be always available.

Syntax
-----------------------------------------------------
A ``aws_sqs_queue`` resource block manages queues in Amazon Simple Queue Service (SQS). For example:

.. code-block:: ruby

   aws_sqs_queue 'name' do
     options({ :delay_seconds => 1 })
   end

The full syntax for all of the properties that are available to the ``aws_sqs_queue`` resource is:

.. code-block:: ruby

   aws_sqs_queue 'name' do
     options                       Hash
   end

where

* ``aws_sqs_queue`` is the resource
* ``name`` is the name of the resource block and also the name of a queue in Amazon Simple Queue Service (SQS)
* ``options`` is a property of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of the Amazon Simple Queue Service (SQS) queue.
   * - ``options``
     - **Ruby Type:** Hash

       Use to specify a Hash that `contains one (or more) attributes <http://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_GetQueueAttributes.html>`__ for the Amazon Simple Queue Service (SQS) queue. For example:

       .. code-block:: ruby

          options({ :delay_seconds => 1 })

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Create an SQS queue**

.. To create a queue in Amazon Simple Queue Service (SQS):

.. code-block:: ruby

   aws_sqs_queue 'ref-sqs-queue'

**Delete an SQS queue**

.. To delete a queue in Amazon Simple Queue Service (SQS):

.. code-block:: ruby

   aws_sqs_queue 'ref-sqs-queue' do
     action :destroy
   end

aws_subnet
=====================================================
The ``aws_subnet`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_subnet`` resource to configure a subnet within a defined virtual network in Amazon Virtual Private Cloud (VPC) (the networking layer of Amazon EC2).

This defined virtual network is dedicated to a specific Amazon Web Services (AWS) account and is logically isolated from other defined virtual network in Amazon Web Services (AWS). One (or more) subnets may exist within this defined virtual network.

Syntax
-----------------------------------------------------
A ``aws_subnet`` resource block manages subnets in Amazon Web Services (AWS). For example:

.. code-block:: ruby

   aws_subnet 'name' do
     vpc 'ref-vpc'
     cidr_block '10.0.0.0/24'
     availability_zone 'us-west-1a'
     map_public_ip_on_launch true
     route_table 'ref-public'
     aws_tags :chef_type => 'aws_subnet'
   end

The full syntax for all of the properties that are available to the ``aws_subnet`` resource is:

.. code-block:: ruby

   aws_subnet 'name' do
     availability_zone             String
     cidr_block                    String
     map_public_ip_on_launch       TrueClass, FalseClass
     route_table                   String
     subnet_id                     String
     vpc                           String
   end

where

* ``aws_subnet`` is the resource
* ``name`` is the name of the resource block and also the name of a subnet within a defined virtual network in Amazon Virtual Private Cloud (VPC)
* ``availability_zone``, ``cidr_block``, ``map_public_ip_on_launch``, ``route_table``, ``vpc`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``availability_zone``
     - **Ruby Type:** String

       Use to specify the availability zone for the subnet. For example: ``us-east-1a`` or ``us-east-1b``. Default value: selected automatically by Amazon Web Services (AWS).
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``cidr_block``
     - **Ruby Type:** String

       Required. Use to specify the classless inter-domain routing (CIDR) block of IP address that are associated with a subnet. This must be a subset of the IP addresses in the defined virtual network and must not overlap with any other IP addresses used by any other subnet within this defined virtual network. For example, ``'10.0.0.0/24'`` will give 256 addresses and ``'10.0.0.0/16'`` will give 65536.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``map_public_ip_on_launch``
     - **Ruby Type:** TrueClass, FalseClass

       Use to specify if public IP addresses are assigned to new instances in this subnet by default. Default value: ``false``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of the subnet.
   * - ``network_acl``
     - **Ruby Type:** String, AwsNetworkAcl, AWS::EC2::NetworkACL

       Use to specify a network ACL to be associated with this subnet.
   * - ``route_table``
     - **Ruby Type:** String, AwsRouteTable, AWS::EC2::RouteTable

       Use to specify the route table associated with this subnet. This may be the name of an ``aws_route_table`` resource block that exists elsewhere in a cookbook, an actual ``aws_route_table`` resource block that exists in this recipe, or the name of the main route table in Amazon Virtual Private Cloud (VPC). Default value: ``:default_to_main``, which will detach any explicit route table that may be associated with this subnet, and then use the subnet that exists for the defined virtual network in which this subnet exists.
   * - ``subnet_id``
     - **Ruby Type:** String

       Use to specify the identifier for the subnet.
   * - ``vpc``
     - **Ruby Type:** String, AwsVpc, AWS::EC2::VPC

       Use to specify the identifier for the Amazon Virtual Private Cloud (VPC).

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Remove the default subnet**

.. To remove the default subnet:

.. code-block:: ruby

   aws_subnet 'default' do
     availability_zone availability_zone
     action :destroy
   end

**Add a public subnet**

.. To add a public subnet:

.. code-block:: ruby

   aws_subnet 'public-#{availability_zone}' do
     availability_zone availability_zone
     cidr_block '10.0.#{128+class_c}.0/24'
     route_table 'public-routes'
     map_public_ip_on_launch true
   end

**Define a subnet for a cache cluster**

.. tag resource_provisioning_aws_cache_cluster_create

.. To define a VPC, subnets, and security group for a cache cluster:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'
   with_driver 'aws::us-east-1'

   aws_vpc 'test' do
     cidr_block '10.0.0.0/24'
   end

   aws_subnet 'public-test' do
     vpc 'test'
     availability_zone 'us-east-1a'
     cidr_block '10.0.0.0/24'
   end

   aws_cache_subnet_group 'test-ec' do
     description 'My awesome group'
     subnets [ 'public-test' ]
   end

   aws_security_group 'test-sg' do
     vpc 'test'
   end

   aws_cache_cluster 'my-cluster-mem' do
     az_mode 'single-az'
     number_nodes 2
     node_type 'cache.t2.micro'
     engine 'memcached'
     engine_version '1.4.14'
     security_groups ['test-sg']
     subnet_group_name 'test-ec'
   end

.. end_tag

**Define subnets for a batch of machines**

.. tag resource_provisioning_aws_security_group_machine_batch

.. To define a VPC, subnets, and security group for a batch of machines:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'

   with_driver 'aws::eu-west-1'
     aws_vpc 'provisioning-vpc' do
       cidr_block '10.0.0.0/24'
       internet_gateway true
       main_routes '0.0.0.0/0' => :internet_gateway
     end

     aws_subnet 'provisioning-vpc-subnet-a' do
       vpc 'provisioning-vpc'
       cidr_block '10.0.0.0/26'
       availability_zone 'eu-west-1a'
       map_public_ip_on_launch true
     end

     aws_subnet 'provisioning-vpc-subnet-b' do
       vpc 'provisioning-vpc'
       cidr_block '10.0.0.128/26'
       availability_zone 'eu-west-1a'
       map_public_ip_on_launch true
     end

   machine_batch do
     machines %w(mario-a mario-b)
     action :destroy
   end

   machine_batch do
     machine 'mario-a' do
       machine_options bootstrap_options: { subnet: 'provisioning-vpc-subnet-a' }
     end

     machine 'mario-b' do
       machine_options bootstrap_options: { subnet: 'provisioning-vpc-subnet-b' }
     end
   end

   aws_security_group 'provisioning-vpc-security-group' do
     inbound_rules [
       {:port => 2223, :protocol => :tcp, :sources => ['10.0.0.0/24'] },
       {:port => 80..100, :protocol => :udp, :sources => ['1.1.1.0/24'] }
     ]
     outbound_rules [
       {:port => 2223, :protocol => :tcp, :destinations => ['1.1.1.0/16'] },
       {:port => 8080, :protocol => :tcp, :destinations => ['2.2.2.0/24'] }
     ]
     vpc 'provisioning-vpc'
   end

.. end_tag

aws_vpc
=====================================================
The ``aws_vpc`` resource is a driver-specific resource used by Chef provisioning. Use the ``aws_vpc`` resource to `launch resources into a defined virtual network <http://aws.amazon.com/documentation/vpc/>`__ with Amazon Virtual Private Cloud (VPC) (the networking layer of Amazon EC2).

This defined virtual network is dedicated to a specific Amazon Web Services (AWS) account and is logically isolated from other defined virtual network in Amazon Web Services (AWS). Amazon EC2 instances may be launched into the defined virtual network and it may be configured for specific IP address ranges, subnets, routing tables, network gateways, and security settings.

Use this resource along with the

* ``aws_subnet`` resource to define instances that are contained within walled-off sub-sections of a defined virtual network
* ``aws_security_group`` resource to define which instances can talk to each other
* ``aws_route_table`` resource to define where traffic is located when an instance in a subnet talks to a specific IP address

Syntax
-----------------------------------------------------
A ``aws_vpc`` resource block typically declares VPCs in Amazon Web Services (AWS). For example:

.. code-block:: ruby

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

The full syntax for all of the properties that are available to the ``aws_vpc`` resource is:

.. code-block:: ruby

   aws_vpc 'name' do
     cidr_block                    String
     dhcp_options                  String
     enable_dns_hostnames          TrueClass, FalseClass
     enable_dns_support            TrueClass, FalseClass
     internet_gateway              TrueClass, FalseClass
     instance_tenancy              Symbol
     main_route_table              String
     main_routes                   Hash
     vpc_id                        String
   end

where

* ``aws_vpc`` is the resource
* ``name`` is the name of the resource block and also the name of the defined virtual network in Amazon Virtual Private Cloud (VPC)
* ``cidr_block``, ``dhcp_options``, ``enable_dns_hostnames``, ``enable_dns_support``, ``internet_gateway``, ``instance_tenancy``, and ``main_routes`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       Specify a Hash of Amazon Web Services (AWS) tags.

       .. tag resources_provisioning_aws_attributes_aws_tag_example

       For example:

       .. code-block:: ruby

          aws_tags company: 'my_company', 'key_as_string' => :value_as_symbol

       .. code-block:: ruby

          aws_tags 'Name' => 'custom-vpc-name'

       .. end_tag

   * - ``chef_server``
     - **Ruby Type:** Hash

       The Chef server on which IDs are located.
   * - ``cidr_block``
     - **Ruby Type:** String

       Required. Use to specify the classless inter-domain routing (CIDR) block of IP address that are associated with a defined virtual network. For example, ``'10.0.0.0/24'`` will give 256 addresses and ``'10.0.0.0/16'`` will give 65536.
   * - ``dhcp_options``
     - **Ruby Type:** AwsDhcpOptions, AWS::EC2::DHCPOptions, String

       Use to specify the DHCP options for the defined virtual network.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``enable_dns_hostnames``
     - **Ruby Type:** TrueClass

       Use to specify if instances launched in a defined virtual network are assigned DNS hostnames. Possible values: ``true`` or ``false``. When ``true``, ``enable_dns_support`` must also be set to ``true``.
   * - ``enable_dns_support``
     - **Ruby Type:** TrueClass

       Use to specify if DNS resolution is supported for a defined virtual network. When ``false``, resolution of public DNS hostnames to IP addresses is disabled. When ``true``, queries made to either the DNS server provided by Amazon Web Services (AWS) (and located at the 169.254.169.253 IP address) or the reserved IP address at the base of the defined virtual network range (plus two) will be resolved successfully. For example, a reserved IP address of ``10.0.0.0/16`` is located at ``10.0.0.2``.
   * - ``instance_tenancy``
     - **Ruby Type:** Symbol

       Use to specify if an instance that runs in the defined virtual network instance will run on hardware that is dedicated to a single customer and is physically isolated at the host hardware level from non-dedicated instances. Set to ``:default`` when the instance runs on shared hardware. Set to ``:dedicated`` when the instance runs on dedicated hardware. Default value: ``:default``.
   * - ``internet_gateway``
     - **Ruby Type:** String, AWS::EC2::InternetGateway

       Use to specify if a defined virtual network has an internet gateway. Possible values: ``true`` or ``false``. When ``true``, an internet gateway is created and attached to the defined virtual network. When ``false``, an internet gateway is deleted when the ``Owned`` tag on the internet gateway is ``true`` and is detached if the tag is ``false``.
   * - ``main_route_table``
     - **Ruby Type:** String, AwsRouteTable, AWS::EC2::RouteTable

       Use to specify the main route table. This may be the name of an ``aws_route_table`` resource block that exists elsewhere in a cookbook, an actual ``aws_route_table`` resource block that exists in this recipe, or the name of the main route table in Amazon Virtual Private Cloud (VPC).

       Use ``main_route_table`` by itself (without specifying ``main_routes``) to update the main route association to point to the specified route table. In this situation, use the ``aws_route_table`` resource to manage the route table itself.
   * - ``main_routes``
     - **Ruby Type:** Hash

       Use to specify a Hash that defines the routes for the main route table. The destination (on the left side of the ``=>``) must be a classless inter-domain routing (CIDR) block. The target (on the right side of the ``=>``) may be the identifier for an internet gateway, an instance name, the identifier for network interface, a Chef provisioning machine name, or a Chef provisioning resource.

       For example:

       .. code-block:: ruby

          main_routes {
          '10.0.0.0/8' => 'internal_vpn',
          '0.0.0.0/0' => :internet_gateway
          }

       Use ``main_routes`` by itself (without specifying ``main_route_table``) to update the default route table that is created when Amazon Web Services (AWS) creates Amazon Virtual Private Cloud (VPC).
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       The managed entry store. For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of the defined virtual network. Because the name of a Amazon Virtual Private Cloud (VPC) instance is not guaranteed to be unique for an account at Amazon Web Services (AWS), Chef provisioning will store the associated identifier on the Chef server using the ``data/aws_vpc/<name>`` data bag.
   * - ``vpc_id``
     - **Ruby Type:** String

       Use to specify the identifier for the Amazon Virtual Private Cloud (VPC).

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Add a defined virtual network (VPC)**

.. To add a defined virtual network (VPC):

.. code-block:: ruby

   aws_vpc 'test-vpc' do
     cidr_block '10.0.0.0/24'
     internet_gateway true
   end

**Add a defined virtual network (VPC) with route table**

.. To add a defined virtual network (VPC) with route table:

.. code-block:: ruby

   aws_vpc 'provisioning-vpc' do
     cidr_block '10.0.0.0/24'
     internet_gateway true
     main_routes '0.0.0.0/0' => :internet_gateway
   end

**Delete a VPC that has a defined route table**

.. To delete a VPC that has a defined route table:

An Amazon Virtual Private Cloud (VPC) cannot be deleted when it has a non-main route table attached to it. To delete an Amazon Virtual Private Cloud (VPC), first restore the ``default`` route table, and then delete the Amazon Virtual Private Cloud (VPC) and the associated non-main route table. For example:

.. code-block:: ruby

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

**Set up a VPC, route table, key pair, and machine**

.. tag resource_provisioning_aws_route_table_define_vpc_key_machine

.. To define a VPC, route table, key pair, and machine:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'

   with_driver 'aws::eu-west-1'

   aws_vpc 'test-vpc' do
     cidr_block '10.0.0.0/24'
     internet_gateway true
   end

   aws_route_table 'ref-public1' do
     vpc 'test-vpc'
     routes '0.0.0.0/0' => :internet_gateway
   end

   aws_key_pair 'ref-key-pair'

   m = machine 'test' do
     machine_options bootstrap_options: { key_name: 'ref-key-pair' }
   end

.. end_tag

**Define a VPC for a cache cluster**

.. tag resource_provisioning_aws_cache_cluster_create

.. To define a VPC, subnets, and security group for a cache cluster:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'
   with_driver 'aws::us-east-1'

   aws_vpc 'test' do
     cidr_block '10.0.0.0/24'
   end

   aws_subnet 'public-test' do
     vpc 'test'
     availability_zone 'us-east-1a'
     cidr_block '10.0.0.0/24'
   end

   aws_cache_subnet_group 'test-ec' do
     description 'My awesome group'
     subnets [ 'public-test' ]
   end

   aws_security_group 'test-sg' do
     vpc 'test'
   end

   aws_cache_cluster 'my-cluster-mem' do
     az_mode 'single-az'
     number_nodes 2
     node_type 'cache.t2.micro'
     engine 'memcached'
     engine_version '1.4.14'
     security_groups ['test-sg']
     subnet_group_name 'test-ec'
   end

.. end_tag

**Define a VPC for a batch of machines**

.. tag resource_provisioning_aws_security_group_machine_batch

.. To define a VPC, subnets, and security group for a batch of machines:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'

   with_driver 'aws::eu-west-1'
     aws_vpc 'provisioning-vpc' do
       cidr_block '10.0.0.0/24'
       internet_gateway true
       main_routes '0.0.0.0/0' => :internet_gateway
     end

     aws_subnet 'provisioning-vpc-subnet-a' do
       vpc 'provisioning-vpc'
       cidr_block '10.0.0.0/26'
       availability_zone 'eu-west-1a'
       map_public_ip_on_launch true
     end

     aws_subnet 'provisioning-vpc-subnet-b' do
       vpc 'provisioning-vpc'
       cidr_block '10.0.0.128/26'
       availability_zone 'eu-west-1a'
       map_public_ip_on_launch true
     end

   machine_batch do
     machines %w(mario-a mario-b)
     action :destroy
   end

   machine_batch do
     machine 'mario-a' do
       machine_options bootstrap_options: { subnet: 'provisioning-vpc-subnet-a' }
     end

     machine 'mario-b' do
       machine_options bootstrap_options: { subnet: 'provisioning-vpc-subnet-b' }
     end
   end

   aws_security_group 'provisioning-vpc-security-group' do
     inbound_rules [
       {:port => 2223, :protocol => :tcp, :sources => ['10.0.0.0/24'] },
       {:port => 80..100, :protocol => :udp, :sources => ['1.1.1.0/24'] }
     ]
     outbound_rules [
       {:port => 2223, :protocol => :tcp, :destinations => ['1.1.1.0/16'] },
       {:port => 8080, :protocol => :tcp, :destinations => ['2.2.2.0/24'] }
     ]
     vpc 'provisioning-vpc'
   end

.. end_tag

