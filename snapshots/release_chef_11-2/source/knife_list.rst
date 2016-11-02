

=====================================================
knife list
=====================================================

.. tag knife_list_25

Use the ``knife list`` subcommand to view a list of objects on the Chef server. This subcommand works similar to ``knife cookbook list``, ``knife data bag list``, ``knife environment list``, ``knife node list``, and ``knife role list``, but with a single verb (and a single action).

.. end_tag

Syntax
=====================================================
.. tag knife_list_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ knife list [PATTERN...] (options)

.. end_tag

Options
=====================================================
.. note:: .. tag knife_common_see_common_options_link

          Review the list of :doc:`common options </knife_common_options>` available to this (and all) knife subcommands and plugins.

          .. end_tag

.. tag 4_4

This subcommand has the following options:

``-d``
   Prevent a directory's children from showing when a directory matches a pattern.

``-R``
   List directories recursively.

.. end_tag

.. note:: .. tag knife_common_see_all_config_options

          See :doc:`knife.rb </config_rb_knife_optional_settings>` for more information about how to add certain knife options as settings in the knife.rb file.

          .. end_tag

Examples
=====================================================
.. tag knife_list_roles

For example, to view a list of roles on the Chef server:

.. code-block:: bash

   $ knife list roles/

.. end_tag

.. tag knife_list_roles_and_environments

To view a list of roles and environments on the Chef server:

.. code-block:: bash

   $ knife list roles/ environments/

.. end_tag

.. tag knife_list_everything

To view a list of absolutely everything on the Chef server:

.. code-block:: bash

   $ knife list -R /

.. end_tag

