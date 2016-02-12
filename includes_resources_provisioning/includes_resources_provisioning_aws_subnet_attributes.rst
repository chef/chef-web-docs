.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |chef provisioning| driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``availability_zone``
     - **Ruby Type:** String

       Use to specify the availability zone for the subnet. For example: ``us-east-1a`` or ``us-east-1b``. Default value: selected automatically by |amazon aws|.
   * - ``aws_tags``
     - **Ruby Type:** Hash

       |aws_tag|

       .. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_attributes_aws_tag_example.rst
   * - ``chef_server``
     - **Ruby Type:** Hash

       |provisioning_server|
   * - ``cidr_block``
     - **Ruby Type:** String

       Required. Use to specify the |cidr| block of IP address that are associated with a subnet. This must be a subset of the IP addresses in the defined virtual network and must not overlap with any other IP addresses used by any other subnet within this defined virtual network. For example, ``'10.0.0.0/24'`` will give 256 addresses and ``'10.0.0.0/16'`` will give 65536.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       |driver_provisioning|
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       |managed_entry_store| For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
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

       Use to specify the route table associated with this subnet. This may be the name of an ``aws_route_table`` resource block that exists elsewhere in a cookbook, an actual ``aws_route_table`` resource block that exists in this recipe, or the name of the main route table in |amazon vpc|. Default value: ``:default_to_main``, which will detach any explicit route table that may be associated with this subnet, and then use the subnet that exists for the defined virtual network in which this subnet exists.
   * - ``subnet_id``
     - **Ruby Type:** String

       Use to specify the identifier for the subnet.
   * - ``vpc``
     - **Ruby Type:** String, AwsVpc, AWS::EC2::VPC

       Use to specify the identifier for the |amazon vpc|.