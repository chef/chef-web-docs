.. THIS PAGE DOCUMENTS chef-client version 12.2

=====================================================
windows_package
=====================================================

.. include:: ../../includes_resources/includes_resource_package_windows.rst

.. note:: This resource does not support downloading packages from the network. Please use the **remote_file** resource for this purpose. Then, install packages locally using the source property to point at the package location on disk.

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_package_windows_syntax_12-3.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_package_windows_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_package_windows_attributes_12-3.rst

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

.. 
.. almost!
.. 
.. **Download a package from a URL**
.. 
.. .. include:: ../../step_resource/step_resource_windows_package_url.rst
.. 
