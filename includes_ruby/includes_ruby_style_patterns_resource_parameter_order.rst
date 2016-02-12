.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Follow this order for information in each resource declaration:

* Source
* Cookbook
* Resource ownership
* Permissions
* Notifications
* Action

For example:

.. code-block:: ruby

   template '/tmp/foobar.txt' do
     source 'foobar.txt.erb'
     owner  'someuser'
     group  'somegroup'
     mode   '0644'
     variables(
       :foo => 'bar'
     )
     notifies :reload, 'service[whatever]'
     action :create
   end
