.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. This topic is NOT the same as the LWRP resource topic; keep separate.

For example, the following definition leverages the **directory** resource to create a new directory, and then evaluate that within the context of the custom resource:

.. code-block:: ruby

   def env_dir
     return @env_dir unless @env_dir.nil?
     @env_dir = Chef::Resource::Directory.new(::File.join(sv_dir_name, 'env'), run_context)
     @env_dir.owner(new_resource.owner)
     @env_dir.group(new_resource.group)
     @env_dir.mode(00755)
     @env_dir
   end

The following definition uses the **template** resource for Debian-specific cases, but then the **link** resource for everything else:

.. code-block:: ruby

   def lsb_init
     return @lsb_init unless @lsb_init.nil?
     initfile = ::File.join(new_resource.lsb_init_dir, new_resource.service_name)
     if node['platform'] == 'debian'
       ::File.unlink(initfile) if ::File.symlink?(initfile)
       @lsb_init = Chef::Resource::Template.new(initfile, run_context)
       @lsb_init.owner('root')
       @lsb_init.group('root')
       @lsb_init.mode(00755)
       @lsb_init.cookbook('runit')
       @lsb_init.source('init.d.erb')
       @lsb_init.variables(:name => new_resource.service_name)
     else
       @lsb_init = Chef::Resource::Link.new(initfile, run_context)
       @lsb_init.to(new_resource.sv_bin)
     end
     @lsb_init
   end

Otherwise, a resource defined in the ``/libraries`` directory is done using Ruby, is added to recipes as if it were any other resource, and is processed by the chef-client in the same way as any other resource. See the ``/libraries`` directory in the `database <https://github.com/chef-cookbooks/database>`_ and `runit <https://github.com/hw-cookbooks/runit>`_ cookbooks for complete examples of how to use this approach when defining a resource.
