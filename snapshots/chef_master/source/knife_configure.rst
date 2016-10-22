=====================================================
knife configure
=====================================================

.. include:: ../../includes_knife/includes_knife_configure.rst

Syntax
=====================================================
This subcommand has the following syntax when creating a knife.rb file:

.. code-block:: bash

   $ knife configure (options)

and the following syntax when creating a client.rb file:

.. code-block:: bash

   $ knife configure client DIRECTORY




Options
=====================================================
.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

This subcommand has the following options for use when configuring a knife.rb file:

``--admin-client-name NAME``
   The name of the client, typically the name of the admin client.

``--admin-client-key PATH``
   The path to the private key used by the client, typically a file named ``admin.pem``.

``-i``, ``--initial``
   Create a API client, typically an administrator client on a freshly-installed Chef server.

``-r REPO``, ``--repository REPO``
   The path to the chef-repo.

``--validation-client-name NAME``
   The name of the validation client, typically a client named chef-validator.

``--validation-key PATH``
   The path to the validation key used by the client, typically a file named chef-validator.pem.



.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
=====================================================
The following examples show how to use this knife subcommand:

**Configure knife.rb**

.. To create a knife.rb file, enter:

.. code-block:: bash

   $ knife configure

**Configure client.rb**

.. To configure a client.rb, enter:

.. code-block:: bash

   $ knife configure client '/directory'

