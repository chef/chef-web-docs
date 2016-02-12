.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If a custom skeleton cookbook is located on a |mac os x| desktop (and in this example, the ``chef_generator`` cookbook is simply a copy of the same cookbook that ships in the |chef dk|), the following command will use the skeleton cookbook at the custom location to generate a cookbook into the repository from which the ``chef`` command is run:

.. code-block:: bash

   $ chef generate cookbook --generator-cookbook ~/Desktop testcookbook

.. note:: The ``code_generator`` cookbook itself is not specified as part of the path.

will return something similar to:

.. code-block:: bash

   Compiling Cookbooks...
   Recipe: code_generator::cookbook
     * directory[/Users/grantmc/Desktop/chef-repo/test-cookbook] action create
       - create new directory /Users/grantmc/Desktop/chef-repo/test-cookbook
	   
     * template[/Users/grantmc/Desktop/chef-repo/test-cookbook/metadata.rb] action create
       - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/metadata.rb
	   
     * template[/Users/grantmc/Desktop/chef-repo/test-cookbook/README.md] action create
       - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/README.md

     * cookbook_file[/Users/grantmc/Desktop/chef-repo/test-cookbook/chefignore] action create
       - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/chefignore

     * cookbook_file[/Users/grantmc/Desktop/chef-repo/test-cookbook/Berksfile] action create
       - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/Berksfile

     * template[/Users/grantmc/Desktop/chef-repo/test-cookbook/.kitchen.yml] action create
       - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/.kitchen.yml
	   
     * directory[/Users/grantmc/Desktop/chef-repo/test-cookbook/recipes] action create
       - create new directory /Users/grantmc/Desktop/chef-repo/test-cookbook/recipes
	   
     * template[/Users/grantmc/Desktop/chef-repo/test-cookbook/recipes/default.rb] action create
       - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/recipes/default.rb
