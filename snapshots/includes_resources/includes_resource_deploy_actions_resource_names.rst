.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The chef-client caches deployment actions as they are taken. In order for the chef-client to be able to apply a subsequent deployment action---rolling back a release using the ``:rollback`` action, for example---all related deployment actions must be contained within resource blocks that have the same name. This ensures that the chef-client will be able to find the correct deployment from within the cached deployment actions.

For example, a simple deployment:

.. code-block:: ruby

   deploy_revision 'name' do
     ...
     action :deploy
   end

In order to use the ``:rollback`` action with this deployment, the ``:rollback`` action must be in a resource block that has the same resource name as the initial deploy action. For example:

.. code-block:: ruby

   deploy_revision 'name' do
     ...
     action :rollback
   end

