.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To verify host name is reachable over a specific protocol and port number:

.. code-block:: ruby

   describe host('example.com', port: 53, proto: 'udp') do
     it { should be_reachable }
   end
