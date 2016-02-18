.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To update the Apt repository at the start of a chef-client run:

.. code-block:: ruby

   apt_update if node['platform_family'] == 'debian' do
     action :update
   end 
