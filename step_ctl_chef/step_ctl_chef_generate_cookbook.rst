.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To generate a cookbook, run a command similar to:

.. code-block:: bash

   $ chef generate cookbook chefdocs

will return something similar to:

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
