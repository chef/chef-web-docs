.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``after_restart``
   **Ruby Types:** Proc, String

   A block of code, or a path to a file that contains code, that is run after restarting. Default value: ``deploy/after_restart.rb``.

``before_migrate``
   **Ruby Types:** Proc, String

   A block of code, or a path to a file that contains code, that is run before a migration. Default value: ``deploy/before_migrate.rb``.

``before_restart``
   **Ruby Types:** Proc, String

   A block of code, or a path to a file that contains code, that is run before restarting. Default value: ``deploy/before_restart.rb``.

``before_symlink``
   **Ruby Types:** Proc, String

   A block of code, or a path to a file that contains code, that is run before symbolic linking. Default value: ``deploy/before_symlink.rb``.

``branch``
   **Ruby Type:** String

   The alias for the revision.

``create_dirs_before_symlink``
   **Ruby Type:** Array

   Create directories in the release directory before symbolic links are created. This property runs after ``purge_before_symlink`` and before ``symlink``. Default value: ``%w{tmp public config}`` (or the same as ``["tmp", "public", "config"]``).

``deploy_to``
   **Ruby Type:** String

   The "meta root" for the application, if different from the path that is used to specify the name of a resource. Default value: the ``name`` of the resource block See "Syntax" section above for more information.

``environment``
   **Ruby Type:** Hash

   A Hash of environment variables in the form of ``({"ENV_VARIABLE" => "VALUE"})``. (These variables must exist for a command to be run successfully.)

``group``
   **Ruby Type:** String

   The system group that is responsible for the checked-out code.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``keep_releases``
   **Ruby Type:** Integer

   The number of releases for which a backup is kept. Default value: ``5``.

``migrate``
   **Ruby Types:** TrueClass, FalseClass

   Run a migration command. Default value: ``false``.

``migration_command``
   **Ruby Type:** String

   A string that contains a shell command that can be executed to run a migration operation.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst

``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider. See "Providers" section below for more information.

``purge_before_symlink``
   **Ruby Type:** Array

   An array of directories (relative to the application root) to be removed from a checkout before symbolic links are created. This attribute runs before ``create_dirs_before_symlink`` and before ``symlink``. Default value: ``%w{log tmp/pids public/system}`` (or the same as ``["log", "tmp/pids", "public/system"]``.

``repo``
   **Ruby Type:** String

   The alias for the repository.

``repository``
   **Ruby Type:** String

   The URI for the repository.

``repository_cache``
   **Ruby Type:** String

   The name of the sub-directory in which the pristine copy of an application's source is kept. Default value: ``cached-copy``.

``restart_command``
   **Ruby Types:** String, Proc

   A string that contains a shell command that can be executed to run a restart operation.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``revision``
   **Ruby Type:** String

   A branch, tag, or commit to be synchronized with git. This can be symbolic, like ``HEAD`` or it can be a source control management-specific revision identifier. Default value: ``HEAD``.

``rollback_on_error``
   **Ruby Types:** TrueClass, FalseClass

   Roll a resource back to a previously-deployed release if an error occurs when deploying a new release. Default value: ``false``.

``scm_provider``
   **Ruby Type:** Chef Class

   The name of the source control management provider. Default value: ``Chef::Provider::Git``. Optional values: ``Chef::Provider::Subversion``.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst

``symlinks``
   **Ruby Type:** Hash

   Map files in a shared directory to their paths in the current release directory. This property runs after ``create_dirs_before_symlink`` and ``purge_before_symlink``. Default value: ``{"system" => "public/system", "pids" => "tmp/pids", "log" => "log"}``.

``symlink_before_migrate``
   **Ruby Type:** Hash

   Map files in a shared directory to the current release directory. The symbolic links for these files are created before any migration is run. Use parentheses ``( )`` around curly braces ``{ }`` to ensure the contents within the curly braces are interpreted as a block and not as an empty Hash. Set to ``symlink_before_migrate({})`` to prevent the creation of symbolic links. Default value: ``{"config/database.yml" => "config/database.yml"}``.

``user``
   **Ruby Type:** String

   The system user that is responsible for the checked-out code.

The following properties are for use with git only:

``enable_submodules``
   **Ruby Types:** TrueClass, FalseClass

   Perform a sub-module initialization and update. Default value: ``false``.

``git_ssh_wrapper``
   **Ruby Type:** String

   The alias for the ``ssh_wrapper``.

``remote``
   **Ruby Type:** String

   The remote repository to use when synchronizing an existing clone. Default value: ``origin``.

``shallow_clone``
   **Ruby Types:** TrueClass, FalseClass

   Set the clone depth to ``5``. Default value: ``false``.

``ssh_wrapper``
   **Ruby Type:** String

   The path to the wrapper script used when running SSH with git. The ``GIT_SSH`` environment variable is set to this.

The following properties are for use with Subversion only:

``svn_arguments``
   **Ruby Type:** String

   The extra arguments that are passed to the Subversion command.

``svn_password``
   **Ruby Type:** String

   The password for a user that has access to the Subversion repository.

``svn_username``
   **Ruby Type:** String

   The user name for a user that has access to the Subversion repository.
