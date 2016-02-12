.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The pattern for file specificity depends on two things: the lookup path and the source attribute. The first pattern that matches is used:

#. /host-$fqdn/$source
#. /$platform-$platform_version/$source
#. /$platform/$source
#. /default/$source
#. /$source

Use an array with the ``source`` attribute to define an explicit lookup path. For example:

.. code-block:: ruby

   file '/conf.py' do
     source ['#{node.chef_environment}.py', 'conf.py']
   end

The following example emulates the entire file specificity pattern by defining it as an explicit path:

.. code-block:: ruby

   file '/conf.py' do
     source %W{
       host-#{node['fqdn']}/conf.py
       #{node['platform']}-#{node['platform_version']}/conf.py
       #{node['platform']}/conf.py
       default/conf.py
     }
   end
