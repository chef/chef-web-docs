.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To add inbound and outbound rules:

.. code-block:: ruby

   aws_security_group 'test-sg' do
     vpc 'test-vpc'
     inbound_rules '0.0.0.0/0'                   => 22,
                   'other-sg'                    => 1024..2048,
                   { load_balancer: 'other-lb' } => 1024..2048
     outbound_rules 443        => '0.0.0.0/0',
                    2048..4096 => 'other-sg',
                    2048..4096 => { load_balancer: 'other-lb' }
   end
