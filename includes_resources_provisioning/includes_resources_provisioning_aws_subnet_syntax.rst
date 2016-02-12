.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_subnet`` resource block manages subnets in |amazon aws|. For example:

.. code-block:: ruby

   aws_subnet 'name' do
     vpc 'ref-vpc'
     cidr_block '10.0.0.0/24'
     availability_zone 'us-west-1a'
     map_public_ip_on_launch true
     route_table 'ref-public'
     aws_tags :chef_type => 'aws_subnet'
   end

The full syntax for all of the properties that are available to the ``aws_subnet`` resource is:

.. code-block:: ruby

   aws_subnet 'name' do
     availability_zone             String
     cidr_block                    String
     map_public_ip_on_launch       TrueClass, FalseClass
     route_table                   String
     subnet_id                     String
     vpc                           String
   end

where 

* ``aws_subnet`` is the resource
* ``name`` is the name of the resource block and also the name of a subnet within a defined virtual network in |amazon vpc|
* ``availability_zone``, ``cidr_block``, ``map_public_ip_on_launch``, ``route_table``, ``vpc`` are properties of this resource, with the |ruby| type shown. |see attributes|
