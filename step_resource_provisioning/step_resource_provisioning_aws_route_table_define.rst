.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To define a route table:

.. code-block:: ruby

   aws_route_table 'route-table' do
     vpc 'vpc'
     routes '0.0.0.0/0' => :internet_gateway
   end
