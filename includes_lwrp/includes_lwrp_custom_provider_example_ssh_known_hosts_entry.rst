.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``ssh_known_hosts_entry`` custom provider (found in the `ssh_known_hosts <https://github.com/chef-cookbooks/ssh_known_hosts>`_ cookbook) is used to add hosts and keys to the ``/etc/ssh_known_hosts`` file.

.. code-block:: ruby

   action :create do
     key = (new_resource.key || `ssh-keyscan -H #{new_resource.host} 2>&1`)
     comment = key.split('\n').first
   
     Chef::Application.fatal! 'Could not resolve #{new_resource.host}' if key =~ /getaddrinfo/
   
     file node['ssh_known_hosts']['file'] do
       action        :create
       backup        false
       content       
       only_if do
         !::File.exists?(node['ssh_known_hosts']['file']) || ::File.new(node['ssh_known_hosts']['file']).readlines.length == 0
       end
     end
   
     ruby_block "add #{new_resource.host} to #{node['ssh_known_hosts']['file']}" do
       block do
         file = ::Chef::Util::FileEdit.new(node['ssh_known_hosts']['file'])
         file.insert_line_if_no_match(/#{Regexp.escape(comment)}|#{Regexp.escape(key)}/, key)
         file.write_file
       end
     end
     new_resource.updated_by_last_action(true)
   end
