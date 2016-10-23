.. THIS PAGE DOCUMENTS chef-client version 12.10

=====================================================
remote_directory
=====================================================

.. include:: ../../includes_resources/includes_resource_remote_directory.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_remote_directory_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_remote_directory_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_remote_directory_attributes.rst

Recursive Directories
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_remote_directory_recursive.rst

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_remote_directory_recursive_example.rst

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
.. .. include:: ../../includes_resources/includes_resource_remote_directory_providers.rst
.. 

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Recursively transfer a directory from a remote location**

.. include:: ../../step_resource/step_resource_remote_directory_recursive_transfer.rst

**Use with the chef_handler lightweight resource**

.. include:: ../../step_resource/step_resource_remote_directory_report_handler.rst
