.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |chef provisioning| driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``automatic_failover``
     - **Ruby Type:** TrueClass, FalseClass

       Use to specify if a read-only replica is automatically promoted to read/write primary if the existing primary fails. Set to ``true`` to enabme automatic failover for this cache replication group.
   * - ``aws_tags``
     - **Ruby Type:** Hash

       |aws_tag|

       .. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_attributes_aws_tag_example.rst
   * - ``chef_server``
     - **Ruby Type:** Hash

       |provisioning_server|
   * - ``description``
     - **Ruby Type:** String

       Use to specify the description for a cache replication group.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       |driver_provisioning|
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

       |managed_entry_store| For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``node_type``
     - **Ruby Type:** String

       Use to specify the compute and memory capacity of the nodes in the cache replication group. The possible values depend on the type of nodes: general purpose volumes, provisioned volumes, or magnetic volumes. For example: ``cache.t2.small``, ``cache.r3.2xlarge``, or ``cache.m3.large``.
   * - ``number_cache_clusters``
     - **Ruby Type:** Integer

       Use to specify the initial number of cache clusters for a cache replication group. If ``automatic_failover`` is ``true``, this number must be at least ``2``. Maximum value: ``6``.
   * - ``preferred_availability_zones``
     - **Ruby Type:** String, Array

       Use to specify an array of identifiers for |amazon ec2| availability zones into which the cache clusters associated with this cache replication group will be created. For example:

       .. code-block:: ruby

          preferred_availability_zones [ 
            'PreferredAvailabilityZones.member.1=us-east-1a', 
            'PreferredAvailabilityZones.member.2=us-east-1c', 
            'PreferredAvailabilityZones.member.3=us-east-1d'
          ]

   * - ``security_groups``
     - **Ruby Type:** String, Array, AwsSecurityGroup, AWS::EC2::SecurityGroup

       Use to specify an array of identifiers for |amazon vpc| security groups that are associated with this cache replication group.
   * - ``subnet_group_name``
     - **Ruby Type:** String

       Use to specify the name of the cache subnet group that to use with this cache replication group.
