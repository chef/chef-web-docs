.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |chef provisioning| driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``additional_options``
     - **Ruby Type:** Hash

       A |ruby hash| of `options to be passed <http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/RDS/Client.html#create_db_instance-instance_method>`__ to the API for |amazon rds|. Default value: ``{ }``.
   * - ``allocated_storage``
     - **Ruby Type:** Integer

       The size (in gigabytes) allocated to the relational database.
   * - ``chef_server``
     - **Ruby Type:** Hash

       |provisioning_server|
   * - ``db_instance_class``
     - **Ruby Type:** String

       The size of the instance on which the relational database is run. For example: ``db.t1.small``.
   * - ``db_instance_identifier``
     - **Ruby Type:** String

       The identifier for the relational database.
   * - ``db_name``
     - **Ruby Type:** String

       The name of the relational database. This value varies, depending on the `selected database engine <http://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html>`__.
   * - ``db_subnet_group_name``
     - **Ruby Type:** String

       The name of the database subnet to which the relational database belongs.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       |driver_provisioning|
   * - ``engine``
     - **Ruby Type:** String

       The name of the relational database. For example: ``postgres``.
   * - ``engine_version``
     - **Ruby Type:** String

       The version of the relational database. For example: ``9.2``.
   * - ``iops``
     - **Ruby Type:** Integer

       The number of provisioned I/O operations per second for the allocated disk.
   * - ``managed_entry_store``
     - **Ruby Type:** Chef::Provisioning::ManagedEntryStore

       |managed_entry_store| For example: ``Chef::Provisioning.chef_managed_entry_store(self.chef_server)``.
   * - ``master_user_password``
     - **Ruby Type:** String

       The password for the database super user.
   * - ``master_username``
     - **Ruby Type:** String

       The username for the database super user.
   * - ``multi_az``
     - **Ruby Type:** TrueClass, FalseClass

       Use to specify if the database instance is deployed to multiple availability zones. Default value: ``false``.
   * - ``name``
     - **Ruby Type:** String

       The name of the instance.
   * - ``port``
     - **Ruby Type:** Integer

       The port number on which the database accepts connections.
   * - ``publicly_accessible``
     - **Ruby Type:** TrueClass, FalseClass

       Use to specify that a relational database instance has DNS name that resolves to a routable public IP address. Default value: ``false``.
