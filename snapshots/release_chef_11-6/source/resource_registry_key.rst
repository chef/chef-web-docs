.. THIS PAGE DOCUMENTS chef-client version 11.6

=====================================================
registry_key
=====================================================

.. include:: ../../includes_resources/includes_resource_registry_key.rst

.. note:: .. include:: ../../includes_notes/includes_notes_registry_key_redirection.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_registry_key_syntax.rst

Registry Key Path Separators
-----------------------------------------------------
.. include:: ../../includes_windows/includes_windows_registry_key_backslashes.rst

Recipe DSL Methods
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_windows_methods.rst

.. include:: ../../includes_notes/includes_notes_dsl_recipe_order_for_windows_methods.rst

registry_data_exists?
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_data_exists.rst

registry_get_subkeys
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_get_subkeys.rst

registry_get_values
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_get_values.rst

registry_has_subkeys?
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_has_subkeys.rst

registry_key_exists?
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_key_exists.rst

registry_value_exists?
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_value_exists.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_registry_key_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_registry_key_attributes_12-5.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_registry_key_providers.rst
.. 

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Create a registry key**

.. include:: ../../step_resource/step_resource_registry_key_create.rst

**Delete a registry key value**

.. include:: ../../step_resource/step_resource_registry_key_delete_value.rst

**Delete a registry key and its subkeys, recursively**

.. include:: ../../step_resource/step_resource_registry_key_delete_recursively.rst

**Use re-directed keys**

.. include:: ../../step_resource/step_resource_registry_key_redirect.rst

**Set proxy settings to be the same as those used by the chef-client**

.. include:: ../../step_resource/step_resource_registry_key_set_proxy_settings_to_same_as_chef_client.rst

**Set the name of a registry key to "(Default)"**

.. include:: ../../step_resource/step_resource_registry_key_set_default.rst
