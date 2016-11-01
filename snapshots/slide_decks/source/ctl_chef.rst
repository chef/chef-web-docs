================================================
chef (the command line tool)
================================================

.. revealjs::

 .. revealjs:: chef (the command line tool) Training

  .. tag slides_core_splash

  .. Use this slide as the very first slide in every slide deck. The title of this slide (as included in the slide map file) is what identifies the training.

  .. image:: ../../images/slides_splash.png

  .. end_tag

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

  .. tag slides_ctl_chef_generate_repo_help

  Run:

  .. code-block:: bash

     $ chef generate repo --help

  Returns:

  .. code-block:: none

     Usage: chef generate repo NAME [options]

       -C, --copyright COPYRIGHT        Name of the copyright holder
       -m, --email EMAIL                Email address of the author
       -I, --license LICENSE            all_rights, apache2, mit, gplv2, gplv3
       -p, --policy-only                Create a repository for policy only, 
                                          not cookbooks
       -g GENERATOR_COOKBOOK_PATH,      Use GENERATOR_COOKBOOK_PATH for the 
                                          code_generator cookbook
          --generator-cookbook

  .. end_tag

 .. revealjs:: Go home!

  .. tag slides_core_home_directory

  Run:

  .. code-block:: bash

     $ cd ~

  .. end_tag

 .. revealjs:: Generate a chef-repo

  .. tag slides_ctl_chef_generate_repo_chef

  Run:

  .. code-block:: bash

     $ chef generate repo chef-repo

  Returns:

  .. code-block:: none

     Compiling Cookbooks...
       Recipe: code_generator::repo
         * directory[/home/chef/chef-repo] action create
           - create new directory /home/chef/chef-repo
           - restore selinux security context
         * template[/home/chef/chef-repo/LICENSE] action create
           - create new file /home/chef/chef-repo/LICENSE
           - update content in file /home/chef/chef-repo/LICENSE
             from none to dbc1af
           - restore selinux security context
         * cookbook_file[/home/chef/chef-repo/README.md] action create
           - create new file /home/chef/chef-repo/README.md
           - update content in file /home/chef/chef-repo/README.md
             from none to 767ead
           - restore selinux security context
         * cookbook_file[/home/chef/chef-repo/Rakefile] action create

  .. end_tag

 .. revealjs:: Generate a cookbook

  .. tag slides_cookbook_motd_generate_cookbook

  Run:

  .. code-block:: bash

     $ chef generate cookbook motd

  Returns:

  .. code-block:: none

     Compiling Cookbooks...
       Recipe: code_generator::cookbook
         * directory[/home/chef/chef-repo/cookbooks/motd] action create
           - create new directory /home/chef/chef-repo/cookbooks/motd
         * template[/home/chef/chef-repo/cookbooks/motd/metadata.rb]
           action create_if_missing
           - create new file /home/chef/chef-repo/cookbooks/motd/metadata.rb
           - update content in file /home/chef/chef-repo/cookbooks/motd/metadata.rb
             from none to 7852c2
         * template[/home/chef/chef-repo/cookbooks/motd/README.md]
           action create_if_missing
       ...

  .. end_tag

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

  .. tag slides_chef_repo_open_cookbooks

  Run:

  .. code-block:: bash

     $ cd ~/chef-repo/cookbooks

  .. end_tag

 .. revealjs:: Generate a cookbook named "apache"

  .. tag slides_cookbook_apache_generate_cookbook

  Run:

  .. code-block:: bash

     $ chef generate cookbook apache

  Returns:

  .. code-block:: none

     Compiling Cookbooks...
     Recipe: code_generator::cookbook
       * directory[/home/chef/chef-repo/cookbooks/apache] action create
         - create new directory /home/chef/chef-repo/cookbooks/apache
         - restore selinux security context
       * template[/home/chef/chef-repo/cookbooks/apache/metadata.rb] action
         create_if_missing
         - create new file /home/chef/chef-repo/cookbooks/apache/metadata.rb
         - update content in /home/chef/chef-repo/cookbooks/apache/metadata.rb
           from none to 4c0e2d
         - restore selinux security context
       * template[/home/chef/chef-repo/cookbooks/apache/README.md] action
         create_if_missing
         - create new file /home/chef/chef-repo/cookbooks/apache/README.md
      ...

  .. end_tag

 .. revealjs:: Recap

    * Generated a chef-repo
    * Generated a cookbook
    * Generated an Embedded Ruby (ERB) template
    * Generated a cookbook named "apache"

    * What tools can we use to test the behavior of these cookbooks and templates?
    * Where should we store this cookbook data?

 .. revealjs:: Questions

  .. tag slides_core_questions

  .. Use this slide every time the slide deck stops for Q/A sessions with attendees.

  .. image:: ../../images/slides_questions.png

  .. end_tag

 .. revealjs:: Time to Hack

   .. tag slides_core_hack

   .. Use this slide every time the slide deck stops for Q/A sessions with attendees.

   .. image:: ../../images/slides_hack.png

   .. end_tag

 .. revealjs:: More Info About the chef Command Line Tool

    For more information, see:

    * |url slides_docs_chef_io|
    * URLTBD
