.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``master-recover`` subcommand is used to force the Chef server to attempt to become the master server. This command is typically run in tandem with the ``backup-recover`` subcommand on the back-end peer, unless the back-end peer is no longer available. 

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl master-recover
