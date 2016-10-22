.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is hooked into a slide deck


Use the **template** resource to configure httpd on the node based on the ``httpd.conf.erb`` template located in the cookbook:

.. code-block:: ruby

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

where

* ``source`` gets the ``httpd.conf.erb`` template from this cookbook
* ``variables`` assigns the ``instance_name`` and ``port`` properties to variables in the template
