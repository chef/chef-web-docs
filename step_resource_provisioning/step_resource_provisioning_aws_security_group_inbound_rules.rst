.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To add and edit inbound rules:

.. code-block:: ruby

   aws_security_group 'test-sg' do
     vpc 'test-vpc'
     inbound_rules '0.0.0.0/0' => 80,
                   'other-sg'  => [ 80, 1024..2048 ],
                   '127.0.0.1' => 1024..2048,
                   { load_balancer: 'other-lb' } => 1024..2048
   end
