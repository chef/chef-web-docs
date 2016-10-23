.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

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

``Chef::Provider::Package::Yum``, ``yum_package``
   The provider for the Yum package provider.

``Chef::Provider::Package::Zypper``, ``package``
   The provider for the openSUSE platform.
