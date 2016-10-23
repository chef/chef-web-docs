.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A chef-client that is running as a daemon can be woken up and started by sending the process a ``SIGUSR1``. For example, to trigger a chef-client run on a machine running Linux:

.. code-block:: bash

   $ sudo killall -USR1 chef-client





