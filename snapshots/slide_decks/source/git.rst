================================================
git
================================================


.. revealjs::

 .. revealjs:: git Training

  .. include:: ../../includes_slides/includes_slides_core_splash.rst

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

  .. include:: ../../includes_slides/includes_slides_ctl_chef_generate_repo_chef.rst

 .. revealjs:: Commit the chef-repo to git

  .. include:: ../../includes_slides/includes_slides_github_commit_chef_repo.rst

 .. revealjs:: Commit the chef-repo to git

  .. include:: ../../includes_slides/includes_slides_github_commit_chef_repo_git_init.rst

 .. revealjs:: Commit the chef-repo to git

  .. include:: ../../includes_slides/includes_slides_github_commit_chef_repo_git_add.rst

 .. revealjs:: Commit the chef-repo to git

  .. include:: ../../includes_slides/includes_slides_github_commit_chef_repo_git_commit.rst

 .. revealjs:: Create a cookbook in the chef-repo

  .. include:: ../../includes_slides/includes_slides_cookbook_motd_generate_cookbook.rst

 .. revealjs:: Commit the cookbook to git

  .. include:: ../../includes_slides/includes_slides_github_commit_chef_repo_git_add.rst

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

  .. include:: ../../includes_slides/includes_slides_core_questions.rst

 .. revealjs:: More Info About git

    For more information, see:

    * |url slides_docs_chef_io|
