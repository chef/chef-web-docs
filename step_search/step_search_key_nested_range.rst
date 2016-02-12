.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To use a range search to find IP addresses within a subnet, enter the following:

.. code-block:: bash

   $ knife search node 'network_interfaces_X_addresses:[192.168.0.* TO 192.168.127.*]'
   
where ``192.168.0.* TO 192.168.127.*`` defines the subnet range.
