================================================
chef (the command line tool)
================================================


.. revealjs::

 .. revealjs:: chef (the command line tool) Training

  .. include:: ../../includes_slides/includes_slides_core_splash.rst

 .. revealjs:: About chef (the command line tool)

   ``chef`` is an executable command line tool. Use it to:
   
   * Generate cookbooks, recipes, and other things that make up your Chef code
   * Ensure RubyGems are downloaded properly for your development environment
   * Verify that all components are installed and configured correctly
   
   ``chef`` is included with the Chef development kit.

 .. revealjs:: Objectives

    * Generate a chef-repo
    * Generate a cookbook
    * Generate an Embedded Ruby (ERB) template
    * Generate a cookbook named "apache"

 .. revealjs:: What can the chef command generate?

  Run:
  
  .. code-block:: bash
  
     $ chef generate --help
  
  Returns:
  
  .. code-block:: none
  
     Usage: chef generate GENERATOR [options]
     
     Available generators:
       app        Generate an application repo
       cookbook   Generate a single cookbook
       recipe     Generate a new recipe
       attribute  Generate an attributes file
       template   Generate a file template
       file       Generate a cookbook file
       lwrp       Generate a lightweight resource/provider
       repo       Generate a Chef policy repository

 .. revealjs:: How do we generate a repo?

  .. include:: ../../includes_slides/includes_slides_ctl_chef_generate_repo_help.rst

 .. revealjs:: Go home!

  .. include:: ../../includes_slides/includes_slides_core_home_directory.rst

 .. revealjs:: Generate a chef-repo

  .. include:: ../../includes_slides/includes_slides_ctl_chef_generate_repo_chef.rst

 .. revealjs:: Generate a cookbook

  .. include:: ../../includes_slides/includes_slides_cookbook_motd_generate_cookbook.rst

 .. revealjs:: Generate an ERB template

  Run:
  
  .. code-block:: bash
  
     $ chef generate template --help
  
  Returns:
  
  .. code-block:: none
  
     Usage: chef generate template [path/to/cookbook] NAME [options]
       -C, --copyright COPYRIGHT        Name of the copyright holder - defaults to 'The Authors'
       -m, --email EMAIL                Email address of the author - defaults to 'you@example.com'
       -I, --license LICENSE            all_rights, apache2, mit, gplv2, gplv3 - defaults to all_rights
       -s, --source SOURCE_FILE         Copy content from SOURCE_FILE
       -g GENERATOR_COOKBOOK_PATH,      Use GENERATOR_COOKBOOK_PATH for the code_generator cookbook
          --generator-cookbook

 .. revealjs:: Go to the motd cookbook directory

  Run:
  
  .. code-block:: bash
  
     $ cd ~/chef-repo/cookbooks/motd

 .. revealjs:: Generate the ERB template

  Run:
  
  .. code-block:: bash
  
     $ chef generate template . motd -s /etc/motd
  
  Returns:
  
  .. code-block:: none
  
     Compiling Cookbooks...
       Recipe: code_generator::template
       * directory[././templates/default] action create
         - create new directory ././templates/default
       * file[././templates/default/motd.erb] action create
         - create new file ././templates/default/motd.erb
         - update content in file ././templates/default/motd.erb 
           from none to 315f5b

 .. revealjs:: Generate the ERB template

  #. Open ``~/chef-repo/cookbooks/motd/templates/default/motd.erb``.
  #. Add:
  
     .. code-block:: ruby
     
        Property of COMPANY NAME
  
  #. Save the file.

 .. revealjs:: Verify the ERB template

  * chef-apply does not understand cookbooks, only resources and recipes
  * We cannot use chef-apply to apply the policy stored in our motd cookbook
  

 .. revealjs:: Generate a cookbook named "apache"

  .. include:: ../../includes_slides/includes_slides_chef_repo_open_cookbooks.rst

 .. revealjs:: Generate a cookbook named "apache"

  .. include:: ../../includes_slides/includes_slides_cookbook_apache_generate_cookbook.rst

 .. revealjs:: Recap

    * Generated a chef-repo
    * Generated a cookbook
    * Generated an Embedded Ruby (ERB) template
    * Generated a cookbook named "apache"

    * What tools can we use to test the behavior of these cookbooks and templates?
    * Where should we store this cookbook data?

 .. revealjs:: Questions

  .. include:: ../../includes_slides/includes_slides_core_questions.rst

 .. revealjs:: Time to Hack

   .. include:: ../../includes_slides/includes_slides_core_hack.rst

 .. revealjs:: More Info About the chef Command Line Tool

    For more information, see:

    * |url slides_docs_chef_io|
    * URLTBD
