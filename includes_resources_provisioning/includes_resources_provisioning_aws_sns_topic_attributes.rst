.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |chef provisioning| driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``arn``
     - **Ruby Type:** String

       Use to specify the |amazon arn|. When a topic is created, |amazon sns| will assign a unique |amazon arn| to the topic, which will include the service name, region, and |amazon aws| identifier of the user and topic name. For example, a topic named ``seapower`` with a user account ID of ``5060091557628`` that is hosted in the ``US West`` region would be similar to: ``arn:aws:sns:us-west-1:5060091557628:seapower``.
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
   * - ``name``
     - **Ruby Type:** String

       Use to specify the unique name of an |amazon sns| topic. Must be a string of alphanumeric characters, hyphens (``-``), and/or underscores (``_``) that does not exceed 256 characters. (If a topic name is deleted, it may be reused as the name of a new topic.)
