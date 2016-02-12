.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how to use the |resource execute|, |resource service|, and |resource mount| resources together to ensure that a node running on |amazon ec2| is running |mysql|. This example does the following:

* Checks to see if the |amazon ec2| node has |mysql|
* If the node has |mysql|, stops |mysql|
* Installs |mysql|
* Mounts the node
* Restarts |mysql|

.. code-block:: ruby

   # the following code sample comes from the ``server_ec2``
   # recipe in the following cookbook:
   # https://github.com/chef-cookbooks/mysql

   if (node.attribute?('ec2') && ! FileTest.directory?(node['mysql']['ec2_path']))
   
     service 'mysql' do
       action :stop
     end
   
     execute 'install-mysql' do
       command "mv #{node['mysql']['data_dir']} #{node['mysql']['ec2_path']}"
       not_if do FileTest.directory?(node['mysql']['ec2_path']) end
     end
   
     [node['mysql']['ec2_path'], node['mysql']['data_dir']].each do |dir|
       directory dir do
         owner 'mysql'
         group 'mysql'
       end
     end
   
     mount node['mysql']['data_dir'] do
       device node['mysql']['ec2_path']
       fstype 'none'
       options 'bind,rw'
       action [:mount, :enable]
     end
   
     service 'mysql' do
       action :start
     end
   
   end

where

* the two |resource service| resources are used to stop, and then restart the |mysql| service
* the |resource execute| resource is used to install |mysql|
* the |resource mount| resource is used to mount the node and enable |mysql|
