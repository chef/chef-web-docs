================================================
chef-repo
================================================

.. revealjs::

 .. revealjs:: chef-repo Training

  .. tag slides_core_splash

  .. Use this slide as the very first slide in every slide deck. The title of this slide (as included in the slide map file) is what identifies the training.

  .. image:: ../../images/slides_splash.png

  .. end_tag

 .. revealjs:: About the chef-repo

  .. tag chef_repo_26

  The chef-repo is the repository structure in which cookbooks are authored, tested, and maintained:

  * Cookbooks contain recipes, attributes, custom resources, libraries, definitions, files, templates, tests, and metadata
  * The chef-repo should be synchronized with a version control system (such as git), and then managed as if it were source code

  .. end_tag

 .. revealjs:: Objectives

    * Generate the chef-repo
    * Commit the chef-repo to git

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

 .. revealjs:: Create a chef-repo

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

 .. revealjs:: Commit this chef-repo to git

  .. tag slides_github_commit_chef_repo

  Run:

  .. code-block:: bash

     $ cd chef-repo

  .. end_tag

 .. revealjs:: Commit this chef-repo to git

  .. tag slides_github_commit_chef_repo_git_init

  Run:

  .. code-block:: bash

     $ git init

  Returns:

  .. code-block:: none

     Initialized empty Git repository in /home/chef/chef-repo/.git/

  .. end_tag

 .. revealjs:: Commit this chef-repo to git

  .. tag slides_github_commit_chef_repo_git_add

  Run:

  .. code-block:: bash

     $ git add .

  .. end_tag

 .. revealjs:: Commit this chef-repo to git

  .. tag slides_github_commit_chef_repo_git_commit

  Run:

  .. code-block:: bash

     $ git commit -m "Initial chef-repo"

  Returns:

  .. code-block:: none

     [master (root-commit) 6774a70] Initial chef repo
     11 files changed, 388 insertions(+), 0 deletions(-)
     create mode 100644 .gitignore
     create mode 100644 LICENSE
     create mode 100644 README.md
     create mode 100644 Rakefile
     create mode 100644 certificates/README.md
     create mode 100644 chefignore
     create mode 100644 config/rake.rb
     create mode 100644 cookbooks/README.md
     create mode 100644 data_bags/README.md
     create mode 100644 environments/README.md
     create mode 100644 roles/README.md

  .. end_tag

 .. revealjs:: Recap

    * Generated the chef-repo
    * Committed the chef-repo to git

 .. revealjs:: Questions

  .. tag slides_core_questions

  .. Use this slide every time the slide deck stops for Q/A sessions with attendees.

  .. image:: ../../images/slides_questions.png

  .. end_tag

 .. revealjs:: More Info About the chef-repo

    For more information, see:

    * |url slides_docs_chef_io|
