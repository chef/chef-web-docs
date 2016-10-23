.. THIS PAGE DOCUMENTS chef-client version 12.8

=====================================================
launchd
=====================================================

.. include:: ../../includes_resources/includes_resource_launchd.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_launchd_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_launchd_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_launchd_attributes.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_cron_providers.rst
.. 

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Create a Launch Daemon from a cookbook file**

.. include:: ../../step_resource/step_resource_launchd_create_from_cookbook.rst

**Create a Launch Daemon using keys**

.. include:: ../../step_resource/step_resource_launchd_create_using_keys.rst

**Remove a Launch Daemon**

.. include:: ../../step_resource/step_resource_launchd_remove.rst
