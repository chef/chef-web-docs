================================================
git
================================================

.. revealjs::

 .. revealjs:: git Training

  .. tag slides_core_splash

  .. Use this slide as the very first slide in every slide deck. The title of this slide (as included in the slide map file) is what identifies the training.

  .. image:: ../../images/slides_splash.png

  .. end_tag

 .. revealjs:: About git

  * Managing infrastructure as code means storing that code in a version control system
  * Any version control system will do but ...
  * The Chef community prefers and recommends git
  * Many tools support git by default

 .. revealjs:: Objectives

    * Install git
    * Create a chef-repo
    * Commit the chef-repo to git
    * Create a cookbook in the chef-repo
    * Commit the cookbook to git
    * One repository or many repositories?

 .. revealjs:: Install git

  * The ``git`` package should be installed
  * The file named ``'/home/chef/.gitconfig'`` should be created
  * It should be owned by the ``chef`` user and group
  * It should have content similar to:

    .. code-block:: bash

       [user]\n  name=John Doe\n  email=jdoe@example\n

 .. revealjs:: Install git

  #. Open ``~/git.rb``.
  #. Add:

     .. code-block:: ruby

        package 'git' do
          action :install
        end

        file '/home/chef/.gitconfig' do
          content '[user]\n  name=John Doe\n  email=jdoe@example\n'
          user 'chef'
          group 'chef'
        end

  #. Save the file.

 .. revealjs:: Install git

  Run:

  .. code-block:: bash

     $ sudo chef-apply ~/git.rb

  Returns:

  .. code-block:: none

     Recipe: (chef-apply cookbook)::(chef-apply recipe)
       * package[git] action install
         - install version 1.7.1-3.el6_4.1 of package git
       * file[/home/chef/.gitconfig] action create
         - create new file /home/chef/.gitconfig
         - update content in file /home/chef/.gitconfig from none to 259950
           --- /home/chef/.gitconfig
           +++ /tmp/..gitconfig20140924-10180-1ij68vq 
           @@ -1 +1,4 @@
           +[user]
           +  name=John Doe
           +  email=jdoe@example.com
         - change owner from '' to 'chef'
         - change group from '' to 'chef'
         - restore selinux security context

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

 .. revealjs:: Commit the chef-repo to git

  .. tag slides_github_commit_chef_repo

  Run:

  .. code-block:: bash

     $ cd chef-repo

  .. end_tag

 .. revealjs:: Commit the chef-repo to git

  .. tag slides_github_commit_chef_repo_git_init

  Run:

  .. code-block:: bash

     $ git init

  Returns:

  .. code-block:: none

     Initialized empty Git repository in /home/chef/chef-repo/.git/

  .. end_tag

 .. revealjs:: Commit the chef-repo to git

  .. tag slides_github_commit_chef_repo_git_add

  Run:

  .. code-block:: bash

     $ git add .

  .. end_tag

 .. revealjs:: Commit the chef-repo to git

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

 .. revealjs:: Create a cookbook in the chef-repo

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

 .. revealjs:: Commit the cookbook to git

  .. tag slides_github_commit_chef_repo_git_add

  Run:

  .. code-block:: bash

     $ git add .

  .. end_tag

 .. revealjs:: Commit the cookbook to git

  Run:

  .. code-block:: bash

     $ git commit -m "initial motd cookbook"

  Returns:

  .. code-block:: none

     [master (root-commit) af2b629] initial apache recipe, does nothing
     6 files changed, 144 insertions(+), 0 deletions(-)
     create mode 100644 .kitchen.yml
     create mode 100644 Berksfile
     create mode 100644 README.md
     create mode 100644 chefignore
     create mode 100644 metadata.rb
     create mode 100644 recipes/default.rb

 .. revealjs:: One chef-repo? Or many chef-repos?

  Once you have more than one cookbook, you may ask yourself this question: "How many repositories do I need?"

  The answer is easy: "It depends!"

  The most common choices:

  * A single chef-repo that contains all cookbooks
  * Many repositories, with a dedicated chef-repo for each cookbook

 .. revealjs:: One chef-repo

  * All related source code is tracked in one source code repository
  * External dependencies are made with built-in vendor branches

 .. revealjs:: Many chef-repos

  * All cookbooks are treated as independent software projects
  * External dependencies are fetched as needed
  * Treated as artifacts

 .. revealjs:: Recap

    * Installed git
    * Created a chef-repo
    * Committed the chef-repo to git
    * Created a cookbook in the chef-repo
    * Committed the cookbook to git

 .. revealjs:: Questions

  .. tag slides_core_questions

  .. Use this slide every time the slide deck stops for Q/A sessions with attendees.

  .. image:: ../../images/slides_questions.png

  .. end_tag

 .. revealjs:: More Info About git

    For more information, see:

    * |url slides_docs_chef_io|
