.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to prevent concurrent chef-client runs from both holding a lock on etcd:

.. code-block:: ruby

   lock_key = "#{node.chef_environment}/#{node.name}"
   
   Chef.event_handler do
     on :converge_start do |run_context|
       Etcd.lock_acquire(lock_key)
     end
   end
   
   Chef.event_handler do
     on :converge_complete do
       Etcd.lock_release(lock_key)
     end
   end
