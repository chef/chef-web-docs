.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


There are many ways to structure a |knife| plugin. The following syntax shows a typical |knife| plugin:

.. code-block:: ruby

   require 'chef/knife'
   # other require attributes, as needed
   
   module ModuleName
     class SubclassName < Chef::Knife
   
     deps do
       require 'chef/dependency'
       # other dependencies, as needed
     end

     banner "knife subcommand argument VALUE (options)"
   
     option :name_of_option,
       :short => "-l VALUE",
       :long => "--long-option-name VALUE",
       :description => "The description for the option.",
       :proc => Proc.new { code_to_run }
       :boolean => true | false
       :default => default_value
   
     def run
       # Ruby code goes here
     end
   end

where:

* ``require`` identifies any other |knife| subcommands and/or |knife| plugins required by this plugin
* ``module ModuleName`` declares the |knife| plugin as its own namespace
* ``class SubclassName < Chef::Knife`` declares the plugin as a subclass of ``Knife``, which is in the ``Chef`` namespace. The capitalization of this name is important. For example, ``SubclassName`` would have a |knife| command of ``knife subclass name``, whereas ``Subclassname`` would have a |knife| command of ``knife subclassname``
* ``deps do`` is a list of dependencies
* ``banner "knife subcommand argument VALUE (options)"`` is displayed when a user enters ``knife subclassName --help``
* ``option :name_of_option`` defines each of the command-line options that are available for this plugin. For example, ``knife subclass -l VALUE`` or ``knife subclass --long-option-name VALUE``
* ``def run`` is the |ruby| code that is executed when the command is run

and where for each command-line option:

* ``:short`` defines the short option name
* ``:long`` defines the long option name
* ``:description`` defines a description that is displayed when a user enters ``knife subclassName --help``
* ``:boolean`` defines whether the option is ``true`` or ``false``; if the ``:short`` and ``:long`` names define a ``VALUE``, then this attribute must not be used
* ``:proc`` defines code that determines the value for this option
* ``:default`` defines a default value

The following example shows part of a |knife| plugin named ``knife windows``:

.. code-block:: ruby

   require 'chef/knife'
   require 'chef/knife/winrm_base'
   
   class Chef
     class Knife
       class Winrm < Knife
   
         include Chef::Knife::WinrmBase
   
         deps do
           require 'readline'
           require 'chef/search/query'
           require 'em-winrm'
         end
   
         attr_writer :password
   
         banner "knife winrm QUERY COMMAND (options)"
   
         option :attribute,
           :short => "-a ATTR",
           :long => "--attribute ATTR",
           :description => "The attribute to use for opening the connection - default is fqdn",
           :default => "fqdn"
   
         ... # more options
      
         def session
           session_opts = {}
           session_opts[:logger] = Chef::Log.logger if Chef::Log.level == :debug
           @session ||= begin
             s = EventMachine::WinRM::Session.new(session_opts)
             s.on_output do |host, data|
               print_data(host, data)
             end
             s.on_error do |host, err|
               print_data(host, err, :red)
             end
             s.on_command_complete do |host|
               host = host == :all ? 'All Servers' : host
               Chef::Log.debug("command complete on #{host}")
             end
             s
           end
   
         end
   
         ... # more def blocks
   
       end
     end
   end

Take a look at all of the code for this plugin on |github|: https://github.com/chef/knife-windows/blob/master/lib/chef/knife/winrm.rb.


