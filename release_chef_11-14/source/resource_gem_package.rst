.. THIS PAGE DOCUMENTS chef-client version 11.14

=====================================================
gem_package
=====================================================

.. warning:: ../../includes_notes/includes_notes_chef_gem_vs_gem_package.rst

.. include:: ../../includes_resources/includes_resource_package_gem.rst

.. note:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_12-1_package_gem_syntax.rst

Gem Package Options
=====================================================
.. include:: ../../includes_resources/includes_resource_package_options.rst

Specify with Hash
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_options_hash.rst

**Example**

.. include:: ../../step_resource/step_resource_package_install_gem_with_hash_options.rst

Specify with String
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_options_string.rst

**Example**

.. include:: ../../step_resource/step_resource_package_install_gem_with_options_string.rst

Specify with .gemrc File
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_options_gemrc.rst

**Example**

.. include:: ../../step_resource/step_resource_package_install_gem_with_gemrc.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_package_gem_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_12-1_package_gem_attributes.rst

Providers
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_package_gem_providers.rst

Examples
=====================================================
|generic resource statement|

**Install a gems file from the local file system**

.. include:: ../../step_resource/step_resource_package_install_gems_from_local.rst

**Use the ignore_failure common attribute**

.. include:: ../../step_resource/step_resource_package_use_ignore_failure_attribute.rst

