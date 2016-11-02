

=====================================================
knife environment 
=====================================================

.. tag environment

An environment is a way to map an organization's real-life workflow to what can be configured and managed when using Chef server. Every organization begins with a single environment called the ``_default`` environment, which cannot be modified (or deleted). Additional environments can be created to reflect each organization's patterns and workflow. For example, creating ``production``, ``staging``, ``testing``, and ``development`` environments. Generally, an environment is also associated with one (or more) cookbook versions.

.. end_tag

.. tag knife_environment_25

The ``knife environment`` subcommand is used to manage environments within a single organization on the Chef server.

.. end_tag

.. note:: .. tag knife_common_see_common_options_link

          Review the list of :doc:`common options </knife_common_options>` available to this (and all) knife subcommands and plugins.

          .. end_tag

create
=====================================================
.. tag knife_environment_create

Use the ``create`` argument to add an environment object to the Chef server. When this argument is run, knife will open $EDITOR to enable editing of the ``ENVIRONMENT`` description field (unless a description is specified as part of the command). When finished, knife will add the environment to the Chef server.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_environment_create_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife environment create ENVIRONMENT_NAME -d DESCRIPTION

.. end_tag

Options
-----------------------------------------------------
.. tag knife_environment_create_options

This argument has the following options:

``--description DESCRIPTION``
   The description of the environment. This value populates the description field for the environment on the Chef server.

.. end_tag

.. note:: .. tag knife_common_see_all_config_options

          See :doc:`knife.rb </config_rb_knife_optional_settings>` for more information about how to add certain knife options as settings in the knife.rb file.

          .. end_tag

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Create an environment**

.. tag knife_environment_create_summary

To create an environment named ``dev`` with a description of ``The development environment.``:

.. code-block:: bash

   $ knife environment create dev --description "The development environment."

.. end_tag

delete
=====================================================
.. tag knife_environment_delete

Use the ``delete`` argument to delete an environment from a Chef server.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_environment_delete_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife environment delete ENVIRONMENT_NAME

.. end_tag

Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Delete an environment**

.. tag knife_environment_delete_summary

To delete an environment named ``dev``, enter:

.. code-block:: bash

   $ knife environment delete dev

Type ``Y`` to confirm a deletion.

.. end_tag

edit
=====================================================
.. tag knife_environment_edit

Use the ``edit`` argument to edit the attributes of an environment. When this argument is run, knife will open $EDITOR to enable editing of ``ENVIRONMENT`` attributes. When finished, knife will update the Chef server with those changes.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_environment_edit_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife environment edit ENVIRONMENT_NAME

.. end_tag

Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Edit an environment**

.. tag knife_environment_edit_summary

To edit an environment named ``devops``, enter:

.. code-block:: bash

   $ knife environment edit devops

.. end_tag

from file
=====================================================
.. tag knife_environment_from_file

Use the ``from file`` argument to add or update an environment using a JSON or Ruby DSL description.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_environment_from_file_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife environment from file FILE (options)

.. end_tag

Options
-----------------------------------------------------
.. tag knife_environment_from_file_options

This argument has the following options:

``-a``, ``--all``
   Upload all environments found at the specified path.

.. end_tag

.. note:: .. tag knife_common_see_all_config_options

          See :doc:`knife.rb </config_rb_knife_optional_settings>` for more information about how to add certain knife options as settings in the knife.rb file.

          .. end_tag

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Create an environment from a JSON file**

.. tag knife_environment_from_file_summary

To add an environment using data contained in a JSON file:

.. code-block:: bash

   $ knife environment from file "path to JSON file"

.. end_tag

list
=====================================================
.. tag knife_environment_list

Use the ``list`` argument to list all of the environments that are currently available on the Chef server.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_environment_list_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife environment list -w

.. end_tag

Options
-----------------------------------------------------
.. tag knife_environment_list_options

This argument has the following options:

``-w``, ``--with-uri``
   Show the corresponding URIs.

.. end_tag

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**View a list of environments**

.. tag knife_environment_list_summary

To view a list of environments:

.. code-block:: bash

   $ knife environment list -w

.. end_tag

show
=====================================================
.. tag knife_environment_show

Use the ``show`` argument to display information about the specified environment.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_environment_show_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife environment show ENVIRONMENT_NAME

.. end_tag

Options
-----------------------------------------------------
.. tag knife_environment_show_options

This argument has the following options:

``-a ATTR``, ``--attribute ATTR``
   The attribute (or attributes) to show.

.. end_tag

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Show environments**

.. tag knife_environment_show_summary

To view information about the ``dev`` environment enter:

.. code-block:: bash

   $ knife environment show dev

to return:

.. code-block:: bash

   % knife environment show dev
   chef_type:            environment
   cookbook_versions:
   default_attributes:
   description:
   json_class:           Chef::Environment
   name:                 dev
   override_attributes:

   \\
   \\ 
   \\
   \\

.. end_tag

**Show environments as JSON**

.. tag knife_environment_show_json

To view information in JSON format, use the ``-F`` common option as part of the command like this:

.. code-block:: bash

   $ knife environment show devops -F json

Other formats available include ``text``, ``yaml``, and ``pp``.

.. end_tag

