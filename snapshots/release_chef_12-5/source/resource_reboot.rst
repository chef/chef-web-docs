.. THIS PAGE DOCUMENTS chef-client version 12.5

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
.. include:: ../../includes_resources/includes_resource_service_reboot_attributes_12-5.rst

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
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Reboot a node immediately**

.. include:: ../../step_resource/step_resource_service_reboot_immediately.rst

**Reboot a node at the end of a chef-client run**

.. include:: ../../step_resource/step_resource_service_reboot_request.rst

**Cancel a reboot**

.. include:: ../../step_resource/step_resource_service_reboot_cancel.rst

**Rename computer, join domain, reboot**

.. include:: ../../step_resource/step_resource_powershell_rename_join_reboot.rst
