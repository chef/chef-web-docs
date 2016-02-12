.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is hooked into a slide deck
.. If changes are made to this file, also update includes_custom_resources_website_final_resource


The finished custom resource should look exactly like this:

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
   
   ... # continued on next slide
