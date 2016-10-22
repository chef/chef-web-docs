.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To manage a service whose name depends on the platform of the node on which it runs:

.. code-block:: ruby

   service 'example_service' do
     case node['platform']
     when 'centos','redhat','fedora'
       service_name 'redhat_name'
     else
       service_name 'other_name'
     end
     supports :restart => true
     action [ :enable, :start ]
   end
