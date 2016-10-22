.. THIS PAGE DOCUMENTS chef-client version 11.12

=====================================================
ohai
=====================================================

.. include:: ../../includes_resources/includes_resource_ohai.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_ohai_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_ohai_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_ohai_attributes_12-5.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_ohai_providers.rst
.. 

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Reload Ohai**

.. include:: ../../step_resource/step_resource_ohai_reload.rst

**Reload Ohai after a new user is created**

.. include:: ../../step_resource/step_resource_ohai_reload_after_create_user.rst
