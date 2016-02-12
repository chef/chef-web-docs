.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Data can be passed to a definition from more than one recipe. Use a definition to create a compile-time macro that can be referenced by resources during the converge phase. For example, when both ``/etc/aliases`` and |path etc sudoers| require updates from multiple recipes during a single |chef client| run.

A definition that reopens resources would look something like:

.. code-block:: ruby

   # example provided by community member "Mithrandir". Thank you!

   define :email_alias, :recipients => [] do
     execute 'newaliases' do
       action :nothing
     end
    
     t = nil
     begin
       t = resources(:template => '/etc/aliases')
     rescue Chef::Exceptions::ResourceNotFound
       t = template '/etc/aliases' do
         source 'aliases.erb'
         cookbook 'aliases'
         variables({:aliases => {} })
         notifies :run, 'execute[newaliases]'
       end
     end
   
     if not t.variables[:aliases].has_key?(params[:name])
       t.variables[:aliases][params[:name]] = []
     end
     t.variables[:aliases][params[:name]] << [ params[:recipients] ]
   end
