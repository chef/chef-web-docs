.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``ipaddress`` matcher tests if a host name is resolvable to a specific IP address:

.. code-block:: ruby

   its('ipaddress') { should include '93.184.216.34' }
