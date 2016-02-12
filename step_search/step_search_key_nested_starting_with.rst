.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To find all IP address that are on the same network, enter the following:

.. code-block:: bash

   $ knife search node 'network_interfaces__addresses:192.168*'

where ``192.168*`` is the network address for which the search will be run.
