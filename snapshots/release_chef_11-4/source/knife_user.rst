

=====================================================
knife user 
=====================================================

.. tag knife_user_24

The ``knife user`` subcommand is used to manage the list of users and their associated RSA public key-pairs.

.. end_tag

.. warning:: .. tag notes_knife_user_limitations

             In versions of the chef-client prior to version 12.0, this subcommand ONLY works when run against the open source Chef server; it does not run against Enterprise Chef (including hosted Enterprise Chef), or Private Chef.

             Starting with Chef server 12.0, this functionality is built into the :doc:`chef-server-ctl <ctl_chef_server>` command-line tool as part of the following arguments:

             * :ref:`user-create <ctl_chef_server-user-create>`
             * :ref:`user-delete <ctl_chef_server-user-delete>`
             * :ref:`user-edit <ctl_chef_server-user-edit>`
             * :ref:`user-list <ctl_chef_server-user-list>`
             * :ref:`user-show <ctl_chef_server-user-show>`

             Starting with chef-client version 12.4.1, the ``knife user`` functionality is restored for the following arguments: ``user-edit``, ``user-list``, and ``user-show`` for Chef server version 12.0 (and higher).

             Starting with Chef server 12.4.1, :ref:`users who are members of the server-admins group <ctl_chef_server-server-admins>` may use the ``user-create``, ``user-delete``, ``user-edit``, ``user-list``, and ``user-show`` arguements to manage user accounts on the Chef server via the ``knife user`` subcommand.

             .. end_tag

.. note:: .. tag knife_common_see_common_options_link

          Review the list of :doc:`common options </knife_common_options>` available to this (and all) knife subcommands and plugins.

          .. end_tag

create
=====================================================
.. tag knife_user_create

Use the ``create`` argument to create a user. This process will generate an RSA key pair for the named user. The public key will be stored on the Chef server and the private key will be displayed on ``STDOUT`` or written to a named file.

* For the user, the private key should be copied to the system as ``/etc/chef/client.pem``.
* For knife, the private key is typically copied to ``~/.chef/client_name.pem`` and referenced in the knife.rb configuration file.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_user_create_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user create USER_NAME (options)

.. end_tag

Options
-----------------------------------------------------
.. tag 3_1

This argument has the following options:

``-a``, ``--admin``
   Create a client as an admin client. This is required for any user to access Open Source Chef as an administrator. This option only works when used with the open source Chef server and will have no effect when used with Enterprise Chef or Chef server 12.x.

``-f FILE_NAME``, ``--file FILE_NAME``
   Save a private key to the specified file name.

``-p PASSWORD``, ``--password PASSWORD``
   The user password.

``--user-key FILE_NAME``
   The path to a file that contains the public key.  If this option is not specified, the Chef server will generate a public/private key pair.

.. end_tag

.. note:: .. tag knife_common_see_all_config_options

          See :doc:`knife.rb </config_rb_knife_optional_settings>` for more information about how to add certain knife options as settings in the knife.rb file.

          .. end_tag

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Create a user**

.. tag knife_user_create_summary

.. To create a new user named "Radio Birdman" with a private key saved to "/keys/user_name", enter:

.. code-block:: bash

   $ knife user create "Radio Birdman" -f /keys/user_name

.. end_tag

delete
=====================================================
.. tag knife_user_delete

Use the ``delete`` argument to delete a registered user.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_user_delete_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user delete USER_NAME

.. end_tag

Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Delete a user**

.. tag knife_user_delete_summary

.. To delete a user named "Steve Danno", enter:

.. code-block:: bash

   $ knife user delete "Steve Danno"

.. end_tag

edit
=====================================================
.. tag knife_user_edit

Use the ``edit`` argument to edit the details of a user. When this argument is run, knife will open $EDITOR. When finished, knife will update the Chef server with those changes.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_user_edit_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user edit USER_NAME

.. end_tag

Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
None.

list
=====================================================
.. tag knife_user_list

Use the ``list`` argument to view a list of registered users.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_user_list_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user list (options)

.. end_tag

Options
-----------------------------------------------------
.. tag knife_user_list_options

This argument has the following options:

``-w``, ``--with-uri``
   Show the corresponding URIs.

.. end_tag

Examples
-----------------------------------------------------
None.

reregister
=====================================================
.. tag knife_user_reregister

Use the ``reregister`` argument to regenerate an RSA key pair for a user. The public key will be stored on the Chef server and the private key will be displayed on ``STDOUT`` or written to a named file.

.. note:: Running this argument will invalidate the previous RSA key pair, making it unusable during authentication to the Chef server.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_user_reregister_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user reregister USER_NAME (options)

.. end_tag

Options
-----------------------------------------------------
.. tag knife_user_reregister_options

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

**Regenerate the RSA key-pair**

.. tag knife_user_reregister_summary

.. To regenerate the RSA key pair for a user named "Robert Younger", enter:

.. code-block:: bash

   $ knife user reregister "Robert Younger"

.. end_tag

show
=====================================================
.. tag knife_user_show

Use the ``show`` argument to show the details of a user.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_user_show_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user show USER_NAME (options)

.. end_tag

Options
-----------------------------------------------------
.. tag knife_user_show_options

This argument has the following options:

``-a ATTR``, ``--attribute ATTR``
   The attribute (or attributes) to show.

.. end_tag

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Show user data**

.. tag knife_user_show_summary

To view a user named ``Dennis Teck``, enter:

.. code-block:: bash

   $ knife user show "Dennis Teck"

to return something like:

.. code-block:: bash

   chef_type:   user
   json_class:  Chef::User
   name:        Dennis Teck
   public_key:

.. end_tag

**Show user data as JSON**

.. tag knife_user_show_json

To view information in JSON format, use the ``-F`` common option as part of the command like this:

.. code-block:: bash

   $ knife user show "Dennis Teck" -F json

(Other formats available include ``text``, ``yaml``, and ``pp``, e.g. ``-F yaml`` for YAML.)

.. end_tag

