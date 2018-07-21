=====================================================
Site Map
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/index.rst>`__

This is the documentation for:

* Chef, including the Chef server, the Chef client, the Chef
  development kit (Chef DK) and related tools
* Chef Automate

For information on Habitat and InSpec, see their respective documentation:

* `Habitat documentation <https://www.habitat.sh/docs/>`_
* `InSpec documentation <https://www.inspec.io/docs/>`_

This page has links to each topic in this doc set. You can also use
the navigation tool or the search box to find what you're looking for.

If you are new to Chef, we highly recommend the `Getting Started <https://learn.chef.io/tracks/getting-started/>`_ track on Learn Chef to familarize yourself with Chef concepts.

If you need documentation for previous versions, see the `Docs Archive <https://docs-archive.chef.io>`_.

Overview
=====================================================

Chef Platform Overview
-----------------------------------------------------

`Platform Overview </platform_overview.html>`__

Community
-----------------------------------------------------

`About the Community </community.html>`__ |
`Contributing </community_contributions.html>`__ |
`Guidelines </community_guidelines.html>`__ |
`Docs Style Guide </style_guide.html>`__

Packages and Platform Support
-----------------------------------------------------
`Packages </packages.html>`__ |
`Platforms and Supported Versions </platforms.html>`__ |
`Omnitruck API </api_omnitruck.html>`__ |
`Licensing </chef_license.html>`__

Chef
=====================================================

Getting Started
-----------------------------------------------------
`Chef Overview </chef_overview.html>`__ |
`Quick Start </quick_start.html>`__ |
`System Requirements </chef_system_requirements.html>`__

**Chef Workstation**:
`Chef Workstation Beta <https://www.chef.sh/>`__ |
`Documentation <https://www.chef.sh/docs/chef-workstation/getting-started/>`__

**Release Notes**:
`Chef Client </release_notes.html>`__ |
`Chef Development Kit </release_notes_chefdk.html>`__ |
`Chef Server </release_notes_server.html>`__ |
`Chef Push Jobs </release_notes_push_jobs.html>`__ |
`Ohai </release_notes_ohai.html>`__

`Deprecations </chef_deprecations_client.html>`__

Concepts
-----------------------------------------------------

`Workstation </workstation.html>`__ |
`chef-repo </chef_repo.html>`__ |
`Nodes </nodes.html>`__ |
`Chef Client Overview </chef_client_overview.html>`__ |
`Server </server_components.html>`__ |
`Search </chef_search.html>`__ |
`Cookbooks </cookbooks.html>`__ |
`Handlers </handlers.html>`__ |
`Management Console </manage.html>`__

**Policy**: `About Policy </policy.html>`__ | `Data Bags </data_bags.html>`__ | `Environments </environments.html>`__ | `Roles </roles.html>`__

`Push Jobs </push_jobs.html>`__ |
`Reporting </reporting.html>`__ |
`Run-lists </run_lists.html>`__

**Security**: `Authentication </auth.html#authentication.html>`__ | `Authorization </auth.html#authorization.html>`__ | `Private Keys </chef_private_keys.html>`__ | `FIPS-mode </ctl_chef_client.html#run-in-fips-mode.html>`__

**Supermarket**: `Public Supermarket (overview) </supermarket.html#public-supermarket>`__ | `Private Supermarket (overview) </supermarket.html#private-supermarket>`__ | `Share Cookbooks on the Chef Supermarket </supermarket_share_cookbook.html>`__

`Microsoft Windows </windows.html>`__

**Appendix**: `Env Variables </environment_variables.html>`__ | `Troubleshooting </errors.html>`__ | `Glossary </glossary.html>`__

Setup
-----------------------------------------------------
`Proxies </proxies.html>`__ |
`Chef DK on Windows </dk_windows.html>`__ |
`Workstation </install_dk.html>`__

**Nodes**: `Install via Bootstrap </install_bootstrap.html>`__ | `Install via URL </install_omnibus.html>`__ | `Install on Windows </install_windows.html>`__ | `Install on Junos OS </junos.html>`__ | `chef-client (executable) </ctl_chef_client.html>`__ | `client.rb </config_rb_client.html>`__ | `Upgrades </upgrade_client.html>`__ | `Security </chef_client_security.html>`__

**Server**: `Hosted Chef Server <https://manage.chef.io/signup.html>`__ | `Install Standalone </install_server.html#standalone.html>`__ | `Install High Availability </install_server_ha.html>`__ | `Upgrade High Availability </upgrade_server_ha_v2.html>`__  | `Integrate Chef Compliance with Chef Server </integrate_compliance_chef_server.html>`__

**Supermarket**: `Public Supermarket <https://supermarket.chef.io.html>`__ | `Install Private Supermarket </install_supermarket.html>`__ | `Customize Supermarket </install_supermarket.html#customize-supermarket.html>`__ | `Run in Kitchen </install_supermarket.html#run-supermarket-in-kitchen.html>`__

`Management Console </ctl_chef_server.html#install.html>`__ | `Push Jobs </install_push_jobs.html>`__

**Integrations**: `AWS Marketplace </aws_marketplace.html>`__ |  `Microsoft Azure </azure_portal.html>`__ | `Google Cloud Platform </google.html>`__ | `VMware </vmware.html>`__

`Air-gapped Installation </install_chef_air_gap.html>`__ |
`Microsoft Windows </windows.html>`__ |
`Uninstall </uninstall.html>`__

Cookbook Reference
-----------------------------------------------------
`About Cookbooks </cookbooks.html>`__ |
`Attributes </attributes.html>`__ |
`Definitions </definitions.html>`__ |
`Files </files.html>`__ |
`Libraries </libraries.html>`__

**Recipes**: `About Recipes </recipes.html>`__ | `Debug Recipes, Client Runs </debug.html>`__

**Audit Mode DSL**:
`About the Audit Mode DSL </dsl_audit.html>`__ |
`control </dsl_audit.html#control>`__ |
`control_group </dsl_audit.html#control-group>`__ |

**Resources**:
`About Resources </resource.html>`__ |
`Common Functionality </resource_common.html>`__ |
`Custom Resources </custom_resources.html>`__ |
`All Resources (Single Page) </resource_reference.html>`__ |
`Examples (by Resource) </resource_examples.html>`__

`apt_package </resource_apt_package.html>`__ |
`apt_preference </resource_apt_preference.html>`__ |
`apt_repository </resource_apt_repository.html>`__ |
`apt_update </resource_apt_update.html>`__ |
`bash </resource_bash.html>`__ |
`batch </resource_batch.html>`__ |
`bff_package </resource_bff_package.html>`__ |
`breakpoint </resource_breakpoint.html>`__ |
`build_essential </resource_build_essential.html>`__ |
`cab_package </resource_cab_package.html>`__ |
`chef_acl </resource_chef_acl.html>`__ |
`chef_client </resource_chef_client.html>`__ |
`chef_container </resource_chef_container.html>`__ |
`chef_data_bag </resource_chef_data_bag.html>`__ |
`chef_data_bag_item </resource_chef_data_bag_item.html>`__ |
`chef_environment </resource_chef_environment.html>`__ |
`chef_gem </resource_chef_gem.html>`__ |
`chef_group </resource_chef_group.html>`__ |
`chef_handler </resource_chef_handler.html>`__ |
`chef_mirror </resource_chef_mirror.html>`__ |
`chef_node </resource_chef_node.html>`__ |
`chef_organization </resource_chef_organization.html>`__ |
`chef_role </resource_chef_role.html>`__ |
`chef_user </resource_chef_user.html>`__ |
`chocolatey_config </resource_chocolatey_config.html>`__
`chocolatey_package </resource_chocolatey_package.html>`__
`cookbook_file </resource_cookbook_file.html>`__ |
`cron </resource_cron.html>`__ |
`csh </resource_csh.html>`__ |
`deploy </resource_deploy.html>`__ |
`directory </resource_directory.html>`__ |
`dmg_package </resource_dmg_package.html>`__ |
`dpkg_package </resource_dpkg_package.html>`__ |
`dsc_resource </resource_dsc_resource.html>`__ |
`dsc_script </resource_dsc_script.html>`__ |
`windows_env </resource_windows_env.html>`__ |
`erl_call </resource_erlang_call.html>`__ |
`execute </resource_execute.html>`__ |
`file </resource_file.html>`__ |
`freebsd_package </resource_freebsd_package.html>`__ |
`gem_package </resource_gem_package.html>`__ |
`git </resource_git.html>`__ |
`group </resource_group.html>`__ |
`homebrew_cask </resource_homebrew_cask.html>`__ |
`homebrew_package </resource_homebrew_package.html>`__ |
`homebrew_tap </resource_homebrew_tap.html>`__ |
`hostname </resource_hostname.html>`__ |
`http_request </resource_http_request.html>`__ |
`ifconfig </resource_ifconfig.html>`__ |
`ips_package </resource_ips_package.html>`__ |
`ksh </resource_ksh.html>`__ |
`launchd </resource_launchd.html>`__ |
`link </resource_link.html>`__ |
`log </resource_log.html>`__ |
`macos_userdefaults </resource_macos_userdefaults.html>`__ |
`macports_package </resource_macports_package.html>`__ |
`mdadm </resource_mdadm.html>`__ |
`mount </resource_mount.html>`__ |
`ohai </resource_ohai.html>`__ |
`ohai_hint </resource_ohai_hint.html>`__ |
`openbsd_package </resource_openbsd_package.html>`__ |
`openssl_dhparam </resource_openssl_dhparam.html>`__ |
`openssl_rsa_private_key </resource_openssl_rsa_private_key.html>`__ |
`openssl_rsa_public_key </resource_openssl_rsa_public_key.html>`__ |
`osx_profile </resource_osx_profile.html>`__ |
`package </resource_package.html>`__ |
`pacman_package </resource_pacman_package.html>`__ |
`paludis_package </resource_paludis_package.html>`__ |
`perl </resource_perl.html>`__ |
`portage_package </resource_portage_package.html>`__ |
`powershell_package </resource_powershell_package.html>`__ |
`powershell_script </resource_powershell_script.html>`__ |
`private_key </resource_private_key.html>`__ |
`public_key </resource_public_key.html>`__ |
`python </resource_python.html>`__ |
`reboot </resource_reboot.html>`__ |
`registry_key </resource_registry_key.html>`__ |
`remote_directory </resource_remote_directory.html>`__ |
`remote_file </resource_remote_file.html>`__ |
`route </resource_route.html>`__ |
`rpm_package </resource_rpm_package.html>`__ |
`ruby </resource_ruby.html>`__ |
`ruby_block </resource_ruby_block.html>`__ |
`script </resource_script.html>`__ |
`rhsm_errata </resource_rhsm_errata.html>`__ |
`rhsm_errata_level </resource_rhsm_errata_level.html>`__ |
`rhsm_register </resource_rhsm_register.html>`__ |
`rhsm_repo </resource_rhsm_repo.html>`__ |
`rhsm_subscription </resource_rhsm_subscription.html>`__ |
`service </resource_service.html>`__ |
`smartos_package </resource_smartos_package.html>`__ |
`solaris_package </resource_solaris_package.html>`__ |
`subversion </resource_subversion.html>`__ |
`sudo </resource_sudo.html>`__ |
`swap_file </resource_swap_file.html>`__ |
`sysctl </resource_sysctl.html>`__ |
`systemd_unit </resource_systemd_unit.html>`__ |
`template </resource_template.html>`__ |
`user </resource_user.html>`__ |
`windows_ad_join </resource_windows_ad_join.html>`__ |
`windows_auto_run </resource_windows_auto_run.html>`__ |
`windows_feature </resource_windows_feature.html>`__ |
`windows_feature_dism </resource_windows_feature_dism.html>`__ |
`windows_feature_powershell.html </resource_windows_feature_powershell.html>`__ |
`windows_font </resource_windows_font.html>`__ |
`windows_package </resource_windows_package.html>`__ |
`windows_printer.html </resource_windows_printer.html>`__ |
`windows_printer_port </resource_windows_printer_port.html>`__ |
`windows_service </resource_windows_service.html>`__ |
`windows_shortcut </resource_windows_shortcut.html>`__ |
`windows_task </resource_windows_task.html>`__ |
`yum_package </resource_yum.html>`__ |
`yum_repository </resource_yum_repository.html>`__ |
`dnf_package </resource_dnf_package.html>`__ |
`zypper_package </resource_zypper_package.html>`__ |
`zypper_repository </resource_zypper_repository.html>`__


`Templates </templates.html>`__ |
`Cookbook Repo </cookbook_repo.html>`__ |
`metadata.rb </config_rb_metadata.html>`__ |
`Cookbook Versions </cookbook_versions.html>`__ |
`Ruby </ruby.html>`__

**Chef Automate Cookbooks**: `build-cookbook (cookbook) </delivery_build_cookbook.html>`__ | `delivery-truck (cookbook) </delivery_truck.html>`__ | `Publish Cookbooks to Multiple Chef Servers </publish_cookbooks_multiple_servers.html>`__

Chef DK
-----------------------------------------------------

`About the ChefDK </about_chefdk.html>`__ |
`Berkshelf </berkshelf.html>`__ |
`chef-apply (executable) </ctl_chef_apply.html>`__ |
`chef-shell (executable) </chef_shell.html>`__

**chef (executable)**: `chef env </ctl_chef.html#chef-env>`__ | `chef exec </ctl_chef.html#chef-exec>`__ | `chef gem </ctl_chef.html#chef-gem>`__ | `chef generate app </ctl_chef.html#chef-generate-app>`__ | `chef generate attribute </ctl_chef.html#chef-generate-attribute>`__ | `chef generate cookbook </ctl_chef.html#chef-generate-cookbook>`__ | `chef generate build-cookbook </ctl_chef.html#chef-generate-build-cookbook>`__ | `chef generate file </ctl_chef.html#chef-generate-file>`__ | `chef generate lwrp </ctl_chef.html#chef-generate-lwrp>`__ | `chef generate recipe </ctl_chef.html#chef-generate-recipe>`__ | `chef generate repo </ctl_chef.html#chef-generate-repo>`__ | `chef generate template </ctl_chef.html#chef-generate-template>`__ | `chef provision </ctl_chef.html#chef-provision>`__ | `chef shell-init </ctl_chef.html#chef-shell-init>`__ | `chef verify </ctl_chef.html#chef-verify>`__

**Chef Solo**: `About Chef Solo </chef_solo.html>`__ | `chef-solo (executable) </ctl_chef_solo.html>`__ | `solo.rb </config_rb_solo.html>`__

`chef-zero (local mode) </ctl_chef_client.html#run-in-local-mode>`_ |
`chef-vault </chef_vault.html>`__ |
`ChefSpec </chefspec.html>`__

**Configuration**: `config.rb </config_rb.html>`__ | `Multiple Config Files </config_rb_client.html#d-directories.html>`__

`cookstyle </cookstyle.html>`__ |
`Delivery CLI </delivery_cli.html>`__ |
`Foodcritic </foodcritic.html>`__

**Kitchen**: `About Kitchen </kitchen.html>`__ | `kitchen (executable) </ctl_kitchen.html>`__ | `.kitchen.yml </config_yml_kitchen.html>`__ `kitchen-vagrant </plugin_kitchen_vagrant.html>`__

**Knife**: `About Knife </knife.html>`__ | `Common Options </knife_options.html>`__ | `Setting up Knife </knife_setup.html>`__ | `knife bootstrap </knife_bootstrap.html>`__ | `knife client </knife_client.html>`__ | `knife configure </knife_configure.html>`__ | `knife cookbook </knife_cookbook.html>`__ | `knife cookbook site </knife_cookbook_site.html>`__ | `knife data bag </knife_data_bag.html>`__ | `knife delete </knife_delete.html>`__ | `knife deps </knife_deps.html>`__ | `knife diff </knife_diff.html>`__ | `knife download </knife_download.html>`__ | `knife edit </knife_edit.html>`__ | `knife environment </knife_environment.html>`__ | `knife exec </knife_exec.html>`__ | `knife list </knife_list.html>`__ | `knife node </knife_node.html>`__ | `knife raw </knife_raw.html>`__ | `knife recipe list </knife_recipe_list.html>`__ | `knife role </knife_role.html>`__ | `knife search </knife_search.html>`__ | `knife serve </knife_serve.html>`__ | `knife show </knife_show.html>`__ | `knife ssh </knife_ssh.html>`__ | `knife ssl check </knife_ssl_check.html>`__ | `knife ssl fetch </knife_ssl_fetch.html>`__ | `knife status </knife_status.html>`__ | `knife tag </knife_tag.html>`__ | `knife upload </knife_upload.html>`__ | `knife user </knife_user.html>`__ | `knife xargs </knife_xargs.html>`__

**knife opc**: `About knife opc </plugin_knife_opc.html>`__ | `knife.rb Configuration </plugin_knife_opc.html#plugin-knife-opc-knife-rb-configuration>`__ | `opc user list </plugin_knife_opc.html#plugin-knife-opc-opc-user-list>`__ | `opc user show </plugin_knife_opc.html#plugin-knife-opc-opc-user-show>`__ | `opc user create </plugin_knife_opc.html#plugin-knife-opc-opc-user-create>`__ | `opc user delete </plugin_knife_opc.html#plugin-knife-opc-opc-user-delete>`__ | `opc user delete </plugin_knife_opc.html#plugin-knife-opc-opc-user-edit>`__ |  | `opc org list </plugin_knife_opc.html#plugin-knife-opc-opc-org-list>`__ | `opc org show </plugin_knife_opc.html#plugin-knife-opc-opc-org-show>`__ | `opc org create </plugin_knife_opc.html#plugin-knife-opc-opc-org-create>`__ | `opc org delete </plugin_knife_opc.html#plugin-knife-opc-opc-org-delete>`__ | `opc org user add </plugin_knife_opc.html#plugin-knife-opc-opc-org-user-add>`__ | `opc org user remove </plugin_knife_opc.html#plugin-knife-opc-opc-org-user-remove>`__

`knife spork </plugin_knife_spork.html>`__

**knife supermarket**: `supermarket download </plugin_knife_supermarket.html#download>`__ | `supermarket install </plugin_knife_supermarket.html#install>`__ | `supermarket list </plugin_knife_supermarket.html#list>`__ | `supermarket search </plugin_knife_supermarket.html#search>`__ | `supermarket share </plugin_knife_supermarket.html#share>`__ | `supermarket show </plugin_knife_supermarket.html#show>`__ | `supermarket unshare </plugin_knife_supermarket.html#unshare>`__

**Ohai**: `About Ohai </ohai.html>`__ | `ohai (executable) </ctl_ohai.html>`__

**Policyfile**: `About Policyfile </policyfile.html>`__ | `Policyfile.rb </config_rb_policyfile.html>`__

**Provisioning**: `About Provisioning </provisioning.html>`__ | `load_balancer resource </resource_load_balancer.html>`__ | `machine resource </resource_machine.html>`__ | `machine_batch resource </resource_machine_batch.html>`__ | `machine_execute resource </resource_machine_execute.html>`__ | `machine_file resource </resource_machine_file.html>`__ | `machine_image resource </resource_machine_image.html>`__ | `AWS Driver Resources </provisioning_aws.html>`__ | `Fog Driver Resources </provisioning_fog.html>`__ | `Vagrant Driver Resources </provisioning_vagrant.html>`__

`push-jobs-client (executable) </ctl_push_jobs_client.html>`__

Managing the Server
-----------------------------------------------------

`Runbook (Single Page) </runbook.html>`__ |
`Backend Cluster Failure Recovery </backend_failure_recovery.html>`__ |
`Backup and Restore </server_backup_restore.html>`__ |
`Data Storage </server_data.html>`__ |
`Firewalls and Ports </server_firewalls_and_ports.html>`__ |
`Active Directory and LDAP </server_ldap.html>`__ |
`Log Files </server_logs.html>`__ |
`Monitor </server_monitor.html>`__ |
`Organizations and Groups </server_orgs.html>`__ |
`Secrets </secrets.html>`__ |
`Security </server_security.html>`__ |
`Services </server_services.html>`__ |
`Tuning </server_tuning.html>`__ |
`Upgrades </upgrade_server.html>`__ |
`Upgrade HA Cluster </upgrade_server_ha_v2.html>`__ |
`Users </server_users.html>`__ |
`chef-server-ctl </ctl_chef_server.html>`__ |
`chef-backend-ctl </ctl_chef_backend.html>`__ |
`chef-server.rb </config_rb_server.html>`__ |
`opscode-expander-ctl </ctl_opscode_expander.html>`__ |
`Chef Server API </api_chef_server.html>`__

**Push Jobs**: `knife push jobs </plugin_knife_push_jobs.html>`__ | `push-jobs-client </ctl_push_jobs_client.html>`__ | `push-jobs-client.rb </config_rb_push_jobs_client.html>`__ | `push-jobs-server.rb </config_rb_push_jobs_server.html>`__ | `Push Jobs API </api_push_jobs.html>`__ | `Server Sent Events </server_sent_events.html>`__

**Supermarket**: `Log Files </supermarket_logs.html>`__ | `Backup and Restore </supermarket_backup_restore.html>`__ | `Monitoring </supermarket_monitor.html>`__ | `supermarket.rb </config_rb_supermarket.html>`__ | `knife supermarket </plugin_knife_supermarket.html>`__ | `supermarket-ctl </ctl_supermarket.html>`__ | `Supermarket API </supermarket_api.html>`__

**Management Console**: `Configure SAML </server_configure_saml.html>`__ | `Clients </server_manage_clients.html>`__ | `Cookbooks </server_manage_cookbooks.html>`__ | `Data Bags </server_manage_data_bags.html>`__ | `Environments </server_manage_environments.html>`__ | `Nodes </server_manage_nodes.html>`__ | `Roles </server_manage_roles.html>`__ | `Users </server_users.html#chef-manage.html>`__ | `manage.rb </config_rb_manage.html>`__ | `chef-manage-ctl </ctl_manage.html>`__

Habitat
=====================================================

Documentation
-----------------------------------------------------

`Habitat Documentation <https://www.habitat.sh/docs/>`__

Tutorials
-----------------------------------------------------

 `Habitat Tutorials <https://www.habitat.sh/tutorials/>`_

InSpec
=====================================================

Documentation
-----------------------------------------------------

`InSpec Documentation <https://www.inspec.io/docs/>`_

Tutorials
-----------------------------------------------------

`InSpec Tutorials <https://www.inspec.io/tutorials/>`_

Chef Automate
=====================================================

Overview
-----------------------------------------------------

`Chef Automate Overview </chef_automate.html>`__ |
`Workflow Overview </workflow.html>`__ |
`Nodes Overview </visibility.html>`__ |
`Compliance Overview </chef_automate_compliance.html>`__ |
`Administration Overview </automate_admin.html>`__

Getting Started
-----------------------------------------------------

`Installation Guide </install_chef_automate.html>`__ |
`Configure a Pipeline </delivery_pipeline.html>`__ |
`Configure a Project </config_json_delivery.html>`__ |
`Configure Data Collection </data_collection.html>`__ |
`Data Collection and Chef HA </data_collection_ha.html>`__ |
`Data Collection without Chef Server </data_collection_without_server.html>`__ |
`Stream Data </stream_data_chef_automate.html>`__ |
`Upgrades </upgrade_chef_automate.html>`_

Release Notes
-----------------------------------------------------

`Release Notes </release_notes_chef_automate.html>`__

Nodes
-----------------------------------------------------

`Node Notifications w/Slack </integrate_node_notifications_slack.html>`__ |
`Node Notifications w/Webhooks </integrate_node_notifications_webhook.html>`__ |
`Node Search Reference </search_query_chef_automate.html>`__

Compliance
-----------------------------------------------------

`Reporting </automate_compliance_reporting.html>`__ |
`Scanner </automate_compliance_scanner.html>`__ |
`Profile Store </profile_store.html>`__ |
`Credentials </automate_compliance_credentials.html>`__

Workflow
-----------------------------------------------------

`build-cookbook (cookbook) </delivery_build_cookbook.html>`__ |
`delivery-truck (cookbook) </delivery_truck.html>`__ |
`Manage Dependencies </delivery_manage_dependencies.html>`__ |
`Runners </runners.html>`__ |
`Workflow w/Bitbucket </integrate_delivery_bitbucket.html>`__ |
`Workflow w/Email (SMTP) </integrate_delivery_smtp.html>`__ |
`Workflow w/GitHub </integrate_delivery_github.html>`__ |
`Workflow w/Slack </integrate_delivery_slack.html>`__

Admin
-----------------------------------------------------

`Authentication w/LDAP </integrate_delivery_ldap.html>`__ |
`Authentication w/SAML </integrate_chef_automate_saml.html>`__

Managing the Server
-----------------------------------------------------

`Backups </delivery_server_backup.html>`__ |
`Capacity Planning </scaling_capacity_planning_chef_automate.html>`__ |
`Disaster Recovery </delivery_server_disaster_recovery.html>`__ |
`Elasticsearch and Kibana Authentication </elasticsearch_and_kibana_auth.html>`__ |
`Secrets </delivery_manage_secrets.html>`__ |
`Data Retention Management in Chef Automate </data_retention_chef_automate.html>`__ |
`Tuning </delivery_server_tuning.html>`__ |
`Users and Roles </delivery_users_and_roles.html>`__

Reference
-----------------------------------------------------

`Chef Automate API </api_automate.html>`__ |
`Automate CTL </ctl_automate_server.html>`__ |
`Chef Compliance API </api_compliance.html>`__ |
`Delivery CLI </delivery_cli.html>`__
`delivery.rb </config_rb_delivery.html>`__ |
`Workflow DSL </dsl_delivery.html>`__

AWS OpsWorks for Chef Automate
-----------------------------------------------------

`AWS OpsWorks for Chef Automate </aws_opsworks_chef_automate.html>`__

Troubleshooting
-----------------------------------------------------

`Troubleshooting </troubleshooting_chef_automate.html>`__

Compliance scanner
-----------------------------------------------------

`Overview </chef_compliance.html>`__ |
`Installation Guide </install_chef_compliance.html>`__ |
`Integrate w/Chef Server </integrate_compliance_chef_server.html>`__ |
`Integrate w/Chef Automate </integrate_compliance_server_chef_automate.html>`__ |
`Upgrade Compliance </upgrade_compliance.html>`__ |
`chef-compliance.rb </config_rb_compliance.html>`__ |
`Profile Store </profile_store.html>`__

Legacy
=====================================================

Analytics
-----------------------------------------------------

`Overview </analytics.html>`__ |
`Release Notes </release_notes_analytics.html>`__ |
`Install Standalone </install_analytics.html>`__ |
`Web UI </actions.html>`__ |
`Management Console </analytics_webui_tasks.html>`__ |
`Nodes View </analytics_nodes_view.html>`__ |
`Integrations </analytics.html#integrations>`_ |
`Splunk </analytics_splunk.html>`__ |
`Rules </analytics_rules.html>`__ |
`Monitor </analytics_monitor.html>`__ |
`Upgrades </upgrade_analytics.html>`__ |
`Chef Client for Analytics </chef_client_analytics.html>`__ |
`opscode-analytics-ctl </ctl_analytics.html>`__ |
`opscode-analytics.rb </config_rb_analytics.html>`__ |
`knife-analytics </plugin_knife_analytics.html>`__ |
`Analytics API </api_analytics.html>`__ |
`Recipe DSL for Analytics </dsl_recipe_analytics.html>`__

Reporting
-----------------------------------------------------

`Overview </reporting.html>`__ |
`Install Reporting </install_reporting.html>`__ |
`View Reports </server_manage_reports.html>`__ |
`knife reporting </plugin_knife_reporting.html>`__ |
`opscode-reporting-ctl </ctl_reporting.html>`__ |
`opscode-reporting.rb </config_rb_reporting.html>`__ |
`Reporting API </api_reporting.html>`__

Extension APIs
=====================================================

Resources
-----------------------------------------------------

**Recipe DSL**: `attribute? </dsl_recipe.html#attribute>`_ | `control </dsl_recipe.html#control>`_ | `control_group </dsl_recipe.html#control-group>`_ | `cookbook_name </dsl_recipe.html#cookbook-name>`_ | `data_bag </dsl_recipe.html#data-bag>`_ | `data_bag_item </dsl_recipe.html#data-bag-item>`_ | `platform? </dsl_recipe.html#platform>`_ | `platform_family? </dsl_recipe.html#platform-family>`_ | `reboot_pending? </dsl_recipe.html#reboot-pending>`_ | `recipe_name </dsl_recipe.html#recipe-name>`_ | `registry_data_exists? </dsl_recipe.html#registry-data-exists>`_ | `registry_get_subkeys </dsl_recipe.html#registry-get-subkeys>`_ | `registry_get_values </dsl_recipe.html#registry-get-values>`_ | `registry_has_subkeys? </dsl_recipe.html#registry-has-subkeys>`_ | `registry_key_exists? </dsl_recipe.html#registry-key-exists>`_ | `registry_value_exists? </dsl_recipe.html#registry-value-exists>`_ | `resources </dsl_recipe.html#resources>`_ | `search </dsl_recipe.html#search>`_ | `shell_out </dsl_recipe.html#shell-out>`_ | `shell_out! </dsl_recipe.html#shell-out-bang>`_ | `shell_out_with_systems_locale </dsl_recipe.html#shell-out-with-systems-locale>`_ | `tag </dsl_recipe.html#tag-tagged-untag>`_ | `tagged? </dsl_recipe.html#tag-tagged-untag>`_ | `untag </dsl_recipe.html#tag-tagged-untag>`_ | `value_for_platform </dsl_recipe.html#value-for-platform>`_ | `value_for_platform_family </dsl_recipe.html#value-for-platform-family>`_ | `Windows Platform Helpers </dsl_recipe.html#helpers>`_

 `Community Resources <https://supermarket.chef.io>`__

Handlers
-----------------------------------------------------
`Custom Handlers </handlers.html#custom-handlers>`_ |
`Handler DSL </dsl_handler.html>`__ |
`Community Handlers </plugin_community.html#handlers>`_

Knife Plugins
-----------------------------------------------------

`About Cloud Plugins </plugin_knife.html>`__ |
`Custom Plugins </plugin_knife_custom.html>`__ |
`Community Plugins (knife) </plugin_community.html#knife>`_

Ohai Plugins
-----------------------------------------------------
`Custom Plugins </ohai_custom.html>`__ | `Community Plugins </plugin_community.html#ohai.html>`__

Chef Client Plugins
-----------------------------------------------------

`Chef Client Plugins </plugin_community.html#chef-client>`_

Addenda
=====================================================

`Available on GitHub <https://github.com/chef/chef-web-docs>`_ |
`Get Chef <https://www.chef.io/chef/get-chef>`_ |
`Send Feedback </feedback.html>`__ |
`Support <https://www.chef.io/support>`_ |
`Site Map </index.html>`__ |
`Archive <https://docs-archive.chef.io/index.html>`_

.. Hide the TOC from this file.

.. toctree::
   :hidden:

   about_chefdk
   api_chef_server
   api_compliance
   api_automate
   api_omnitruck
   api_push_jobs
   api_reporting
   attributes
   audit_cookbook
   auth
   automate_compliance_scanner
   automate_compliance_reporting
   automate_compliance_profile_store
   automate_compliance_credentials
   automate_nodes
   automate_admin
   aws_marketplace
   aws_opsworks_chef_automate
   azure_portal
   backend_failure_recovery
   berkshelf
   chef_automate
   chef_automate_compliance
   chef_client_overview
   chef_client_security
   chef_deprecations_client
   chefdk_setup
   chef_license
   chef_overview
   chef_private_keys
   chef_quick_overview
   chef_repo
   chef_search
   chef_shell
   chef_solo
   chef_system_requirements
   chef_vault
   chefspec
   community
   community_contributions
   community_guidelines
   chef_compliance
   config_json_delivery
   config_rb
   config_rb_client
   config_rb_compliance
   config_rb_delivery
   config_rb_delivery_optional_settings
   config_rb_knife
   config_rb_knife_optional_settings
   config_rb_manage
   config_rb_metadata
   config_rb_metadata
   config_rb_policyfile
   config_rb_push_jobs_client
   config_rb_push_jobs_server
   config_rb_reporting
   config_rb_server
   config_rb_server_optional_settings
   config_rb_solo
   config_rb_supermarket
   config_yml_kitchen
   cookbook_repo
   cookbook_versions
   cookbooks
   cookstyle
   ctl_chef
   ctl_chef_apply
   ctl_chef_backend
   ctl_chef_client
   ctl_chef_server
   ctl_chef_solo
   delivery_cli
   ctl_automate_server
   ctl_kitchen
   ctl_manage
   ctl_ohai
   ctl_opscode_expander
   ctl_push_jobs_client
   ctl_reporting
   ctl_supermarket
   custom_resources
   custom_resources_notes
   data_bags
   data_collection
   data_collection_ha
   data_collection_without_server
   scaling_capacity_planning_chef_automate
   stream_data_chef_automate
   data_retention_chef_automate
   debug
   definitions
   delivery_pipeline
   delivery_build_cookbook
   delivery_manage_dependencies
   delivery_manage_secrets
   delivery_server_backup
   delivery_server_disaster_recovery
   delivery_server_tuning
   delivery_truck
   delivery_users_and_roles
   deprecations_attributes
   deprecations_chef_gem_compile_time
   deprecations_chef_platform_methods
   deprecations_chef_rest
   deprecations_chocolatey_uninstall
   deprecations_custom_resource_cleanups
   deprecations_deploy_resource
   deprecations_dnf_package_allow_downgrade
   deprecations_easy_install
   deprecations_exit_code
   deprecations_internal_api
   deprecations_json_auto_inflate
   deprecations_launchd_hash_property
   deprecations_local_listen
   deprecations_namespace_collisions
   deprecations_ohai_amazon_linux
   deprecations_ohai_cloud
   deprecations_ohai_cloud_v2
   deprecations_ohai_digitalocean
   deprecations_ohai_filesystem
   deprecations_ohai_filesystem_v2
   deprecations_ohai_legacy_config
   deprecations_ohai_libvirt_plugin
   deprecations_ohai_run_command_helpers
   deprecations_ohai_sigar_plugins
   deprecations_ohai_v6_plugins
   deprecations_ohai_windows_cpu
   deprecations_ohai_ipscopes
   deprecations_property_name_collision
   deprecations_resource_cloning
   deprecations_run_command
   deprecations_shell_out
   deprecations_supports_property
   deprecations_verify_file
   dk_windows
   dsl_audit
   dsl_custom_resource
   dsl_delivery
   dsl_handler
   dsl_recipe
   elasticsearch_and_kibana_auth
   environment_variables
   environments
   errors
   error_messages
   feedback
   files
   filter_compliance_scan
   fips
   foodcritic
   glossary
   google
   handlers
   install_chef_automate
   install_bootstrap
   install_chef_air_gap
   install_chef_compliance
   install_dk
   install_omnibus
   install_push_jobs
   install_reporting
   install_server
   install_server_ha
   install_server_ha_aws
   install_server_ha_drbd
   install_server_post
   install_server_pre
   install_server_tiered
   install_supermarket
   install_windows
   integrate_chef_automate_saml
   integrate_compliance_chef_server
   integrate_compliance_server_chef_automate
   integrate_delivery_bitbucket
   integrate_delivery_github
   integrate_delivery_ldap
   integrate_delivery_slack
   integrate_delivery_smtp
   integrate_node_notifications_slack
   integrate_node_notifications_webhook
   junos
   kitchen
   knife
   knife_options
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
   knife_setup
   knife_xargs
   libraries
   manage
   nodes
   ohai
   ohai_custom
   packages
   page_not_found
   perform_compliance_scan
   platform_overview
   platforms
   plugin_community
   plugin_kitchen_vagrant
   plugin_knife
   plugin_knife_custom
   plugin_knife_opc
   plugin_knife_push_jobs
   plugin_knife_reporting
   plugin_knife_spork
   plugin_knife_supermarket
   plugin_knife_windows
   policy
   policyfile
   profile_store
   proxies
   provisioning
   provisioning_aws
   provisioning_fog
   provisioning_vagrant
   publish_cookbooks_multiple_servers
   push_jobs
   quick_start
   recipes
   reporting
   release_notes
   release_notes_chef_automate
   release_notes_chefdk
   release_notes_server
   release_notes_push_jobs
   release_notes_ohai
   resource
   resource_apt_package
   resource_apt_preference
   resource_apt_repository
   resource_apt_update
   resource_bash
   resource_batch
   resource_bff_package
   resource_breakpoint
   resource_build_essential
   resource_cab_package
   resource_chef_acl
   resource_chef_client
   resource_chef_container
   resource_chef_data_bag
   resource_chef_data_bag_item
   resource_chef_environment
   resource_chef_gem
   resource_chef_group
   resource_chef_handler
   resource_chef_mirror
   resource_chef_node
   resource_chef_organization
   resource_chef_role
   resource_chef_user
   resource_chocolatey_package
   resource_common
   resource_cookbook_file
   resource_cron
   resource_csh
   resource_deploy
   resource_directory
   resource_dmg_package
   resource_dnf_package
   resource_dpkg_package
   resource_dsc_resource
   resource_dsc_script
   resource_erlang_call
   resource_examples
   resource_execute
   resource_file
   resource_freebsd_package
   resource_gem_package
   resource_git
   resource_group
   resource_homebrew_cask
   resource_homebrew_package
   resource_homebrew_tap
   resource_hostname
   resource_http_request
   resource_ifconfig
   resource_ips_package
   resource_ksh
   resource_launchd
   resource_link
   resource_load_balancer
   resource_log
   resource_machine
   resource_machine_batch
   resource_machine_execute
   resource_machine_file
   resource_machine_image
   resource_macos_userdefaults
   resource_macports_package
   resource_mdadm
   resource_mount
   resource_msu_package
   resource_ohai
   resource_ohai_hint
   resource_openbsd_package
   resource_openssl_rsa_private_key
   resource_openssl_rsa_public_key
   resource_openssl_dhparam
   resource_osx_profile
   resource_package
   resource_pacman_package
   resource_paludis_package
   resource_perl
   resource_portage_package
   resource_powershell_package
   resource_powershell_script
   resource_private_key
   resource_public_key
   resource_python
   resource_reboot
   resource_registry_key
   resource_remote_directory
   resource_remote_file
   resource_rhsm_errata
   resource_rhsm_errata_level
   resource_rhsm_register
   resource_rhsm_repo
   resource_rhsm_subscription
   resource_route
   resource_rpm_package
   resource_ruby
   resource_ruby_block
   resource_script
   resource_service
   resource_smartos_package
   resource_solaris_package
   resource_subversion
   resource_sudo
   resource_swap_file
   resource_sysctl
   resource_systemd_unit
   resource_template
   resource_user
   resource_windows_ad_join
   resource_windows_auto_run
   resource_windows_env
   resource_windows_feature
   resource_windows_feature_dism
   resource_windows_feature_powershell
   resource_windows_font
   resource_windows_package
   resource_windows_path
   resource_windows_printer
   resource_windows_printer_port
   resource_windows_service
   resource_windows_shortcut
   resource_windows_task
   resource_yum
   resource_yum_repository
   resource_zypper_package
   resource_zypper_repository
   resource_reference
   roles
   ruby
   run_lists
   runners
   runbook
   search_query_chef_automate
   secrets
   server_backup_restore
   server_components
   server_configure_saml
   server_data
   server_firewalls_and_ports
   server_high_availability
   server_ldap
   server_logs
   server_manage_clients
   server_manage_cookbooks
   server_manage_data_bags
   server_manage_environments
   server_manage_nodes
   server_manage_reports
   server_manage_roles
   server_monitor
   server_orgs
   server_replication
   server_security
   server_sent_events
   server_services
   server_tuning
   server_users
   setup_build_node
   style_guide
   supermarket
   supermarket_api
   supermarket_backup_restore
   supermarket_logs
   supermarket_monitor
   supermarket_share_cookbook
   templates
   troubleshooting_chef_automate
   uninstall
   upgrade_chef_automate
   upgrade_client
   upgrade_client_notes
   upgrade_compliance
   upgrade_server
   upgrade_server_ha_v2
   upgrade_server_notes
   upgrade_server_open_source_notes
   visibility
   vmware
   windows
   workflow
   actions
   analytics
   analytics_monitor
   analytics_nodes_view
   analytics_rules
   analytics_splunk
   analytics_webui_tasks
   api_analytics
   chef_client_analytics
   config_rb_analytics
   ctl_analytics
   dsl_recipe_analytics
   install_analytics
   install_reporting
   install_server_pre
   plugin_knife_analytics
   release_notes_analytics
   upgrade_analytics
