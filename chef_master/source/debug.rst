=====================================================
Debug Recipes, Chef Infra Client Runs
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/debug.rst>`__

Elements of good approaches to building cookbooks and recipes that are reliable include:

* A consistent syntax pattern when constructing recipes
* Using the same patterns in Ruby
* Using platform resources before creating custom ones
* Using community-authored resources before creating custom ones

Ideally, the best way to debug a recipe is to not have to debug it in the first place. That said, the following sections discuss various approaches to debugging recipes and failed Chef Infra Client runs.

Basic
=====================================================
Some simple ways to quickly identify common issues that can trigger recipe and/or Chef Infra Client run failures include:

* Using an empty run-list
* Using verbose logging with knife
* Using logging with Chef Infra Client
* Using the **log** resource in a recipe to define custom logging

Empty Run-lists
-----------------------------------------------------
.. tag node_run_list_empty

Use an empty run-list to determine if a failed Chef Infra Client run has anything to do with the recipes that are defined within that run-list. This is a quick way to discover if the underlying cause of a Chef Infra Client run failure is a configuration issue. If a failure persists even if the run-list is empty, check the following:

* Configuration settings in the config.rb file
* Permissions for the user to both the Chef Infra Server and to the node on which a Chef Infra Client run is to take place

.. end_tag

Knife
-----------------------------------------------------
Use the verbose logging that is built into knife:

``-V``, ``--verbose``
  Set for more verbose outputs. Use ``-VV`` for maximum verbosity.

.. note:: Plugins do not always support verbose logging.

Chef Infra Client
-----------------------------------------------------
Use the verbose logging that is built into Chef Infra Client:

``-l LEVEL``, ``--log_level LEVEL``
   The level of logging to be stored in a log file.

``-L LOGLOCATION``, ``--logfile c``
   The location of the log file. This is recommended when starting any executable as a daemon. Default value: ``STDOUT``.

log Resource
-----------------------------------------------------
.. tag resource_log_summary

Use the **log** resource to create log entries. The **log** resource behaves like any other resource: built into the resource collection during the compile phase, and then run during the execution phase. (To create a log entry that is not built into the resource collection, use ``Chef::Log`` instead of the **log** resource.)

.. note:: By default, every log resource that executes will count as an updated resource in the updated resource count at the end of a Chef run. You can disable this behavior by adding ``count_log_resource_updates false`` to your Chef ``client.rb`` configuration file.

.. end_tag

New in 12.0, ``-o RUN_LIST_ITEM``. Changed in 12.0 ``-f`` no longer allows unforked intervals, ``-i SECONDS`` is applied before a Chef Infra Client run.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_log_syntax

A **log** resource block adds messages to the log file based on events that occur during a Chef Infra Client run:

.. code-block:: ruby

   log 'message' do
     message 'A message add to the log.'
     level :info
   end

The full syntax for all of the properties that are available to the **log** resource is:

.. code-block:: ruby

  log 'name' do
    level        Symbol # default value: :info
    message      String # default value: 'name' unless specified
    action       Symbol # defaults to :write if not specified
  end

where:

* ``log`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps Chef Infra Client will take to bring the node into the desired state.
* ``level`` and ``message`` are the properties available to this resource.

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_log_actions

The log resource has the following actions:

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of a Chef Infra Client run.

   .. end_tag

``:write``
   Default. Write to log.

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_log_properties

The log resource has the following properties:

``level``
   **Ruby Type:** Symbol | **Default Value:** ``:info``

   The logging level for displaying this message. Options (in order of priority): ``:debug``, ``:info``, ``:warn``, ``:error``, and ``:fatal``.

``message``
   **Ruby Type:** String | **Default Value:** ``The resource block's name``

   The message to be added to a log file. Default value: the ``name`` of the resource block. See "Syntax" section above for more information.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes:

**Specify a log entry**

.. tag resource_log_set_info

.. To set the info (default) logging level:

.. code-block:: ruby

   log 'a string to log'

.. end_tag

**Set debug logging level**

.. tag resource_log_set_debug

.. To set the debug logging level:

.. code-block:: ruby

   log 'a debug string' do
     level :debug
   end

.. end_tag

**Create log entry when the contents of a data bag are used**

.. tag resource_log_set_debug

.. To set the debug logging level:

.. code-block:: ruby

   log 'a debug string' do
     level :debug
   end

.. end_tag

**Add a message to a log file**

.. tag resource_log_add_message

.. To add a message to a log file:

.. code-block:: ruby

   log 'message' do
     message 'This is the message that will be added to the log.'
     level :info
   end

.. end_tag

Advanced
=====================================================
Some more complex ways to debug issues with a Chef Infra Client run include:

* Using the **chef_handler** cookbook
* Using the chef-shell and the **breakpoint** resource to add breakpoints to recipes, and to then step through the recipes using the breakpoints
* Using the ``debug_value`` method from chef-shell to identify the location(s) from which attribute values are being set
* Using the ``ignore_failure`` method in a recipe to force Chef Infra Client to move past an error to see what else is going on in the recipe, outside of a known failure
* Using chef-solo to run targeted Chef Infra Client runs for specific scenarios

chef_handler
-----------------------------------------------------
.. tag handler

Use a handler to identify situations that arise during a Chef Infra Client run, and then tell Chef Infra Client how to handle these situations when they occur.

.. end_tag

.. tag handler_types

There are three types of handlers:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Handler
     - Description
   * - exception
     - An exception handler is used to identify situations that have caused a Chef Infra Client run to fail. An exception handler can be loaded at the start of a Chef Infra Client run by adding a recipe that contains the **chef_handler** resource to a node's run-list. An exception handler runs when the ``failed?`` property for the ``run_status`` object returns ``true``.
   * - report
     - A report handler is used when a Chef Infra Client run succeeds and reports back on certain details about that Chef Infra Client run. A report handler can be loaded at the start of a Chef Infra Client run by adding a recipe that contains the **chef_handler** resource to a node's run-list. A report handler runs when the ``success?`` property for the ``run_status`` object returns ``true``.
   * - start
     - A start handler is used to run events at the beginning of a Chef Infra Client run. A start handler can be loaded at the start of a Chef Infra Client run by adding the start handler to the ``start_handlers`` setting in the client.rb file or by installing the gem that contains the start handler by using the **chef_gem** resource in a recipe in the **chef-client** cookbook. (A start handler may not be loaded using the ``chef_handler`` resource.)

.. end_tag

Read more `about exception, report, and start handlers </handlers.html>`__.

chef-shell
-----------------------------------------------------
.. tag chef_shell_summary

chef-shell is a recipe debugging tool that allows the use of breakpoints within recipes. chef-shell runs as an Interactive Ruby (IRb) session. chef-shell supports both recipe and attribute file syntax, as well as interactive debugging features.

.. end_tag

.. tag chef_shell_modes

chef-shell is tool that is run using an Interactive Ruby (IRb) session. chef-shell currently supports recipe and attribute file syntax, as well as interactive debugging features. chef-shell has three run modes:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Mode
     - Description
   * - Standalone
     - Default. No cookbooks are loaded, and the run-list is empty.
   * - Solo
     - chef-shell acts as a Chef Solo Client. It attempts to load the chef-solo configuration file at ``~/.chef/config.rb`` and any JSON attributes passed. If the JSON attributes set a run-list, it will be honored. Cookbooks will be loaded in the same way that chef-solo loads them. chef-solo mode is activated with the ``-s`` or ``--solo`` command line option, and JSON attributes are specified in the same way as for chef-solo, with ``-j /path/to/chef-solo.json``.
   * - Client
     - chef-shell acts as a Chef Infra Client. During startup, it reads the Chef Infra Client configuration file from ``~/.chef/client.rb`` and contacts the Chef Infra Server to get the node's run_list, attributes, and cookbooks. Chef Infra Client mode is activated with the ``-z`` or ``--client`` options. You can also specify the configuration file with ``-c CONFIG`` and the server URL with ``-S SERVER_URL``.

.. end_tag

Configure
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag chef_shell_config

chef-shell determines which configuration file to load based on the following:

#. If a configuration file is specified using the ``-c`` option, chef-shell will use the specified configuration file
#. If a NAMED_CONF is given, chef-shell will load ~/.chef/NAMED_CONF/chef_shell.rb
#. If no NAMED_CONF is given chef-shell will load ~/.chef/chef_shell.rb if it exists
#. If no chef_shell.rb can be found, chef-shell falls back to load:
      * /etc/chef/client.rb if -z option is given.
      * /etc/chef/solo.rb   if --solo-legacy-mode option is given.
      * .chef/config.rb     if -s option is given.
      * .chef/knife.rb      if -s option is given.

.. end_tag

chef-shell.rb
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag chef_shell_config_rb

The chef-shell.rb file can be used to configure chef-shell in the same way as the client.rb file is used to configure Chef Infra Client. For example, to configure chef-shell to authenticate to the Chef Infra Server, copy the ``node_name``, ``client_key``, and ``chef_server_url`` settings from the config.rb file:

.. code-block:: ruby

   node_name                'your-knife-clientname'
   client_key               File.expand_path('~/.chef/my-client.pem')
   chef_server_url          'https://api.opscode.com/organizations/myorg'

and then add them to the chef-shell.rb file. Other configuration possibilities include disabling Ohai plugins (which will speed up the chef-shell boot process) or including arbitrary Ruby code in the chef-shell.rb file.

.. end_tag

Run as a Chef Infra Client
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag chef_shell_run_as_chef_client

By default, chef-shell loads in standalone mode and does not connect to the Chef Infra Server. The chef-shell can be run as a Chef Infra Client to verify functionality that is only available when Chef Infra Client connects to the Chef Infra Server, such as search functionality or accessing data stored in data bags.

chef-shell can use the same credentials as knife when connecting to a Chef Infra Server. Make sure that the settings in chef-shell.rb are the same as those in config.rb, and then use the ``-z`` option as part of the command. For example:

.. code-block:: bash

   $ chef-shell -z

.. end_tag

Manage
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag chef_shell_manage

When chef-shell is configured to access a Chef Infra Server, chef-shell can list, show, search for and edit cookbooks, clients, nodes, roles, environments, policyfiles, and data bags.

The syntax for managing objects on the Chef Infra Server is as follows:

.. code-block:: bash

   $ chef-shell -z named_configuration

where:

* ``named_configuration`` is an existing configuration file in ``~/.chef/named_configuration/chef_shell.rb``, such as ``production``, ``staging``, or ``test``

Once in chef-shell, commands can be run against objects as follows:

.. code-block:: bash

   $ chef (preprod) > items.command

* ``items`` is the type of item to search for: ``cookbooks``, ``clients``, ``nodes``, ``roles``, ``environments`` or a data bag
* ``command`` is the command: ``list``, ``show``, ``find``, or ``edit``

For example, to list all of the nodes in a configuration named "preprod":

.. code-block:: bash

   $ chef (preprod) > nodes.list

to return something similar to:

.. code-block:: bash

   => [node[i-f09a939b], node[i-049a936f], node[i-eaaaa581], node[i-9154b1fb],
       node[i-6a213101], node[i-c2687aa9], node[i-7abeaa11], node[i-4eb8ac25],
       node[i-9a2030f1], node[i-a06875cb], node[i-145f457f], node[i-e032398b],
       node[i-dc8c98b7], node[i-6afdf401], node[i-f49b119c], node[i-5abfab31],
       node[i-78b8ac13], node[i-d99678b3], node[i-02322269], node[i-feb4a695],
       node[i-9e2232f5], node[i-6e213105], node[i-cdde3ba7], node[i-e8bfb083],
       node[i-743c2c1f], node[i-2eaca345], node[i-aa7f74c1], node[i-72fdf419],
       node[i-140e1e7f], node[i-f9d43193], node[i-bd2dc8d7], node[i-8e7f70e5],
       node[i-78f2e213], node[i-962232fd], node[i-4c322227], node[i-922232f9],
       node[i-c02728ab], node[i-f06c7b9b]]

The ``list`` command can take a code block, which will applied (but not saved) to each object that is returned from the server. For example:

.. code-block:: bash

   $ chef (preprod) > nodes.list {|n| puts "#{n.name}: #{n.run_list}" }

to return something similar to:

.. code-block:: bash

   => i-f09a939b: role[lb], role[preprod], recipe[aws]
      i-049a936f: role[lb], role[preprod], recipe[aws]
      i-9154b1fb: recipe[erlang], role[base], role[couchdb], role[preprod],
      i-6a213101: role[chef], role[preprod]
      # more...

The ``show`` command can be used to display a specific node. For example:

.. code-block:: bash

   $ chef (preprod) > load_balancer = nodes.show('i-f09a939b')

to return something similar to:

.. code-block:: bash

   => node[i-f09a939b]

or:

.. code-block:: bash

   $ chef (preprod) > load_balancer.ec2.public_hostname

to return something similar to:

.. code-block:: bash

   => "ec2-111-22-333-44.compute-1.amazonaws.com"

The ``find`` command can be used to search the Chef Infra Server from the chef-shell. For example:

.. code-block:: bash

   $ chef (preprod) > pp nodes.find(:ec2_public_hostname => 'ec2*')

A code block can be used to format the results. For example:

.. code-block:: bash

   $ chef (preprod) > pp nodes.find(:ec2_public_hostname => 'ec2*') {|n| n.ec2.ami_id } and nil

to return something similar to:

.. code-block:: bash

   => ["ami-f8927a91",
       "ami-f8927a91",
       "ami-a89870c1",
       "ami-a89870c1",
       "ami-a89870c1",
       "ami-a89870c1",
       "ami-a89870c1"
       # and more...

Or:

.. code-block:: bash

   $ chef (preprod) > amis = nodes.find(:ec2_public_hostname => 'ec2*') {|n| n.ec2.ami_id }
   $ chef (preprod) > puts amis.uniq.sort

to return something similar to:

.. code-block:: bash

   => ami-4b4ba522
      ami-a89870c1
      ami-eef61587
      ami-f8927a91

.. end_tag

breakpoint Resource
-----------------------------------------------------
.. tag chef_shell_breakpoints

chef-shell allows the current position in a run-list to be manipulated during a Chef Infra Client run. Add breakpoints to a recipe to take advantage of this functionality.

.. end_tag

.. tag resource_breakpoint_summary

Use the **breakpoint** resource to add breakpoints to recipes. Run the chef-shell in Chef Infra Client mode, and then use those breakpoints to debug recipes. Breakpoints are ignored by Chef Infra Client during an actual Chef Infra Client run. That said, breakpoints are typically used to debug recipes only when running them in a non-production environment, after which they are removed from those recipes before the parent cookbook is uploaded to the Chef Infra Server.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_breakpoint_syntax

A **breakpoint** resource block creates a breakpoint in a recipe:

.. code-block:: ruby

   breakpoint 'name' do
     action :break
   end

where

* ``:break`` will tell Chef Infra Client to stop running a recipe; can only be used when Chef Infra Client is being run in chef-shell mode

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_breakpoint_actions

The breakpoint resource has the following actions:

``:break``
   Use to add a breakpoint to a recipe.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of a Chef Infra Client run.

   .. end_tag

.. end_tag

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_breakpoint_properties

This resource does not have any properties.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes:

**A recipe without a breakpoint**

.. tag resource_breakpoint_no

.. A resource without breakpoints:

.. code-block:: ruby

   yum_key node['yum']['elrepo']['key'] do
     url  node['yum']['elrepo']['key_url']
     action :add
   end

   yum_repository 'elrepo' do
     description 'ELRepo.org Community Enterprise Linux Extras Repository'
     key node['yum']['elrepo']['key']
     mirrorlist node['yum']['elrepo']['url']
     includepkgs node['yum']['elrepo']['includepkgs']
     exclude node['yum']['elrepo']['exclude']
     action :create
   end

.. end_tag

**The same recipe with breakpoints**

.. tag resource_breakpoint_yes

.. code-block:: ruby

   breakpoint "before yum_key node['yum']['repo_name']['key']" do
     action :break
   end

   yum_key node['yum']['repo_name']['key'] do
     url  node['yum']['repo_name']['key_url']
     action :add
   end

   breakpoint "after yum_key node['yum']['repo_name']['key']" do
     action :break
   end

   breakpoint "before yum_repository 'repo_name'" do
     action :break
   end

   yum_repository 'repo_name' do
     description 'description'
     key node['yum']['repo_name']['key']
     mirrorlist node['yum']['repo_name']['url']
     includepkgs node['yum']['repo_name']['includepkgs']
     exclude node['yum']['repo_name']['exclude']
     action :create
   end

   breakpoint "after yum_repository 'repo_name'" do
     action :break
   end

where the name of each breakpoint is an arbitrary string. In the previous examples, the names are used to indicate if the breakpoint is before or after a resource, and then also to specify which resource.

.. end_tag

Step Through Run-list
-----------------------------------------------------
.. tag chef_shell_step_through_run_list

To explore how using the **breakpoint** to manually step through a Chef Infra Client run, create a simple recipe in chef-shell:

.. code-block:: bash

   $ chef > recipe_mode
     chef:recipe > echo off
     chef:recipe > file "/tmp/before-breakpoint"
     chef:recipe > breakpoint "foo"
     chef:recipe > file "/tmp/after-breakpoint"

and then run Chef Infra Client:

.. code-block:: bash

   $ chef:recipe > run_chef
     [Fri, 15 Jan 2020 14:17:49 -0800] DEBUG: Processing file[/tmp/before-breakpoint]
     [Fri, 15 Jan 2020 14:17:49 -0800] DEBUG: file[/tmp/before-breakpoint] using Chef::Provider::File
     [Fri, 15 Jan 2020 14:17:49 -0800] INFO: Creating file[/tmp/before-breakpoint] at /tmp/before-breakpoint
     [Fri, 15 Jan 2020 14:17:49 -0800] DEBUG: Processing [./bin/../lib/chef/mixin/recipe_definition_dsl_core.rb:56:in 'new']
     [Fri, 15 Jan 2020 14:17:49 -0800] DEBUG: [./bin/../lib/chef/mixin/recipe_definition_dsl_core.rb:56:in 'new'] using Chef::Provider::Breakpoint

Chef Infra Client ran the first resource before the breakpoint (``file[/tmp/before-breakpoint]``), but then stopped after execution. Chef Infra Client attempted to name the breakpoint after its position in the source file, but Chef Infra Client was confused because the resource was entered interactively. From here, chef-shell can resume the interrupted Chef Infra Client run:

.. code-block:: bash

   $ chef:recipe > chef_run.resume
     [Fri, 15 Jan 2020 14:27:08 -0800] INFO: Creating file[/tmp/after-breakpoint] at /tmp/after-breakpoint

A quick view of the ``/tmp`` directory shows that the following files were created:

.. code-block:: bash

   after-breakpoint
   before-breakpoint

You can rewind and step through a Chef Infra Client run:

.. code-block:: bash

   $ chef:recipe > Chef::Log.level = :debug # debug logging won't turn on automatically in this case
       => :debug
     chef:recipe > chef_run.rewind
       => 0
     chef:recipe > chef_run.step
     [Fri, 15 Jan 2020 14:40:52 -0800] DEBUG: Processing file[/tmp/before-breakpoint]
     [Fri, 15 Jan 2020 14:40:52 -0800] DEBUG: file[/tmp/before-breakpoint] using Chef::Provider::File
       => 1
     chef:recipe > chef_run.step
     [Fri, 15 Jan 2020 14:40:54 -0800] DEBUG: Processing [./bin/../lib/chef/mixin/recipe_definition_dsl_core.rb:56:in 'new']
     [Fri, 15 Jan 2020 14:40:54 -0800] DEBUG: [./bin/../lib/chef/mixin/recipe_definition_dsl_core.rb:56:in 'new'] using Chef::Provider::Breakpoint
       => 2
     chef:recipe > chef_run.step
     [Fri, 15 Jan 2020 14:40:56 -0800] DEBUG: Processing file[/tmp/after-breakpoint]
     [Fri, 15 Jan 2020 14:40:56 -0800] DEBUG: file[/tmp/after-breakpoint] using Chef::Provider::File
       => 3

From the output, the rewound run-list is shown, but when the resources are executed again, they will repeat their checks for the existence of files. If they exist, Chef Infra Client will skip creating them. If the files are deleted, then:

.. code-block:: bash

   $ chef:recipe > ls("/tmp").grep(/breakpoint/).each {|f| rm "/tmp/#{f}" }
       => ["after-breakpoint", "before-breakpoint"]

Rewind, and then resume your Chef Infra Client run to get the expected results:

.. code-block:: bash

   $ chef:recipe > chef_run.rewind
     chef:recipe > chef_run.resume
     [Fri, 15 Jan 2020 14:48:56 -0800] DEBUG: Processing file[/tmp/before-breakpoint]
     [Fri, 15 Jan 2020 14:48:56 -0800] DEBUG: file[/tmp/before-breakpoint] using Chef::Provider::File
     [Fri, 15 Jan 2020 14:48:56 -0800] INFO: Creating file[/tmp/before-breakpoint] at /tmp/before-breakpoint
     [Fri, 15 Jan 2020 14:48:56 -0800] DEBUG: Processing [./bin/../lib/chef/mixin/recipe_definition_dsl_core.rb:56:in 'new']
     [Fri, 15 Jan 2020 14:48:56 -0800] DEBUG: [./bin/../lib/chef/mixin/recipe_definition_dsl_core.rb:56:in 'new'] using Chef::Provider::Breakpoint
     chef:recipe > chef_run.resume
     [Fri, 15 Jan 2020 14:49:20 -0800] DEBUG: Processing file[/tmp/after-breakpoint]
     [Fri, 15 Jan 2020 14:49:20 -0800] DEBUG: file[/tmp/after-breakpoint] using Chef::Provider::File
     [Fri, 15 Jan 2020 14:49:20 -0800] INFO: Creating file[/tmp/after-breakpoint] at /tmp/after-breakpoint

.. end_tag

Debug Existing Recipe
-----------------------------------------------------
.. tag chef_shell_debug_existing_recipe

chef-shell can be used to debug existing recipes. The recipe first needs to be added to a run-list for the node, so that it is cached when starting chef-shell and then used for debugging. chef-shell will report which recipes are being cached when it is started:

.. code-block:: bash

    loading configuration: none (standalone session)
    Session type: standalone
    Loading.......done.

    This is the chef-shell.
    Chef Infra Client Version: 15.7.32
    https://chef.io
    https://docs.chef.io/

    run `help' for help, `exit' or ^D to quit.

    Ohai2u username@localhost!
    chef (15.7.32)>

To just load one recipe from the run-list, go into the recipe and use the ``include_recipe`` command. For example:

.. code-block:: bash

   $ chef > recipe_mode
     chef:recipe > include_recipe "getting-started"
       => [#<Chef::Recipe:0x10256f9e8 @cookbook_name="getting-started",
     ... output truncated ...

To load all of the recipes from a run-list, use code similar to the following:

.. code-block:: ruby

   node.run_list.expand(node.chef_environment).recipes.each do |r|
     include_recipe r
   end

After the recipes that are to be debugged have been loaded, use the ``run_chef`` command to run them.

.. end_tag

Advanced Debugging
-----------------------------------------------------
.. tag chef_shell_advanced_debug

In chef-shell, it is possible to get verbose debugging using the tracing feature in Interactive Ruby (IRb). chef-shell provides a shortcut for turning tracing on and off. For example:

.. code-block:: bash

   $ chef > tracing on
     /Users/username/.rvm/ree-1.8.7-2009.10/lib/ruby/1.8/tracer.rb:150: warning: tried to create Proc object without a block
     /Users/username/.rvm/ree-1.8.7-2009.10/lib/ruby/1.8/tracer.rb:146: warning: tried to create Proc object without a block
     tracing is on
       => nil

and:

.. code-block:: bash

   $ chef > tracing off
     #0:(irb):3:Object:-: tracing off
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:108:Shell::Extensions::ObjectCoreExtensions:>:       def off
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:109:Shell::Extensions::ObjectCoreExtensions:-:         :off
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:110:Shell::Extensions::ObjectCoreExtensions:<:       end
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:273:main:>:       def tracing(on_or_off)
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:274:main:-:         conf.use_tracer = on_or_off.on_off_to_bool
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:161:Shell::Extensions::Symbol:>:       def on_off_to_bool
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:162:Shell::Extensions::Symbol:-:         self.to_s.on_off_to_bool
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:148:Shell::Extensions::String:>:       def on_off_to_bool
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:149:Shell::Extensions::String:-:         case self
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:153:Shell::Extensions::String:-:           false
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:157:Shell::Extensions::String:<:       end
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:163:Shell::Extensions::Symbol:<:       end
     tracing is off
      => nil
     chef >

.. end_tag

debug_value
-----------------------------------------------------
Use the ``debug_value`` method to discover the location within the attribute precedence hierarchy from which a particular attribute (or sub-attribute) is set. This method is available when running chef-shell in Chef Infra Client mode:

.. code-block:: bash

   $ chef-shell -z

For example, the following attributes exist in a cookbook. Some are defined in a role file:

.. code-block:: ruby

   default_attributes 'test' => {'source' => 'role default'}
   override_attributes 'test' => {'source' => 'role override'}

And others are defined in an attributes file:

.. code-block:: ruby

   default[:test][:source]  = 'attributes default'
   set[:test][:source]      = 'attributes normal'
   override[:test][:source] = 'attributes override'

To debug the location in which the value of ``node[:test][:source]`` is set, use chef-shell and run a command similar to:

.. code-block:: none

   $ pp node.debug_value('test', 'source')

This will pretty-print return all of the attributes and sub-attributes as an array of arrays; ``:not_present`` is returned for any attribute without a value:

.. code-block:: bash

   [['set_unless_enabled?', false],
    ['default', 'attributes default'],
    ['env_default', :not_present],
    ['role_default', 'role default'],
    ['force_default', :not_present],
    ['normal', 'attributes normal'],
    ['override', 'attributes override'],
    ['role_override', 'role override'],
    ['env_override', :not_present],
    ['force_override', :not_present],
    ['automatic', :not_present]]

where

* ``set_unless_enabled`` indicates if the attribute collection is in ``set_unless`` mode; this typically returns ``false``
* Each attribute type is listed in order of precedence
* Each attribute value shown is the value that is set for that precedence level
* ``:not_present`` is shown for any attribute precedence level that has no attributes

A `blog post by Joshua Timberman <http://jtimberman.housepub.org/blog/2014/09/02/chef-node-dot-debug-value/>`_ provides another example of using this method.

ignore_failure Method
-----------------------------------------------------
All resources share a set of common actions, attributes, and so on. Use the following attribute in a resource to help identify where an issue within a recipe may be located:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Attribute
     - Description
   * - ``ignore_failure``
     - Continue running a recipe if a resource fails for any reason. Default value: ``false``.

chef-solo
-----------------------------------------------------

See `chef-solo (executable) </ctl_chef_solo.html>`__ for complete CTL documentation.

.. tag chef_solo_summary

chef-solo is a command that executes Chef Infra Client in a way that does not require the Chef Infra Server in order to converge cookbooks. chef-solo uses Chef Infra Client's `Chef local mode </ctl_chef_client.html#run-in-local-mode>`_, and **does not support** the following functionality present in Chef Infra Client / server configurations:

* Centralized distribution of cookbooks
* A centralized API that interacts with and integrates infrastructure components
* Authentication or authorization

.. note:: chef-solo can be run as a daemon.

The chef-solo executable is run as a command-line tool.

.. end_tag

See `chef-solo (executable) </ctl_chef_solo.html>`__ for complete CTL documentation.
