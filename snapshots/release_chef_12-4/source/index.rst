=====================================================
About chef-client 12.4
=====================================================

.. include:: ../../includes_chef/includes_chef_index.rst

View the :doc:`release notes </release_notes>` for chef-client 12.4.

Getting Started
=====================================================
**From the beginning:** :doc:`Overview (long) </chef_overview>`

**Key concepts:** :doc:`Workstations </workstation>` | :doc:`The Server </server_components>` | :doc:`Nodes </nodes>` | :doc:`Cookbooks </cookbooks>` | :doc:`Attributes </attributes>` | :doc:`Resources </resource>` | :doc:`Custom Resources </custom_resources>` | :doc:`Knife </knife>`

**Using Ruby:** :doc:`Just Enough Ruby for Chef </ruby>`


The Workstation
=====================================================

**The Basics:** :doc:`About the Workstation </workstation>` | :doc:`The chef-repo </chef_repo>` | :doc:`Knife </knife>` | :doc:`Debug Recipes </debug>`

**Install:** :doc:`Install the chef-client on a Workstation </install_dk>` | :doc:`Bootstrap a Node </install_bootstrap>` | :doc:`Create and Sync the chef-repo </chef_repo>`

**Knife:** :doc:`About Knife </knife>` | :doc:`Common Options </knife_common_options>` | :doc:`Working with Knife </knife_using>` --- **Commands:** :doc:`bootstrap </knife_bootstrap>` | :doc:`client </knife_client>` | :doc:`configure </knife_configure>` | :doc:`cookbook </knife_cookbook>` | :doc:`cookbook site </knife_cookbook_site>` | :doc:`data bag </knife_data_bag>` | :doc:`delete </knife_delete>` | :doc:`deps </knife_deps>` | :doc:`diff </knife_diff>` | :doc:`download </knife_download>` | :doc:`edit </knife_edit>` | :doc:`environment </knife_environment>` | :doc:`exec </knife_exec>` | :doc:`list </knife_list>` | :doc:`node </knife_node>` | :doc:`raw </knife_raw>` | :doc:`recipe list </knife_recipe_list>` | :doc:`role </knife_role>` | :doc:`search </knife_search>` | :doc:`serve </knife_serve>` | :doc:`show </knife_show>` | :doc:`ssh </knife_ssh>` | :doc:`ssl check </knife_ssl_check>` | :doc:`ssl fetch </knife_ssl_fetch>` | :doc:`status </knife_status>` | :doc:`tag </knife_tag>` | :doc:`upload </knife_upload>` | :doc:`user </knife_user>` | :doc:`xargs </knife_xargs>`

**Settings:** :doc:`knife.rb </config_rb_knife>` | :doc:`metadata.rb </config_rb_metadata>`

**Tools:** :doc:`chef-shell (executable) </ctl_chef_shell>` | :doc:`chef-apply (executable) </ctl_chef_apply>`


The Nodes
=====================================================
**The Basics:** :doc:`About Nodes </nodes>` | :doc:`chef-client (agent) </chef_client>` | :doc:`The chef-client Run </chef_client>` | :doc:`Chef Solo </chef_solo>` | :doc:`Debug Recipes </debug>`

**Install:** :doc:`Install the chef-client on a Node (Bootstrap) </install_bootstrap>` and :doc:`knife bootstrap </knife_bootstrap>` | :doc:`Install the chef-client on Windows </install_windows>` | :doc:`Download the chef-client with Omnitruck API </api_omnitruck>`

.. include:: ../../includes_chef/includes_chef_index_ohai.rst

**Settings:** :doc:`client.rb </config_rb_client>` | :doc:`solo.rb </config_rb_solo>`

**Command-line Tools:** :doc:`chef-client (executable) </ctl_chef_client>` | :doc:`chef-solo (executable) </ctl_chef_solo>` | :doc:`chef-shell (executable) </ctl_chef_shell>`

Cookbooks
=====================================================
**The Basics:** :doc:`About Cookbooks </cookbooks>` | :doc:`About Recipes </recipes>` | :doc:`About Attribute Files </attributes>` |  :doc:`Handlers </handlers>` | `Popular Cookbooks <https://github.com/chef-cookbooks>`_

**Custom Resources:** :doc:`About Custom Resources </custom_resources>`

**Other Cookbook Components:** :doc:`About Definitions </definitions>` | :doc:`About Files </files>` | :doc:`About Libraries </libraries>` | :doc:`About Cookbook Metadata </cookbook_repo>` | :doc:`About Templates </templates>` | :doc:`About Versions </cookbook_versions>`

**The Recipe DSL:** :doc:`About the Recipe DSL </dsl_recipe>` --- **Methods:** `attribute? <https://docs.chef.io/release/12-4/dsl_recipe.html#attribute>`_ | `control <https://docs.chef.io/release/12-4/dsl_recipe.html#control>`_ | `control_group <https://docs.chef.io/release/12-4/dsl_recipe.html#control-group>`_ | `cookbook_name <https://docs.chef.io/release/12-4/dsl_recipe.html#cookbook-name>`_ | `data_bag <https://docs.chef.io/release/12-4/dsl_recipe.html#data-bag>`_ | `data_bag_item <https://docs.chef.io/release/12-4/dsl_recipe.html#data-bag-item>`_ | `platform? <https://docs.chef.io/release/12-4/dsl_recipe.html#platform>`_ | `platform_family? <https://docs.chef.io/release/12-4/dsl_recipe.html#platform-family>`_ | `reboot_pending <https://docs.chef.io/release/12-4/dsl_recipe.html#reboot-pending>`_ |  `recipe_name <https://docs.chef.io/release/12-4/dsl_recipe.html#recipe-name>`_ | `registry_data_exists? <https://docs.chef.io/release/12-4/dsl_recipe.html#registry-data-exists>`_ | `registry_get_subkeys <https://docs.chef.io/release/12-4/dsl_recipe.html#registry-get-subkeys>`_ | `registry_get_values <https://docs.chef.io/release/12-4/dsl_recipe.html#registry-get-values>`_ | `registry_has_subkeys? <https://docs.chef.io/release/12-4/dsl_recipe.html#registry-has-subkeys>`_ | `registry_key_exists? <https://docs.chef.io/release/12-4/dsl_recipe.html#registry-key-exists>`_ | `registry_value_exists? <https://docs.chef.io/release/12-4/dsl_recipe.html#registry-value-exists>`_ | `resources <https://docs.chef.io/release/12-4/dsl_recipe.html#resources>`_ | `search <https://docs.chef.io/release/12-4/dsl_recipe.html#search>`_ | `shell_out <https://docs.chef.io/release/12-4/dsl_recipe.html#shell-out>`_ | `shell_out! <https://docs.chef.io/release/12-4/dsl_recipe.html#id2>`_ | `shell_out_with_systems_locale <https://docs.chef.io/release/12-4/dsl_recipe.html#shell-out-with-systems-locale>`_ | `tag <https://docs.chef.io/release/12-4/dsl_recipe.html#tag-tagged-untag>`_ | `tagged? <https://docs.chef.io/release/12-4/dsl_recipe.html#tag-tagged-untag>`_ | `untag <https://docs.chef.io/release/12-4/dsl_recipe.html#tag-tagged-untag>`_ | `value_for_platform <https://docs.chef.io/release/12-4/dsl_recipe.html#value-for-platform>`_ | `value_for_platform_family <https://docs.chef.io/release/12-4/dsl_recipe.html#value-for-platform-family>`_ | `Windows Platform Helpers <https://docs.chef.io/release/12-4/dsl_recipe.html#helpers>`_

**Resources:** :doc:`About Resources </resource>` | :doc:`Common Functionality </resource_common>` --- :doc:`apt_package </resource_apt_package>` | :doc:`bash </resource_bash>` | :doc:`batch </resource_batch>` | :doc:`bff_package </resource_bff_package>` | :doc:`breakpoint </resource_breakpoint>` | :doc:`chef_gem </resource_chef_gem>` | :doc:`chef_handler </resource_chef_handler>` | :doc:`cookbook_file </resource_cookbook_file>` | :doc:`cron </resource_cron>` | :doc:`deploy </resource_deploy>` | :doc:`directory </resource_directory>` | :doc:`dpkg_package </resource_dpkg_package>` | :doc:`dsc_resource </resource_dsc_resource>` | :doc:`dsc_script </resource_dsc_script>` | :doc:`easy_install_package </resource_easy_install_package>` | :doc:`env </resource_env>` | :doc:`erl_call </resource_erlang_call>` | :doc:`execute </resource_execute>` | :doc:`file </resource_file>` | :doc:`gem_package </resource_gem_package>` | :doc:`git </resource_git>` | :doc:`group </resource_group>` | :doc:`homebrew_package </resource_homebrew_package>` | :doc:`http_request </resource_http_request>` | :doc:`ifconfig </resource_ifconfig>` | :doc:`link </resource_link>` | :doc:`log </resource_log>` | :doc:`mdadm </resource_mdadm>` | :doc:`mount </resource_mount>` | :doc:`ohai </resource_ohai>` | :doc:`package </resource_package>` | :doc:`powershell_script </resource_powershell_script>` | :doc:`reboot </resource_reboot>` | :doc:`registry_key </resource_registry_key>` | :doc:`remote_directory </resource_remote_directory>` | :doc:`remote_file </resource_remote_file>` | :doc:`route </resource_route>` | :doc:`rpm_package </resource_rpm_package>` | :doc:`ruby_block </resource_ruby_block>` | :doc:`script </resource_script>` | :doc:`service </resource_service>` | :doc:`subversion </resource_subversion>` | :doc:`template </resource_template>` | :doc:`user </resource_user>` | :doc:`windows_package </resource_windows_package>` | :doc:`windows_service </resource_windows_service>` | :doc:`yum_package </resource_yum>`


.. Hide the TOC from this file.

.. toctree::
   :hidden:

   api_omnitruck
   attributes
   chef_overview
   chef_client
   chef_repo
   chef_search
   chef_solo
   config_rb_client
   config_rb_knife
   config_rb_knife_optional_settings
   config_rb_metadata
   config_rb_solo
   cookbook_repo
   cookbook_versions
   cookbooks
   ctl_chef_apply
   ctl_chef_client
   ctl_chef_shell
   ctl_chef_solo
   custom_resources
   debug
   definitions
   dsl_recipe
   files
   handlers
   install_bootstrap
   install_dk
   install_windows
   knife
   knife_common_options
   knife_bootstrap
   knife_client
   knife_configure
   knife_cookbook
   knife_cookbook_site
   knife_data_bag
   knife_delete
   knife_deps
   knife_diff
   knife_download
   knife_edit
   knife_environment
   knife_exec
   knife_list
   knife_node
   knife_raw
   knife_recipe_list
   knife_role
   knife_search
   knife_serve
   knife_show
   knife_ssh
   knife_ssl_check
   knife_ssl_fetch
   knife_status
   knife_tag
   knife_upload
   knife_user
   knife_using
   knife_xargs
   libraries
   nodes
   proxies
   recipes
   release_notes
   resource
   resource_apt_package
   resource_bash
   resource_batch
   resource_bff_package
   resource_breakpoint
   resource_chef_gem
   resource_chef_handler
   resource_common
   resource_cookbook_file
   resource_cron
   resource_csh
   resource_deploy
   resource_directory
   resource_dpkg_package
   resource_dsc_resource
   resource_dsc_script
   resource_easy_install_package
   resource_env
   resource_erlang_call
   resource_execute
   resource_file
   resource_freebsd_package
   resource_gem_package
   resource_git
   resource_group
   resource_homebrew_package
   resource_http_request
   resource_ifconfig
   resource_ips_package
   resource_link
   resource_log
   resource_macports_package
   resource_mdadm
   resource_mount
   resource_ohai
   resource_openbsd_package
   resource_package
   resource_pacman_package
   resource_paludis_package
   resource_perl
   resource_portage_package
   resource_powershell_script
   resource_python
   resource_reboot
   resource_registry_key
   resource_remote_directory
   resource_remote_file
   resource_route
   resource_rpm_package
   resource_ruby
   resource_ruby_block
   resource_script
   resource_service
   resource_smartos_package
   resource_solaris_package
   resource_subversion
   resource_template
   resource_user
   resource_windows_package
   resource_windows_service
   resource_yum
   ruby
   server_components
   templates
   workstation
