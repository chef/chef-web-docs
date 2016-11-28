

=====================================================
knife.rb Optional Settings
=====================================================

.. tag knife_using_knife_rb

In addition to the default settings in a knife.rb file, there are other subcommand-specific settings that can be added. When a subcommand is run, knife will use:

#. A value passed via the command-line
#. A value contained in the knife.rb file
#. The default value

A value passed via the command line will override a value in the knife.rb file; a value in a knife.rb file will override a default value.

.. end_tag

.. warning:: .. tag notes_knife_most_config_settings_should_not_be_used

             Many optional settings should not be added to the knife.rb file. The reasons for not adding them can vary. For example, using ``--yes`` as a default in the knife.rb file will cause knife to always assume that "Y" is the response to any prompt, which may lead to undesirable outcomes. Other settings, such as ``--hide-healthy`` (used only with the ``knife status`` subcommand) or ``--bare-directories`` (used only with the ``knife list`` subcommand) probably aren't used often enough (and in the same exact way) to justify adding them to the knife.rb file. In general, if the optional settings are not listed on :doc:`the main knife.rb topic <config_rb_knife>`, then add settings only after careful consideration. Do not use optional settings in a production environment until after the setting's performance has been validated in a safe testing environment.

             .. end_tag

The following list describes all of the optional settings that can be added to the knife.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``knife[:admin]``
     - Create a client as an admin client. This is required for any user to access Open Source Chef as an administrator.
   * - ``knife[:after]``
     - Add a run-list item after the specified run-list item.
   * - ``knife[:all]``
     - Indicates that all environments, cookbooks, cookbook versions, metadata, and/or data bags will be uploaded, deleted, generated, or tested. The context depends on which knife subcommand and argument is used.
   * - ``knife[:all_versions]``
     - Return all available versions for every cookbook.
   * - ``knife[:admin]``
     - Create a client as an admin client. This is required for any user to access Open Source Chef as an administrator. (This setting is available only for the open source Chef server.)
   * - ``knife[:admin_client_name]``
     - 
   * - ``knife[:bare_directories]``
     - Prevent a directory's children from showing when a directory matches a pattern.
   * - ``knife[:bootstrap_proxy]``
     - The proxy server for the node that is the target of a bootstrap operation.
   * - ``knife[:bootstrap_version]``
     - The version of the chef-client to install.
   * - ``knife[:bootstrap_template]``
     - 
   * - ``knife[:chef_repo_path]``
     - The path to the chef-repo.
   * - ``knife[:concurrency]``
     - The number of allowed concurrent connections.
   * - ``knife[:config_file]``
     - The configuration file to use.
   * - ``knife[:depends]``
     - Ensure that when a cookbook has a dependency on one (or more) cookbooks, those cookbooks are also uploaded.
   * - ``knife[:description]``
     - The description for an environment and/or a role.
   * - ``knife[:disable_editing]``
     - Prevent the $EDITOR from being opened and accept data as-is.
   * - ``knife[:distro]``
     - .. tag knife_bootstrap_distro

       The template file to be used during a bootstrap operation. The following distributions are supported:

       * ``chef-full`` (the default bootstrap)
       * ``centos5-gems``
       * ``fedora13-gems``
       * ``ubuntu10.04-gems``
       * ``ubuntu10.04-apt``
       * ``ubuntu12.04-gems``
       * The name of a custom bootstrap template file.

       When this option is used, knife searches for the template file in the following order:

       #. The ``bootstrap/`` folder in the current working directory
       #. The ``bootstrap/`` folder in the chef-repo
       #. The ``bootstrap/`` folder in the ``~/.chef/`` directory
       #. A default bootstrap file.

       Do not use the ``--template-file`` option when ``--distro`` is specified.

       .. end_tag

   * - ``knife[:download_directory]``
     - The directory in which cookbooks are located.
   * - ``knife[:editor]``
     - The $EDITOR that is used for all interactive commands.
   * - ``knife[:environment]``
     - The name of the environment.
   * - ``knife[:exec]``
     - A string of code that to be executed.
   * - ``knife[:file]``
     - Save a private key to the specified file name.
   * - ``knife[:force]``
     - Overwrite an existing directory.
   * - ``knife[:fqdn]``
     - FQDN
   * - ``knife[:freeze]``
     - Require changes to a cookbook be included as a new version. Only the ``--force`` option can override this setting.
   * - ``knife[:forward_agent]``
     - Enable SSH agent forwarding.
   * - ``knife[:hide_healthy]``
     - Hide nodes on which a chef-client run has occurred within the previous hour.
   * - ``knife[:host_key_verify]``
     - Use ``--no-host-key-verify`` to disable host key verification.
   * - ``knife[:identity_file]``
     - The SSH identity file used for authentication. Key-based authentication is recommended.
   * - ``knife[:initial]``
     - Create a API client, typically an administrator client on a freshly-installed Chef server.
   * - ``knife[:input]``
     - The name of a file to be used with the ``PUT`` or a ``POST`` request.
   * - ``knife[:latest]``
     - Download the most recent version of a cookbook.
   * - ``knife[:manual]``
     - Define a search query as a space-separated list of servers.
   * - ``knife[:method]``
     - The request method: ``DELETE``, ``GET``, ``POST``, or ``PUT``.
   * - ``knife[:name_only]``
     - Show only the names of modified files.
   * - ``knife[:name_status]``
     - Show only the names of files with a status of ``Added``, ``Deleted``, ``Modified``, or ``Type Changed``.
   * - ``knife[:no_deps]``
     - Ensure that all cookbooks to which the installed cookbook has a dependency are not installed.
   * - ``knife[:platform]``
     - The platform for which a cookbook is designed.
   * - ``knife[:platform_version]``
     - The version of the platform.
   * - ``knife[:pretty]``
     - Use ``--no-pretty`` to disable pretty-print output for JSON.
   * - ``knife[:print_after]``
     - Show data after a destructive operation.
   * - ``knife[:purge]``
     - Entirely remove a cookbook (or cookbook version) from the Chef server. Use this action carefully because only one copy of any single file is stored on the Chef server. Consequently, purging a cookbook disables any other cookbook that references one or more files from the cookbook that has been purged.
   * - ``knife[:readme_format]``
     - The document format of the readme file: ``md`` (markdown) and ``rdoc`` (Ruby docs).
   * - ``knife[:recurse]``
     - Use to recursively delete, disable, or list a directory.
   * - ``knife[:repo_mode]``
     - The layout of the local chef-repo. Possible values: ``static``, ``everything``, or ``hosted_everything``. Use ``static`` for just roles, environments, cookbooks, and data bags. By default, ``everything`` and ``hosted_everything`` are dynamically selected depending on the server type.
   * - ``knife[:repository]``
     - The path to the chef-repo.
   * - ``knife[:run_list]``
     - A comma-separated list of roles and/or recipes to be applied.
   * - ``knife[:script_path]``
     - A colon-separated path at which Ruby scripts are located.
   * - ``knife[:secret]``
     - The encryption key that is used for values contained within a data bag item.
   * - ``knife[:secret_file]``
     - The path to the file that contains the encryption key.
   * - ``knife[:server_name]``
     - Same as node_name. Recommended configuration is to allow Ohai to collect this value during each chef-client run.
   * - ``knife[:sort_reverse]``
     - Sort a list by last run time, descending.
   * - ``knife[:ssh_attribute]``
     - The attribute used when opening an SSH connection.
   * - ``knife[:ssh_gateway]``
     - The SSH tunnel or gateway that is used to run a bootstrap action on a machine that is not accessible from the workstation.
   * - ``knife[:ssh_password]``
     - The SSH password. This can be used to pass the password directly on the command line. If this option is not specified (and a password is required) knife prompts for the password.
   * - ``knife[:ssh_port]``
     - The SSH port.
   * - ``knife[:ssh_user]``
     - The SSH user name.
   * - ``knife[:template_file]``
     - The path to a template file to be used during a bootstrap operation.
   * - ``knife[:use current_branch]``
     - Ensure that the current branch is used.
   * - ``knife[:use_sudo]``
     - Execute a bootstrap operation with sudo.
   * - ``knife[:user]`` and/or ``knife[:user_home]``
     - The user name used by knife to sign requests made by the API client to the Chef server. Authentication fails if the user name does not match the private key.
   * - ``knife[:user_key]``
     - Save a public key to the specified file name.
   * - ``knife[:user_password]``
     - The user password.
   * - ``knife[:yes]``
     - Respond to all confirmation prompts with "Yes".
