.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following providers:

``Chef::Provider::Package``, ``package``
   When this short name is used, the |chef client| will attempt to determine the correct provider during the |chef client| run.

``Chef::Provider::Package::Apt``, ``apt_package``
   The provider for the |debian| and |ubuntu| platforms.

``Chef::Provider::Package::Dpkg``, ``dpkg_package``
   The provider for the |debian dpkg| platform. Can be used with the ``options`` attribute.

``Chef::Provider::Package::EasyInstall``, ``easy_install_package``
   The provider for |python|.

``Chef::Provider::Package::Freebsd``, ``freebsd_package``
   The provider for the |freebsd| platform.

``Chef::Provider::Package::Ips``, ``ips_package``
   The provider for the |ips| platform.

``Chef::Provider::Package::Macports``, ``macports_package``
   The provider for the |mac os x| platform.

``Chef::Provider::Package::Pacman``, ``pacman_package``
   The provider for the |archlinux| platform.

``Chef::Provider::Package::Portage``, ``portage_package``
   The provider for the |gentoo| platform. Can be used with the ``options`` attribute.

``Chef::Provider::Package::Rpm``, ``rpm_package``
   The provider for the |rpm| platform. Can be used with the ``options`` attribute.

``Chef::Provider::Package::Rubygems``, ``gem_package``
   Can be used with the ``options`` attribute.

``Chef::Provider::Package::Rubygems``, ``chef_gem``
   Can be used with the ``options`` attribute.

``Chef::Provider::Package::SmartOS``, ``smart_o_s_package``
   The provider for the |smartos| platform.

``Chef::Provider::Package::Solaris``, ``solaris_package``
   The provider for the |solaris| platform.

``Chef::Provider::Package::Yum``, ``yum_package``
   The provider for the |yum| package provider.

``Chef::Provider::Package::Zypper``, ``package``
   The provider for the |suse| platform.
