.. THIS PAGE DOCUMENTS chef-client version 11.10

=====================================================
|knife rb| Optional Settings
=====================================================

.. include:: ../../includes_knife/includes_knife_using_knife_rb.rst

.. warning:: .. include:: ../../includes_notes/includes_notes_knife_most_config_settings_should_not_be_used.rst

The following list describes all of the optional settings that can be added to the |knife rb| file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``knife[:admin]``
     - |admin client|
   * - ``knife[:after]``
     - |after|
   * - ``knife[:all]``
     - Indicates that all environments, cookbooks, cookbook versions, metadata, and/or data bags will be uploaded, deleted, generated, or tested. The context depends on which |knife| subcommand and argument is used.
   * - ``knife[:all_versions]``
     - |all cookbooks return|
   * - ``knife[:admin]``
     - |admin client| (This setting is available only for the open source |chef server|.)
   * - ``knife[:admin_client_name]``
     - 
   * - ``knife[:bare_directories]``
     - |d knife list|
   * - ``knife[:bootstrap_proxy]``
     - |bootstrap proxy|
   * - ``knife[:bootstrap_version]``
     - |bootstrap version|
   * - ``knife[:bootstrap_template]``
     - 
   * - ``knife[:chef_repo_path]``
     - |path chef_repo|
   * - ``knife[:concurrency]``
     - |concurrency|
   * - ``knife[:config_file]``
     - |config|
   * - ``knife[:depends]``
     - |include-dependencies|
   * - ``knife[:description]``
     - The description for an environment and/or a role.
   * - ``knife[:disable_editing]``
     - |no_editor|
   * - ``knife[:distro]``
     - |distro|
   * - ``knife[:download_directory]``
     - |directory cookbooks|
   * - ``knife[:editor]``
     - |editor|
   * - ``knife[:environment]``
     - |name environment|
   * - ``knife[:exec]``
     - |exec|
   * - ``knife[:file]``
     - |file private_key|
   * - ``knife[:force]``
     - |force directory|
   * - ``knife[:fqdn]``
     - |fqdn|
   * - ``knife[:freeze]``
     - |freeze|
   * - ``knife[:forward_agent]``
     - |forward_agent|
   * - ``knife[:hide_healthy]``
     - |hide_healthy|
   * - ``knife[:host_key_verify]``
     - |no_host_key_verify|
   * - ``knife[:identity_file]``
     - |identity-file|
   * - ``knife[:initial]``
     - |initial|
   * - ``knife[:input]``
     - |input file|
   * - ``knife[:latest]``
     - |latest|
   * - ``knife[:manual]``
     - |manual_list|
   * - ``knife[:method]``
     - |method request type|
   * - ``knife[:name_only]``
     - |name only|
   * - ``knife[:name_status]``
     - |name status|
   * - ``knife[:no_deps]``
     - |skip-dependencies|
   * - ``knife[:platform]``
     - |platform|
   * - ``knife[:platform_version]``
     - |platform_version|
   * - ``knife[:pretty]``
     - |no_pretty|
   * - ``knife[:print_after]``
     - |print_after|
   * - ``knife[:purge]``
     - |purge cookbook|
   * - ``knife[:readme_format]``
     - |readme-format|
   * - ``knife[:recurse]``
     - Use to recursively delete, disable, or list a directory.
   * - ``knife[:repo_mode]``
     - |repo_mode|
   * - ``knife[:repository]``
     - |repository|
   * - ``knife[:run_list]``
     - |run-list|
   * - ``knife[:script_path]``
     - |script-path|
   * - ``knife[:secret]``
     - |secret|
   * - ``knife[:secret_file]``
     - |secret_file|
   * - ``knife[:server_name]``
     - Same as node_name. Recommended configuration is to allow |ohai| to collect this value during each |chef client| run.
   * - ``knife[:sort_reverse]``
     - |sort_reverse|
   * - ``knife[:ssh_attribute]``
     - |attribute ssh|
   * - ``knife[:ssh_gateway]``
     - |ssh_gateway|
   * - ``knife[:ssh_password]``
     - |ssh_password|
   * - ``knife[:ssh_port]``
     - |ssh_port|
   * - ``knife[:ssh_user]``
     - |ssh_user|
   * - ``knife[:template_file]``
     - |path bootstrap_template|
   * - ``knife[:use current_branch]``
     - |use current_branch|
   * - ``knife[:use_sudo]``
     - |sudo bootstrap|
   * - ``knife[:user]`` and/or ``knife[:user_home]``
     - |user knife|
   * - ``knife[:user_key]``
     - |file public_key|
   * - ``knife[:user_password]``
     - |password user|
   * - ``knife[:yes]``
     - |yes|

