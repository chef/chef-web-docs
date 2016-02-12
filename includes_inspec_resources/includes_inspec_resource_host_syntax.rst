.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``host`` |inspec resource| block declares a host name, and then (depending on what is to be tested) a port and/or a protocol:

.. code-block:: ruby

   describe host('example.com', port: 80, proto: 'tcp') do
     it { should be_reachable }
   end

where

* ``host()`` must specify a host name and may specify a port number and/or a protocol
* ``'example.com'`` is the host name
* ``port:`` is the port number
* ``proto: 'name'`` is the Internet protocol: |tcp| (``proto: 'tcp'``), |udp| (``proto: 'udp'`` or  |icmp| (``proto: 'icmp'``))
* ``be_reachable`` is a valid matcher for this |inspec resource|
