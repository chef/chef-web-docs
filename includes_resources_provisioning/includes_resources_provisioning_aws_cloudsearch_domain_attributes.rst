.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |chef provisioning| driver-specific resource has the following properties:

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

       The version of the |amazon cloudsearch| API to use when communicating with |amazon aws|. Default value: ``20130101``. This value may be changed to the ``20110201`` API version for domains that are not accessible using the ``20130101`` API version.
   * - ``chef_server``
     - **Ruby Type:** Hash

       |provisioning_server|
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       |driver_provisioning|
   * - ``index_fields``
     - **Ruby Type:** Array

       An array that specifies `the desired index fields <http://docs.aws.amazon.com/cloudsearch/latest/developerguide/API_IndexField.html>`__. Must include the following keys: ``index_field_name`` and ``index_field_type``. 
   * - ``instance_type``
     - **Ruby Type:** String

       The instance type: ``search.m1.small``, ``search.m3.medium``, ``search.m3.large``, ``search.m3.xlarge``, or ``search.m3.2xlarge``.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       |managed_entry_store| For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``mutli_az``
     - **Ruby Type:** TrueClass, FalseClass

       Specifies if the |amazon cloudsearch| domain is deployed to multiple availability zones. Default value: ``false``.
   * - ``name``
     - **Ruby Type:** String

       The name of the domain.
   * - ``partition_count``
     - **Ruby Type:** Integer

       The number of pre-configured partitions for the domain.
   * - ``replication_count``
     - **Ruby Type:** Integer

       The number of replicas for each partition.
