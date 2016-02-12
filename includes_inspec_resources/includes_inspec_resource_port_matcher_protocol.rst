.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``protocol`` matcher tests the Internet protocol: |icmp| (``'icmp'``), |tcp| (``'tcp'`` or ``'tcp6'``), or |udp| (``'udp'`` or ``'udp6'``):

.. code-block:: ruby

   its('protocol') { should eq 'tcp' }

or for the |ipv6| protocol:

.. code-block:: ruby

   its('protocol') { should eq 'tcp6' }
