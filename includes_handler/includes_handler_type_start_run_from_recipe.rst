.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |cookbook chef_client| cookbook can be configured to automatically install and configure gems that are required by a start handler. For example:

.. code-block:: ruby

   node.set['chef_client']['load_gems']['chef-reporting'] = {
     :require_name => 'chef_reporting',
     :action => :install
   }
   
   node.set['chef_client']['config']['start_handlers'] = [
     {
       :class => 'Chef::Reporting::StartHandler',
       :arguments => []
     }
   ]
   
   include_recipe 'chef-client::config'
