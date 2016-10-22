=====================================================
knife recipe list 
=====================================================

.. include:: ../../includes_knife/includes_knife_recipe_list.rst

Syntax
=====================================================
This subcommand has the following syntax:

.. code-block:: bash

   $ knife recipe list REGEX


Options
=====================================================
.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

This command does not have any specific options.

Examples
=====================================================
The following examples show how to use this knife subcommand:

**View a list of recipes**

To view a list of recipes:

.. code-block:: bash

   $ knife recipe list 'couchdb::*'

to return:

.. code-block:: bash

   couchdb::main_monitors
   couchdb::master
   couchdb::default
   couchdb::org_cleanu
