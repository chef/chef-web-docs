.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is hooked into a slide deck
.. This is the consolidated version of includes_custom_resources_slide_website_final_resource_part1, includes_custom_resources_slide_website_final_resource_part2, includes_custom_resources_slide_website_final_resource_part3

.. code-block:: ruby

   property :instance_name, String, name_property: true
   property :port, Fixnum, required: true
   
   action :create do
     package 'httpd' do
       action :install
     end
   
     template "/lib/systemd/system/httpd-#{instance_name}.service" do
       source 'httpd.service.erb'
       variables(
         :instance_name => instance_name
       )
       owner 'root'
       group 'root'
       mode '0644'
       action :create
     end

     template "/etc/httpd/conf/httpd-#{instance_name}.conf" do
       source 'httpd.conf.erb'
       variables(
         :instance_name => instance_name,
         :port => port
       )
       owner 'root'
       group 'root'
       mode '0644'
       action :create
     end
   
     directory "/var/www/vhosts/#{instance_name}" do
       recursive true
       owner 'root'
       group 'root'
       mode '0755'
       action :create
     end
   
     service "httpd-#{instance_name}" do
       action [:enable, :start]
     end
       
   end
