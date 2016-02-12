.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |chef provisioning| driver-specific resource has the following properties:

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

       |aws_tag|

       .. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_attributes_aws_tag_example.rst
   * - ``chef_server``
     - **Ruby Type:** Hash

       |provisioning_server|
   * - ``desired_capacity``
     - **Ruby Type:** Integer

       Use to specify the desired number of machines in the auto scaling group. For example: ``2``.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       |driver_provisioning|
   * - ``launch_configuration``
     - **Ruby Type:** String

       Use to specify the name of a launch configuration.
   * - ``load_balancers``
     - **Ruby Type:** Array

       Use to specify the name of a load balancer.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       |managed_entry_store| For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
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

       Use to specify a |ruby hash| of options to be applied to this auto scaling group.
