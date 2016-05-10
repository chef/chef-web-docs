.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``backup-data`` subcommand is used to create a backup .tar file located at ``/var/tmp/<bu-dir>/delivery_backup.tar``. This file must be copied to the machine on which the backup is restored via the ``restore-data`` subcommand.

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl backup-data
