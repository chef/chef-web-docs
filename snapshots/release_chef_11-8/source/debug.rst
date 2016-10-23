.. THIS PAGE DOCUMENTS chef-client version 11.8

=====================================================
Debug Recipes and chef-client Runs
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

.. include:: ../../includes_debug/includes_debug.rst

Basic 
=====================================================
.. include:: ../../includes_debug/includes_debug_basic.rst

Empty Run-lists
-----------------------------------------------------
.. include:: ../../includes_node/includes_node_run_list_empty.rst

Knife
-----------------------------------------------------
.. include:: ../../includes_debug/includes_debug_knife.rst

chef-client
-----------------------------------------------------
.. include:: ../../includes_debug/includes_debug_chef_client.rst

log Resource
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_log.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_log_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_log_actions.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_log_attributes_12-5.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_log_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Specify a log entry**

.. include:: ../../step_resource/step_resource_log_set_info.rst

**Set debug logging level**

.. include:: ../../step_resource/step_resource_log_set_debug.rst

**Create log entry when the contents of a data bag are used**

.. include:: ../../step_resource/step_resource_log_set_debug.rst

**Add a message to a log file**

.. include:: ../../step_resource/step_resource_log_add_message.rst

Advanced
=====================================================
.. include:: ../../includes_debug/includes_debug_advanced.rst

chef_handler
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler.rst

.. include:: ../../includes_handler/includes_handler_types.rst

Read more :doc:`about exception, report, and start handlers </handlers>`.

chef-shell
-----------------------------------------------------
.. include:: ../../includes_chef_shell/includes_chef_shell.rst

.. note:: .. include:: ../../includes_notes/includes_notes_chef_shell_was_shef.rst

.. note:: chef-shell is configured using the :doc:`chef-shell (executable) </ctl_chef_shell>`.

.. include:: ../../includes_chef_shell/includes_chef_shell_modes.rst

Configure
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_shell/includes_chef_shell_config.rst

chef-shell.rb
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_shell/includes_chef_shell_config_rb.rst

Run as a chef-client
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_shell/includes_chef_shell_run_as_chef_client.rst

Manage
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_shell/includes_chef_shell_manage.rst

breakpoint Resource
-----------------------------------------------------
.. include:: ../../includes_chef_shell/includes_chef_shell_breakpoints.rst

.. include:: ../../includes_resources/includes_resource_breakpoint.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_breakpoint_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_breakpoint_actions.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_breakpoint_attributes_12-5.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_breakpoint_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**A recipe without a breakpoint**

.. include:: ../../step_resource/step_resource_breakpoint_no.rst

**The same recipe with breakpoints**

.. include:: ../../step_resource/step_resource_breakpoint_yes.rst

Step Through Run-list
-----------------------------------------------------
.. include:: ../../includes_chef_shell/includes_chef_shell_step_through_run_list.rst

Debug Existing Recipe
-----------------------------------------------------
.. include:: ../../includes_chef_shell/includes_chef_shell_debug_existing_recipe.rst

Advanced Debugging
-----------------------------------------------------
.. include:: ../../includes_chef_shell/includes_chef_shell_advanced_debug.rst

debug_value
-----------------------------------------------------
.. include:: ../../includes_node/includes_node_debug_attribute_value.rst

ignore_failure Method
-----------------------------------------------------
.. include:: ../../includes_debug/includes_debug_ignore_failure.rst

chef-solo
-----------------------------------------------------
.. include:: ../../includes_chef_solo/includes_chef_solo.rst

.. include:: ../../includes_ctl_chef_solo/includes_ctl_chef_solo.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_solo/includes_ctl_chef_solo_11-12_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Use a URL**

.. include:: ../../step_ctl_chef_solo/step_ctl_chef_solo_use_url.rst

**Use a directory**

.. include:: ../../step_ctl_chef_solo/step_ctl_chef_solo_use_directory.rst

**Use a URL for cookbook and JSON data**

.. include:: ../../step_ctl_chef_solo/step_ctl_chef_solo_url_for_cookbook_and_json.rst

**"Hello World"**

.. include:: ../../includes_chef_shell/includes_chef_shell_example_hello_world.rst

**Get Specific Nodes**

.. include:: ../../includes_chef_shell/includes_chef_shell_example_get_specific_nodes.rst
