.. THIS PAGE DOCUMENTS chef-client version 12.1

=====================================================
breakpoint
=====================================================

.. include:: ../../includes_resources/includes_resource_breakpoint.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_breakpoint_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_breakpoint_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_breakpoint_attributes_12-5.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_breakpoint_providers.rst
.. 

Debug Recipes with chef-shell
=====================================================
.. include:: ../../includes_chef_shell/includes_chef_shell.rst

Modes
-----------------------------------------------------
.. include:: ../../includes_chef_shell/includes_chef_shell_modes.rst

Configure
-----------------------------------------------------
.. include:: ../../includes_chef_shell/includes_chef_shell_config.rst

chef-shell.rb
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_shell/includes_chef_shell_config_rb.rst

Run as a chef-client
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_shell/includes_chef_shell_run_as_chef_client.rst

Manage
-----------------------------------------------------
.. include:: ../../includes_chef_shell/includes_chef_shell_manage.rst

Use Breakpoints
-----------------------------------------------------
.. include:: ../../includes_chef_shell/includes_chef_shell_breakpoints.rst

Step Through Run-list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_shell/includes_chef_shell_step_through_run_list.rst

Debug Existing Recipe
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_shell/includes_chef_shell_debug_existing_recipe.rst

Advanced Debugging
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_shell/includes_chef_shell_advanced_debug.rst

Debug Examples
-----------------------------------------------------
The following examples show how to use chef-shell.

"Hello World"
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_shell/includes_chef_shell_example_hello_world.rst

Get Specific Nodes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_shell/includes_chef_shell_example_get_specific_nodes.rst

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**A recipe without a breakpoint**

.. include:: ../../step_resource/step_resource_breakpoint_no.rst

**The same recipe with breakpoints**

.. include:: ../../step_resource/step_resource_breakpoint_yes.rst
