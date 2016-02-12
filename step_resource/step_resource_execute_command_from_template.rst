.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to set up IPv4 packet forwarding using the |resource execute| resource to run a command named ``forward_ipv4`` that uses a template defined by the |resource template| resource:

.. code-block:: ruby

   execute 'forward_ipv4' do
     command 'echo > /proc/.../ipv4/ip_forward'
     action :nothing
   end
   
   template '/etc/file_name.conf' do
     source 'routing/file_name.conf.erb'
     notifies :run, 'execute[forward_ipv4]', :delayed
   end

where the ``command`` property for the |resource execute| resource contains the command that is to be run and the ``source`` property for the |resource template| resource specifies which template to use. The ``notifies`` property for the |resource template| specifies that the ``execute[forward_ipv4]`` (which is defined by the |resource execute| resource) should be queued up and run at the end of the |chef client| run.
