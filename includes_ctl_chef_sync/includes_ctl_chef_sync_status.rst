.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use to show the current status of all organizations that are synchronizing. This subcommand should only be run for replica organizations.

This option has the following syntax:

.. code-block:: bash

   $ chef-sync-ctl sync-status

and will return a list that shows the organization name, its status, the last synchronization time, and the time at which the synchronization process will begin again.
