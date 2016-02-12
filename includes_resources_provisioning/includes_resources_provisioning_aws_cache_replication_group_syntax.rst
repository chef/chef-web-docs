.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_cache_replication_group`` resource block manages replication groups for cache clusters in |amazon aws|. For example:

.. code-block:: ruby

   aws_cache_replication_group 'name' do
     automatic_failover true
     engine 'name'
     engine_version '1.2.3'
     node_type 'cache.m3.large'
     number_cache_clusters 3
     preferred_availability_zones [ 
       'PreferredAvailabilityZones.member.1=us-east-1a', 
       'PreferredAvailabilityZones.member.2=us-east-1c', 
       'PreferredAvailabilityZones.member.3=us-east-1d'
     ]
     subnet_group_name 'subnet-1'
   end

The full syntax for all of the properties that are available to the ``aws_cache_replication_group`` resource is:

.. code-block:: ruby

   aws_cache_replication_group 'name' do
     az_mode                       String
     automatic_failover            TrueClass, FalseClass
     description                   String
     engine                        String
     engine_version                String
     group_name                    String  # defaults to 'name' if not specified
     node_type                     String
     number_cache_clusters         Integer
     preferred_availability_zones  String, Array
     security_groups               String, Array
     subnet_group_name             String
   end

where 

* ``aws_cache_replication_group`` is the resource
* ``name`` is the name of the resource block
* ``automatic_failover``, ``engine``, ``engine_version``, ``node_type``, ``number_cache_clusters``, ``preferred_availability_zones``, and ``subnet_group_name`` are properties of this resource, with the |ruby| type shown. |see attributes|
