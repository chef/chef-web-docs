.. THIS PAGE DOCUMENTS chef-client version 12.4

=====================================================
directory
=====================================================

.. include:: ../../includes_resources/includes_resource_directory.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_directory_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_directory_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_directory_attributes_12-5.rst

Recursive Directories
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_directory_recursive.rst

Windows File Security
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_windows_security.rst

**Access Control Lists (ACLs)**

.. include:: ../../includes_resources_common/includes_resources_common_windows_security_acl.rst

**Inheritance**

.. include:: ../../includes_resources_common/includes_resources_common_windows_security_inherits.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_directory_providers.rst
.. 

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Create a directory**

.. include:: ../../step_resource/step_resource_directory_create.rst

**Create a directory in Microsoft Windows**

.. include:: ../../step_resource/step_resource_directory_create_in_windows.rst

**Create a directory recursively**

.. include:: ../../step_resource/step_resource_directory_create_recursively.rst

**Delete a directory**

.. include:: ../../step_resource/step_resource_directory_delete.rst

**Set directory permissions using a variable**

.. include:: ../../step_resource/step_resource_directory_set_permissions_with_variable.rst

**Set directory permissions for a specific type of node**

.. include:: ../../step_resource/step_resource_directory_set_permissions_for_specific_node.rst

**Reload the configuration**

.. include:: ../../step_resource/step_resource_ruby_block_reload_configuration.rst

**Manage dotfiles**

.. include:: ../../step_resource/step_resource_directory_manage_dotfiles.rst
