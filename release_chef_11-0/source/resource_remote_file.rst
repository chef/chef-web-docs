.. THIS PAGE DOCUMENTS chef-client version 11.0

=====================================================
remote_file
=====================================================

.. include:: ../../includes_resources/includes_resource_11-4_remote_file.rst

.. note:: .. include:: ../../includes_notes/includes_notes_remote_file_resource_fetch_from_files_directory.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_11-4_remote_file_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_11-4_remote_file_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_11-4_remote_file_attributes.rst

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

.. include:: ../../includes_resources/includes_resource_remote_file_providers.rst

Examples
=====================================================
|generic resource statement|

**Transfer a file from a URL**

.. include:: ../../step_resource/step_resource_remote_file_transfer_from_url.rst

.. The "Transfer a file only when the source has changed" example is deprecated in chef-client 11-6

**Transfer a file only when the source has changed**

.. include:: ../../step_resource/step_resource_remote_file_transfer_remote_source_changes.rst

**Install a file from a remote location using bash**

.. include:: ../../step_resource/step_resource_remote_file_install_with_bash.rst

**Store certain settings**

.. include:: ../../step_resource/step_resource_remote_file_store_certain_settings.rst

**Use the platform_family? method**

.. include:: ../../step_resource/step_resource_remote_file_use_platform_family.rst

**Specify local Windows file path as a valid URI**

.. include:: ../../step_resource/step_resource_remote_file_local_windows_path.rst