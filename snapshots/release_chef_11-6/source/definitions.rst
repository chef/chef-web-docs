

=====================================================
About Definitions
=====================================================

.. tag 4_summary

A definition is code that is reused across recipes, similar to a compile-time macro. A definition is created using arbitrary code wrapped around built-in chef-client resources---**file**, **execute**, **template**, and so on---by declaring those resources into the definition as if they were declared in a recipe. A definition is then used in one (or more) recipes as if it were a resource.

Though a definition behaves like a resource, some key differences exist. A definition:

* Is not a resource or a custom resource
* Is defined from within the ``/definitions`` directory of a cookbook
* Is loaded before resources during the chef-client run; this ensures the definition is available to all of the resources that may need it
* May not notify resources in the resource collection because a definition is loaded **before** the resource collection itself is created; however, a resource in a definition **may** notify a resource that exists within the same definition
* Automatically supports why-run mode, unlike custom resources

Use a defintion when repeating patterns exist across resources and/or when a simple, direct approach is desired. There is no limit to the number of resources that may be included in a definition: use as many built-in chef-client resources as necessary.

.. end_tag

Syntax
=====================================================
.. tag 4_syntax

A definition has four components:

* A resource name
* Zero or more arguments that define parameters their default values; if a default value is not specified, it is assumed to be ``nil``
* A hash that can be used within a definition's body to provide access to parameters and their values
* The body of the definition

The basic syntax of a definition is:

.. code-block:: ruby

   define :resource_name do
     body
   end

More commonly, the usage incorporates arguments to the definition:

.. code-block:: ruby

   define :resource_name, :parameter => :argument, :parameter => :argument do
     body (likely referencing the params hash)
   end

The following simplistic example shows a definition with no arguments (a parameterless macro in the truest sense):

.. code-block:: ruby

   define :prime_myfile do
     file '/etc/myfile' do
       content 'some content'
     end
   end

An example showing the use of parameters, with a parameter named ``port`` that defaults to ``4000`` rendered into a **template** resource, would look like:

 .. code-block:: ruby

   define :prime_myfile, port: 4000 do
     template '/etc/myfile' do
       source 'myfile.erb'
       variables({
         port: params[:port],
       })
     end
   end

Or the following definition, which looks like a resource when used in a recipe, but also contains resources---**directory** and **file**---that are repeated, but with slightly different parameters:

.. code-block:: ruby

   define :host_porter, :port => 4000, :hostname => nil do
     params[:hostname] ||= params[:name]

     directory '/etc/#{params[:hostname]}' do
       recursive true
     end

     file '/etc/#{params[:hostname]}/#{params[:port]}' do
       content 'some content'
     end
   end

which is then used in a recipe like this:

.. code-block:: ruby

   host_porter node['hostname'] do
    port 4000
   end

   host_porter 'www1' do
     port 4001
   end

.. end_tag

Examples
=====================================================
The following examples show how to use cookbook definitions.

Simplify Repeating Patterns
-----------------------------------------------------
.. tag 4_scenario_common_install

A definition file is similar to a macro; use a definition to define reusable code. For example, the following definition defines a common installation scenario, in this case installing Splunk on multiple machines:

.. code-block:: ruby

   define :splunk_installer, :url => nil do
     cache_dir = Chef::Config[:file_cache_path]
     package_file = splunk_file(params[:url])
     cached_package = ::File.join(cache_dir, package_file)

     remote_file cached_package do
       source params[:url]
       action :create_if_missing
     end

     if %w{omnios}.include?(node['platform'])
       pkgopts = [
         '-a #{cache_dir}/#{params[:name]}-nocheck',
         '-r #{cache_dir}/splunk-response'
       ]

       execute 'uncompress #{cached_package}' do
         not_if { File.exist?("#{cache_dir}/#{package_file.gsub(/\.Z/, '')}") }
       end

       cookbook_file '#{cache_dir}/#{params[:name]}-nocheck' do
         source 'splunk-nocheck'
       end

       file '#{cache_dir}/splunk-response' do
         content 'BASEDIR=/opt'
       end
     end

     package params[:name] do
       source cached_package.gsub(/\.Z/, '')
       case node['platform_family']
       when 'rhel'
         provider Chef::Provider::Package::Rpm
       when 'debian'
         provider Chef::Provider::Package::Dpkg
       when 'omnios'
         provider Chef::Provider::Package::Solaris
         options pkgopts.join(' ')
       end
     end
   end

Once created, this definition is used just like a resource:

.. code-block:: ruby

   splunk_installer 'use #1' do
     url node['splunk']['server']['url']
   end

and then another recipe:

.. code-block:: ruby

   splunk_installer 'use #2' do
     url node['splunk']['forwarder']['url']
   end

and so on.

.. end_tag

Create a Resource
-----------------------------------------------------
.. tag 4_scenario_create_resource

A definition file can be used to create an object that the chef-client can then use like a resource. For example:

.. code-block:: ruby

   apache_site Definition
   define :apache_site, :enable => true do
     include_recipe 'apache2'

     if params[:enable]
       execute 'a2ensite #{params[:name]}' do
         command '/usr/sbin/a2ensite #{params[:name]}'
         notifies :restart, resources(:service => 'apache2')
         not_if do
           ::File.symlink?('#{node[:apache][:dir]}/sites-enabled/#{params[:name]}') or
           ::File.symlink?('#{node[:apache][:dir]}/sites-enabled/000-#{params[:name]}')
         end
         only_if do ::File.exists?('#{node[:apache][:dir]}/sites-available/#{params[:name]}') end
       end
     else
       execute 'a2dissite #{params[:name]}' do
         command '/usr/sbin/a2dissite #{params[:name]}'
         notifies :restart, resources(:service => 'apache2')
         only_if do ::File.symlink?('#{node[:apache][:dir]}/sites-enabled/#{params[:name]}') end
       end
     end
   end

Once created, the definition can be used by placing it in a recipe:

.. code-block:: ruby

   apache_site resource
   # Enable my_site.conf
   apache_site 'my_site.conf' do
     enable true
   end

   # Disable my_site.conf
   apache_site 'my_site.conf' do
     enable false
   end

The attributes of the new ``apache_site`` object are made accessible with the params hash. Within the context of a chef-client run, the definition will be replaced by all the resources that are specified within the definition. For example, in the ``enabled`` case, the definition will be expanded to:

.. code-block:: ruby

   execute 'a2ensite my_site.conf' do
     command '/usr/sbin/a2ensite my_site.conf'
     notifies :restart, resources(:service => 'apache2')
     not_if do
       ::File.symlink?('/etc/apache2/sites-enabled/my_site.conf') or
         ::File.symlink?('/etc/apache2/sites-enabled/000-my_site.conf')
     end
   end

.. end_tag

Many Recipes, One Definition
-----------------------------------------------------
.. tag definition_scenario_many_recipes_one_definition

Data can be passed to a definition from more than one recipe. Use a definition to create a compile-time macro that can be referenced by resources during the converge phase. For example, when both ``/etc/aliases`` and ``/etc/sudoers`` require updates from multiple recipes during a single chef-client run.

A definition that reopens resources would look something like:

.. code-block:: ruby

   define :email_alias, :recipients => [] do
     name       = params[:name]
     recipients = params[:recipients]

     find_resource(:execute, 'newaliases') do
       action :nothing
     end

     t = find_resource(template: '/etc/aliases') do
       source 'aliases.erb'
       cookbook 'aliases'
       variables({:aliases => {} })
       notifies :run, 'execute[newaliases]'
     end

     aliases = t.variables[:aliases]

     if !aliases.has_key?(name)
       aliases[name] = []
     end
     aliases[name].concat(recipients)
   end

.. end_tag

Virtual Hosts
-----------------------------------------------------
.. tag 4_scenario_virtual_hosts

Two applications need to be deployed and run on a single node under the same domain and sub-domain. A Ruby on Rails application will reside as the main application at ``example.com`` and a WordPress application will reside at ``blog.example.com``. The domain is running Apache2 as the web server. The domain is expected to grow, but for now only two ``run_list`` resources are created, with the appropriate roles added to them. At some point in the future, when a new sub-domain is required, a new ``run_list`` resource would also be created.

The virtual host on the Apache2 server is only one per node, which can create challenges when a node requires updates. Using a definition helps get around this issue. For example, the ``web_app`` definition exists in the ``apache2`` cookbook, and can be used like this:

.. code-block:: ruby

   web_app 'blog_site' do
     server_name 'blog'
     server_aliases [ "blog.#{node['domain']}", node['fqdn'] ]
     docroot '/srv/www/blog_site'
   end

When the chef-client processes a recipe that contains this definition, it will find the ``web_app`` resource and will attempt to recognize it as a resource. Assuming that the ``apache2`` cookbook is available, the resources contained within that cookbook will be found and loaded, replacing the definition.

.. end_tag

