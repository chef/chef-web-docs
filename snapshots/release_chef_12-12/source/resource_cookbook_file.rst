.. THIS PAGE DOCUMENTS chef-client version 12.12

=====================================================
cookbook_file
=====================================================

.. include:: ../../includes_resources/includes_resource_cookbook_file.rst

.. include:: ../../includes_resources/includes_resource_cookbook_file_transfers.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_cookbook_file_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_cookbook_file_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_cookbook_file_attributes.rst

.. warning:: .. include:: ../../includes_notes/includes_notes_selinux_file_based_resources.rst

Atomic File Updates
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_atomic_update.rst

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
.. .. include:: ../../includes_resources/includes_resource_cookbook_file_providers.rst
.. 

File Specificity
=====================================================
.. include:: ../../includes_file/includes_file_cookbook_specificity.rst

.. include:: ../../includes_file/includes_file_cookbook_specificity_pattern.rst

.. include:: ../../includes_file/includes_file_cookbook_specificity_example.rst

**Host Notation**

.. include:: ../../includes_file/includes_file_cookbook_specificity_host_notation.rst

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Transfer a file**

.. include:: ../../step_resource/step_resource_cookbook_file_transfer_a_file.rst

**Handle cookbook_file and yum_package resources in the same recipe**

.. include:: ../../step_resource/step_resource_yum_package_handle_cookbook_file_and_yum_package.rst

**Install repositories from a file, trigger a command, and force the internal cache to reload**

.. include:: ../../step_resource/step_resource_yum_package_install_yum_repo_from_file.rst

**Use a case statement**

.. include:: ../../step_resource/step_resource_cookbook_file_use_case_statement.rst

**Manage dotfiles**

.. include:: ../../step_resource/step_resource_directory_manage_dotfiles.rst
