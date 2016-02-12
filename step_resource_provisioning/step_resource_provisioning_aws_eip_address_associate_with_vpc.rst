.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To associate an elastic IP address to the VPC associated with a machine:

.. code-block:: ruby

   aws_eip_address 'Web_IP_1' do
     machine 'SRV_OR_Web_1'
     associate_to_vpc true
   end
