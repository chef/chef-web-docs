.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


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
