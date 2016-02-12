.. THIS PAGE DOCUMENTS chef-client version 12.4

=====================================================
reboot
=====================================================

.. include:: ../../includes_resources/includes_resource_service_reboot.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_service_reboot_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_service_reboot_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_12-4_service_reboot_attributes.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_service_reboot_providers.rst
.. 

Examples
=====================================================
|generic resource statement|

**Reboot a node immediately**

.. include:: ../../step_resource/step_resource_12-4_service_reboot_immediately.rst

**Cancel a reboot**

.. include:: ../../step_resource/step_resource_service_reboot_cancel.rst

**Rename computer, join domain, reboot**

.. include:: ../../step_resource/step_resource_powershell_rename_join_reboot.rst
