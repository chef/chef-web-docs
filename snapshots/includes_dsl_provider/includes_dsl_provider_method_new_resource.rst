.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``new_resource`` method is used to represent a resource as loaded by the chef-client during the chef-client run. In other words: what the resource should be. The custom provider should compare the resource as it exists on the node to the resource that is created during the chef-client run to determine what steps need to be taken to bring the resource into the desired state.

For example:

.. code-block:: ruby

   action :delete do
     if ::File.exists?(new_resource.path)
       converge_by("deleting #{new_resource.path}) do
         if ::File.writable?(new_resource.path)
           Chef::Log.info("Deleting #{new_resource} at #{new_resource.path}")
           ::File.delete(new_resource.path)
         else
           raise "Cannot delete #{new_resource} at #{new_resource.path}!"
         end
       end
     end
   end

where

* The chef-client checks to see if the file exists, then if the file is writable, and then attempts to delete the resource
* ``path`` is an attribute of the new resource that is defined by the custom resource
