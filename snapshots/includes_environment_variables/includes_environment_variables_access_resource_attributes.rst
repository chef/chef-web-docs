.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

If processes is started by using the **execute** or **script** resources (or any of the resources based on those two resources, such as **bash**), use the ``environment`` attribute to alter the environment that will be passed to the process.

.. code-block:: bash

   bash 'env_test' do
     code <<-EOF
     echo $FOO
   EOF
     environment ({ 'FOO' => 'bar' })
   end

The only environment being altered is the one being passed to the child process that is started by the **bash** resource. This will not affect the environment of the chef-client or any child processes.
