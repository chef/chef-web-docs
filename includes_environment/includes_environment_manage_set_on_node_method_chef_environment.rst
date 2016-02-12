.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. example only, should not be included in published documentation

.. warning:: Changing a node's environment during the |chef client| run is not common and not recommended.

Use the ``chef_environment`` method to load the node object, and then set an environment during a |chef client| run. Because the environment is set during the |chef client| run, the changes will be applied during the next |chef client| run.

For example:

code-block:: ruby

   module Canaria
     def self.canary?(unique_string, percent, overrides = [])
       return true if overrides.include?(unique_string)
       return false if percent.to_i == 0
       Digest::MD5.hexdigest(unique_string).to_s.hex % 100 <= percent.to_i
     end
   
     def self.chef_environment(node, chef_env)
       begin
         Chef::Environment.load(chef_env)
       rescue Net::HTTPServerException => e
         msg = 'Chef Environment error: '
         if e.response.code.to_s == '404'
           msg << '#{chef_env} does not exist, cannot change.'
         else
           msg << '#{chef_env} raised #{e.message}'
         end
         Chef::Log.error(msg)
         raise
       end
   
       node.chef_environment(chef_env)
     end
   
     module DSL
       def canary?
         Canaria.canary?(node['fqdn'],
                         node['canaria']['percentage'],
                         node['canaria']['overrides'])
       end
   
       def set_chef_environment(chef_env)
         Canaria.chef_environment(node, chef_env)
       end
     end
   end

   if defined?(Chef)
     Chef::Recipe.send(:include, Canaria::DSL)
     Chef::Provider.send(:include, Canaria::DSL)
     Chef::Resource.send(:include, Canaria::DSL)
     Chef::ResourceDefinition.send(:include, Canaria::DSL)
   end
