.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

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
