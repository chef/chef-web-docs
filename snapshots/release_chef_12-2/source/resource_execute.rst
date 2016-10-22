.. THIS PAGE DOCUMENTS chef-client version 12.2

=====================================================
execute
=====================================================

.. include:: ../../includes_resources/includes_resource_execute.rst

.. note:: .. include:: ../../includes_notes/includes_notes_execute_resource_intepreter.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_execute_syntax_12-5.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_execute_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_execute_attributes_12-5.rst

Guards
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_guards.rst

.. note:: .. include:: ../../includes_resources_common/includes_resources_common_guards_execute_resource.rst

**Attributes**

.. include:: ../../includes_resources_common/includes_resources_common_guards_attributes.rst

**Arguments**

.. include:: ../../includes_resources_common/includes_resources_common_guards_arguments.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_execute_providers.rst
.. 

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Run a command upon notification**

.. include:: ../../step_resource/step_resource_execute_command_upon_notification.rst

**Run a touch file only once while running a command**

.. include:: ../../step_resource/step_resource_execute_command_with_touch_file.rst

**Run a command which requires an environment variable**

.. include:: ../../step_resource/step_resource_execute_command_with_variable.rst

**Delete a repository using yum to scrub the cache**

.. include:: ../../step_resource/step_resource_yum_package_delete_repo_use_yum_to_scrub_cache.rst

**Install repositories from a file, trigger a command, and force the internal cache to reload**

.. include:: ../../step_resource/step_resource_yum_package_install_yum_repo_from_file.rst

**Prevent restart and reconfigure if configuration is broken**

.. include:: ../../step_resource/step_resource_execute_subscribes_prevent_restart_and_reconfigure.rst

**Notify in a specific order**

.. include:: ../../step_resource/step_resource_execute_notifies_specific_order.rst

**Execute a command using a template**

.. include:: ../../step_resource/step_resource_execute_command_from_template.rst

**Add a rule to an IP table**

.. include:: ../../step_resource/step_resource_execute_add_rule_to_iptable.rst

**Stop a service, do stuff, and then restart it**

.. include:: ../../step_resource/step_resource_service_stop_do_stuff_start.rst

**Use the platform_family? method**

.. include:: ../../step_resource/step_resource_remote_file_use_platform_family.rst

**Control a service using the execute resource**

.. include:: ../../step_resource/step_resource_execute_control_a_service.rst

**Use the search recipe DSL method to find users**

.. include:: ../../step_resource/step_resource_execute_use_search_dsl_method.rst

**Enable remote login for Mac OS X**

.. include:: ../../step_resource/step_resource_execute_enable_remote_login.rst

**Execute code immediately, based on the template resource**

.. include:: ../../step_resource/step_resource_template_notifies_run_immediately.rst

**Sourcing a file**

.. include:: ../../step_resource/step_resource_execute_source_a_file.rst

**Run a Knife command**

.. include:: ../../step_resource/step_resource_execute_knife_user_create.rst

**Run install command into virtual environment**

.. include:: ../../step_resource/step_resource_execute_install_q.rst

**Run a command as a named user**

.. include:: ../../step_resource/step_resource_execute_bundle_install.rst
