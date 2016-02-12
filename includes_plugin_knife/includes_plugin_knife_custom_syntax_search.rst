.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the |chef server| search capabilities from a plugin to return information about the infrastructure to that plugin. Use the ``require`` method to ensure that search functionality is available with the following:

.. code-block:: ruby

   require 'chef/search/query'

Create a search query object and assign it to a variable:

.. code-block:: ruby

   variable_name = Chef::Search::Query.new

After the search object is created it can be used by the plugin to execute search queries for objects on the |chef server|. For example, using a variable named ``query_nodes`` a plugin could search for nodes with the ``webserver`` role and then return the name of each node found:

.. code-block:: ruby

   query = "role:webserver"
    
   query_nodes.search('node', query) do |node_item|
     puts "Node Name: #{node_item.name}"
   end

This result can then be used to edit nodes. For example, searching for nodes with the ``webserver`` role, and then changing the run_list for those nodes to a role named ``apache2``:

.. code-block:: ruby

   query = "role:webserver"
   
   query_nodes.search('node', query) do |node_item|
     ui.msg "Changing the run_list to role[apache2] for #{node_item.name}"
     node_item.run_list("role[apache2]")
     node_item.save
     ui.msg "New run_list: #{node_item.run_list}"
   end

It's also possible to specify multiple items to add to the run_list:

.. code-block:: ruby

   node_item.run_list("role[apache2]", "recipe[mysql]")

And arguments sent with a plugin command can also be used to search. For example, if the command ``knife envchange "web*"`` is sent, then the command will search for any nodes in roles beginning with "web" and then change their environment to "web":

.. code-block:: ruby

   module MyKnifePlugins
  
     class Envchange < Chef::Knife
   
       banner "knife envchange ROLE"
     
       deps do
         require 'chef/search/query'
       end
   
       def run
         if name_args.size == 1
           role = name_args.first
         else
           ui.fatal "Please provide a role name to search for"
           exit 1
         end
   
         query = "role:#{role}"
         query_nodes = Chef::Search::Query.new
    
         query_nodes.search('node', query) do |node_item|
           ui.msg "Moving #{node_item.name} to the web environment"
           node_item.chef_environment("web")
           node_item.save
         end
    
       end
     end
