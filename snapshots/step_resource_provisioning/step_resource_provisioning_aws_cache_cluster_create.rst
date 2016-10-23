.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To define a VPC, subnets, and security group for a cache cluster:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'
   with_driver 'aws::us-east-1'
   
   aws_vpc 'test' do
     cidr_block '10.0.0.0/24'
   end
   
   aws_subnet 'public-test' do
     vpc 'test'
     availability_zone 'us-east-1a'
     cidr_block '10.0.0.0/24'
   end
   
   aws_cache_subnet_group 'test-ec' do
     description 'My awesome group'
     subnets [ 'public-test' ]
   end
   
   aws_security_group 'test-sg' do
     vpc 'test'
   end
   
   aws_cache_cluster 'my-cluster-mem' do
     az_mode 'single-az'
     number_nodes 2
     node_type 'cache.t2.micro'
     engine 'memcached'
     engine_version '1.4.14'
     security_groups ['test-sg']
     subnet_group_name 'test-ec'
   end
