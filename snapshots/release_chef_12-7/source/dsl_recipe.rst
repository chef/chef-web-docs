.. THIS PAGE DOCUMENTS chef-client version 12.7

=====================================================
About the Recipe DSL
=====================================================

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe.rst

Because the Recipe DSL is a Ruby DSL, then anything that can be done using Ruby can also be done in a recipe, including ``if`` and ``case`` statements, using the ``include?`` Ruby method, including recipes in recipes, and checking for dependencies.

Use Ruby
=====================================================
Common Ruby techniques can be used with the Recipe DSL methods.

if Statements
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_statement_if.rst

case Statements
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_statement_case.rst

include? Method
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_parameter_include.rst

Array Syntax Shortcut
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_array_shortcut.rst

Include Recipes
=====================================================
.. include:: ../../includes_cookbooks/includes_cookbooks_recipe_include_in_recipe.rst

Reload Attributes
-----------------------------------------------------
.. include:: ../../includes_cookbooks/includes_cookbooks_attribute_file_reload_from_recipe.rst

Recipe DSL Methods
=====================================================
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method.rst

attribute?
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_attribute.rst

control
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_controls.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_syntax.rst

directory Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_directory.rst

file Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_file.rst

package Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_package.rst

port Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_port.rst

service Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_service.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**A package is installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_package_installed.rst

**A package version is installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_package_installed_version.rst

**A package is not installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_package_not_installed.rst

**A service is enabled**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_service_enabled.rst

**A configuration file contains specific settings**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_file_sshd_configuration.rst

**A file contains desired permissions and contents**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_file_permissions.rst

**Test an attribute value**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_use_attributes.rst


control_group
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_group.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_group_syntax.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**control_group block with multiple control blocks**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_group_many_controls.rst

**Duplicate control_group names**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_group_duplicate_names.rst

**Verify a package is installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_group_simple_recipe.rst

cookbook_name
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_cookbook_name.rst

data_bag
-----------------------------------------------------
.. include:: ../../includes_data_bag/includes_data_bag.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_data_bag.rst

**Examples**

The following example shows how the ``data_bag`` method can be used in a recipe.

**Get a data bag, and then iterate through each data bag item**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_data_bag.rst

data_bag_item
-----------------------------------------------------
.. include:: ../../includes_data_bag/includes_data_bag.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_data_bag_item.rst

**Examples**

The following examples show how the ``data_bag_item`` method can be used in a recipe.

**Get a data bag, and then iterate through each data bag item**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_data_bag.rst

**Use the contents of a data bag in a recipe**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_data_bag_use_data_bag_methods.rst

platform?
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_platform.rst

Parameters
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_platform_parameters.rst

For example:

.. code-block:: ruby

   platform?('debian')

or:

.. code-block:: ruby

   platform?('rhel', 'debian')

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following example shows how the ``platform?`` method can be used in a recipe.

**Use an if statement with the platform recipe DSL method**

.. include:: ../../step_resource/step_resource_ruby_block_if_statement_use_with_platform.rst

platform_family?
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_platform_family.rst

.. 
.. Parameters
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_platform_family_parameters.rst
.. 

For example:

.. code-block:: ruby

   platform_family?('gentoo')

or:

.. code-block:: ruby

   platform_family?('slackware', 'suse', 'arch')

.. note:: ``platform_family?`` will default to ``platform?`` when ``platform_family?`` is not explicitly defined.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how the ``platform_family?`` method can be used in a recipe.

**Use a specific binary for a specific platform**

.. include:: ../../step_resource/step_resource_remote_file_use_platform_family.rst

reboot_pending?
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_reboot_pending.rst

recipe_name
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_recipe_name.rst

resources
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_resources.rst

search
-----------------------------------------------------
.. include:: ../../includes_search/includes_search.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_search.rst

:filter_result
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_search_filter_result.rst

Query Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_search/includes_search_query_syntax.rst

Keys
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_search/includes_search_key.rst

**Nested Fields**

.. include:: ../../includes_search/includes_search_key_nested.rst

Patterns
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_search/includes_search_pattern.rst

**Exact Match**

.. include:: ../../includes_search/includes_search_pattern_exact.rst

**Wildcard Match**

.. include:: ../../includes_search/includes_search_pattern_wildcard.rst

**Range Match**

.. include:: ../../includes_search/includes_search_pattern_range.rst

**Fuzzy Match**

.. include:: ../../includes_search/includes_search_pattern_fuzzy.rst

Operators
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_search/includes_search_boolean_operators.rst

Special Characters
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_search/includes_search_special_characters.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how the ``search`` method can be used in a recipe.

**Use the search recipe DSL method to find users**

.. include:: ../../step_resource/step_resource_execute_use_search_dsl_method.rst

shell_out
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_shell_out.rst

shell_out!
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_shell_out_bang.rst

shell_out_with_systems_locale
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_shell_out_with_systems_locale.rst

tag, tagged?, untag
-----------------------------------------------------
.. include:: ../../includes_chef/includes_chef_tags.rst

.. include:: ../../includes_cookbooks/includes_cookbooks_recipe_tags.rst

value_for_platform
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_value_for_platform.rst

Operators
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cookbooks/includes_cookbooks_version_constraints_operators.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_value_for_platform_examples.rst

value_for_platform_family
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_value_for_platform_family.rst

Event Handlers
=====================================================
.. note:: Event handlers are not specifically part of the Recipe DSL. An event handler is declared using the ``Chef.event_hander`` method, which declares the event handler within recipes in a similar manner to other Recipe DSL methods.

.. include:: ../../includes_dsl_handler/includes_dsl_handler.rst

on Method
-----------------------------------------------------
.. include:: ../../includes_dsl_handler/includes_dsl_handler_method_on.rst

Event Types
-----------------------------------------------------
.. include:: ../../includes_dsl_handler/includes_dsl_handler_event_types.rst

Examples
-----------------------------------------------------
The following examples show ways to use the Handler DSL.

Send Email
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_handler/includes_dsl_handler_slide_send_email.rst

**Define How Email is Sent**

.. include:: ../../includes_dsl_handler/includes_dsl_handler_slide_send_email_library.rst

**Add the Handler**

.. include:: ../../includes_dsl_handler/includes_dsl_handler_slide_send_email_handler.rst

**Test the Handler**

.. include:: ../../includes_dsl_handler/includes_dsl_handler_slide_send_email_test.rst

etcd Locks
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_handler/includes_dsl_handler_example_etcd_lock.rst

HipChat Notifications
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_handler/includes_dsl_handler_example_hipchat.rst


Windows Platform
=====================================================
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_windows_methods.rst

.. note:: .. include:: ../../includes_notes/includes_notes_dsl_recipe_order_for_windows_methods.rst

registry_data_exists?
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_data_exists.rst

registry_get_subkeys
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_get_subkeys.rst

registry_get_values
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_get_values.rst

registry_has_subkeys?
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_has_subkeys.rst

registry_key_exists?
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_key_exists.rst

registry_value_exists?
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_value_exists.rst

Helpers
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_helper_windows_platform.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_helper_windows_platform_helpers.rst

.. include:: ../../step_dsl_recipe/step_dsl_recipe_helper_windows_platform.rst
