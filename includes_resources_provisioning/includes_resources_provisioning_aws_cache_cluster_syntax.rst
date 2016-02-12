.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_cache_cluster`` resource block manages cache clusters in |amazon elasticache|. For example:

.. code-block:: ruby

   aws_cache_cluster 'name' do
     az_mode 'single-az'
     engine 'name'
     engine_version '1.2.3'
     node_type 'cache.m3.large'
     number_nodes 10
     preferred_availability_zones [ 
       'PreferredAvailabilityZones.member.1=us-east-1a', 
       'PreferredAvailabilityZones.member.2=us-east-1c', 
       'PreferredAvailabilityZones.member.3=us-east-1d'
     ]
     subnet_group_name 'subnet-1'
   end

The full syntax for all of the properties that are available to the ``aws_cache_cluster`` resource is:

.. code-block:: ruby

   aws_cache_cluster 'name' do
     az_mode                       String
     cluster_name                  String  # defaults to 'name' if not specified
     engine                        String
     engine_version                String
     node_type                     String
     number_nodes                  Integer
     preferred_availability_zone   String
     preferred_availability_zones  String, Array
     security_groups               String, Array
     subnet_group_name             String
   end

where 

* ``aws_cache_cluster`` is the resource
* ``name`` is the name of the resource block
* ``az_mode``, ``engine``, ``engine_version``, ``node_type``, ``number_nodes``, ``preferred_availability_zones``, and ``subnet_group_name`` are properties of this resource, with the |ruby| type shown. |see attributes|
