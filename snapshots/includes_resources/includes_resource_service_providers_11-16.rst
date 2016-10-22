.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The **service** resource does not have service-specific short names. This is because the chef-client identifies the platform at the start of every chef-client run based on data collected by Ohai. The chef-client looks up the platform in the `provider_mapping.rb <https://github.com/chef/chef/blob/master/lib/chef/platform/provider_mapping.rb>`_ file, and then determines the correct provider for that platform. In certain situations, such as when more than one init system is available on a node, a specific provider may need to be identified by using the ``provider`` attribute and the long name for that provider.

This resource has the following providers:

``Chef::Provider::Service::Init``, ``service``
   When this short name is used, the chef-client will determine the correct provider during the chef-client run.

``Chef::Provider::Service::Init::Debian``, ``service``
   The provider for the Debian and Ubuntu platforms.

``Chef::Provider::Service::Upstart``, ``service``
   The provider that is used when Upstart is available on the platform.

``Chef::Provider::Service::Init::Freebsd``, ``service``
   The provider for the FreeBSD platform.

``Chef::Provider::Service::Init::Gentoo``, ``service``
   The provider for the Gentoo platform.

``Chef::Provider::Service::Init::Redhat``, ``service``
   The provider for the Red Hat and CentOS platforms.

``Chef::Provider::Service::Solaris``, ``service``
   The provider for the Solaris platform.

``Chef::Provider::Service::Windows``, ``service``
   The provider for the Microsoft Windows platform.

``Chef::Provider::Service::Macosx``, ``service``
   The provider for the Mac OS X platform.
