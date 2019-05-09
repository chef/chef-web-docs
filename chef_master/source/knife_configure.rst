=====================================================
knife configure
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/knife_configure.rst>`__

.. tag knife_configure_summary

Use the ``knife configure`` subcommand to create the `client.rb <config_rb_client.html>`_ and `config.rb <config_rb.html>`_ files so that they can be distributed to workstations and nodes.

.. end_tag

Syntax
=====================================================
This subcommand has the following syntax when creating a config.rb file:

.. code-block:: bash

   $ knife configure (options)

and the following syntax when creating a client.rb file:

.. code-block:: bash

   $ knife configure client DIRECTORY

Options
=====================================================
.. note:: .. tag knife_common_see_common_options_link

          Review the list of `common options </knife_options.html>`__ available to this (and all) knife subcommands and plugins.

          .. end_tag

This subcommand has the following options for use when configuring a config.rb file:

``--admin-client-name NAME``
   The name of the client, typically the name of the admin client.

``--admin-client-key PATH``
   The path to the private key used by the client, typically a file named ``admin.pem``.

``-i``, ``--initial``
   Create a API client, typically an administrator client on a freshly-installed Chef Infra Server.

``-r REPO``, ``--repository REPO``
   The path to the chef-repo.

``--validation-client-name NAME``
   The name of the validation client, typically a client named chef-validator.

``--validation-key PATH``
   The path to the validation key used by the client, typically a file named chef-validator.pem.

.. note:: .. tag knife_common_see_all_config_options

          See `config.rb </config_rb_optional_settings.html>`__ for more information about how to add certain knife options as settings in the config.rb file.

          .. end_tag

Examples
=====================================================
The following examples show how to use this knife subcommand:

**Configure config.rb**

.. To create a config.rb file, enter:

.. code-block:: bash

   $ knife configure

**Configure client.rb**

.. To configure a client.rb, enter:

.. code-block:: bash

   $ knife configure client '/directory'
