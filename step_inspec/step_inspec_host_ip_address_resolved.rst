.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To verify that a specific IP address can be resolved:

.. code-block:: ruby

   describe host('example.com', port: 80, proto: 'tcp') do
     it { should be_resolvable }
     its('ipaddress') { should include '192.168.1.1' }
   end
