.. THIS PAGE DOCUMENTS chef-client version 11.2

=====================================================
yum_package
=====================================================

.. include:: ../../includes_resources/includes_resource_package_yum.rst

.. note:: .. include:: ../../includes_notes/includes_notes_yum_resource_using_file_names.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_package_yum_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_package_yum_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_package_yum_attributes_12-5.rst

Providers
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_package_yum_providers.rst

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install an exact version**

.. include:: ../../step_resource/step_resource_yum_package_install_exact_version.rst

**Install a minimum version**

.. include:: ../../step_resource/step_resource_yum_package_install_minimum_version.rst

**Install a minimum version using the default action**

.. include:: ../../step_resource/step_resource_yum_package_install_package_using_default_action.rst

**To install a package**

.. include:: ../../step_resource/step_resource_yum_package_install_package.rst

**To install a partial minimum version**

.. include:: ../../step_resource/step_resource_yum_package_install_partial_minimum_version.rst

**To install a specific architecture**

.. include:: ../../step_resource/step_resource_yum_package_install_specific_architecture.rst

**To install a specific version-release**

.. include:: ../../step_resource/step_resource_yum_package_install_specific_version_release.rst

**To install a specific version (even when older than the current)**

.. include:: ../../step_resource/step_resource_yum_package_install_specific_version.rst

**Handle cookbook_file and yum_package resources in the same recipe**

.. include:: ../../step_resource/step_resource_yum_package_handle_cookbook_file_and_yum_package.rst
