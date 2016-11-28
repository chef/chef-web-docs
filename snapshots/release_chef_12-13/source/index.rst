=====================================================
About chef-client 12.13
=====================================================

.. tag chef_index

Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by the chef-client. Cookbooks (and recipes) are used to tell the chef-client how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration.

.. end_tag

View the :doc:`release notes </release_notes>` for chef-client 12.13.

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

.. tag chef_index_ohai

**Ohai:** About Ohai | Custom Ohai Plugins 

.. end_tag

**Settings:** :doc:`client.rb </config_rb_client>` | :doc:`solo.rb </config_rb_solo>`

**Command-line Tools:** :doc:`chef-client (executable) </ctl_chef_client>` | :doc:`chef-solo (executable) </ctl_chef_solo>` | :doc:`chef-shell (executable) </ctl_chef_shell>`

Cookbooks
=====================================================
**The Basics:** :doc:`About Cookbooks </cookbooks>` | :doc:`About Recipes </recipes>` | :doc:`About Attribute Files </attributes>` |  :doc:`Handlers </handlers>` | `Popular Cookbooks <https://github.com/chef-cookbooks>`_

**Custom Resources:** :doc:`About Custom Resources </custom_resources>`

**Other Cookbook Components:** :doc:`About Definitions </definitions>` | :doc:`About Files </files>` | :doc:`About Libraries </libraries>` | :doc:`About Cookbook Metadata </cookbook_repo>` | :doc:`About Templates </templates>` | :doc:`About Versions </cookbook_versions>`

**The Recipe DSL:** :doc:`About the Recipe DSL </dsl_recipe>` --- **Methods:** :ref:`attribute? <dsl_recipe-attribute>` | :ref:`control <dsl_recipe-control>` | :ref:`control_group <dsl_recipe-control-group>` | :ref:`cookbook_name <dsl_recipe-cookbook-name>` | :ref:`data_bag <dsl_recipe-data-bag>` | :ref:`data_bag_item <dsl_recipe-data-bag-item>` | :ref:`platform? <dsl_recipe-platform>` | :ref:`platform_family? <dsl_recipe-platform-family>` | :ref:`reboot_pending <dsl_recipe-reboot-pending>` |  :ref:`recipe_name <dsl_recipe-recipe-name>` | :ref:`registry_data_exists? <dsl_recipe-registry-data-exists>` | :ref:`registry_get_subkeys <dsl_recipe-registry-get-subkeys>` | :ref:`registry_get_values <dsl_recipe-registry-get-values>` | :ref:`registry_has_subkeys? <dsl_recipe-registry-has-subkeys>` | :ref:`registry_key_exists? <dsl_recipe-registry-key-exists>` | :ref:`registry_value_exists? <dsl_recipe-registry-value-exists>` | :ref:`resources <dsl_recipe-resources>` | :ref:`search <dsl_recipe-search>` | :ref:`shell_out <dsl_recipe-shell-out>` | :ref:`shell_out! <dsl_recipe-shell-out-bang>` | :ref:`shell_out_with_systems_locale <dsl_recipe-shell-out-with-systems-locale>` | :ref:`tag <dsl_recipe-tag-tagged-untag>` | :ref:`tagged? <dsl_recipe-tag-tagged-untag>` | :ref:`untag <dsl_recipe-tag-tagged-untag>` | :ref:`value_for_platform <dsl_recipe-value-for-platform>` | :ref:`value_for_platform_family <dsl_recipe-value-for-platform-family>` | :ref:`Windows Platform Helpers <dsl_recipe-helpers>`

**Resources:** :doc:`About Resources </resource>` | :doc:`Common Functionality </resource_common>` --- :doc:`apt_package </resource_apt_package>` | :doc:`bash </resource_bash>` | :doc:`batch </resource_batch>` | :doc:`bff_package </resource_bff_package>` | :doc:`breakpoint </resource_breakpoint>` | :doc:`chef_gem </resource_chef_gem>` | :doc:`chef_handler </resource_chef_handler>` | :doc:`cookbook_file </resource_cookbook_file>` | :doc:`cron </resource_cron>` | :doc:`deploy </resource_deploy>` | :doc:`directory </resource_directory>` | :doc:`dpkg_package </resource_dpkg_package>` | :doc:`dsc_resource </resource_dsc_resource>` | :doc:`dsc_script </resource_dsc_script>` | :doc:`easy_install_package </resource_easy_install_package>` | :doc:`env </resource_env>` | :doc:`erl_call </resource_erlang_call>` | :doc:`execute </resource_execute>` | :doc:`file </resource_file>` | :doc:`gem_package </resource_gem_package>` | :doc:`git </resource_git>` | :doc:`group </resource_group>` | :doc:`homebrew_package </resource_homebrew_package>` | :doc:`http_request </resource_http_request>` | :doc:`ifconfig </resource_ifconfig>` | :doc:`link </resource_link>` | :doc:`log </resource_log>` | :doc:`mdadm </resource_mdadm>` | :doc:`mount </resource_mount>` | :doc:`ohai </resource_ohai>` | :doc:`osx_profile </resource_osx_profile>` | :doc:`package </resource_package>` | :doc:`powershell_script </resource_powershell_script>` | :doc:`reboot </resource_reboot>` | :doc:`registry_key </resource_registry_key>` | :doc:`remote_directory </resource_remote_directory>` | :doc:`remote_file </resource_remote_file>` | :doc:`route </resource_route>` | :doc:`rpm_package </resource_rpm_package>` | :doc:`ruby_block </resource_ruby_block>` | :doc:`script </resource_script>` | :doc:`service </resource_service>` | :doc:`subversion </resource_subversion>` | :doc:`template </resource_template>` | :doc:`user </resource_user>` | :doc:`windows_package </resource_windows_package>` | :doc:`windows_service </resource_windows_service>` | :doc:`yum_package </resource_yum>`

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
   dsl_custom_resource
   dsl_handler
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
   resource_apt_update
   resource_bash
   resource_batch
   resource_bff_package
   resource_breakpoint
   resource_chef_gem
   resource_chef_handler
   resource_chocolatey_package
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
   resource_launchd
   resource_link
   resource_log
   resource_ksh
   resource_macports_package
   resource_mdadm
   resource_mount
   resource_ohai
   resource_openbsd_package
   resource_osx_profile
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
