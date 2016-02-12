.. THIS PAGE DOCUMENTS chef-client version 11.6

=====================================================
log
=====================================================

.. include:: ../../includes_resources/includes_resource_log.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_log_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_log_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_log_attributes.rst

Providers
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_log_providers.rst

Examples
=====================================================
|generic resource statement|

**Set default logging level**

.. include:: ../../step_resource/step_resource_log_set_info.rst

**Set debug logging level**

.. include:: ../../step_resource/step_resource_log_set_debug.rst

**Add a message to a log file**

.. include:: ../../step_resource/step_resource_log_add_message.rst

**Use Chef::Log to create a log entry**

.. include:: ../../step_resource/step_resource_11-16_log_class_chef_log.rst