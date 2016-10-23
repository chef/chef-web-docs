.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. To create a machine with lock file, synchronized to the Chef server:

.. code-block:: ruby

   with_driver 'vagrant:~/.vagrant.d/boxes' do
   
     # Set machine options
     options = {
       vagrant_options: { 'vm.box' => 'opscode-ubuntu-14.04' },
       # Set all machine options to default values
       convergence_options: ChefDK::ProvisioningData.context.convergence_options
     }
   
     # Set node name to --node-name
     machine context.node_name do
       machine_options(options)
   
       # Force a Chef run every time and set action to --destroy option
       action(ChefDK::ProvisioningData.context.action)
     end
   end

and then to provision the machine, run the following:

.. code-block:: bash

   $ chef provision test123 --sync -n aar-dev

This will synchronize the Policyfile.lock.json file to the Chef server, and then run the chef-client on the node.
.. code-block:: bash

   Recipe: code_generator::cookbook
     * directory[/Users/grantmc/chefdocs] action create
       - create new directory /Users/grantmc/chefdocs
   
     * template[/Users/grantmc/chefdocs/metadata.rb] action create
       - create new file /Users/grantmc/chefdocs/metadata.rb
   
     * template[/Users/grantmc/chefdocs/README.md] action create
       - create new file /Users/grantmc/chefdocs/README.md
   
     * cookbook_file[/Users/grantmc/chefdocs/chefignore] action create
       - create new file /Users/grantmc/chefdocs/chefignore
   
     * cookbook_file[/Users/grantmc/chefdocs/Berksfile] action create
       - create new file /Users/grantmc/chefdocs/Berksfile
   
     * template[/Users/grantmc/chefdocs/.kitchen.yml] action create
       - create new file /Users/grantmc/chefdocs/.kitchen.yml
   
     * directory[/Users/grantmc/chefdocs/recipes] action create
       - create new directory /Users/grantmc/chefdocs/recipes
   
     * template[/Users/grantmc/chefdocs/recipes/default.rb] action create
       - create new file /Users/grantmc/chefdocs/recipes/default.rb
   
     * execute[initialize-git] action run
       - execute git init .
   
     * cookbook_file[/Users/grantmc/chefdocs/.gitignore] action create
       - create new file /Users/grantmc/chefdocs/.gitignore

and which creates a directory structure similar to::

   /chefdocs
     /.git
	 .gitignore
     .kitchen.yml
     Berksfile
     chefignore
     metadata.rb
     README.md
     /recipes
       default.rb
