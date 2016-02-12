.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |chef provisioning| driver-specific resource has the following properties:

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

       |aws_tag|

       .. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_attributes_aws_tag_example.rst
   * - ``chef_server``
     - **Ruby Type:** Hash

       |provisioning_server|
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       |driver_provisioning|
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       |managed_entry_store| For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``private_key_options``
     - **Ruby Type:** Hash

       Use to specify a |ruby hash| that defines a list of parameters for the ``private_key`` resource that is used to generate this key.
   * - ``private_key_path``
     - **Ruby Type:** String

       Use to specify the path to the private key to use. The private key will be generated if it does not exist.
   * - ``public_key_path``
     - **Ruby Type:** String

       Use to specify the path to the public key to use. The public key will be generated if it does not exist.
