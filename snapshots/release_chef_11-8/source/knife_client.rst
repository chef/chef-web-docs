

=====================================================
knife client 
=====================================================

.. tag knife_client_25

The ``knife client`` subcommand is used to manage an API client list and their associated RSA public key-pairs. This allows authentication requests to be made to the Chef server by any entity that uses the Chef server API, such as the chef-client and knife.

.. end_tag

.. note:: .. tag knife_common_see_common_options_link

          Review the list of :doc:`common options </knife_common_options>` available to this (and all) knife subcommands and plugins.

          .. end_tag

bulk delete
=====================================================
.. tag knife_client_bulk_delete

Use the ``bulk delete`` argument to delete any API client that matches a pattern defined by a regular expression. The regular expression must be within quotes and not be surrounded by forward slashes (``/``).

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_client_bulk_delete_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife client bulk delete REGEX

.. end_tag

Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
None.

create
=====================================================
.. tag knife_client_create

Use the ``create`` argument to create a new API client. This process will generate an RSA key pair for the named API client. The public key will be stored on the Chef server and the private key will be displayed on ``STDOUT`` or written to a named file.

* For the chef-client, the private key should be copied to the system as ``/etc/chef/client.pem``.
* For knife, the private key is typically copied to ``~/.chef/client_name.pem`` and referenced in the knife.rb configuration file.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_client_create_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife client create CLIENT_NAME (options)

.. end_tag

Options
-----------------------------------------------------
.. tag 10_summary

This argument has the following options:

``-a``, ``--admin``
   Create a client as an admin client. This is required for any user to access Open Source Chef as an administrator. This option only works when used with the open source Chef server and will have no effect when used with Enterprise Chef.

``-f FILE_NAME``, ``--file FILE_NAME``
   Save a private key to the specified file name.

.. end_tag

.. note:: .. tag knife_common_see_all_config_options

          See :doc:`knife.rb </config_rb_knife_optional_settings>` for more information about how to add certain knife options as settings in the knife.rb file.

          .. end_tag

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Create an admin client**

.. tag knife_client_create_admin

To create a chef-client that can access the Chef server API as an administrator---sometimes referred to as an "API chef-client"---with the name "exampleorg" and save its private key to a file, enter:

.. code-block:: bash

   $ knife client create exampleorg -a -f "/etc/chef/client.pem"

.. end_tag

**Create an admin client for Enterprise Chef**

.. tag knife_client_create_hosted_and_private

When running the ``create`` argument, be sure to omit the ``-a`` option:

.. code-block:: bash

   $ knife client create exampleorg -f "/etc/chef/client.pem"

.. end_tag

delete
=====================================================
.. tag knife_client_delete

Use the ``delete`` argument to delete a registered API client.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_client_delete_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife client delete CLIENT_NAME

.. end_tag

Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Delete a client**

.. tag knife_client_delete_summary

To delete a client with the name "client_foo", enter:

.. code-block:: bash

   $ knife client delete client_foo

Type ``Y`` to confirm a deletion.

.. end_tag

edit
=====================================================
.. tag knife_client_edit

Use the ``edit`` argument to edit the details of a registered API client. When this argument is run, knife will open $EDITOR to enable editing of the ``admin`` attribute. (None of the other attributes should be changed using this argument.) When finished, knife will update the Chef server with those changes.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_client_edit_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife client edit CLIENT_NAME

.. end_tag

Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Edit a client**

.. tag knife_client_edit_summary

To edit a client with the name "exampleorg", enter:

.. code-block:: bash

   $ knife client edit exampleorg

.. end_tag

list
=====================================================
.. tag knife_client_list

Use the ``list`` argument to view a list of registered API client.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_client_list_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife client list (options)

.. end_tag

Options
-----------------------------------------------------
.. tag knife_client_list_options

This argument has the following options:

``-w``, ``--with-uri``
   Show the corresponding URIs.

.. end_tag

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**View a list of clients**

.. tag knife_client_list_all

To verify the API client list for the Chef server, enter:

.. code-block:: bash

   $ knife client list

to return something similar to:

.. code-block:: none

   exampleorg
   i-12345678
   rs-123456

.. end_tag

.. tag knife_client_list_authenticate

To verify that an API client can authenticate to the 
Chef server correctly, try getting a list of clients using ``-u`` and ``-k`` options to specify its name and private key:

.. code-block:: bash

   $ knife client list -u ORGNAME -k .chef/ORGNAME.pem

.. end_tag

reregister
=====================================================
.. tag knife_client_reregister

Use the ``reregister`` argument to regenerate an RSA key pair for an API client. The public key will be stored on the Chef server and the private key will be displayed on ``STDOUT`` or written to a named file.

.. note:: Running this argument will invalidate the previous RSA key pair, making it unusable during authentication to the Chef server.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_client_reregister_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife client reregister CLIENT_NAME (options)

.. end_tag

Options
-----------------------------------------------------
.. tag knife_client_reregister_options

This argument has the following options:

``-f FILE_NAME``, ``--file FILE_NAME``
   Save a private key to the specified file name.

.. end_tag

.. note:: .. tag knife_common_see_all_config_options

          See :doc:`knife.rb </config_rb_knife_optional_settings>` for more information about how to add certain knife options as settings in the knife.rb file.

          .. end_tag

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Reregister a client**

.. tag knife_client_reregister_summary

To re-register the RSA key pair for a client named "testclient" and save it to a file named "rsa_key", enter:

.. code-block:: bash

   $ knife client reregister testclient -f rsa_key

.. end_tag

show
=====================================================
.. tag knife_client_show

Use the ``show`` argument to show the details of an API client.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_client_show_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife client show CLIENT_NAME (options)

.. end_tag

Options
-----------------------------------------------------
.. tag knife_client_show_options

This argument has the following options:

``-a ATTR``, ``--attribute ATTR``
   The attribute (or attributes) to show.

.. end_tag

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Show clients**

.. tag knife_client_show_summary

To view a client named "testclient", enter:

.. code-block:: bash

   $ knife client show testclient

to return something like:

.. code-block:: none

   admin:       false
   chef_type:   client
   json_class:  Chef::ApiClient
   name:        testclient
   public_key:

.. end_tag

.. tag knife_client_show_json

To view information in JSON format, use the ``-F`` common option as part of the command like this:

.. code-block:: bash

   $ knife client show devops -F json

Other formats available include ``text``, ``yaml``, and ``pp``.

.. end_tag

