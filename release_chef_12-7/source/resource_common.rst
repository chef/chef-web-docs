.. THIS PAGE DOCUMENTS chef-client version 12.7

=====================================================
Common Functionality 
=====================================================

.. include:: ../../includes_resources_common/includes_resources_common_intro.rst

.. _resource_common_actions:

Actions
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_actions.rst

Examples
-----------------------------------------------------
The following examples show how to use common actions in a recipe.

**Use the :nothing action**

.. include:: ../../step_resource/step_resource_service_use_nothing_action.rst

.. _resource_common_properties:

Properties
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_attributes.rst

Examples
-----------------------------------------------------
The following examples show how to use common properties in a recipe.

**Use the ignore_failure common property**

.. include:: ../../step_resource/step_resource_package_use_ignore_failure_attribute.rst

**Use the provider common property**

.. include:: ../../step_resource/step_resource_package_use_provider_attribute.rst

**Use the supports common property**

.. include:: ../../step_resource/step_resource_service_use_supports_attribute.rst

**Use the supports and providers common properties**

.. include:: ../../step_resource/step_resource_service_use_provider_and_supports_attributes.rst

.. _resource_common_guards:

Guards
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_guards.rst

.. note:: .. include:: ../../includes_resources_common/includes_resources_common_guards_execute_resource.rst

Attributes
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_guards_attributes.rst

Arguments
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_guards_arguments.rst

not_if Examples
-----------------------------------------------------

**Update if not already updated**

.. include:: ../../step_recipe/step_recipe_guard_notif_do_not_update_if_already_updated.rst

**Ensure a node can resolve a host**

.. include:: ../../step_recipe/step_recipe_guard_notif_ensure_node_can_resolve_host.rst

**Prevent installs on older versions**

.. include:: ../../step_recipe/step_recipe_guard_notif_prevent_install_on_older_versions.rst

**Set the administrator if not already set**

.. include:: ../../step_recipe/step_recipe_guard_notif_set_administrator_unless_already_set.rst

only_if Examples
-----------------------------------------------------

**Install packages only when necessary**

.. include:: ../../step_recipe/step_recipe_guard_onlyif_certain_packages.rst

**Remove a recipe if it belongs to a specific run-list**

.. include:: ../../step_recipe/step_recipe_guard_onlyif_remove_recipe.rst

**Re-register ASP.Net if it's already installed**

.. include:: ../../step_recipe/step_recipe_guard_onlyif_reregister_aspdotnet.rst

.. _resource_common_guard_interpreters:

Guard Interpreters
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_guard_interpreter.rst

Attributes
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_guard_interpreter_attributes.rst

Inheritance
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_guard_interpreter_attributes_inherit.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_guard_interpreter_example_default.rst

.. _resource_common_lazy_eval:

Lazy Evaluation
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_lazy_evaluation.rst

.. _resource_common_notifications:

Notifications
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_notification.rst

Timers
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

Notifies
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

.. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how to use the ``notifies`` notification in a recipe.

**Delay notifications**

.. include:: ../../step_resource/step_resource_template_notifies_delay.rst

**Notify immediately**

.. include:: ../../step_resource/step_resource_template_notifies_run_immediately.rst

**Notify multiple resources**

.. include:: ../../step_resource/step_resource_template_notifies_multiple_resources.rst

**Notify in a specific order**

.. include:: ../../step_resource/step_resource_execute_notifies_specific_order.rst

**Reload a service**

.. include:: ../../step_resource/step_resource_template_notifies_reload_service.rst

**Restart a service when a template is modified**

.. include:: ../../step_resource/step_resource_template_notifies_restart_service_when_template_modified.rst

**Send notifications to multiple resources**

.. include:: ../../step_resource/step_resource_template_notifies_send_notifications_to_multiple_resources.rst

**Execute a command using a template**

.. include:: ../../step_resource/step_resource_execute_command_from_template.rst

**Restart a service, and then notify a different service**

.. include:: ../../step_resource/step_resource_service_restart_and_notify.rst

**Notify when a remote source changes**

.. include:: ../../step_resource/step_resource_remote_file_transfer_remote_source_changes.rst

Subscribes
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

.. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how to use the ``subscribes`` notification in a recipe.

**Prevent restart and reconfigure if configuration is broken**

.. include:: ../../step_resource/step_resource_execute_subscribes_prevent_restart_and_reconfigure.rst

**Reload a service using a template**

.. include:: ../../step_resource/step_resource_service_subscribes_reload_using_template.rst

**Stash a file in a data bag**

.. include:: ../../step_resource/step_resource_ruby_block_stash_file_in_data_bag.rst

.. _resource_common_relative_paths:

Relative Paths
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_relative_paths.rst

Examples
-----------------------------------------------------
.. include:: ../../step_resource/step_resource_template_use_relative_paths.rst

.. _resource_common_run_in_compile_phase:

Run in Compile Phase
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_compile.rst

run_action
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_compile_begin.rst

.. _resource_common_windows_file_security:

Windows File Security
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_windows_security.rst

Access Control Lists (ACLs)
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_windows_security_acl.rst

Inheritance
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_windows_security_inherits.rst

