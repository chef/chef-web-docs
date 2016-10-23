.. THIS PAGE DOCUMENTS chef-client version 11.10

=====================================================
remote_file
=====================================================

.. include:: ../../includes_resources/includes_resource_remote_file.rst

.. note:: .. include:: ../../includes_notes/includes_notes_remote_file_resource_fetch_from_files_directory.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_remote_file_syntax_12-0.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_remote_file_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_remote_file_attributes_12-0.rst

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

Prevent Re-downloads
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_remote_file_redownload.rst

Providers
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_remote_file_providers.rst

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Transfer a file from a URL**

.. include:: ../../step_resource/step_resource_remote_file_transfer_from_url.rst

**Install a file from a remote location using bash**

.. include:: ../../step_resource/step_resource_remote_file_install_with_bash.rst

**Store certain settings**

.. include:: ../../step_resource/step_resource_remote_file_store_certain_settings.rst

**Use the platform_family? method**

.. include:: ../../step_resource/step_resource_remote_file_use_platform_family.rst

**Specify local Windows file path as a valid URI**

.. include:: ../../step_resource/step_resource_remote_file_local_windows_path.rst
