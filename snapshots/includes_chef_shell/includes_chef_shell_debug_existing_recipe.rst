.. The contents of this file are included in multiple topics.
.. This file describes a command or a subcommand for Knife.
.. This file should not be changed in a way that hinders its ability to appear in multiple documentation sets.

chef-shell can be used to debug existing recipes. The recipe first needs to be added to a run-list for the node, so that it is cached when starting chef-shell and then used for debugging. chef-shell will report which recipes are being cached when it is started:

.. code-block:: bash

   Loading....[Fri, 18 May 2012 11:30:08 -0700] INFO: Run List is [recipe[getting-started]]
   [Fri, 18 May 2012 11:30:08 -0700] INFO: Run List expands to [getting-started]
   [Fri, 18 May 2012 11:30:09 -0700] INFO: Loading cookbooks [getting-started]
   done.
   
   This is chef-shell, the Chef shell.
    Chef Version: 0.10.10
    http://www.opscode.com/chef
    docs.opscode.com
   
   run `help' for help, `exit' or ^D to quit.
   
   Ohai2u NODENAME!
   chef > 

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
