=====================================================
knife raw
=====================================================

.. include:: ../../includes_knife/includes_knife_raw.rst

Syntax
=====================================================
.. include:: ../../includes_knife/includes_knife_raw_syntax.rst

Options
=====================================================
.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

This subcommand has the following options:

``-i FILE``, ``--input FILE``
   The name of a file to be used with the ``PUT`` or a ``POST`` request.

``--[no-]pretty``
   Use ``--no-pretty`` to disable pretty-print output for JSON. Default: ``--pretty``.

``-m METHOD``, ``--method METHOD``
   The request method: ``DELETE``, ``GET``, ``POST``, or ``PUT``. Default value: ``GET``.

``--proxy-auth``
   Enable proxy authentication to the Chef server web user interface. Default value: ``false``.

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
=====================================================
The following examples show how to use this knife subcommand:

**View a client**

.. include:: ../../step_knife/step_knife_raw_view_client.rst

**View a node**

.. include:: ../../step_knife/step_knife_raw_view_node.rst

**Delete a data bag**

.. include:: ../../step_knife/step_knife_raw_delete_data_bag.rst

**Delete a role**

To delete a role, enter a command similar to:

.. code-block:: bash

   $ knife raw -m DELETE /roles/role-foo.json

to return something similar to:

.. code-block:: bash

   {
     "name":"role-foo",
     "json_class":"Chef::Role",
     "chef_type":"role"
   }
