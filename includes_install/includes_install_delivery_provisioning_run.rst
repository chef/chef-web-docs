.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To run provisioning (from inside the ``delivery-cluster`` directory), run the following command:

.. code-block:: bash

   $ rake setup:cluster

.. note:: If the first converge fails on the build nodes, try running the above step again. The |delivery| cluster is complicated and sometimes there are timeouts.
