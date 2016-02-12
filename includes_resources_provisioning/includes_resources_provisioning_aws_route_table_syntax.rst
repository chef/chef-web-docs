.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_route_table`` resource block manages route tables. For example:

.. code-block:: ruby

   aws_route_table 'name' do
     vpc 'ref-vpc'
     routes '0.0.0.0/0' => :internet_gateway
     aws_tags :chef_type => 'aws_route_table'
   end

The full syntax for all of the properties that are available to the ``aws_route_table`` resource is:

.. code-block:: ruby

   aws_route_table 'name' do
     ignore_route_targets          String, Array
     route_table_id                String
     routes                        Hash
     virtual_private_gateways      String, Array
     vpc                           String
   end

where 

* ``aws_route_table`` is the resource
* ``name`` is the name of the resource block and also the name of a route table in |amazon vpc|
* ``routes``, and ``vpc`` are attributes of this resource, with the |ruby| type shown. |see attributes|
