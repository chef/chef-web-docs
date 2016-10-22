.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


On a system with the chef-client installed, use Ruby to make an authenticated request to the Chef server:

.. code-block:: ruby

   require 'rubygems'
   require 'chef/config'
   require 'chef/log'
   require 'chef/rest'
    
   chef_server_url = 'https://chefserver.com'
   client_name = 'clientname'
   signing_key_filename = '/path/to/pem/for/clientname'
   
   rest = Chef::REST.new(chef_server_url, client_name, signing_key_filename)
   puts rest.get_rest('/clients')

or:

.. code-block:: ruby

   require 'rubygems'
   require 'mixlib/cli'
   require 'chef'
   require 'chef/node'
   require 'chef/mixin/xml_escape'
   require 'json'
   
   config_file = 'c:/chef/client.rb'
   Chef::Config.from_file(config_file)
   Chef::Log.level = Chef::Config[:log_level]
   
   def Usage()
     puts '/etc/chef/client.rb' # The config file location, e.g. ~/home/.chef/knife.rb etc
     config_file = gets.chomp
     if (!File.exist?(config_file))
       puts 'config_file #{config_file} does not exist. Exiting.\n'
       exit
     end
     STDOUT.puts <<-EOF
       Choose options e.g. 1
       
       1 Display all nodes per environment
       2 Display all nodes in detail (can be slow if there a large number of nodes)
       9 Exit
     EOF
   end
   
   def ExecuteUserChoice()
     testoption = gets.chomp
     case testoption
     when '1'
       Execute(method(:DisplayNodesPerEnv))
     when '2'
       Execute(method(:DisplayNodesDetail))
     when '9'
       puts 'exit'
     else
       puts 'Unknown option #{testoption}. Exiting\n'
       exit
     end
   end
   
   def DisplayNodesPerEnv()
     Chef::Environment.list(false).each do |envr|
       print 'ENVIRONMENT: ', envr[0], '\n'
       Chef::Node.list_by_environment(envr[0], false).each do |node_info|
         print '\tNODE: ', node_info[0], '\n'
         print '\t\tURL: ', node_info[1], '\n'
       end
     end
   end
   
   def DisplayNodesDetail()
     Chef::Node.list(true).each do |node_array|
       node = node_array[1]
       print '#{node.name}\n'
       print '\t#{node[:fqdn]}\n'
       print '\t#{node[:kernel][:machine]}\n'
       print '\t#{node[:kernel][:os]}\n'
       print '\t#{node[:platform]}\n'
       print '\t#{node[:platform_version]}\n'
       print '\t#{node.chef_environment}\n'
       print '\t#{node.run_list.roles}\n'
     end
   end
   
   def Execute(option)
     begin
       profilestart = Time.now
       option.call()
       profileend = Time.now
       timeofrun = profileend - profilestart
       print 'Time taken = #{timeofrun}'
     rescue Exception => ex
       print 'Error calling chef API'
       print ex.message
       print ex.backtrace.join('\n')
     end
   end
   
   Usage()
   ExecuteUserChoice()

Another way Ruby can be used with the Chef server API is to get objects from the Chef server, and then interact with the returned data using Ruby methods. Whenever possible, the Chef server API will return an object of the relevant type. The returned object is then available to be called by other methods. For example, the ``api.get`` method can be used to return a node named ``foobar``, and then ``.destroy`` can be used to delete that node:

.. code-block:: none

   silly_node = api.get('/nodes/foobar')
   silly_node.destroy
