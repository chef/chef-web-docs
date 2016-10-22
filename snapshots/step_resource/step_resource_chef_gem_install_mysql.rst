.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To install MySQL:

.. code-block:: ruby

   execute 'apt-get update' do
     ignore_failure true
     action :nothing
   end.run_action(:run) if node['platform_family'] == 'debian'
   
   node.set['build_essential']['compiletime'] = true
   include_recipe 'build-essential'
   include_recipe 'mysql::client'
   
   node['mysql']['client']['packages'].each do |mysql_pack|
     resources("package[#{mysql_pack}]").run_action(:install)
   end
   
   chef_gem 'mysql'
