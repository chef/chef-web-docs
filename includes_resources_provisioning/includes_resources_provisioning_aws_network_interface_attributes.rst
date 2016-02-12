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
   * - ``description``
     - **Ruby Type:** String

       Use to specify the description for the network interface.
   * - ``device_index``
     - **Ruby Type:** Integer

       Use to specify the attachment order position for the network interface.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       |driver_provisioning|
   * - ``machine``
     - **Ruby Type:** String, FalseClass, AwsInstance, AWS::EC2::Instance

       Use to specify the name of the |amazon aws| instance for which this network interface is associated.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       |managed_entry_store| For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
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
