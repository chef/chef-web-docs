.. THIS PAGE DOCUMENTS chef-client version 11.14

=====================================================
file
=====================================================

.. include:: ../../includes_resources/includes_resource_file.rst

.. note:: ../../includes_notes/includes_notes_file_resource_use_other_resources.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_12-0_file_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_file_actions.rst

.. warning:: ../../includes_notes/includes_notes_selinux_file_based_resources.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_12-0_file_attributes.rst

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

Providers
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_file_providers.rst

Examples
=====================================================
|generic resource statement|

**Create a file**

.. include:: ../../step_resource/step_resource_file_create.rst

**Create a file in Microsoft Windows**

.. include:: ../../step_resource/step_resource_file_create_in_windows.rst

**Remove a file**

.. include:: ../../step_resource/step_resource_file_remove.rst

**Set file modes**

.. include:: ../../step_resource/step_resource_file_set_file_mode.rst

**Delete a repository using yum to scrub the cache**

.. include:: ../../step_resource/step_resource_yum_package_delete_repo_use_yum_to_scrub_cache.rst

**Add the value of a data bag item to a file**

.. include:: ../../step_resource/step_resource_file_content_data_bag.rst

**Write a YAML file**

.. include:: ../../step_resource/step_resource_file_content_yaml_config.rst

**Write a string to a file**

.. include:: ../../step_resource/step_resource_file_content_add_string.rst

**Create a file from a copy**

.. include:: ../../step_resource/step_resource_file_copy.rst