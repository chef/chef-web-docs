.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example listens to a |resource execute| block that tests if an init script exists, and then doesn't run if the init script exists. The |resource service| block only runs if the init script does not exist:

.. code-block:: ruby
   
   execute "command" do
     not_if File.exists?('/etc/init.d/script')
   end
   
   service 'name' do
     supports :restart => true
     subscribes :run, 'execute[command]', :immediately
     action :start
   end
