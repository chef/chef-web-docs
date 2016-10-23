.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``provides`` method to map a custom resource/provider to an existing resource/provider, and then to also specify the platform(s) on which the behavior of the custom resource/provider will be applied. This method enables scenarios like:

* Building a custom resource that is based on an existing resource
* Defining platform mapping specific to a custom resource
* Handling situations where a resource on a particular platform may have more than one provider, such as the behavior on the Ubuntu platform where both SysVInit and systemd are present
* Allowing the custom resource to declare what platforms are supported, enabling the creator of the custom resource to use arbitrary criteria if desired
* Not using the previous naming convention---``#{cookbook_name}_#{provider_filename}``

.. warning:: The ``provides`` method must be defined in both the custom resource and custom provider files and both files must have identical ``provides`` statement(s). 

The syntax for the ``provides`` method is as follows:

.. code-block:: ruby

   provides :resource_name, os: [ 'platform', 'platform', ...], platform_family: 'family'

where:

* ``:resource_name`` is a chef-client resource: ``:cookbook_file``, ``:package``, ``:rpm_package``, and so on
* ``'platform'`` is a comma-separated list of platforms: ``'windows'``, ``'solaris2'``, ``'linux'``, and so on
* ``platform_family`` is optional and may specify the same parameters as the ``platform_family?`` method in the Recipe DSL; ``platform`` is optional and also supported (and is the same as the ``platform?`` method in the Recipe DSL)

A custom resource/provider may be mapped to more than one existing resource/provider. Multiple platform associations may be made. For example, to completely map a custom resource/provider to an existing custom resource/provider, only specificy the resource name:

.. code-block:: ruby

   provides :cookbook_file

The same mapping, but only for the Linux platform:

.. code-block:: ruby

   provides :cookbook_file, os: 'linux'

A similar mapping, but also for packages on the Microsoft Windows platform:

.. code-block:: ruby

   provides :cookbook_file
   provides :package, os: 'windows'

Use multiple ``provides`` statements to define multiple conditions: Use an array to match any of the platforms within the array:

.. code-block:: ruby

   provides :cookbook_file
   provides :package, os: 'windows'
   provides :rpm_package, os: [ 'linux', 'aix' ]

Use an array to match any of the platforms within the array:

.. code-block:: ruby

   provides :package, os: 'solaris2', platform_family: 'solaris2' do |node|
     node[:platform_version].to_f <= 5.10
   end
