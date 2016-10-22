.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To pass a block of Python code before a migration is run:

.. code-block:: ruby

   deploy_revision '/deploy/dir/' do
     # other attributes
     # ...
     
     before_migrate do
       # release_path is the path to the timestamp dir 
       # for the current release
       current_release = release_path
        
       # Create a local variable for the node so we'll have access to
       # the attributes
       deploy_node = node
       
       # A local variable with the deploy resource.
       deploy_resource = new_resource
        
       python do
         cwd current_release
         user 'myappuser'
         code<<-PYCODE
           # Woah, callbacks in python!
           # ...
           # current_release, deploy_node, and deploy_resource are all available
           # within the deploy hook now.
         PYCODE
       end
     end
   end
