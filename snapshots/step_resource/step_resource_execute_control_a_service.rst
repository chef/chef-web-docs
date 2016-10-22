.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. warning:: This is an example of something that should NOT be done. Use the **service** resource to control a service, not the **execute** resource.

Do something like this:

.. code-block:: ruby

   service 'tomcat' do
     action :start
   end

and NOT something like this:

.. code-block:: ruby

   execute 'start-tomcat' do
     command '/etc/init.d/tomcat6 start'
     action :run
   end

There is no reason to use the **execute** resource to control a service because the **service** resource exposes the ``start_command`` property directly, which gives a recipe full control over the command issued in a much cleaner, more direct manner.
