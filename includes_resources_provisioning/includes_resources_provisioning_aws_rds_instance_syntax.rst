.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_rds_instance`` resource block manages remote database intances. For example:

.. code-block:: ruby

   aws_rds_instance 'rds-instance' do
     engine 'postgres'
     publicly_accessible false
     db_instance_class 'db.t1.micro'
     master_username 'user'
     master_user_password 'password'
     multi_az false
     db_subnet_group_name 'db-subnet-group'
   end

The full syntax for all of the properties that are available to the ``aws_rds_instance`` resource is:

.. code-block:: ruby

   aws_rds_instance 'name' do
     additional_options            Hash
     allocated_storage             Integer
     db_instance_class             String
     db_instance_identifier        String
     db_name                       String
     db_subnet_group_name          String
     engine                        String
     engine_version                String
     iops                          Integer
     master_user_password          String
     master_username               String
     multi_az                      TrueClass, FalseClass
     port                          Integer
     publicly_accessible           TrueClass, FalseClass
   end

where 

* ``aws_rds_instance`` is the resource
* ``name`` is the name of the resource block
* ``additional_options``, ``allocated_storage``, ``db_instance_class``, ``db_instance_identifier``, ``db_name``, ``db_subnet_group_name``, ``engine``, ``engine_version``, ``iops``, ``master_user_password``, ``master_username``, ``multi_az``, ``port``, and ``publicly_accessible`` are properties of this resource, with the |ruby| type shown. |see attributes|
