.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To add a defined virtual network (VPC) with route table:

.. code-block:: ruby

   aws_vpc 'provisioning-vpc' do
     cidr_block '10.0.0.0/24'
     internet_gateway true
     main_routes '0.0.0.0/0' => :internet_gateway
   end
