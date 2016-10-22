.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is hooked into a slide deck


Use the **template** resource to create an ``httpd.service`` on the node based on the ``httpd.service.erb`` template located in the cookbook:

.. code-block:: ruby

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

where

* ``source`` gets the ``httpd.service.erb`` template from this cookbook
* ``variables`` assigns the ``instance_name`` property to a variable in the template
