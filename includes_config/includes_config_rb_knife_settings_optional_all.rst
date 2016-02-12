.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. warning:: Many optional settings should not be added to the |knife rb| file. The reasons for not adding them can vary. For example, using ``--yes`` as a default in the |knife rb| file will cause |knife| to always assume that "Y" is the response to any prompt, which may lead to undesirable outcomes. Other settings, such as ``--hide-healthy`` (used only with the ``knife status`` subcommand) or ``--bare-directories`` (used only with the ``knife list`` subcommand) probably aren't used often enough (and in the same exact way) to justify adding them to the |knife rb| file. In general, if the optional settings are not listed on `the main knife.rb topic <https://docs.chef.io/config_rb_knife.html>`_, then add settings only after careful consideration. Do not use optional settings in a production environment until after the setting's performance has been validated in a safe testing environment.

The following list describes all of the optional settings that can be added to the configuration file:

``knife[:admin]``
   |admin client|

``knife[:admin_client_key]``
   

``knife[:admin_client_name]``
   

``knife[:after]``
   |after|

``knife[:all]``
   Indicates that all environments, cookbooks, cookbook versions, metadata, and/or data bags will be uploaded, deleted, generated, or tested. The context depends on which |knife| subcommand and argument is used.

``knife[:all_versions]``
   |all cookbooks return|

``knife[:attribute]``
   |attribute_show|

``knife[:attribute_from_cli]``
   

``knife[:authentication_protocol_version]``
   

``knife[:bare_directories]``
   |d knife list|

``knife[:before]``
   

``knife[:bootstrap_curl_options]``
   |bootstrap curl_options| |bootstrap no_install_command|

``knife[:bootstrap_install_command]``
   |bootstrap install_command| |bootstrap no_curl_sh_wget|

``knife[:bootstrap_no_proxy]``
   |bootstrap no_proxy|

``knife[:bootstrap_proxy]``
   |bootstrap proxy|

``knife[:bootstrap_template]``
   |path bootstrap_template|

``knife[:bootstrap_vault_file]``
   |bootstrap vault_file|

``knife[:bootstrap_vault_item]``
   |bootstrap vault_item|

``knife[:bootstrap_vault_json]``
   |bootstrap vault_json|

   .. include:: ../../step_knife/step_knife_bootstrap_vault_json.rst

``knife[:bootstrap_version]``
   |bootstrap version|

``knife[:bootstrap_wget_options]``
   |bootstrap wget_options| |bootstrap no_install_command|

``knife[:both]``
   |delete_local_and_remote|

``knife[:chef_node_name]``
   

``knife[:chef_repo_path]``
   |path chef_repo|

``knife[:chef_server_url]``
   

``knife[:chef_zero_host]``
   |host chef_zero|

``knife[:chef_zero_post]``
   |port chef_zero|

``knife[:client_key]``
   

``knife[:color]``
   

``knife[:concurrency]``
   |concurrency|

``knife[:config_file]``
   |config|

``knife[:cookbook_copyright]``
   

``knife[:cookbook_email]``
   

``knife[:cookbook_license]``
   

``knife[:cookbook_path]``
   

``knife[:delete_validators]``
   

``knife[:depends]``
   |include-dependencies|

``knife[:description]``
   The description for an environment and/or a role.

``knife[:diff]``
   

``knife[:diff_filter]``
   |diff_filter|

``knife[:disable_editing]``
   |no_editor|

``knife[:distro]``
   

``knife[:download_directory]``
   |directory cookbooks|

``knife[:dry_run]``
   |dry_run|

``knife[:editor]``
   |editor|

``knife[:encrypt]``
   

``knife[:env_run_list]``
   

``knife[:environment]``
   |name environment|

``knife[:exec]``
   |exec|

``knife[:file]``
   |file private_key|

``knife[:filter_result]``
   

``knife[:first_boot_attributes]``
   

``knife[:flat]``
   |flat|

``knife[:force]``
   |force directory|

``knife[:format]``
   

``knife[:forward_agent]``
   |forward_agent|

``knife[:fqdn]``
   |fqdn|

``knife[:freeze]``
   |freeze|

``knife[:help]``
   

``knife[:hide_healthy]``
   |hide_healthy|

``knife[:hints]``
   |hint|

``knife[:host_key_verify]``
   |no_host_key_verify|

``knife[:id_only]``
   

``knife[:identity_file]``
   |identity-file|

``knife[:initial]``
   |initial|

``knife[:input]``
   |input file|

``knife[:latest]``
   |latest|

``knife[:local]``
   |local_directory|

``knife[:local_mode]``
   

``knife[:log_level]``
   

``knife[:log_location]``
   

``knife[:manual]``
   |manual_list|

``knife[:max_arguments_per_command]``
   

``knife[:max_command_line]``
   

``knife[:method]``
   |method request type|

``knife[:mismatch]``
   

``knife[:name_only]``
   |name only|

``knife[:name_status]``
   |name status|

``knife[:no_deps]``
   |skip-dependencies|

``knife[:node_name]``
   |name node_knife_rb| For example:

   .. code-block:: ruby

      node_name 'user_name'

   or:

   .. code-block:: ruby

      node_name 'machine_name'

``knife[:null_separator]``
   

``knife[:on_error]``
   

``knife[:one_column]``
   |one_column|

``knife[:patterns]``
   

``knife[:platform]``
   |platform|

``knife[:platform_version]``
   |platform_version|

``knife[:pretty]``
   |no_pretty|

``knife[:print_after]``
   |print_after|

``knife[:proxy_auth]``
   |proxy_auth|

``knife[:purge]``
   |purge cookbook|

``knife[:query]``
   

``knife[:readme_format]``
   |readme-format|

``knife[:recurse]``
   |no_recurse_delete|

``knife[:recursive]``
   

``knife[:remote]``
   

``knife[:replace_all]``
   

``knife[:replace_first]``
   

``knife[:repo_mode]``
   |repo_mode|

``knife[:repository]``
   |repository|

``knife[:rows]``
   

``knife[:run_list]``
   |run-list|

``knife[:script_path]``
   |script-path|

``knife[:secret]``
   |secret|

``knife[:secret_file]``
   |secret_file|

``knife[:server_name]``
   Same as node_name. Recommended configuration is to allow |ohai| to collect this value during each |chef client| run.

``knife[:sort]``
   

``knife[:sort_reverse]``
   |sort_reverse|

``knife[:ssh_attribute]``
   |attribute ssh|

``knife[:ssh_gateway]``
   |ssh_gateway|

``knife[:ssh_password]``
   |ssh_password|

``knife[:ssh_password_ng]``
   

``knife[:ssh_port]``
   |ssh_port|

``knife[:ssh_user]``
   |ssh_user|

``knife[:start]``
   

``knife[:template_file]``
   

``knife[:trailing_slashes]``
   

``knife[:tree]``
   |tree|

``knife[:use current_branch]``
   |use current_branch|

``knife[:use_sudo]``
   |sudo bootstrap|

``knife[:use_sudo_password]``
   

``knife[:user]`` and/or ``knife[:user_home]``
   |user knife|

``knife[:user_key]``
   |file public_key|

``knife[:user_password]``
   |password user|

``knife[:validation_client_name]``
   

``knife[:validation_key]``
   

``knife[:validator]``
   

``knife[:verbose_commands]``
   

``knife[:verbosity]``
   

``knife[:with_uri]``
   

``knife[:yes]``
   |yes|
