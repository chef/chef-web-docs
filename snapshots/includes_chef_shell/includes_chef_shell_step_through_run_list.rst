.. The contents of this file are included in multiple topics.
.. This file describes a command or a subcommand for Knife.
.. This file should not be changed in a way that hinders its ability to appear in multiple documentation sets.

To explore how using the **breakpoint** to manually step through a chef-client run, create a simple recipe in chef-shell:

.. code-block:: bash

   $ chef > recipe_mode
     chef:recipe > echo off
     chef:recipe > file "/tmp/before-breakpoint"
     chef:recipe > breakpoint "foo"
     chef:recipe > file "/tmp/after-breakpoint"

and then run the chef-client:

.. code-block:: bash

   $ chef:recipe > run_chef
     [Fri, 15 Jan 2010 14:17:49 -0800] DEBUG: Processing file[/tmp/before-breakpoint]
     [Fri, 15 Jan 2010 14:17:49 -0800] DEBUG: file[/tmp/before-breakpoint] using Chef::Provider::File
     [Fri, 15 Jan 2010 14:17:49 -0800] INFO: Creating file[/tmp/before-breakpoint] at /tmp/before-breakpoint
     [Fri, 15 Jan 2010 14:17:49 -0800] DEBUG: Processing [./bin/../lib/chef/mixin/recipe_definition_dsl_core.rb:56:in 'new']
     [Fri, 15 Jan 2010 14:17:49 -0800] DEBUG: [./bin/../lib/chef/mixin/recipe_definition_dsl_core.rb:56:in 'new'] using Chef::Provider::Breakpoint

The chef-client ran the first resource before the breakpoint (``file[/tmp/before-breakpoint]``), but then stopped after execution. The chef-client attempted to name the breakpoint after its position in the source file, but the chef-client was confused because the resource was entered interactively. From here, chef-shell can resume the chef-client run:

.. code-block:: bash

   $ chef:recipe > chef_run.resume
     [Fri, 15 Jan 2010 14:27:08 -0800] INFO: Creating file[/tmp/after-breakpoint] at /tmp/after-breakpoint

A quick view of the ``/tmp`` directory shows that the following files were created:

.. code-block:: bash

   after-breakpoint
   before-breakpoint

The chef-client run can also be rewound, and then stepped through.

.. code-block:: bash

   $ chef:recipe > Chef::Log.level = :debug # debug logging won't turn on automatically in this case
       => :debug 
     chef:recipe > chef_run.rewind
       => 0
     chef:recipe > chef_run.step
     [Fri, 15 Jan 2010 14:40:52 -0800] DEBUG: Processing file[/tmp/before-breakpoint]
     [Fri, 15 Jan 2010 14:40:52 -0800] DEBUG: file[/tmp/before-breakpoint] using Chef::Provider::File
       => 1
     chef:recipe > chef_run.step
     [Fri, 15 Jan 2010 14:40:54 -0800] DEBUG: Processing [./bin/../lib/chef/mixin/recipe_definition_dsl_core.rb:56:in 'new']
     [Fri, 15 Jan 2010 14:40:54 -0800] DEBUG: [./bin/../lib/chef/mixin/recipe_definition_dsl_core.rb:56:in 'new'] using Chef::Provider::Breakpoint
       => 2
     chef:recipe > chef_run.step
     [Fri, 15 Jan 2010 14:40:56 -0800] DEBUG: Processing file[/tmp/after-breakpoint]
     [Fri, 15 Jan 2010 14:40:56 -0800] DEBUG: file[/tmp/after-breakpoint] using Chef::Provider::File
       => 3

From the output, the rewound run-list is shown, but when the resources are executed again, they will repeat their checks for the existence of files. If they exist, the chef-client will skip creating them. If the files are deleted, then:

.. code-block:: bash

   $ chef:recipe > ls("/tmp").grep(/breakpoint/).each {|f| rm "/tmp/#{f}" }
       => ["after-breakpoint", "before-breakpoint"]

Rewind, and then resume the chef-client run to get the expected results: 

.. code-block:: bash

   $ chef:recipe > chef_run.rewind
     chef:recipe > chef_run.resume
     [Fri, 15 Jan 2010 14:48:56 -0800] DEBUG: Processing file[/tmp/before-breakpoint]
     [Fri, 15 Jan 2010 14:48:56 -0800] DEBUG: file[/tmp/before-breakpoint] using Chef::Provider::File
     [Fri, 15 Jan 2010 14:48:56 -0800] INFO: Creating file[/tmp/before-breakpoint] at /tmp/before-breakpoint
     [Fri, 15 Jan 2010 14:48:56 -0800] DEBUG: Processing [./bin/../lib/chef/mixin/recipe_definition_dsl_core.rb:56:in 'new']
     [Fri, 15 Jan 2010 14:48:56 -0800] DEBUG: [./bin/../lib/chef/mixin/recipe_definition_dsl_core.rb:56:in 'new'] using Chef::Provider::Breakpoint
     chef:recipe > chef_run.resume
     [Fri, 15 Jan 2010 14:49:20 -0800] DEBUG: Processing file[/tmp/after-breakpoint]
     [Fri, 15 Jan 2010 14:49:20 -0800] DEBUG: file[/tmp/after-breakpoint] using Chef::Provider::File
     [Fri, 15 Jan 2010 14:49:20 -0800] INFO: Creating file[/tmp/after-breakpoint] at /tmp/after-breakpoint
