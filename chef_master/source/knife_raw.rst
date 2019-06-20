=====================================================
knife raw
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/knife_raw.rst>`__

.. tag knife_raw_summary

Use the ``knife raw`` subcommand to send a REST request to an endpoint in the Chef Infra Server API.

.. end_tag

Syntax
=====================================================
This subcommand has the following syntax:

.. code-block:: bash

   $ knife raw REQUEST_PATH (options)

Options
=====================================================
.. note:: .. tag knife_common_see_common_options_link

          Review the list of `common options </knife_options.html>`__ available to this (and all) knife subcommands and plugins.

          .. end_tag

This subcommand has the following options:

``-i FILE``, ``--input FILE``
   The name of a file to be used with the ``PUT`` or a ``POST`` request.

``--[no-]pretty``
   Use ``--no-pretty`` to disable pretty-print output for JSON. Default: ``--pretty``.

``-m METHOD``, ``--method METHOD``
   The request method: ``DELETE``, ``GET``, ``POST``, or ``PUT``. Default value: ``GET``.

``--proxy-auth``
   Enable proxy authentication to the Chef Infra Server web user interface. Default value: ``false``.

.. note:: .. tag knife_common_see_all_config_options

          See `config.rb </config_rb_optional_settings.html>`__ for more information about how to add certain knife options as settings in the config.rb file.

          .. end_tag

Examples
=====================================================
The following examples show how to use this knife subcommand:

**View a client**

To view information about a client:

.. code-block:: bash

   knife raw /clients/<client_name>

**View a node**

To view information about a node:

.. code-block:: bash

   knife raw /nodes/<node_name>

**Delete a data bag**

To delete a data bag, enter a command similar to:

.. code-block:: bash

   $ knife raw -m DELETE /data/foo

to return something similar to:

.. code-block:: bash

   {
     "name":"foo",
     "json_class":"Chef::DataBag",
     "chef_type":"data_bag"
   }

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
