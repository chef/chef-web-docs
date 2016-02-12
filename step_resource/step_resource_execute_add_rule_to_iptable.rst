.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to add a rule named ``test_rule`` to an IP table using the |resource execute| resource to run a command using a template that is defined by the |resource template| resource:

.. code-block:: ruby

   execute 'test_rule' do
     command 'command_to_run 
       --option value 
       ...
       --option value 
       --source #{node[:name_of_node][:ipsec][:local][:subnet]} 
       -j test_rule'
     action :nothing
   end

   template '/etc/file_name.local' do
     source 'routing/file_name.local.erb'
     notifies :run, 'execute[test_rule]', :delayed
   end

where the ``command`` property for the |resource execute| resource contains the command that is to be run and the ``source`` property for the |resource template| resource specifies which template to use. The ``notifies`` property for the |resource template| specifies that the ``execute[test_rule]`` (which is defined by the |resource execute| resource) should be queued up and run at the end of the |chef client| run.

