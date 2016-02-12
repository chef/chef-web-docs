.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To add a public subnet:

.. code-block:: ruby

   aws_subnet 'public-#{availability_zone}' do
     availability_zone availability_zone
     cidr_block '10.0.#{128+class_c}.0/24'
     route_table 'public-routes'
     map_public_ip_on_launch true
   end
