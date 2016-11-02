=====================================================
Release Notes: chef-client 12.3
=====================================================

.. tag chef

Chef is a powerful automation platform that transforms infrastructure into code. Whether you’re operating in the cloud, on-premises, or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

This diagram shows how you develop, test, and deploy your Chef code.

.. image:: ../../images/start_chef.svg
   :width: 700px
   :align: center

.. end_tag

What's New
=====================================================
The following items are new for chef-client 12.3 and/or are changes from previous versions. The short version:

* **Socketless local mode with chef-zero** Port binding and HTTP requests on localhost may be disabled in favor of socketless mode.
* **Minimal Ohai plugins** Run only the plugins required for name resolution and resource/provider detection.
* **Dynamic resource and provider resolution** Four helper methods may be used in a library file to get resource and/or provider mapping details, and then set them per-resource or provider.
* **New clear_soruces attribute for the chef_gem and gem_package resources** Set to ``true`` to download a gem from the path specified by the ``source`` property (and not from RubyGems).

Socketless Local Mode
-----------------------------------------------------
The chef-client may disable port binding and HTTP requests on localhost by making a socketless request to chef-zero. This may be done from the command line or with a configuration setting.

Use the following command-line option:

``--[no-]listen``
   Run chef-zero in socketless mode. Use ``--no-listen`` to disable port binding and HTTP requests on localhost.

Or add the following setting to the client.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``listen``
     - Run chef-zero in socketless mode. Set to ``false`` to disable port binding and HTTP requests on localhost.

Minimal Ohai
-----------------------------------------------------
The following option may be used with chef-client, chef-solo, and chef-apply to speed up testing intervals:

``--minimal-ohai``
   Run the Ohai plugins for name detection and resource/provider selection and no other Ohai plugins. Set to ``true`` during integration testing to speed up test cycles.

This setting may be configured using the ``minimal_ohai`` setting in the client.rb file.

Dynamic Resolution
-----------------------------------------------------
.. tag libraries_dynamic_resolution

Resources and providers are resolved dynamically and can handle multiple ``provides`` lines for a specific platform. When multiple ``provides`` lines exist, such as ``Homebrew`` and ``MacPorts`` packages for the Mac OS X platform, then one is selected based on resource priority mapping performed by the chef-client during the chef-client run.

Use the following helpers in a library file to get and/or set resource and/or provider priority mapping before any recipes are compiled:

``Chef.get_provider_priority_array(resource_name)``
   Get the priority mapping for a provider.

``Chef.get_resource_priority_array(resource_name)``
   Get the priority mapping for a resource.

``Chef.set_provider_priority_array(resource_name, Array<Class>, *filter)``
   Set the priority mapping for a provider.

``Chef.set_resource_priority_array(resource_name, Array<Class>, *filter)``
   Set the priority mapping for a resource.

For example:

.. code-block:: ruby

   Chef.set_resource_priority_array(:package, [ Chef::Resource::MacportsPackage ], os: 'darwin')

.. end_tag

Changelog
=====================================================
https://github.com/chef/chef/blob/12.3-stable/CHANGELOG.md

