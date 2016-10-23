.. THIS PAGE DOCUMENTS chef-client version 11.6

=====================================================
apt_package
=====================================================

.. include:: ../../includes_resources/includes_resource_package_apt.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_package_apt_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_package_apt_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_package_apt_attributes_12-5.rst

Providers
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_package_apt_providers.rst

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package using package manager** 

.. include:: ../../step_resource/step_resource_apt_package_install_package.rst

**Install a package using local file** 

.. include:: ../../step_resource/step_resource_apt_package_install_package_using_local_file.rst

**Install without using recommend packages as a dependency**

.. include:: ../../step_resource/step_resource_apt_package_install_without_recommends_suggests.rst
