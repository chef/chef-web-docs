.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.



The ``current_resource`` method is used to represent a resource as it exists on the node at the beginning of the chef-client run. In other words: what the resource is currently. The custom provider should compare the resource as it exists on the node to the ``new_resource`` that is created during the chef-client run, and then determine what steps should be taken to bring the resource into the desired state.

For example:

.. code-block:: ruby

   action :add do
     unless current_resource.exists
       cmd = "#{appcmd} add app /site.name:\'#{new_resource.app_name}\'"
       cmd << " /path:\'#{new_resource.path}\'"
       cmd << " /applicationPool:\'#{new_resource.application_pool}\'" if new_resource.application_pool
       cmd << " /physicalPath:\'#{new_resource.physical_path}\'" if new_resource.physical_path
       converge_by("creating App") do
         Chef::Log.debug(cmd)
         shell_out!(cmd)
         Chef::Log.debug('App created')
       end
     else
       Chef::Log.debug('#{new_resource} app already exists - nothing to do')
     end
   end

where the ``unless`` conditional statement checks to make sure the resource doesn't already exist on a node, and then runs a series of commands when it doesn't. If the resource already exists, the log entry would be ``Foo app already exists - nothing to do``.
