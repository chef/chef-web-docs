.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |chef provisioning| driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``aws_tags``
     - **Ruby Type:** Hash

       |aws_tag|

       .. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_attributes_aws_tag_example.rst
   * - ``chef_server``
     - **Ruby Type:** Hash

       |provisioning_server|
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       |driver_provisioning|
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
       * ``sources`` is an IP address (or a |cidr| of IP addresses), a security group to be authorized, and/or a load balancer to be authorized. 

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

       |managed_entry_store| For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
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
       * ``sources`` is an IP address (or a |cidr| of IP addresses), a security group to be authorized, and/or a load balancer to be authorized. 

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

       Required when creating a route table. Use to specify the |amazon vpc| to which this route table is associated. This may be the name of an ``aws_vpc`` resource block that exists elsewhere in a cookbook, an actual ``aws_vpc`` resource block that exists in this recipe, or the name of the main route table in |amazon vpc|.
