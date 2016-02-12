.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is hooked into a slide deck
.. If changes are made to this file, also update includes_custom_resources_website_final_resource


.. code-block:: ruby

   # continued from previous slide
   
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
   
   ... # continued on next slide
