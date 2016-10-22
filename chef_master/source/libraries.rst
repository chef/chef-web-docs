=====================================================
About Libraries
=====================================================

.. tag libraries_summary

A library allows arbitrary Ruby code to be included in a cookbook, either as a way of extending the classes that are built-in to the chef-client---``Chef::Recipe``, for example---or for implementing entirely new functionality, similar to a mixin in Ruby. A library file is a Ruby file that is located within a cookbook's ``/libraries`` directory. Because a library is built using Ruby, anything that can be done with Ruby can be done in a library file.

.. end_tag

Use a library to:

* Define a custom resource
* Create a custom class or module; for example, create a subclass of ``Chef::Recipe``
* Access attributes that are stored in files
* Connect to a database
* Talk to an LDAP provider
* Do anything that can be done with Ruby

Syntax
=====================================================
The syntax for a library varies because library files are created using Ruby and are designed to handle custom situations. See the Examples section below for some ideas. Also, the https://github.com/chef-cookbooks/database and https://github.com/chef-cookbooks/chef-splunk cookbooks contain more detailed and complex examples.

Chef::Provider
=====================================================
.. tag dsl_provider_method_updated_by_last_action_example

Cookbooks that contain custom resources in the ``/libraries`` directory of a cookbook should:

* Be inspected for instances of a) the ``Chef::Provider`` base class, and then b) for the presence of any core resources from the chef-client
* Be updated to use the ``LWRPBase`` base class

For example:

.. code-block:: ruby

   class Chef
     class Provider
       class LvmLogicalVolume < Chef::Provider::LWRPBase
         include Chef::Mixin::ShellOut

         ...
         if new_resource.mount_point
           if new_resource.mount_point.is_a?(String)
             mount_spec = { :location => new_resource.mount_point }
           else
             mount_spec = new_resource.mount_point
           end

           dir_resource = directory mount_spec[:location] do
             mode 0755
             owner 'root'
             group 'root'
             recursive true
             action :nothing
             not_if { Pathname.new(mount_spec[:location]).mountpoint? }
           end
           dir_resource.run_action(:create)
           updates << dir_resource.updated?

           mount_resource = mount mount_spec[:location] do
             options mount_spec[:options]
             dump mount_spec[:dump]
             pass mount_spec[:pass]
             device device_name
             fstype fs_type
             action :nothing
           end
           mount_resource.run_action(:mount)
           mount_resource.run_action(:enable)
           updates << mount_resource.updated?
         end
         new_resource.updated_by_last_action(updates.any?)
       end

.. end_tag

Dynamic Resolution
=====================================================
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

Template Helper Modules
=====================================================
.. tag resource_template_library_module

A template helper module can be defined in a library. This is useful when extensions need to be reused across recipes or to make it easier to manage code that would otherwise be defined inline on a per-recipe basis.

.. code-block:: ruby

   template '/path/to/template.erb' do
     helpers(MyHelperModule)
   end

.. end_tag

Examples
=====================================================
The following examples show how to use cookbook libraries.

Library Resources
-----------------------------------------------------
.. This topic is NOT the same as the LWRP resource topic; keep separate.

A resource can also be defined in ``/libraries`` directory. Some advantages of this approach include more control over how resources behave in the provider, the ability to control the name of the resource directly, and more options available for writing tests. The resources and providers for a library resource, similar to lightweight resources (defined in the ``/resources`` and ``/providers`` folders) typically have a separate file for the resource and the provider, but this is not requirement. The main disadvantage of this approach is that resources defined in the ``/libraries`` directory may not use the Recipe DSL.

.. This topic is NOT the same as the LWRP resource topic; keep separate.

A resource that is defined in the ``/libraries`` directory may leverage core chef-client resources by using the following syntax:

.. code-block:: ruby

   Chef::Resource::name_of_resource.new('name', run_context)

or:

.. code-block:: ruby

   Chef::Resource::name_of_resource.new(:action)

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

Create a Namespace
-----------------------------------------------------
A database can contain a list of virtual hosts that are used by customers. A custom namespace could be created that looks something like:

.. code-block:: ruby

   # Sample provided by "Arjuna (fujin)". Thank you!

   require 'sequel'

   class Chef::Recipe::ISP
     # We can call this with ISP.vhosts
     def self.vhosts
       v = []
       @db = Sequel.mysql(
         'web', 
         :user => 'example', 
         :password => 'example_pw', 
         :host => 'dbserver.example.com'
       )
       @db[
         "SELECT virtualhost.domainname, 
              usertable.userid, 
              usertable.uid, 
              usertable.gid, 
              usertable.homedir
          FROM usertable, virtualhost
          WHERE usertable.userid = virtualhost.user_name"
         ].all do |query|
         vhost_data = {
           :servername   => query[:domainname],
           :documentroot => query[:homedir],
           :uid          => query[:uid],
           :gid          => query[:gid],
         }
         v.push(vhost_data)
       end
       Chef::Log.debug('About to provision #{v.length} vhosts')
       v
     end
   end

After the custom namespace is created, it could then be used in a recipe, like this:

.. code-block:: ruby

   ISP.vhosts.each do |vhost|
     directory vhost[:documentroot] do
       owner 'vhost[:uid]'
       group 'vhost[:gid]'
       mode '0755'
       action :create
     end

     directory '#{vhost[:documentroot]}/#{vhost[:domainname]}' do
       owner 'vhost[:uid]'
       group 'vhost[:gid]'
       mode '0755'
       action :create
     end
   end

Extend a Recipe
-----------------------------------------------------
A customer record is stored in an attribute file that looks like this:

.. code-block:: ruby

   mycompany_customers({
     :bob => {
       :homedir => '/home/bob',
       :webdir => '/home/bob/web'
     }
   }
   )

A simple recipe may contain something like this:

.. code-block:: ruby

   directory node[:mycompany_customers][:bob][:webdir] do
     owner 'bob'
     group 'bob'
     action :create
   end

Or a less verbose version of the same simple recipe:

.. code-block:: ruby

   directory customer(:bob)[:webdir] do
     owner 'bob'
     group 'bob'
     action :create
   end

A simple library could be created that extends ``Chef::Recipe::``, like this:

.. code-block:: ruby

   class Chef
     class Recipe    
       # A shortcut to a customer
       def customer(name)
         node[:mycompany_customers][name]
       end
     end 
   end

Loop Over a Record
-----------------------------------------------------
A customer record is stored in an attribute file that looks like this:

.. code-block:: ruby

   mycompany_customers({
     :bob => {
       :homedir => '/home/bob',
       :webdir => '/home/bob/web'
     }
   }
   )

If there are many customer records in an environment, a simple recipe can be used to loop over every customer, like this:

.. code-block:: ruby

   all_customers do |name, info|
     directory info[:webdir] do
       owner 'name'
       group 'name'
       action :create
     end
   end

A simple library could be created that extends ``Chef::Recipe::``, like this:

.. code-block:: ruby

   class Chef
     class Recipe
       def all_customers(&block)
         node[:mycompany_customers].each do |name, info|
           block.call(name, info)
         end
       end
     end
   end
