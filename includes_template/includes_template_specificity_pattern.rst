.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The pattern for template specificity depends on two things: the lookup path and the source. The first pattern that matches is used:

#. /host-$fqdn/$source
#. /$platform-$platform_version/$source
#. /$platform/$source
#. /default/$source
#. /$source

Use an array with the ``source`` property to define an explicit lookup path. For example:

.. code-block:: ruby

   template '/test' do
     source ['#{node.chef_environment}.erb', 'default.erb']
   end

The following example emulates the entire file specificity pattern by defining it as an explicit path:

.. code-block:: ruby

   template '/test' do
     source %W{
       host-#{node['fqdn']}/test.erb
       #{node['platform']}-#{node['platform_version']}/test.erb
       #{node['platform']}/test.erb
       default/test.erb
     }
   end
