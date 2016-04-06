=====================================================
|knife rb| Optional Settings
=====================================================

.. include:: ../../includes_knife/includes_knife_using_knife_rb.rst

.. include:: ../../includes_config/includes_config_rb_knife_settings_optional_all.rst

By Subcommand
=====================================================
The following sections show the optional settings for the |knife rb| file, sorted by subcommand.

bootstrap
-----------------------------------------------------
The following ``knife bootstrap`` settings can be added to the |knife rb| file:

``knife[:bootstrap_curl_options]``
   Adds the ``--bootstrap-curl-options`` option.

``knife[:bootstrap_install_command]``
   Adds the ``--bootstrap-install-command`` option.

``knife[:bootstrap_no_proxy]``
   Adds the ``--bootstrap-no-proxy`` option.

``knife[:bootstrap_proxy]``
   Adds the ``--bootstrap-proxy`` option.

``knife[:bootstrap_template]``
   Adds the the ``--bootstrap-template`` option.

``knife[:bootstrap_url]``
   Adds the the ``--bootstrap-url`` option.

``knife[:bootstrap_vault_item]``
   Adds the the ``--bootstrap-vault-item`` option.

``knife[:bootstrap_version]``
   Adds the the ``--bootstrap-version`` option.

``knife[:bootstrap_wget_options]``
   Adds the the ``--bootstrap-wget-options`` option.

``knife[:run_list]``
   Adds the the ``--run-list`` option.

``knife[:template_file]``
   Adds the the ``--bootstrap-template`` option.

``knife[:use_sudo]``
   Adds the the ``--sudo`` option.

.. note:: The ``knife bootstrap`` subcommand relies on a number of |ssh|-related settings that are handled by the ``knife ssh`` subcommand.


client create
-----------------------------------------------------
The following ``knife client create`` settings can be added to the |knife rb| file:

``knife[:admin]``
   Adds the the ``--admin`` option.

``knife[:file]``
   Adds the the ``--file`` option.


client reregister
-----------------------------------------------------
The following ``knife client reregister`` settings can be added to the |knife rb| file:

``knife[:file]``
   Adds the the ``--file`` option.


configure
-----------------------------------------------------
The following ``knife configure`` settings can be added to the |knife rb| file:

``knife[:admin_client_name]``
   The name of the admin client that is passed as part of a the command itself.

``knife[:config_file]``
   Adds the the ``--config`` option.

``knife[:disable_editing]``
   Adds the the ``--disable-editing`` option.

``knife[:file]``
   Adds the the ``--file`` option.

``knife[:initial]``
   Adds the the ``--initial`` option.

``knife[:repository]``
   Adds the the ``--repository`` option.

``knife[:user_home]``
   Adds the the ``--user`` option.

``knife[:user_password]``
   Adds the the ``--password`` option.

``knife[:yes]``
   Adds the the ``--yes`` option.


cookbook bulk delete
-----------------------------------------------------
The following ``knife cookbook bulk delete`` settings can be added to the |knife rb| file:

``knife[:purge]``
   Adds the the ``--purge`` option.

``knife[:yes]``
   Adds the the ``--yes`` option.


cookbook create
-----------------------------------------------------
The following ``knife cookbook create`` settings can be added to the |knife rb| file:

``knife[:readme_format]``
   Adds the the ``--readme-format`` option.


cookbook delete
-----------------------------------------------------
The following ``knife cookbook delete`` settings can be added to the |knife rb| file:

``knife[:all]``
   Adds the the ``--all`` option.

``knife[:print_after]``
   Adds the the ``--print-after`` option.

``knife[:purge]``
   Adds the the ``--purge`` option.


cookbook download
-----------------------------------------------------
The following ``knife cookbook download`` settings can be added to the |knife rb| file:

``knife[:download_directory]``
   Adds the the ``--dir`` option.

``knife[:force]``
   Adds the the ``--force`` option.

``knife[:latest]``
   Adds the the ``--latest`` option.


cookbook list
-----------------------------------------------------
The following ``knife cookbook list`` settings can be added to the |knife rb| file:

``knife[:all]``
   Adds the the ``--all`` option.

``knife[:environment]``
   Adds the the ``--environment`` option.


cookbook metadata
-----------------------------------------------------
The following ``knife cookbook metadata`` settings can be added to the |knife rb| file:

``knife[:all]``
   Adds the the ``--all`` option.


cookbook show
-----------------------------------------------------
The following ``knife cookbook show`` settings can be added to the |knife rb| file:

``knife[:fqdn]``
   Adds the the ``--fqdn`` option.

``knife[:platform]``
   Adds the the ``--platform`` option.

``knife[:platform_version]``
   Adds the the ``--platform-version`` option.


cookbook test
-----------------------------------------------------
The following ``knife cookbook test`` settings can be added to the |knife rb| file:

``knife[:all]``
   Adds the the ``--all`` option.


cookbook upload
-----------------------------------------------------
The following ``knife cookbook upload`` settings can be added to the |knife rb| file:

``knife[:all]``
   Adds the the ``--all`` option.

``knife[:depends]``
   Adds the the ``--include-dependencies`` option.

``knife[:environment]``
   Adds the the ``--environment`` option.

``knife[:force]``
   Adds the the ``--force`` option.

``knife[:freeze]``
   Adds the the ``--freeze`` option.


cookbook site download
-----------------------------------------------------
The following ``knife cookbook site download`` settings can be added to the |knife rb| file:

``knife[:file]``
   Adds the the ``--file`` option.

``knife[:force]``
   Adds the the ``--force`` option.


cookbook site install
-----------------------------------------------------
The following ``knife cookbook site install`` settings can be added to the |knife rb| file:

``knife[:cookbook_path]``
   Adds the the ``--cookbook-path`` option.

``knife[:file]``
   Adds the the ``--file`` option.

``knife[:no_deps]``
   Adds the the ``--skip-dependencies`` option.

``knife[:use_current_branch]``
   Adds the the ``--use-current-branch`` option.


cookbook site share
-----------------------------------------------------
The following ``knife cookbook site share`` settings can be added to the |knife rb| file:

``knife[:cookbook_path]``
   Adds the the ``--cookbook-path`` option.


data bag create
-----------------------------------------------------
The following ``knife data bag create`` settings can be added to the |knife rb| file:

``knife[:secret]``
   Adds the the ``--secret`` option.

``knife[:secret_file]``
   Adds the the ``--secret-file`` option.


data bag edit
-----------------------------------------------------
The following ``knife data bag edit`` settings can be added to the |knife rb| file:

``knife[:print_after]``
   Adds the the ``--print-after`` option.

``knife[:secret]``
   Adds the the ``--secret`` option.

``knife[:secret_file]``
   Adds the the ``--secret-file`` option.


data bag from file
-----------------------------------------------------
The following ``knife data bag from file`` settings can be added to the |knife rb| file:

``knife[:all]``
   Adds the the ``--all`` option.

``knife[:secret]``
   Adds the the ``--secret`` option.

``knife[:secret_file]``
   Adds the the ``--secret-file`` option.


data bag show
-----------------------------------------------------
The following ``knife data bag show`` settings can be added to the |knife rb| file:

``knife[:secret]``
   Adds the the ``--secret`` option.

``knife[:secret_file]``
   Adds the the ``--secret-file`` option.


delete
-----------------------------------------------------
The following ``knife delete`` settings can be added to the |knife rb| file:

``knife[:chef_repo_path]``
   Adds the the ``--chef-repo-path`` option.

``knife[:concurrency]``
   Adds the the ``--concurrency`` option.

``knife[:recurse]``
   Adds the the ``--recurse`` option.

``knife[:repo_mode]``
   Adds the the ``--repo-mode`` option.

deps
-----------------------------------------------------
The following ``knife deps`` settings can be added to the |knife rb| file:

``knife[:chef_repo_path]``
   Adds the the ``--chef-repo-path`` option.

``knife[:concurrency]``
   Adds the the ``--concurrency`` option.

``knife[:recurse]``
   Adds the the ``--recurse`` option.

``knife[:remote]``
   Adds the the ``--remote`` option.

``knife[:repo_mode]``
   Adds the the ``--repo-mode`` option.

``knife[:tree]``
   Adds the the ``--tree`` option.


diff
-----------------------------------------------------
The following ``knife diff`` settings can be added to the |knife rb| file:

``knife[:chef_repo_path]``
   Adds the the ``--chef-repo-path`` option.

``knife[:concurrency]``
   Adds the the ``--concurrency`` option.

``knife[:name_only]``
   Adds the the ``--name-only`` option.

``knife[:name_status]``
   Adds the the ``--name-status`` option.

``knife[:recurse]``
   Adds the the ``--recurse`` option.

``knife[:repo_mode]``
   Adds the the ``--repo-mode`` option.


download
-----------------------------------------------------
The following ``knife download`` settings can be added to the |knife rb| file:

``knife[:chef_repo_path]``
   Adds the the ``--chef-repo-path`` option.

``knife[:concurrency]``
   Adds the the ``--concurrency`` option.

``knife[:recurse]``
   Adds the the ``--recurse`` option.

``knife[:repo_mode]``
   Adds the the ``--repo-mode`` option.


edit
-----------------------------------------------------
The following ``knife edit`` settings can be added to the |knife rb| file:

``knife[:chef_repo_path]``
   Adds the the ``--chef-repo-path`` option.

``knife[:concurrency]``
   Adds the the ``--concurrency`` option.

``knife[:disable_editing]``
   Adds the the ``--disable-editing`` option.

``knife[:editor]``
   Adds the the ``--editor`` option.

``knife[:local]``
   Adds the the ``--local`` option.

``knife[:repo_mode]``
   Adds the the ``--repo-mode`` option.


environment create
-----------------------------------------------------
The following ``knife environment create`` settings can be added to the |knife rb| file:

``knife[:description]``
   Adds the the ``--description`` option.


environment from file
-----------------------------------------------------
The following ``knife environment from file`` settings can be added to the |knife rb| file:

``knife[:all]``
   Adds the the ``--all`` option.

``knife[:print_after]``
   Adds the the ``--print-after`` option.


exec
-----------------------------------------------------
The following ``knife exec`` settings can be added to the |knife rb| file:

``knife[:exec]``
   Adds the the ``--exec`` option.

``knife[:script_path]``
   Adds the the ``--script-path`` option.


list
-----------------------------------------------------
The following ``knife list`` settings can be added to the |knife rb| file:

``knife[:bare_directories]``
   Adds the the ``-d`` option.

``knife[:chef_repo_path]``
   Adds the the ``--chef-repo-path`` option.

``knife[:concurrency]``
   Adds the the ``--concurrency`` option.

``knife[:recursive]``
   Adds the the ``-R`` option.

``knife[:repo_mode]``
   Adds the the ``--repo-mode`` option.


node from file
-----------------------------------------------------
The following ``knife node from file`` settings can be added to the |knife rb| file:

``knife[:print_after]``
   Adds the the ``--print-after`` option.


node list
-----------------------------------------------------
The following ``knife node list`` settings can be added to the |knife rb| file:

``knife[:environment]``
   Adds the the ``--environment`` option.


node run list add
-----------------------------------------------------
The following ``knife node run list add`` settings can be added to the |knife rb| file:

``knife[:after]``
   Adds the the ``--after`` option.

``knife[:run_list]``
   |knife option_run_list|


node run list remove
-----------------------------------------------------
The following ``knife node run list remove`` settings can be added to the |knife rb| file:

``knife[:run_list]``
   |knife option_run_list|


raw
-----------------------------------------------------
The following ``knife raw`` settings can be added to the |knife rb| file:

``knife[:chef_repo_path]``
   Adds the the ``--chef-repo-path`` option.

``knife[:concurrency]``
   Adds the the ``--concurrency`` option.

``knife[:input]``
   Adds the the ``--input`` option.

``knife[:method]``
   Adds the the ``--method`` option.

``knife[:pretty]``
   Adds the the ``--[no-]pretty`` option.

``knife[:repo_mode]``
   Adds the the ``--repo-mode`` option.


role create
-----------------------------------------------------
The following ``knife role create`` settings can be added to the |knife rb| file:

``knife[:description]``
   Adds the the ``--description`` option.


role from file
-----------------------------------------------------
The following ``knife role from file`` settings can be added to the |knife rb| file:

``knife[:print_after]``
   Adds the the ``--print-after`` option.


role show
-----------------------------------------------------
The following ``knife role show`` settings can be added to the |knife rb| file:

``knife[:environment]``
   Adds the the ``--environment`` option.


ssh
-----------------------------------------------------
The following ``knife ssh`` settings can be added to the |knife rb| file:

``knife[:concurrency]``
   Adds the the ``--concurrency`` option.

``knife[:identity_file]``
   Adds the the ``--identity-file`` option.

``knife[:host_key_verify]``
   Adds the the ``--[no-]host-key-verify`` option.

``knife[:manual]``
   Adds the the ``--manual-list`` option.

``knife[:ssh_attribute]``
   Adds the the ``--attribute`` option.

``knife[:ssh_gateway]``
   Adds the the ``--ssh-gateway`` option.

``knife[:ssh_password]``
   Adds the the ``--ssh-password`` option.

``knife[:ssh_port]``
   Adds the the ``--ssh-port`` option.
    
``knife[:ssh_user]``
   Adds the the ``--ssh-user`` option.


status
-----------------------------------------------------
The following ``knife status`` settings can be added to the |knife rb| file:

``knife[:hide_healthy]``
   Adds the the ``--hide-healthy`` option.

``knife[:run_list]``
   Adds the the ``--run-list`` option.

``knife[:sort_reverse]``
   Adds the the ``--sort-reverse`` option.


upload
-----------------------------------------------------
The following ``knife upload`` settings can be added to the |knife rb| file:

``knife[:chef_repo_path]``
   Adds the the ``--chef-repo-path`` option.

``knife[:concurrency]``
   Adds the the ``--concurrency`` option.

``knife[:recurse]``
   Adds the the ``--recurse`` option.

``knife[:repo_mode]``
   Adds the the ``--repo-mode`` option.


user create
-----------------------------------------------------
The following ``knife user create`` settings can be added to the |knife rb| file:

``knife[:admin]``
   Adds the the ``--admin`` option.

``knife[:file]``
   Adds the the ``--file`` option.

``knife[:user_key]``
   Adds the the ``--user-key`` option.

``knife[:user_password]``
   Adds the the ``--password`` option.


user reregister
-----------------------------------------------------
The following ``knife user reregister`` settings can be added to the |knife rb| file:

``knife[:file]``
   Adds the the ``--file`` option.


xargs
-----------------------------------------------------
The following ``knife delete`` settings can be added to the |knife rb| file:

``knife[:chef_repo_path]``
   Adds the the ``--chef-repo-path`` option.

``knife[:concurrency]``
   Adds the the ``--concurrency`` option.

``knife[:diff]``
   Adds the the ``--diff`` option.

``knife[:dry_run]``
   Adds the the ``--dry-run`` option.

``knife[:force]``
   Adds the the ``--force`` option.

``knife[:local]``
   Adds the the ``--local`` option.

``knife[:max_arguments_per_command]``
   Adds the the ``--max-args`` option.

``knife[:max_command_line]``
   Adds the the ``--max-chars`` option.

``knife[:null_separator]``
   Adds the the ``-0`` option.

``knife[:patterns]``
   Adds the the ``--pattern`` option.

``knife[:replace_all]``
   Adds the the ``--replace`` option.

``knife[:replace_first]``
   Adds the the ``--replace-first`` option.

``knife[:repo_mode]``
   Adds the the ``--repo-mode`` option.

``knife[:verbose_commands]``
   Adds the the ``-t`` option.
