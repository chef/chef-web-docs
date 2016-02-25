.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``provides`` method to associate a custom resource with the |dsl recipe| on different operating systems. When multiple custom resources use the same DSL, specificity rules are applied to determine the priority, from highest to lowest:

#. provides :resource_name, platform_version: ‘0.1.2’
#. provides :resource_name, platform: ‘platform_name’
#. provides :resource_name, platform_family: ‘platform_family’
#. provides :resource_name, os: ‘operating_system’
#. provides :resource_name

For example:

.. code-block:: ruby

   class GenericFile < Chef::Resource
     provides :file
   end

   class LinuxFile < Chef::Resource
     provides :file, os: 'linux'
   end

   class DebianFile < Chef::Resource
     provides :file, platform_family: 'debian'
   end

If the following recipe is run on |ubuntu|, ``DebianFile`` is selected:

.. code-block:: ruby

   file 'x' do
     ...
   end

because it is the most specific rule. If the platform is |linux|, but not |debian|, ``LinuxFile`` is selected because it is less specific.
