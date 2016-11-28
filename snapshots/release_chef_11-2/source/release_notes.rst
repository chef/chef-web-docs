=====================================================
Release Notes: chef-client 11.2
=====================================================

.. tag chef

Chef is a powerful automation platform that transforms infrastructure into code. Whether you’re operating in the cloud, on-premises, or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

This diagram shows how you develop, test, and deploy your Chef code.

.. image:: ../../images/start_chef.svg
   :width: 700px
   :align: center

.. end_tag

.. note:: The chef-client 11.2 release is updated for Ruby 1.9.3-p484, which resolves a security vulnerability that existed when using prior versions of Ruby.

What's New
=====================================================
The following items are new for chef-client 11.2 and/or are changes from previous versions. The short version:

* **knife user** A new subcommand for creating users in Open Source Chef

knife user
-----------------------------------------------------
.. tag knife_user_24

The ``knife user`` subcommand is used to manage the list of users and their associated RSA public key-pairs.

.. end_tag

create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_user_create

Use the ``create`` argument to create a user. This process will generate an RSA key pair for the named user. The public key will be stored on the Chef server and the private key will be displayed on ``STDOUT`` or written to a named file.

* For the user, the private key should be copied to the system as ``/etc/chef/client.pem``.
* For knife, the private key is typically copied to ``~/.chef/client_name.pem`` and referenced in the knife.rb configuration file.

.. end_tag

**Syntax**

.. tag knife_user_create_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user create USER_NAME (options)

.. end_tag

**Options**

.. tag knife_user_create_options

This argument has the following options:

``-a``, ``--admin``
   Create a client as an admin client. This is required for any user to access Open Source Chef as an administrator. This option only works when used with the open source Chef server and will have no effect when used with Enterprise Chef or Chef server 12.x.

``-f FILE_NAME``, ``--file FILE_NAME``
   Save a private key to the specified file name.

``-k``, ``--prevent-keygen``
   Create a user without a public key. This key may be managed later by using the ``knife user key`` subcommands.

   .. note:: .. tag notes_knife_prevent_keygen

             This option is valid only with Chef server API, version 1.0, which was released with Chef server 12.1. If this option or the ``--user-key`` option are not passed in the command, the Chef server will create a user with a public key named ``default`` and will return the private key. For the Chef server versions earlier than 12.1, this option will not work; a public key is always generated unless ``--user-key`` is passed in the command.

             .. end_tag

``-p PASSWORD``, ``--password PASSWORD``
   The user password. This option only works when used with the open source Chef server and will have no effect when used with Enterprise Chef or Chef server 12.x.

``--user-key FILE_NAME``
   The path to a file that contains the public key. When using Open Source Chef a default key is generated if this option is not passed in the command. For Chef server version 12.x, see the ``--prevent-keygen`` option.

.. end_tag

delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_user_delete

Use the ``delete`` argument to delete a registered user.

.. end_tag

**Syntax**

.. tag knife_user_delete_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user delete USER_NAME

.. end_tag

edit
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_user_edit

Use the ``edit`` argument to edit the details of a user. When this argument is run, knife will open $EDITOR. When finished, knife will update the Chef server with those changes.

.. end_tag

**Syntax**

.. tag knife_user_edit_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user edit USER_NAME

.. end_tag

list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_user_list

Use the ``list`` argument to view a list of registered users.

.. end_tag

**Syntax**

.. tag knife_user_list_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user list (options)

.. end_tag

**Options**

.. tag knife_user_list_options

This argument has the following options:

``-w``, ``--with-uri``
   Show the corresponding URIs.

.. end_tag

reregister
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_user_reregister

Use the ``reregister`` argument to regenerate an RSA key pair for a user. The public key will be stored on the Chef server and the private key will be displayed on ``STDOUT`` or written to a named file.

.. note:: Running this argument will invalidate the previous RSA key pair, making it unusable during authentication to the Chef server.

.. end_tag

**Syntax**

.. tag knife_user_reregister_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user reregister USER_NAME (options)

.. end_tag

**Options**

.. tag knife_user_reregister_options

This argument has the following options:

``-f FILE_NAME``, ``--file FILE_NAME``
   Save a private key to the specified file name.

.. end_tag

show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_user_show

Use the ``show`` argument to show the details of a user.

.. end_tag

**Syntax**

.. tag knife_user_show_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user show USER_NAME (options)

.. end_tag

**Options**

.. tag knife_user_show_options

This argument has the following options:

``-a ATTR``, ``--attribute ATTR``
   The attribute (or attributes) to show.

.. end_tag

What's Fixed
=====================================================
The following bugs were fixed:

* `CHEF-2960 <http://tickets.opscode.com/browse/CHEF-2960>`_  --- Upgrade JSON dependency to 1.7+
* `CHEF-3706 <http://tickets.opscode.com/browse/CHEF-3706>`_  --- Knife should provide commands for the user endpoint
* `CHEF-3707 <http://tickets.opscode.com/browse/CHEF-3707>`_  --- knife configure -i should create a user and not a client
* `CHEF-3809 <http://tickets.opscode.com/browse/CHEF-3809>`_  --- Getting error NoMethodError: undefined method 'CloseHandle' for Chef::ReservedNames::Win32::Handle:Class on Windows servers
* `CHEF-3836 <http://tickets.opscode.com/browse/CHEF-3836>`_  --- Run Lock tests randomly fail on slower Ci machines

What's Improved
=====================================================
The following improvements were made:

* `CHEF-3156 <http://tickets.opscode.com/browse/CHEF-3156>`_  --- Net::SSH dependency prevents using HMAC SHA2 family

