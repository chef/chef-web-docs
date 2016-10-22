.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following user accounts exist on the Chef server: ``pivotal`` (a superuser account), ``alice``, ``bob``, ``carol``, and ``dan``. Run the following command to view a list of users on the Chef server:

.. code-block:: bash

   $ chef-server-ctl user-list

and it returns the same list of users:

.. code-block:: bash

   pivotal
   alice
   bob
   carol
   dan

Alice is a member of the IT team whose responsibilities include day-to-day administration of the Chef server, in particular managing the user accounts on the Chef server that are used by the rest of the organization. From a workstation, Alice runs the following command:

.. code-block:: bash

   $ knife user list -c ~/.chef/alice.rb

and it returns the following error:

.. code-block:: bash

   ERROR: You authenticated successfully to <chef_server_url> as alice
          but you are not authorized for this action
   Response: Missing read permission

Alice is not a superuser and does not have permissions on other users because user accounts are global to organizations in the Chef server. Let's add Alice to the ``server-admins`` group:

.. code-block:: bash

   $ chef-server-ctl grant-server-admin-permissions alice

and it returns the following response:

.. code-block:: bash

   User alice was added to server-admins.

Alice can now create, read, update, and delete user accounts on the Chef server, even for organizations to which Alice is not a member. From a workstation, Alice re-runs the following command:

.. code-block:: bash

   $ knife user list -c ~/.chef/alice.rb

which now returns:

.. code-block:: bash

   pivotal
   alice
   bob
   carol
   dan

Alice is now a server administrator and can use the following knife subcommands to manage users on the Chef server: 

* ``knife user-create``
* ``knife user-delete``
* ``knife user-edit``
* ``knife user-list``
* ``knife user-show``

For example, Alice runs the following command:

.. code-block:: bash

   $ knife user edit carol -c ~/.chef/alice.rb

and the $EDITOR opens in which Alice makes changes, and then saves them.
