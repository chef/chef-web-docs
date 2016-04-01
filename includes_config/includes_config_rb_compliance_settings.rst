.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This configuration file has the following settings:

``core.licensed_node_count``
   The number of node licenses. Default value: ``25``.

If changes are made to this file, reconfigure the |chef compliance| server by running the following command:

.. code-block:: bash

   $ chef-compliance-ctl reconfigure
