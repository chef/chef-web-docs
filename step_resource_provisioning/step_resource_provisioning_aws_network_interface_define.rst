.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To define a network interface:

.. code-block:: ruby

   aws_network_interface 'ref-eni-1' do
     machine 'ref-machine-eni-1'
     subnet 'ref-subnet-eni'
     security_groups ['ref-sg1-eni']
     description 'ref-eni-desc'
   end
