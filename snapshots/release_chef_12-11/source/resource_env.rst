.. THIS PAGE DOCUMENTS chef-client version 12.11

=====================================================
env
=====================================================

.. include:: ../../includes_resources/includes_resource_env.rst

.. note:: .. include:: ../../includes_notes/includes_notes_env_resource_variable_on_unix.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_env_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_env_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_env_attributes.rst

Guards
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_guards.rst

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
.. .. include:: ../../includes_resources/includes_resource_env_providers.rst
.. 

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Set an environment variable**

.. include:: ../../step_resource/step_resource_environment_set_variable.rst
