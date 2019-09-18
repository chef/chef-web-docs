=====================================================
About Run-lists
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/run_lists.rst>`__

.. tag node_run_list

A run-list defines all of the information necessary for Chef to configure a node into the desired state. A run-list is:

* An ordered list of roles and/or recipes that are run in the exact order defined in the run-list; if a recipe appears more than once in the run-list, Chef Infra Client will not run it twice
* Always specific to the node on which it runs; nodes may have a run-list that is identical to the run-list used by other nodes
* Stored as part of the node object on the Chef server
* Maintained using knife and then uploaded from the workstation to the Chef Infra Server, or maintained using Chef Automate

.. end_tag

Run-list Format
=====================================================
.. tag node_run_list_format

A run-list must be in one of the following formats: fully qualified, cookbook, or default. Both roles and recipes must be in quotes, for example:

.. code-block:: ruby

   'role[NAME]'

or

.. code-block:: ruby

   'recipe[COOKBOOK::RECIPE]'

Use a comma to separate roles and recipes when adding more than one item the run-list:

.. code-block:: ruby

   'recipe[COOKBOOK::RECIPE],COOKBOOK::RECIPE,role[NAME]'

.. end_tag

Empty Run-lists
-----------------------------------------------------
.. tag node_run_list_empty

Use an empty run-list to determine if a failed Chef Infra Client run has anything to do with the recipes that are defined within that run-list. This is a quick way to discover if the underlying cause of a Chef Infra Client run failure is a configuration issue. If a failure persists even if the run-list is empty, check the following:

* Configuration settings in the config.rb file
* Permissions for the user to both the Chef Infra Server and to the node on which a Chef Infra Client run is to take place

.. end_tag

Knife Commands
=====================================================
The following knife commands may be used to manage run-lists on the Chef Infra Server.

Quotes, Windows
-----------------------------------------------------
.. tag knife_common_windows_quotes

When running knife in Microsoft Windows, a string may be interpreted as a wildcard pattern when quotes are not present in the command. The number of quotes to use depends on the shell from which the command is being run.

When running knife from the command prompt, a string should be surrounded by single quotes (``' '``). For example:

.. code-block:: bash

   $ knife node run_list set test-node 'recipe[iptables]'

When running knife from Windows PowerShell, a string should be surrounded by triple single quotes (``''' '''``). For example:

.. code-block:: bash

   $ knife node run_list set test-node '''recipe[iptables]'''

.. end_tag

Import-Module chef
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_common_windows_quotes_module

The Chef Client 12.4 release adds an optional feature to the Microsoft Installer Package (MSI) for Chef. This feature enables the ability to pass quoted strings from the Windows PowerShell command line without the need for triple single quotes (``''' '''``). This feature installs a Windows PowerShell module (typically in ``C:\opscode\chef\modules``) that is also appended to the ``PSModulePath`` environment variable. This feature is not enabled by default. To activate this feature, run the following command from within Windows PowerShell:

.. code-block:: bash

   $ Import-Module chef

or add ``Import-Module chef`` to the profile for Windows PowerShell located at:

.. code-block:: bash

   ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

This module exports cmdlets that have the same name as the command-line tools---chef-client, knife, chef-apply---that are built into Chef.

For example:

.. code-block:: bash

   $ knife exec -E 'puts ARGV' """&s0meth1ng"""

is now:

.. code-block:: bash

   $ knife exec -E 'puts ARGV' '&s0meth1ng'

and:

.. code-block:: bash

   $ knife node run_list set test-node '''role[ssssssomething]'''

is now:

.. code-block:: bash

   $ knife node run_list set test-node 'role[ssssssomething]'

To remove this feature, run the following command from within Windows PowerShell:

.. code-block:: bash

   $ Remove-Module chef

.. end_tag

run_list add
-----------------------------------------------------
.. tag knife_node_run_list_add

Use the ``run_list add`` argument to add run-list items (roles or recipes) to a node.

.. end_tag

.. tag node_run_list_format

A run-list must be in one of the following formats: fully qualified, cookbook, or default. Both roles and recipes must be in quotes, for example:

.. code-block:: ruby

   'role[NAME]'

or

.. code-block:: ruby

   'recipe[COOKBOOK::RECIPE]'

Use a comma to separate roles and recipes when adding more than one item the run-list:

.. code-block:: ruby

   'recipe[COOKBOOK::RECIPE],COOKBOOK::RECIPE,role[NAME]'

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_node_run_list_add_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife node run_list add NODE_NAME RUN_LIST_ITEM (options)

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_node_run_list_add_options

This argument has the following options:

``-a ITEM``, ``--after ITEM``
   Add a run-list item after the specified run-list item.

``-b ITEM``, ``--before ITEM``
   Add a run-list item before the specified run-list item.

.. end_tag

.. note:: .. tag knife_common_see_all_config_options

          See `config.rb </config_rb_optional_settings.html>`__ for more information about how to add certain knife options as settings in the config.rb file.

          .. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how to use this knife subcommand:

**Add a role**

.. tag knife_node_run_list_add_role

To add a role to a run-list, enter:

.. code-block:: bash

   $ knife node run_list add NODE_NAME 'role[ROLE_NAME]'

.. end_tag

**Add roles and recipes**

.. tag knife_node_run_list_add_roles_and_recipes

To add roles and recipes to a run-list, enter:

.. code-block:: bash

   $ knife node run_list add NODE_NAME 'recipe[COOKBOOK::RECIPE_NAME],recipe[COOKBOOK::RECIPE_NAME],role[ROLE_NAME]'

.. end_tag

**Add a recipe with a FQDN**

.. tag knife_node_run_list_add_recipe_with_fqdn

To add a recipe to a run-list using the fully qualified format, enter:

.. code-block:: bash

   $ knife node run_list add NODE_NAME 'recipe[COOKBOOK::RECIPE_NAME]'

.. end_tag

**Add a recipe with a cookbook**

.. tag knife_node_run_list_add_recipe_with_cookbook

To add a recipe to a run-list using the cookbook format, enter:

.. code-block:: bash

   $ knife node run_list add NODE_NAME 'COOKBOOK::RECIPE_NAME'

.. end_tag

**Add the default recipe**

.. tag knife_node_run_list_add_default_recipe

To add the default recipe of a cookbook to a run-list, enter:

.. code-block:: bash

   $ knife node run_list add NODE_NAME 'COOKBOOK'

.. end_tag

run_list remove
-----------------------------------------------------
.. tag knife_node_run_list_remove

Use the ``run_list remove`` argument to remove run-list items (roles or recipes) from a node. A recipe must be in one of the following formats: fully qualified, cookbook, or default. Both roles and recipes must be in quotes, for example: ``'role[ROLE_NAME]'`` or ``'recipe[COOKBOOK::RECIPE_NAME]'``. Use a comma to separate roles and recipes when removing more than one, like this: ``'recipe[COOKBOOK::RECIPE_NAME],COOKBOOK::RECIPE_NAME,role[ROLE_NAME]'``.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_node_run_list_remove_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife node run_list remove NODE_NAME RUN_LIST_ITEM

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command does not have any specific options.

.. note:: .. tag knife_common_see_all_config_options

          See `config.rb </config_rb_optional_settings.html>`__ for more information about how to add certain knife options as settings in the config.rb file.

          .. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how to use this knife subcommand:

**Remove a role**

.. tag knife_node_run_list_remove_role

To remove a role from a run-list, enter:

.. code-block:: bash

   $ knife node run_list remove NODE_NAME 'role[ROLE_NAME]'

.. end_tag

**Remove a run-list**

.. tag knife_node_run_list_remove_run_list

To remove a recipe from a run-list using the fully qualified format, enter:

.. code-block:: bash

   $ knife node run_list remove NODE_NAME 'recipe[COOKBOOK::RECIPE_NAME]'

.. end_tag

run_list set
-----------------------------------------------------
.. tag knife_node_run_list_set

Use the ``run_list set`` argument to set the run-list for a node. A recipe must be in one of the following formats: fully qualified, cookbook, or default. Both roles and recipes must be in quotes, for example: ``'role[ROLE_NAME]'`` or ``'recipe[COOKBOOK::RECIPE_NAME]'``. Use a comma to separate roles and recipes when setting more than one, like this: ``'recipe[COOKBOOK::RECIPE_NAME],COOKBOOK::RECIPE_NAME,role[ROLE_NAME]'``.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_node_run_list_set_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife node run_list set NODE_NAME RUN_LIST_ITEM

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command does not have any specific options.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

status
-----------------------------------------------------
The following examples show how to use the ``knife status`` subcommand to verify the status of run-lists.

**View status, include run-lists**

.. tag knife_status_include_run_lists

To include run-lists in the status, enter:

.. code-block:: bash

   $ knife status --run-list

to return something like:

.. code-block:: bash

   20 hours ago, dev-vm.chisamore.com, ubuntu 10.04, dev-vm.chisamore.com, 10.66.44.126, role[lb].
   3 hours ago, i-225f954f, ubuntu 10.04, ec2-67-202-63-102.compute-1.amazonaws.com, 67.202.63.102, role[web].
   3 hours ago, i-a45298c9, ubuntu 10.04, ec2-174-129-127-206.compute-1.amazonaws.com, 174.129.127.206, role[web].
   3 hours ago, i-5272a43f, ubuntu 10.04, ec2-184-73-9-250.compute-1.amazonaws.com, 184.73.9.250, role[web].
   3 hours ago, i-226ca64f, ubuntu 10.04, ec2-75-101-240-230.compute-1.amazonaws.com, 75.101.240.230, role[web].
   3 hours ago, i-f65c969b, ubuntu 10.04, ec2-184-73-60-141.compute-1.amazonaws.com, 184.73.60.141, role[web].

.. end_tag

**View status using a query**

.. tag knife_status_returned_by_query

To show the status of a subset of nodes that are returned by a specific query, enter:

.. code-block:: bash

   $ knife status "role:web" --run-list

to return something like:

.. code-block:: bash

   3 hours ago, i-225f954f, ubuntu 10.04, ec2-67-202-63-102.compute-1.amazonaws.com, 67.202.63.102, role[web].
   3 hours ago, i-a45298c9, ubuntu 10.04, ec2-174-129-127-206.compute-1.amazonaws.com, 174.129.127.206, role[web].
   3 hours ago, i-5272a43f, ubuntu 10.04, ec2-184-73-9-250.compute-1.amazonaws.com, 184.73.9.250, role[web].
   3 hours ago, i-226ca64f, ubuntu 10.04, ec2-75-101-240-230.compute-1.amazonaws.com, 75.101.240.230, role[web].
   3 hours ago, i-f65c969b, ubuntu 10.04, ec2-184-73-60-141.compute-1.amazonaws.com, 184.73.60.141, role[web].

.. end_tag

Management Console
=====================================================
The following sections describe how to manage run-lists when using the Chef management console.

Add Recipe
-----------------------------------------------------
.. tag manage_webui_node_run_list_add_role_or_recipe

To add a role or recipe to a run-list:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click **Edit Run List**.
#. In the **Edit Node Run List** dialog box, drag the role or recipe from the **Available Roles** or **Available Recipes** lists to the current run-list.

   .. image:: ../../images/step_manage_webui_node_run_list_add_role_or_recipe.png

#. Click **Save Run List**.

.. end_tag

Add Role
-----------------------------------------------------
.. tag manage_webui_node_run_list_add_role_or_recipe

To add a role or recipe to a run-list:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click **Edit Run List**.
#. In the **Edit Node Run List** dialog box, drag the role or recipe from the **Available Roles** or **Available Recipes** lists to the current run-list.

   .. image:: ../../images/step_manage_webui_node_run_list_add_role_or_recipe.png

#. Click **Save Run List**.

.. end_tag

Edit Node
-----------------------------------------------------
.. tag manage_webui_node_run_list_edit

To edit a run-list:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click **Edit Run List**.
#. In the **Edit Node Run List** dialog box, make your changes.
#. Click **Save Run List**.

.. end_tag

Edit Role
-----------------------------------------------------
.. tag manage_webui_policy_role_edit_run_list

To edit the run-list for a role:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Roles**.
#. Select a role.
#. Click **Edit Run List**.

   .. image:: ../../images/step_manage_webui_policy_role_edit_run_list.png

#. Make your changes.
#. Click **Save Run List**.

.. end_tag

Remove Recipe
-----------------------------------------------------
.. tag manage_webui_node_run_list_remove_role_or_recipe

To remove a role or recipe from a run-list:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click **Edit Run List**.
#. In the **Edit Node Run List** dialog box, drag the role or recipe from the **Current Run List** to the list of available roles or recipes.

   .. image:: ../../images/step_manage_webui_node_run_list_remove_role_or_recipe.png

#. Click **Save Run List**.

.. end_tag

Remove Role
-----------------------------------------------------
.. tag manage_webui_node_run_list_remove_role_or_recipe

To remove a role or recipe from a run-list:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click **Edit Run List**.
#. In the **Edit Node Run List** dialog box, drag the role or recipe from the **Current Run List** to the list of available roles or recipes.

   .. image:: ../../images/step_manage_webui_node_run_list_remove_role_or_recipe.png

#. Click **Save Run List**.

.. end_tag

View Current
-----------------------------------------------------
.. tag manage_webui_node_run_list_view_current

To view the current run-list for a node:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click the **Details** tab.
#. The current run-list is shown in the lower right:

   .. image:: ../../images/step_manage_webui_node_run_list_view_current.png

.. end_tag

View Node
-----------------------------------------------------
To view all of the nodes:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Select the **Details** tab.
#. The run-list for the node appears under the **Run List** header:

   .. image:: ../../images/step_manage_webui_nodes_view_run_list.png

Run-lists, Applied
=====================================================
A run-list will tell Chef Infra Client what to do when bootstrapping that node for the first time, and then how to configure that node on every subsequent Chef Infra Client run.

Bootstrap Operations
-----------------------------------------------------
.. tag install_chef_client

The ``knife bootstrap`` command is a common way to install Chef Infra Client on a node. The default for this approach assumes that a node can access the Chef website so that it may download the Chef Infra Client package from that location.

The Chef installer will detect the version of the operating system, and then install the appropriate Chef Infra Client version using a single command to install Chef Infra Client and all of its dependencies, including an embedded version of Ruby, RubyGems, OpenSSL, key-value stores, parsers, libraries, and command line utilities.

The Chef installer puts everything into a unique directory (``/opt/chef/``) so that Chef Infra Client will not interfere with other applications that may be running on the target machine. Once installed, Chef Infra Client requires a few more configuration steps before it can perform its first Chef Infra Client run on a node.

.. end_tag

.. tag chef_client_bootstrap_node

A node is any physical, virtual, or cloud system that is configured to be maintained by a Chef Infra Client. Bootstrapping installs Chef Infra Client on a target system so that it can run as a client and sets the node up to communicate with a Chef Infra Server. There are two ways to do this:

* Run the ``knife bootstrap`` command from a workstation.
* Perform an unattended install to bootstrap from the node itself, without requiring SSH  or WinRM connectivity

.. end_tag

.. tag chef_client_bootstrap_stages

The following diagram shows the stages of the bootstrap operation, and the list below the diagram describes each of those stages in greater detail.

.. image:: ../../images/chef_bootstrap.png

During a ``knife bootstrap`` bootstrap operation, the following happens:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Stages
     - Description
   * - **$ knife bootstrap**
     - On UNIX- and Linux-based machines: The ``knife bootstrap`` subcommand is issued from a workstation. The hostname, IP address, or FQDN of the target node is issued as part of this command. An SSH connection is established with the target node using port 22. A shell script is assembled using the chef-full.erb (the default bootstrap template), and is then executed on the target node.

       On Microsoft Windows machines: The ``knife bootstrap windows winrm`` subcommand is issued from a workstation. (This command is part of the `knife windows plugin </knife_windows.html>`__.) The hostname, IP address, or FQDN of the target node is issued as part of this command. A connection is established with the target node using WinRM over port 5985. (WinRM must be enabled with the corresponding firewall rules in place.)
   * - **Get the install script from Chef**
     - On UNIX- and Linux-based machines: The shell script that is derived from the chef-full.erb bootstrap template will make a request to the Chef website to get the most recent version of a second shell script (``install.sh``).

       On Microsoft Windows machines: The batch file that is derived from the windows-chef-client-msi.erb bootstrap template will make a request to the Chef website to get the .msi installer.
   * - **Get the Chef Infra Client package from Chef**
     - The second shell script (or batch file) then gathers system-specific information and determines the correct package for Chef Infra Client, and then downloads the appropriate package from ``omnitruck-direct.chef.io``.
   * - **Install Chef Infra Client**
     - Chef Infra Client is installed on the target node.
   * - **Start a Chef Infra Client run**
     - On UNIX- and Linux-based machines: The second shell script executes the ``chef-client`` binary with a set of initial settings stored within ``first-boot.json`` on the node. ``first-boot.json`` is generated from the workstation as part of the initial ``knife bootstrap`` subcommand.

       On Microsoft Windows machines: The batch file that is derived from the windows-chef-client-msi.erb bootstrap template executes the ``chef-client`` binary with a set of initial settings stored within ``first-boot.json`` on the node. ``first-boot.json`` is generated from the workstation as part of the initial ``knife bootstrap`` subcommand.
   * - **Complete a Chef Infra Client run**
     - a Chef Infra Client run proceeds, using HTTPS (port 443), and registers the node with the Chef Infra Server.

       The first Chef Infra Client run, by default, contains an empty run-list. A `run-list can be specified </knife_bootstrap.html>`__ as part of the initial bootstrap operation using the ``--run-list`` option as part of the ``knife bootstrap`` subcommand.

.. end_tag

The Chef Infra Client Run
-----------------------------------------------------
.. tag chef_client_run

.. THIS TOPIC IS TRUE FOR AN UPCOMING VERSION OF CHEF INFRA CLIENT; THE BEHAVIOR OF "SYNCHRONIZE COOKBOOKS" HAS CHANGED SLIGHTLY OVER TIME AND HAS BEEN VERSIONED.

A "Chef Infra Client run" is the term used to describe the steps Chef Infra Client takes to configure a node during a run. The following diagram shows the various stages that occur during a Chef Infra Client run.

.. image:: ../../images/chef_run.png

During every Chef Infra Client run, the following happens:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Stages
     - Description
   * - **Get configuration data**
     - Chef Infra Client gets process configuration data from the `client.rb </config_rb_client.html>`_ file on the `node </nodes.html>`_, and then gets node configuration data from Ohai. One important piece of configuration data is the name of the node, which is found in the ``node_name`` attribute in the client.rb file or is provided by Ohai. If Ohai provides the name of a node, it is typically the FQDN for the node, which is always unique within an organization.
   * - **Authenticate to the Chef Infra Server**
     - Chef Infra Client `authenticates </auth.html>`_ to the Chef Infra Server using an RSA private key and the Chef Infra Server API. The name of the node is required as part of the authentication process to the Chef Infra Server. If this is the first Chef Infra Client run for a node, the chef-validator will be used to generate the RSA private key.
   * - **Get, rebuild the node object**
     - Chef Infra Client pulls down the node object from the Chef Infra Server. If this is the first Chef Infra Client run for the node, there will not be a node object to pull down from the Chef Infra Server. After the node object is pulled down from the Chef Infra Server, Chef Infra Client rebuilds the node object. If this is the first Chef Infra Client run for the node, the rebuilt node object will contain only the default run-list. For any subsequent Chef Infra Client run, the rebuilt node object will also contain the run-list from the previous Chef Infra Client run.
   * - **Expand the run-list**
     - Chef Infra Client expands the `run-list </run_lists.html>`_ from the rebuilt node object, compiling a full and complete list of roles and recipes that will be applied to the node, placing the roles and recipes in the same exact order they will be applied. (The run-list is stored in each node object's JSON file, grouped under ``run_list``.)
   * - **Synchronize cookbooks**
     - Chef Infra Client asks the Chef Infra Server for a list of all `cookbook files </cookbooks.html>`_ (including recipes, templates, resources, providers, attributes, libraries, and definitions) that will be required to do every action identified in the run-list for the rebuilt node object. The Chef Infra Server provides to Chef Infra Client a list of all of those files. Chef Infra Client compares this list to the cookbook files cached on the node (from previous Chef Infra Client runs), and then downloads a copy of every file that has changed since the previous Chef Infra Client run, along with any new files.
   * - **Reset node attributes**
     - All attributes in the rebuilt node object are reset. All attributes from attribute files, environments, roles, and Ohai are loaded. Attributes that are defined in attribute files are first loaded according to cookbook order. For each cookbook, attributes in the ``default.rb`` file are loaded first, and then additional attribute files (if present) are loaded in lexical sort order. If attribute files are found within any cookbooks that are listed as dependencies in the ``metadata.rb`` file, these are loaded as well. All attributes in the rebuilt node object are updated with the attribute data according to attribute precedence. When all of the attributes are updated, the rebuilt node object is complete.
   * - **Compile the resource collection**
     - Chef Infra Client identifies each resource in the node object and builds the resource collection. Libraries are loaded first to ensure that all language extensions and Ruby classes are available to all resources. Next, attributes are loaded, followed by custom resources, and then all definitions (to ensure that any pseudo-resources within definitions are available). Finally, all recipes are loaded in the order specified by the expanded run-list. This is also referred to as the "compile phase".
   * - **Converge the node**
     - Chef Infra Client configures the system based on the information that has been collected. Each resource is executed in the order identified by the run-list, and then by the order in which each resource is listed in each recipe. Each resource in the resource collection is mapped to a provider. The provider examines the node, and then does the steps necessary to complete the action. And then the next resource is processed. Each action configures a specific part of the system. This process is also referred to as convergence. This is also referred to as the "execution phase".
   * - **Update the node object, process exception and report handlers**
     - When all of the actions identified by resources in the resource collection have been done and Chef Infra Client finishes successfully, then Chef Infra Client updates the node object on the Chef Infra Server with the node object built during a Chef Infra Client run. (This node object will be pulled down by Chef Infra Client during the next Chef Infra Client run.) This makes the node object (and the data in the node object) available for search.

       Chef Infra Client always checks the resource collection for the presence of exception and report handlers. If any are present, each one is processed appropriately.
   * - **Stop, wait for the next run**
     - When everything is configured and the Chef Infra Client run is complete, Chef Infra Client stops and waits until the next time it is asked to run.

.. end_tag

Attribute Evaluation Order
-----------------------------------------------------
.. tag node_attribute_evaluation_order

Chef Infra Client evaluates attributes in the order defined by the run-list, including any attributes that are in the run-list because of cookbook dependencies.

.. end_tag
