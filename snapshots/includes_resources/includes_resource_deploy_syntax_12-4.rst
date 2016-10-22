.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **deploy** resource block manages and controls deployments:

.. code-block:: ruby

   deploy 'private_repo' do
     repo 'git@github.com:acctname/private-repo.git'
     user 'ubuntu'
     deploy_to '/tmp/private_code'
     ssh_wrapper '/tmp/private_code/wrap-ssh4git.sh'
     action :deploy
   end

For example, an application that is deployed to a folder named ``"/path/to/application"``:

.. code-block:: ruby

   deploy_revision "/path/to/application" do
     repo 'ssh://name-of-git-repo/repos/repo.git'
     migrate false
     purge_before_symlink %w{one two folder/three}
     create_dirs_before_symlink []
     symlinks{
       "one"   => "one",
       "two"   => "two",
       "three" => "folder/three"
     }
     before_restart do
       # some Ruby code
     end
     notifies :restart, "service[foo]"
     notifies :restart, "service[bar]"
   end

For the example shown above:

* Because an action is not explicitly specified, the chef-client will use the default action: ``:deploy``
* The ``purge_before_symlink`` application layout is an array of paths that will be cleared before the ``symlinks`` property is run
* The ``create_dirs_before_symlink`` property is empty, which is different from the default
* The ``symlinks`` property is creating three symbolic links
* The ``before_restart`` callback is being used to add custom actions that will occur at the end of the deployment process, but before any services have been notified
* At the end, the recipe is using the ``notifies`` property---a common attribute available to all resources---to alert two services (named "foo" and "bar") that they should restart.

The full syntax for all of the properties that are available to the **deploy** when used with git is:

.. code-block:: ruby

   deploy 'name' do
     after_restart              Proc, String
     before_migrate             Proc, String
     before_restart             Proc, String
     before_symlink             Proc, String
     branch                     String
     create_dirs_before_symlink Array
     deploy_to                  String # defaults to 'name' if not specified
     enable_submodules          TrueClass, FalseClass
     environment                Hash
     git_ssh_wrapper            String
     group                      String
     keep_releases              Integer
     migrate                    TrueClass, FalseClass
     migration_command          String
     notifies                   # see description
     provider                   Chef::Provider::Deploy
     purge_before_symlink       Array
     remote                     String
     repo                       String
     repository                 String
     repository_cache           String
     restart_command            Proc, String
     revision                   String
     rollback_on_error          TrueClass, FalseClass
     scm_provider               Chef::Provider::Git
     shallow_clone              TrueClass, FalseClass
     ssh_wrapper                String
     symlinks                   Hash
     symlink_before_migrate     Hash
     timeout                    Integer
     user                       String
     action                     Symbol # defaults to :create if not specified
   end

and the full syntax for all of the properties that are available to the **deploy** when used with Subversion is:

.. code-block:: ruby

   deploy 'name' do
     after_restart              Proc, String
     before_migrate             Proc, String
     before_restart             Proc, String
     before_symlink             Proc, String
     branch                     String
     create_dirs_before_symlink Array
     deploy_to                  String # defaults to 'name' if not specified
     environment                Hash
     group                      String
     keep_releases              Integer
     migrate                    TrueClass, FalseClass
     migration_command          String
     notifies                   # see description
     provider                   Chef::Provider::Deploy
     purge_before_symlink       Array
     repo                       String
     repository                 String
     repository_cache           String
     restart_command            Proc, String
     revision                   String
     rollback_on_error          TrueClass, FalseClass
     scm_provider               Chef::Provider::Subversion
     subscribes                 # see description
     svn_arguments              String
     svn_password               String
     svn_username               String
     symlinks                   Hash
     symlink_before_migrate     Hash
     timeout                    Integer
     user                       String
     action                     Symbol # defaults to :create if not specified
   end

where 

* ``deploy`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``after_restart``, ``before_migrate``, ``before_restart``, ``before_symlink``, ``branch``, ``create_dirs_before_symlink``, ``deploy_to``, ``enable_submodules``, ``environment``, ``git_ssh_wrapper``, ``group``, ``keep_releases``, ``migrate``, ``migration_command``, ``provider``, ``purge_before_symlink``, ``remote``, ``repo``, ``repository``, ``repository_cache``, ``restart_command``, ``revision``, ``rollback_on_error``, ``scm_provider``, ``shallow_clone``, ``ssh_wrapper``, ``svn_arguments``, ``svn_password``, ``svn_username``, ``symlinks``, ``symlink_before_migrate``, ``timeout``, and ``user`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
