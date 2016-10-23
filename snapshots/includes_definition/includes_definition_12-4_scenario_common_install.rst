.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

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
