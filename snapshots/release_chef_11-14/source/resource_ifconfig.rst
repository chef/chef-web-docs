.. THIS PAGE DOCUMENTS chef-client version 11.14

=====================================================
ifconfig
=====================================================

.. include:: ../../includes_resources/includes_resource_ifconfig.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_ifconfig_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_ifconfig_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_ifconfig_attributes_12-5.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_ifconfig_providers.rst
.. 

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Configure a network interface**

.. include:: ../../step_resource/step_resource_ifconfig_boot_protocol.rst

**Specify a boot protocol**

.. include:: ../../step_resource/step_resource_ifconfig_configure_network_interface.rst

**Specify a static IP address**

.. include:: ../../step_resource/step_resource_ifconfig_static_ip_address.rst

**Update a static IP address with a boot protocol**

.. include:: ../../step_resource/step_resource_ifconfig_update_static_ip_with_boot_protocol.rst
