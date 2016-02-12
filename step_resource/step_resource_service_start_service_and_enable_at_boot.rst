.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To start the service when it is not running and enable it so that it starts at system boot time:

.. code-block:: ruby

   service 'example_service' do
     supports :status => true, :restart => true, :reload => true
     action [ :enable, :start ]
   end
