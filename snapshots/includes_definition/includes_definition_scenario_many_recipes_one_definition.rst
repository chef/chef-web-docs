.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Data can be passed to a definition from more than one recipe. Use a definition to create a compile-time macro that can be referenced by resources during the converge phase. For example, when both ``/etc/aliases`` and ``/etc/sudoers`` require updates from multiple recipes during a single chef-client run.

A definition that reopens resources would look something like:

.. code-block:: ruby

   define :email_alias, :recipients => [] do
     name       = params[:name]
     recipients = params[:recipients]
   
     find_resource(:execute, 'newaliases') do
       action :nothing
     end
   
     t = find_resource(template: '/etc/aliases') do
       source 'aliases.erb'
       cookbook 'aliases'
       variables({:aliases => {} })
       notifies :run, 'execute[newaliases]'
     end
   
     aliases = t.variables[:aliases]
   
     if !aliases.has_key?(name)
       aliases[name] = []
     end
     aliases[name].concat(recipients)
   end
