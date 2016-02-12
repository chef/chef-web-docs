.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To add rules for specific ports, sources, and destinations:

.. code-block:: ruby

   aws_security_group 'test-sg' do
     vpc 'test-vpc'
     inbound_rules [
       { port: 80, sources: [ '0.0.0.0/0' ] },
       { port: [ 80, 1024..2048 ], sources: [ 'other-sg' ] },
       { port: 1024..2048, sources: [ '127.0.0.1' ] },
       { port: 1024..2048, sources: [ { load_balancer: 'other-lb' } ] }
     ]
     outbound_rules [
       { port: 80, destinations: [ '0.0.0.0/0', 'other-sg' ] },
       { port: [ 80, 2048..4096 ], destinations: [ 'other-sg' ] },
       { port: 2048..4096, destinations: [ 'other-sg', '127.0.0.1' ] },
       { port: 1024..2048, destinations: [ { load_balancer: 'other-lb' } ] }
     ]
   end
