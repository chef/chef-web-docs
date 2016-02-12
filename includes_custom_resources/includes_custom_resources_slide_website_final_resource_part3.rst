.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is hooked into a slide deck
.. If changes are made to this file, also update includes_custom_resources_website_final_resource


.. code-block:: ruby

   # continued from previous slide
   
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
