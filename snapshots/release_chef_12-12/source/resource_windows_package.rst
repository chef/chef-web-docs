.. THIS PAGE DOCUMENTS chef-client version 12.12

=====================================================
windows_package
=====================================================

.. include:: ../../includes_resources/includes_resource_package_windows.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_package_windows_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_package_windows_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_package_windows_attributes.rst

Providers
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_package_windows_providers.rst

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_windows_package_install.rst

**Specify a URL for the source attribute**

.. include:: ../../step_resource/step_resource_package_windows_source_url.rst

**Specify path and checksum**

.. include:: ../../step_resource/step_resource_package_windows_source_url_checksum.rst

**Modify remote_file resource attributes**

.. include:: ../../step_resource/step_resource_package_windows_source_remote_file_attributes.rst

**Download a nsis (Nullsoft) package resource**

.. include:: ../../step_resource/step_resource_package_windows_download_nsis_package.rst

**Download a custom package**

.. include:: ../../step_resource/step_resource_package_windows_download_custom_package.rst
