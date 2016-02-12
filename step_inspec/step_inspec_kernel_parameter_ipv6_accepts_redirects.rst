.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if an IPv6 address accepts redirects:

.. code-block:: ruby

   describe kernel_parameter('net.ipv6.conf.interface.accept_redirects') do
     its(:value) { should eq 'true' }
   end
