

=====================================================
knife index rebuild
=====================================================

.. tag knife_index_rebuild_9

Use the ``knife index rebuild`` subcommand to rebuild the search indexes for the open source Chef server. This operation is destructive and may take some time.

.. end_tag

.. warning:: .. tag notes_knife_server_10x_only

             This subcommand ONLY works when run against the open source Chef server version 10.x. This subcommand will NOT run against open source Chef server 11, Enterprise Chef (including hosted Enterprise Chef), or Private Chef.

             .. end_tag

Syntax
=====================================================
.. tag knife_index_rebuild_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ knife index rebuild

.. end_tag

Options
=====================================================
.. note:: .. tag knife_common_see_common_options_link

          Review the list of :doc:`common options </knife_common_options>` available to this (and all) knife subcommands and plugins.

          .. end_tag

This command does not have any specific options.

Examples
=====================================================
None.
