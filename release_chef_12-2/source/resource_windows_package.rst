.. THIS PAGE DOCUMENTS chef-client version 12.2

=====================================================
windows_package
=====================================================

.. include:: ../../includes_resources/includes_resource_package_windows.rst

.. note:: This resource does not support downloading packages from the network. Please use the |resource remote_file| resource for this purpose. Then, install packages locally using the source property to point at the package location on disk.

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_12-3_package_windows_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_package_windows_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_12-3_package_windows_attributes.rst

Providers
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_package_windows_providers.rst

Examples
=====================================================
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_windows_package_install.rst

.. 
.. almost!
.. 
.. **Download a package from a URL**
.. 
.. .. include:: ../../step_resource/step_resource_windows_package_url.rst
.. 
