.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The reason why the ``use_inline_resources`` method exists at all is due to how the chef-client processes resources. Currently, the default behavior of the chef-client processes a single collection of resources, converged on the node in order.

A custom resource is often implemented using the core chef-client resources---**file**, **template**, **package**, and so on---as building blocks. A custom resource is then added to a recipe using the short name of the custom resource in the recipe (and not by using any of the building block resource components). 

This situation can create problems with notifications because the chef-client includes embedded resources in the "single collection of resources" *after* the parent resource has been fully evaluated.

For example:

.. code-block:: ruby

   custom_resource 'something' do
     action :run
     notifies :restart, 'service[whatever]', :immediately
   end
   
   service 'whatever' do
     action :nothing
   end

If the ``custom_resource`` is built using the **file** resource, what happens during the chef-client run is::

   custom_resource (not updated)
     file (updated)
   service (skipped, due to ``:nothing``)

The ``custom_resource`` is converged completely, its state set to not updated before the **file** resource is evaluated. The ``notifies :restart`` is ignored and the service is not restarted. 

If the author of the custom resource knows in advance what notification is required, then the **file** resource can be configured for the notification in the provider. For example:

.. code-block:: ruby

   action :run do
     file '/tmp/foo' do
       owner 'root'
       group 'root'
       mode '0644'
       notifies :restart, 'service[whatever]', :immediately
     end
   end

And then in the recipe:

.. code-block:: ruby

   service 'whatever' do
     action :nothing
   end

This approach works, but only when the author of the custom resource knows what should be notified in advance of the chef-client run. Consequently, this is less-than-ideal for most situations.

Using the ``use_inline_resources`` method will ensure that the chef-client processes a custom resource as if it were its own resource collection---a "mini chef-client run", effectively---that is converged *before* the chef-client finishes evaluating the parent custom resource. This ensures that any notifications that may exist in the embedded resources are processed as if they were notifications on the parent custom resource. For example:

.. code-block:: ruby

   custom_resource 'something' do
     action :run
     notifies :restart, 'service[whatever]', :immediately
   end
   
   service 'whatever' do
     action :nothing
   end

If the ``custom_resource`` is built using the **file** resource, what happens during the chef-client run is::

   custom_resource (starts converging)
     file (updated)
   custom_resource (updated, because ``file`` updated)
   service (updates, because ``:immediately`` is set in the custom resource)
