

=====================================================
knife delete
=====================================================

.. tag knife_delete_25

Use the ``knife delete`` subcommand to delete an object from a Chef server. This subcommand works similar to ``knife cookbook delete``, ``knife data bag delete``, ``knife environment delete``, ``knife node delete``, and ``knife role delete``, but with a single verb (and a single action).

.. end_tag

Syntax
=====================================================
.. tag knife_delete_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ knife delete [PATTERN...] (options)

.. end_tag

Options
=====================================================
.. note:: .. tag knife_common_see_common_options_link

          Review the list of :doc:`common options </knife_common_options>` available to this (and all) knife subcommands and plugins.

          .. end_tag

.. tag 4_1

This subcommand has the following options:

``--recurse``
   Use ``--recurse`` to delete directories recursively. Default: ``--no-recurse``.

.. end_tag

.. note:: .. tag knife_common_see_all_config_options

          See :doc:`knife.rb </config_rb_knife_optional_settings>` for more information about how to add certain knife options as settings in the knife.rb file.

          .. end_tag

Examples
=====================================================
None.

