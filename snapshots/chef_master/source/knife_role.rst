=====================================================
knife role 
=====================================================

.. include:: ../../includes_role/includes_role.rst

.. include:: ../../includes_knife/includes_knife_role.rst

.. note:: To add a role to a node and then build out the run-list for that node, use the :doc:`knife node </knife_node>` subcommand and its ``run_list add`` argument.

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

bulk delete
=====================================================
Use the ``bulk delete`` argument to delete one or more roles that match a pattern defined by a regular expression. The regular expression must be within quotes and not be surrounded by forward slashes (/).


Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife role bulk delete REGEX


Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Bulk delete roles**

Use a regular expression to define the pattern used to bulk delete roles:

.. code-block:: bash

   $ knife role bulk delete "^[0-9]{3}$"

create
=====================================================
Use the ``create`` argument to add a role to the Chef server. Role data is saved as JSON on the Chef server.


Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife role create ROLE_NAME (options)


Options
-----------------------------------------------------
This argument has the following options:

``--description DESCRIPTION``
   The description of the role. This value populates the description field for the role on the Chef server.

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Create a role**

To add a role named ``role1``, enter:

.. code-block:: bash

   $ knife role create role1
   
In the $EDITOR enter the role data in JSON:

.. code-block:: javascript

   {
      "name": "role1",
      "default_attributes": {
      },
      "json_class": "Chef::Role",
      "run_list": ['recipe[cookbook_name::recipe_name],
                    role[role_name]'
      ],
      "description": "",
      "chef_type": "role",
      "override_attributes": {
      }
   }

When finished, save it.

delete
=====================================================
Use the ``delete`` argument to delete a role from the Chef server.


Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife role delete ROLE_NAME


Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Delete a role**

.. To delete a role:

.. code-block:: bash

   $ knife role delete devops

Type ``Y`` to confirm a deletion.

edit
=====================================================
Use the ``edit`` argument to edit role details on the Chef server.


Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife role edit ROLE_NAME


Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Edit a role**

To edit the data for a role named ``role1``, enter:

.. code-block:: bash

   $ knife role edit role1
   
Update the role data in JSON:

.. code-block:: javascript

   {
      "name": "role1",
      "description": "This is the description for the role1 role.",
      "json_class": "Chef::Role",
      "default_attributes": {
      },
      "override_attributes": {
      },
      "chef_type": "role",
      "run_list": ["recipe[cookbook_name::recipe_name]",
                   "role[role_name]"
      ],
      "env_run_lists": {
      },
   }

When finished, save it.

from file
=====================================================
Use the ``from file`` argument to create a role using existing JSON data as a template.


Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife role from file FILE


Options
-----------------------------------------------------
This command does not have any specific options.

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Create a role using JSON data**

To view role details based on the values contained in a JSON file:

.. code-block:: bash

   $ knife role from file "path to JSON file"

list
=====================================================
Use the ``list`` argument to view a list of roles that are currently available on the Chef server.


Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife role list


Options
-----------------------------------------------------
This argument has the following options:

``-w``, ``--with-uri``
   Show the corresponding URIs.

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**View a list of roles**

To view a list of roles on the Chef server and display the URI for each role returned, enter:

.. code-block:: bash

   $ knife role list -w


show
=====================================================
Use the ``show`` argument to view the details of a role.


Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife role show ROLE_NAME


Options
-----------------------------------------------------
This argument has the following options:

``-a ATTR``, ``--attribute ATTR``
   The attribute (or attributes) to show.


.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Show as JSON data**

To view information in JSON format, use the ``-F`` common option as part of the command like this:

.. code-block:: bash

   $ knife role show devops -F json

Other formats available include ``text``, ``yaml``, and ``pp``.

**Show as raw JSON data**

To view node information in raw JSON, use the ``-l`` or ``--long`` option:

.. code-block:: bash

   knife role show -l -F json <role_name>

and/or:

.. code-block:: bash

   knife role show -l --format=json <role_name>
