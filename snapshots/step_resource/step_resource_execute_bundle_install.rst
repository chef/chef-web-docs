.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to run ``bundle install`` from a chef-client run as a specific user. This will put the gem into the path of the user (``vagrant``) instead of the root user (under which the chef-client runs):

.. code-block:: ruby

   execute '/opt/chefdk/embedded/bin/bundle install' do
     cwd node['chef_workstation']['bundler_path']
     user node['chef_workstation']['user']
     environment ({
       'HOME' => "/home/#{node['chef_workstation']['user']}",
       'USER' => node['chef_workstation']['user']
     })
     not_if 'bundle check'
   end
