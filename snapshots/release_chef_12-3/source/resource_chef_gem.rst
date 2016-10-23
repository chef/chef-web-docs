.. THIS PAGE DOCUMENTS chef-client version 12.3

=====================================================
chef_gem
=====================================================

.. warning:: .. include:: ../../includes_notes/includes_notes_chef_gem_vs_gem_package.rst

.. include:: ../../includes_resources/includes_resource_package_chef_gem.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_package_chef_gem_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_package_chef_gem_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_package_chef_gem_attributes_12-5.rst

Providers
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_package_chef_gem_providers.rst

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Compile time vs. converge time installation of gems**

.. include:: ../../step_resource/step_resource_chef_gem_install_for_use_in_recipes.rst

**Install MySQL for Chef**

.. include:: ../../step_resource/step_resource_chef_gem_install_mysql.rst

