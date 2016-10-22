.. THIS PAGE DOCUMENTS chef-client version 12.13

=====================================================
service
=====================================================

.. include:: ../../includes_resources/includes_resource_service.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_service_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_service_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_service_attributes.rst

Providers
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_service_providers.rst

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Start a service**

.. include:: ../../step_resource/step_resource_service_start_service.rst

**Start a service, enable it**

.. include:: ../../step_resource/step_resource_service_start_service_and_enable_at_boot.rst

**Use a pattern**

.. include:: ../../step_resource/step_resource_service_process_table_has_different_value.rst

**Use the :nothing common action**

.. include:: ../../step_resource/step_resource_service_use_nothing_action.rst

**Use the supports common attribute**

.. include:: ../../step_resource/step_resource_service_use_supports_attribute.rst

**Use the supports and providers common attributes**

.. include:: ../../step_resource/step_resource_service_use_provider_and_supports_attributes.rst

**Manage a service, depending on the node platform**

.. include:: ../../step_resource/step_resource_service_manage_ssh_based_on_node_platform.rst

**Change a service provider, depending on the node platform**

.. include:: ../../step_resource/step_resource_service_change_service_provider_based_on_node.rst

**Reload a service using a template**

.. include:: ../../step_resource/step_resource_service_subscribes_reload_using_template.rst

**Enable a service after a restart or reload**

.. include:: ../../step_resource/step_resource_service_notifies_enable_after_restart_or_reload.rst

**Set an IP address using variables and a template**

.. include:: ../../step_resource/step_resource_template_set_ip_address_with_variables_and_template.rst

**Use a cron timer to manage a service**

.. include:: ../../step_resource/step_resource_service_use_variable.rst

**Restart a service, and then notify a different service**

.. include:: ../../step_resource/step_resource_service_restart_and_notify.rst

**Stop a service, do stuff, and then restart it**

.. include:: ../../step_resource/step_resource_service_stop_do_stuff_start.rst

**Control a service using the execute resource**

.. include:: ../../step_resource/step_resource_execute_control_a_service.rst

**Enable a service on AIX using the mkitab command**

.. include:: ../../step_resource/step_resource_service_aix_mkitab.rst
