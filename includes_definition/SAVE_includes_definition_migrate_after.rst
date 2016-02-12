.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. Keep this example---it's useful for showing the progression of a pre-12.5 definition translated to a post-12.5 custom resource, but also to show how the custom resource patterns can be used to remove complexity from resources by eliminating logic, like if statements. These may get re-published someday.

The definition is improved by rewriting it as a custom resource:

.. code-block:: ruby

   property :url, String
   
   action :create do
   
     cache_dir = Chef::Config[:file_cache_path]
     package_file = splunk_file(url)
     cached_package = ::File.join(cache_dir, package_file)
   
     remote_file cached_package do
       source url
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

Once built, the custom resource may be used in a recipe just like the any of the resources that are built into |chef|. The resource gets its name from the cookbook and from the file name in the ``/resources`` directory, with an underscore (``_``) separating them. For example, a cookbook named ``install`` with a custom resource in the ``/resources`` directory named ``splunk.rb``. Use it in a recipe like this:

.. code-block:: ruby

   install_splunk 'name' do
     url node['splunk']['forwarder']['url']
   end

