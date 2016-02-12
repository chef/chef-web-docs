.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |chef provisioning| driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``associate_to_vpc``
     - **Ruby Type:** TrueClass, FalseClass

       Use to associate an elastic IP address to a virtual network that is defined in |amazon vpc|.
   * - ``chef_server``
     - **Ruby Type:** Hash

       |provisioning_server|
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       |driver_provisioning|
   * - ``machine``
     - **Ruby Type:** String, FalseClass

       Use to specify the machine to be provisioned.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       |managed_entry_store| For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``name``
     - **Ruby Type:** String

       Use to specify the name of an elastic IP address. 
   * - ``public_ip``
     - **Ruby Type:** String

       Use to specify the public IP address to associate with a |chef| resource. This will default to the ``name`` of the resource block if that value is an IP address. If an IP address is already allocated to an |amazon aws| account, |chef| will ensure that it is linked.
