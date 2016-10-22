.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows two log entries, one created using ``Chef::Log`` and the other using the **log** resource. Only the log entry created by the **log** resource is built into the resource collection.

.. code-block:: ruby

   ...
   
   client_bin = find_chef_client
   Chef::Log.debug("Found chef-client in #{client_bin}")
   node.default['chef_client']['bin'] = client_bin
   create_directories
   
   log 'Using winsw_service on this Chef version is deprecated; use windows_service' do
     level :warn
     only_if { Gem::Requirement.new('>= 11.5').satisfied_by?(Gem::Version.new(::Chef::VERSION)) }
   end
   
   ...
