.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``action`` method is used to define the steps that will be taken for each of the possible actions defined by the custom resource. Each action must be defined in separate ``action`` blocks within the same file. The syntax for the ``action`` method is as follows:

.. code-block:: ruby

   action :action_name do
     if @current_resource.exists
       Chef::Log.info '#{ @new_resource } already exists - nothing to do.'
     else
       resource 'resource_name' do
         Chef::Log.info '#{ @new_resource } created.'
       end
     end
     new_resource.updated_by_last_action(true)
   end

where:

* ``:action_name`` corresponds to an action defined by a custom resource
* ``if @current_resource.exists`` is a condition test that is using an instance variable to see if the object already exists on the node; this is an example of a test for idempotence
* If the object already exists, a ``#{ @new_resource } already exists - nothing to do.`` log entry is created
* If the object does not already exists, the ``resource`` block is run. This block is a recipe that tells the chef-client what to do. A ``#{ @new_resource } created.`` log entry is created
