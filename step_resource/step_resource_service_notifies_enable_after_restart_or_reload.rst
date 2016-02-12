.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To enable a service after restarting or reloading it:

.. code-block:: ruby
 
   service 'apache' do
     supports :restart => true, :reload => true
     action :enable
   end
