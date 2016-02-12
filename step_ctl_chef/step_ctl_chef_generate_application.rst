.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To generate an application, run a command similar to:

.. code-block:: bash

   $ chef generate app chef-repo
   
will return something similar to:

.. code-block:: bash

   Recipe: code_generator::app
     * directory[/Users/grantmc/chef-repo] action create
       - create new directory /Users/grantmc/chef-repo
   
     * template[/Users/grantmc/chef-repo/.kitchen.yml] action create
       - create new file /Users/grantmc/chef-repo/.kitchen.yml
   
     * template[/Users/grantmc/chef-repo/README.md] action create
       - create new file /Users/grantmc/chef-repo/README.md
   
     * directory[/Users/grantmc/chef-repo/cookbooks] action create
       - create new directory /Users/grantmc/chef-repo/cookbooks
   
     * directory[/Users/grantmc/chef-repo/cookbooks/grantmc] action create
       - create new directory /Users/grantmc/chef-repo/cookbooks/grantmc
   
     * template[/Users/grantmc/chef-repo/cookbooks/grantmc/metadata.rb] action create
       - create new file /Users/grantmc/chef-repo/cookbooks/grantmc/metadata.rb
   
     * cookbook_file[/Users/grantmc/chef-repo/cookbooks/grantmc/chefignore] action create
       - create new file /Users/grantmc/chef-repo/cookbooks/grantmc/chefignore

     * cookbook_file[/Users/grantmc/chef-repo/cookbooks/grantmc/Berksfile] action create
       - create new file /Users/grantmc/chef-repo/cookbooks/grantmc/Berksfile

     * directory[/Users/grantmc/chef-repo/cookbooks/grantmc/recipes] action create
       - create new directory /Users/grantmc/chef-repo/cookbooks/grantmc/recipes

     * template[/Users/grantmc/chef-repo/cookbooks/grantmc/recipes/default.rb] action create
       - create new file /Users/grantmc/chef-repo/cookbooks/grantmc/recipes/default.rb
   
     * execute[initialize-git] action run
       - execute git init .
   
     * cookbook_file[/Users/grantmc/chef-repo/.gitignore] action create
       - create new file /Users/grantmc/chef-repo/.gitignore

and which creates a directory structure similar to::

   /chef-repo
     /.git
	 .gitignore
	 .kitchen.yml
     /cookbooks
	   /chef-repo
	     Berksfile
		 chefignore
		 metadata.rb
		 /recipes
		   default.rb
	  README.md
