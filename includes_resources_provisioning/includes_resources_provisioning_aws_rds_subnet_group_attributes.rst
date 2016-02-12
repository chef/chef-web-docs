.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |chef provisioning| driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``chef_server``
     - **Ruby Type:** Hash

       |provisioning_server|
   * - ``description``
     - **Ruby Type:** String

       The description of the subnet group. 
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       |driver_provisioning|
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       |managed_entry_store| For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       The name of the subnet group.
   * - ``subnets``
     - **Ruby Type:** String, Array, AwsSubnet, AWS::EC2::Subnet

       The subnets to be associated with the relational database service. At least two subnets must be specified.
