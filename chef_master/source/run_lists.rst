=====================================================
About Run-lists
=====================================================

.. include:: ../../includes_node/includes_node_run_list.rst

Run-list Format
=====================================================
.. include:: ../../includes_node/includes_node_run_list_format.rst

Empty Run-lists
-----------------------------------------------------
.. include:: ../../includes_node/includes_node_run_list_empty.rst

|knife_title| Commands
=====================================================
The following |knife| commands may be used to manage run-lists on the |chef server|.

Quotes, Windows
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_common_windows_quotes.rst

Import-Module chef
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_common_windows_quotes_module.rst

run_list add
-----------------------------------------------------
.. include:: ../../includes_node/includes_node_run_list.rst

.. include:: ../../includes_knife/includes_knife_node_run_list_add.rst

.. include:: ../../includes_node/includes_node_run_list_format.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_node_run_list_add_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_node_run_list_add_options.rst

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how to use this |knife| subcommand:

**Add a role**

.. include:: ../../step_knife/step_knife_node_run_list_add_role.rst

**Add roles and recipes**

.. include:: ../../step_knife/step_knife_node_run_list_add_roles_and_recipes.rst

**Add a recipe with a FQDN**

.. include:: ../../step_knife/step_knife_node_run_list_add_recipe_with_fqdn.rst

**Add a recipe with a cookbook**

.. include:: ../../step_knife/step_knife_node_run_list_add_recipe_with_cookbook.rst

**Add the default recipe**

.. include:: ../../step_knife/step_knife_node_run_list_add_default_recipe.rst


run_list remove
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_node_run_list_remove.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_node_run_list_remove_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|no_options|

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how to use this |knife| subcommand:

**Remove a role**

.. include:: ../../step_knife/step_knife_node_run_list_remove_role.rst

**Remove a run-list**

.. include:: ../../step_knife/step_knife_node_run_list_remove_run_list.rst

run_list set
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_node_run_list_set.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_node_run_list_set_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|no_options|

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

status
-----------------------------------------------------
The following examples show how to use the |subcommand knife status| subcommand to verify the status of run-lists.

**View status, include run-lists**

.. include:: ../../step_knife/step_knife_status_include_run_lists.rst

**View status using a query**

.. include:: ../../step_knife/step_knife_status_returned_by_query.rst

Management Console
=====================================================
The following sections describe how to manage run-lists when using the |chef manage|.

Add Recipe
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_node_run_list_add_role_or_recipe.rst

Add Role
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_node_run_list_add_role_or_recipe.rst

Edit Node
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_node_run_list_edit.rst

Edit Role
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_policy_role_edit_run_list.rst

Remove Recipe
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_node_run_list_remove_role_or_recipe.rst

Remove Role
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_node_run_list_remove_role_or_recipe.rst

View Current
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_node_run_list_view_current.rst

View Node
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_nodes_view_run_list.rst

Run-lists, Applied
=====================================================
A run-list will tell the |chef client| what to do when bootstrapping that node for the first time, and then how to configure that node on every subsequent |chef client| run.

Bootstrap Operations
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_chef_client.rst

.. include:: ../../includes_chef_client/includes_chef_client_bootstrap_node.rst

.. include:: ../../includes_chef_client/includes_chef_client_bootstrap_stages.rst

The |chef client_title| Run
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_run.rst

Attribute Evaluation Order
-----------------------------------------------------
.. include:: ../../includes_node/includes_node_attribute_evaluation_order.rst