.. THIS PAGE DOCUMENTS chef-client version 12.0

=====================================================
package
=====================================================

.. include:: ../../includes_resources/includes_resource_package.rst

.. include:: ../../includes_resources/includes_resource_package_base_resource.rst

For more information about specific resources for specific platforms, see the following topics:

* :doc:`apt_package </resource_apt_package>`
* :doc:`bff_package </resource_bff_package>`
* :doc:`chef_gem </resource_chef_gem>`
* :doc:`dpkg_package </resource_dpkg_package>`
* :doc:`easy_install_package </resource_easy_install_package>`
* :doc:`freebsd_package </resource_freebsd_package>`
* :doc:`gem_package </resource_gem_package>`
* :doc:`homebrew_package </resource_homebrew_package>`
* :doc:`ips_package </resource_ips_package>`
* :doc:`macports_package </resource_macports_package>`
* :doc:`pacman_package </resource_pacman_package>`
* :doc:`portage_package </resource_portage_package>`
* :doc:`rpm_package </resource_rpm_package>`
* :doc:`smartos_package </resource_smartos_package>`
* :doc:`solaris_package </resource_solaris_package>`
* :doc:`windows_package </resource_windows_package>`
* :doc:`yum_package </resource_yum>`

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_package_syntax.rst

Gem Package Options
=====================================================
.. include:: ../../includes_resources/includes_resource_package_options.rst

.. warning:: Gem package options should only be used when gems are installed into the system-wide instance of Ruby, and not the instance of Ruby dedicated to the chef-client.

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
.. include:: ../../includes_resources/includes_resource_package_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_package_attributes_12-5.rst

Providers
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

This resource has the following providers:

``Chef::Provider::Package``, ``package``
   When this short name is used, the chef-client will attempt to determine the correct provider during the chef-client run.

``Chef::Provider::Package::Apt``, ``apt_package``
   The provider for the Debian and Ubuntu platforms.

``Chef::Provider::Package::Dpkg``, ``dpkg_package``
   The provider for the dpkg platform. Can be used with the ``options`` attribute.

``Chef::Provider::Package::EasyInstall``, ``easy_install_package``
   The provider for Python.

``Chef::Provider::Package::Freebsd``, ``freebsd_package``
   The provider for the FreeBSD platform.

``Chef::Provider::Package::Ips``, ``ips_package``
   The provider for the ips platform.

``Chef::Provider::Package::Macports``, ``macports_package``
   The provider for the Mac OS X platform.

``Chef::Provider::Package::Pacman``, ``pacman_package``
   The provider for the Arch Linux platform.

``Chef::Provider::Package::Portage``, ``portage_package``
   The provider for the Gentoo platform. Can be used with the ``options`` attribute.

``Chef::Provider::Package::Rpm``, ``rpm_package``
   The provider for the RPM Package Manager platform. Can be used with the ``options`` attribute.

``Chef::Provider::Package::Rubygems``, ``gem_package``
   Can be used with the ``options`` attribute.

   .. warning:: .. include:: ../../includes_notes/includes_notes_resource_gem_package.rst

``Chef::Provider::Package::Rubygems``, ``chef_gem``
   Can be used with the ``options`` attribute.

``Chef::Provider::Package::Smartos``, ``smartos_package``
   The provider for the SmartOS platform.

``Chef::Provider::Package::Solaris``, ``solaris_package``
   The provider for the Solaris platform.

``Chef::Provider::Package::Windows``, ``package``
   The provider for the Microsoft Windows platform.

``Chef::Provider::Package::Yum``, ``yum_package``
   The provider for the Yum package provider.

``Chef::Provider::Package::Zypper``, ``package``
   The provider for the openSUSE platform.

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a gems file for use in recipes**

.. include:: ../../step_resource/step_resource_package_install_gems_for_chef_recipe.rst

**Install a gems file from the local file system**

.. include:: ../../step_resource/step_resource_package_install_gems_from_local.rst

**Install a package**

.. include:: ../../step_resource/step_resource_package_install.rst

**Install a package version**

.. include:: ../../step_resource/step_resource_package_install_version.rst

**Install a package with options**

.. include:: ../../step_resource/step_resource_package_install_with_options.rst

**Install a package with a response_file**

.. include:: ../../step_resource/step_resource_package_install_with_response_file.rst

**Install a package using a specific provider**

.. include:: ../../step_resource/step_resource_package_install_with_specific_provider.rst

**Install a specified architecture using a named provider**

.. include:: ../../step_resource/step_resource_package_install_with_yum.rst

**Purge a package**

.. include:: ../../step_resource/step_resource_package_purge.rst

**Remove a package**

.. include:: ../../step_resource/step_resource_package_remove.rst

**Upgrade a package**

.. include:: ../../step_resource/step_resource_package_upgrade.rst

**Use the ignore_failure common attribute**

.. include:: ../../step_resource/step_resource_package_use_ignore_failure_attribute.rst

**Use the provider common attribute**

.. include:: ../../step_resource/step_resource_package_use_provider_attribute.rst

**Avoid unnecessary string interpolation**

.. include:: ../../step_resource/step_resource_package_avoid_unnecessary_string_interpolation.rst

**Install a package in a platform**

.. include:: ../../step_resource/step_resource_package_install_package_on_platform.rst

**Install sudo, then configure /etc/sudoers/ file**

.. include:: ../../step_resource/step_resource_package_install_sudo_configure_etc_sudoers.rst

**Use a case statement to specify the platform**

.. include:: ../../step_resource/step_resource_package_use_case_statement.rst

**Use symbols to reference attributes**

.. include:: ../../step_resource/step_resource_package_use_symbols_to_reference_attributes.rst

**Use a whitespace array to simplify a recipe**

.. include:: ../../step_resource/step_resource_package_use_whitespace_array.rst

**Specify the Homebrew user with a UUID**

.. include:: ../../step_resource/step_resource_homebrew_package_homebrew_user_as_uuid.rst

**Specify the Homebrew user with a string**

.. include:: ../../step_resource/step_resource_homebrew_package_homebrew_user_as_string.rst
