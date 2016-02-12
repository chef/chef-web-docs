.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use to prepare the specified organization for synchronization by associating the synchronizing user, and then making that user an administrator. This subcommand must be run on both the single, primary |chef server| organization and all replica organizations.

This option has the following syntax:

.. code-block:: bash

   $ chef-sync-ctl prepare-org ORG_NAME

This option will compile a list of group names, organization names, and actors (users, clients, and groups).
