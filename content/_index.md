+++
title = "Site Map"
draft = false

aliases = "ALIASES"

[menu]
  [menu.docs]
    title = "Site Map"
    identifier = "Site Map"
    
    weight = 0
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/index.rst)

This is the documentation for:

-   Chef, including Chef Infra Server, Chef Infra Client, ChefDK, and
    related tools
-   Chef Automate

For information on Chef Habitat and Chef InSpec, see their respective
documentation:

-   [Chef Habitat documentation](https://www.habitat.sh/docs/)
-   [Chef InSpec documentation](https://www.inspec.io/docs/)

This page has links to each topic in this doc set. You can also use the
navigation tool or the search box to find what you're looking for.

If you are new to Chef Infra, we highly recommend the [Getting
Started](https://learn.chef.io/tracks/getting-started/) track on Learn
Chef to familiarize yourself with Chef Infra concepts.

If you need documentation for previous versions, see the [Docs
Archive](https://docs-archive.chef.io).

Overview
========

Chef Platform Overview
----------------------

[Platform Overview](/platform_overview/)

Community
---------

[About the Community](/community/) |
[Contributing](/community_contributions/) |
[Guidelines](/community_guidelines/) | [Docs Style
Guide](/style_guide/)

Packages and Platform Support
-----------------------------

[Licensing](/chef_license/) | [Packages](/packages/) |
[Platforms](/platforms/) | [Supported Versions](/versions/) |
[Omnitruck API](/api_omnitruck/)

Chef
====

Getting Started
---------------

[Chef Overview](/chef_overview/) | [Quick Start](/quick_start/)
| [System Requirements](/chef_system_requirements/)

**Chef Workstation**: [Chef Workstation](https://www.chef.sh/) |
[Documentation](https://www.chef.sh/docs/chef-workstation/getting-started/)

**Release Notes**: [Chef Infra Client](/release_notes/) |
[ChefDK](/release_notes_chefdk/) | [Chef Infra
Server](/release_notes_server/) | [Chef Push
Jobs](/release_notes_push_jobs/) |

[Deprecations](/chef_deprecations_client/)

Concepts
--------

[Chef Workstation](/workstation/) | [chef-repo](/chef_repo/) |
[Nodes](/nodes/) | [Chef Infra Client
Overview](/chef_client_overview/) | [Chef Infra Server
Overview](/server_overview/) | [Search](/chef_search/) |
[Cookbooks](/cookbooks/) | [Handlers](/handlers/) |
[Management Console](/manage/)

**Policy**: [About Policy](/policy/) | [Data Bags](/data_bags/)
| [Environments](/environments/) | [Roles](/roles/)

[Push Jobs](/push_jobs/) | [Run-lists](/run_lists/)

**Security**: [Authentication](/auth.html#authentication) |
[Authorization](/auth.html#authorization) |
[FIPS-mode](/ctl_chef_client.html#run-in-fips-mode.html)

**Supermarket**: [Supermarket](supermarket.html) | [Public Supermarket
(overview)](/supermarket.html#public-supermarket) | [Private
Supermarket (overview)](/supermarket.html#private-supermarket) | [Share
Cookbooks on the Chef Supermarket](/supermarket_share_cookbook/)

**Appendix**: [Env Variables](/environment_variables/) |
[Troubleshooting](/errors/) | [Glossary](/glossary/)

Guides
------

**Chef on Azure**: [Microsoft Azure Portal](/azure_portal/) | [Chef
Workstation in Azure Cloud Shell](/azure_cwa_cloud_shell/) |
[Microsoft Azure PowerShell](/azure_powershell/) | [Knife
Azure](/knife_azure/) | [Knife Azurerm](/knife_azurerm/)

**Chef on Microsoft Windows**: [Chef for Microsoft
Windows](/windows/) | [Installing Chef on
Windows](/dk_windows/) | [Chef Infra Client on Windows
Nodes](/install_windows/) | [Knife Windows](/knife_windows/)

Setup
-----

[Proxies](/proxies/) | [Installing Chef on
Windows](/dk_windows/) | [Chef Workstation](/install_dk/)

**Nodes**: [Install via Bootstrap](/install_bootstrap/) | [Install
via URL](/install_omnibus/) | [Install on
Windows](/install_windows/) | [Install on Junos OS](/junos/) |
[chef-client (executable)](/ctl_chef_client.html) |
[client.rb](/config_rb_client.html) | [Upgrades](/upgrade_client/)
| [Security](/chef_client_security/)

**Server**: [Hosted Chef Infra
Server](https://manage.chef.io/signup.html) | [Install
Standalone](/install_server.html#standalone) | [Chef Server
Prerequisites](/install_server_pre) | [Tiered
Installation](/install_server_tiered/) | [Install High
Availability](/install_server_ha/) | [Upgrade High
Availability](/upgrade_server_ha_v2/)

**Supermarket**: [Public Supermarket](https://supermarket.chef.io.html)
| [Install Private Supermarket](/install_supermarket/) |
[Customize
Supermarket](/install_supermarket.html#customize-supermarket.html) |
[Run in
Kitchen](/install_supermarket.html#run-supermarket-in-kitchen.html)

[Management Console](/ctl_chef_server.html#install) | [Push
Jobs](/install_push_jobs/)

**Integrations**: [AWS Marketplace](/aws_marketplace/) | [Microsoft
Azure](/azure_portal/) | [Google Cloud Platform](/google/) |
[VMware](/vmware/)

[Air-gapped Installation](/install_chef_air_gap/) | [Microsoft
Windows](/windows/) | [Uninstall](/uninstall/)

Cookbook Reference
------------------

[About Cookbooks](/cookbooks/) | [Attributes](/attributes/) |
[Files](/files/) | [Libraries](/libraries/)

**Recipes**: [About Recipes](/recipes/) | [Debug Recipes, Client
Runs](/debug.html)

**Resources**: [About Resources](/resource/) | [Common
Functionality](/resource_common/) | [Custom
Resources](/custom_resources/) | [Converting Definitions to Custom
Resources](/definitions/) | [All Resources (Single
Page)](/resource_reference.html) | [Examples (by
Resource)](/resource_examples.html)

[apt_package](/resource_apt_package/) |
[apt_preference](/resource_apt_preference/) |
[apt_repository](/resource_apt_repository/) |
[apt_update](/resource_apt_update/) |
[archive_file](/resource_archive_file/) |
[bash](/resource_bash/) | [batch](/resource_batch/) |
[bff_package](/resource_bff_package/) |
[breakpoint](/resource_breakpoint/) |
[build_essential](/resource_build_essential/) |
[cab_package](/resource_cab_package/) |
[chef_acl](/resource_chef_acl/) |
[chef_client](/resource_chef_client/) |
[chef_container](/resource_chef_container/) |
[chef_data_bag](/resource_chef_data_bag/) |
[chef_data_bag_item](/resource_chef_data_bag_item/) |
[chef_environment](/resource_chef_environment/) |
[chef_gem](/resource_chef_gem/) |
[chef_group](/resource_chef_group/) |
[chef_handler](/resource_chef_handler/) |
[chef_mirror](/resource_chef_mirror/) |
[chef_node](/resource_chef_node/) |
[chef_organization](/resource_chef_organization/) |
[chef_role](/resource_chef_role/) |
[chef_user](/resource_chef_user/) |
[chocolatey_config](/resource_chocolatey_config/) |
[chocolatey_feature](/resource_chocolatey_feature/) |
[chocolatey_package](/resource_chocolatey_package/) |
[chocolatey_source](/resource_chocolatey_source/) |
[cookbook_file](/resource_cookbook_file/) |
[cron](/resource_cron/) | [cron_d](/resource_cron_d/) |
[cron_access](/resource_cron_access/) | [csh](/resource_csh/)
| [deploy](/resource_deploy/) |
[directory](/resource_directory/) |
[dmg_package](/resource_dmg_package/) |
[dnf_package](/resource_dnf_package/) |
[dpkg_package](/resource_dpkg_package/) |
[dsc_resource](/resource_dsc_resource/) |
[dsc_script](/resource_dsc_script/) |
[erl_call](/resource_erlang_call/) |
[execute](/resource_execute/) | [file](/resource_file/) |
[freebsd_package](/resource_freebsd_package/) |
[gem_package](/resource_gem_package/) | [git](/resource_git/)
| [group](/resource_group/) |
[homebrew_cask](/resource_homebrew_cask/) |
[homebrew_package](/resource_homebrew_package/) |
[homebrew_tap](/resource_homebrew_tap/) |
[hostname](/resource_hostname/) |
[http_request](/resource_http_request/) |
[ifconfig](/resource_ifconfig/) |
[ips_package](/resource_ips_package/) |
[kernel_module](/resource_kernel_module/) |
[ksh](/resource_ksh/) | [launchd](/resource_launchd/) |
[link](/resource_link/) | [log](/resource_log/) |
[locale](/resource_locale/) |
[macos_userdefaults](/resource_macos_userdefaults/) |
[macports_package](/resource_macports_package/) |
[mdadm](/resource_mdadm/) | [mount](/resource_mount/) |
[msu_package](/resource_msu_package) | [ohai](/resource_ohai/) |
[ohai_hint](/resource_ohai_hint/) |
[openbsd_package](/resource_openbsd_package/) |
[openssl_dhparam](/resource_openssl_dhparam/) |
[openssl_ec_private_key](/resource_openssl_ec_private_key/) |
[openssl_ec_public_key](/resource_openssl_ec_public_key/) |
[openssl_rsa_private_key](/resource_openssl_rsa_private_key/) |
[openssl_rsa_public_key](/resource_openssl_rsa_public_key/) |
[openssl_x509_certificate](/resource_openssl_x509_certificate/) |
[openssl_x509_crl](/resource_openssl_x509_crl/) |
[openssl_x509_request](/resource_openssl_x509_request/) |
[osx_profile](/resource_osx_profile/) |
[package](/resource_package/) |
[pacman_package](/resource_pacman_package/) |
[paludis_package](/resource_paludis_package/) |
[perl](/resource_perl/) |
[portage_package](/resource_portage_package/) |
[powershell_package](/resource_powershell_package/) |
[powershell_package_source](/resource_powershell_package_source/)
| [powershell_script](/resource_powershell_script/) |
[private_key](/resource_private_key/) |
[public_key](/resource_public_key/) |
[python](/resource_python/) | [reboot](/resource_reboot/) |
[registry_key](/resource_registry_key/) |
[remote_directory](/resource_remote_directory/) |
[remote_file](/resource_remote_file/) |
[rhsm_errata](/resource_rhsm_errata/) |
[rhsm_errata_level](/resource_rhsm_errata_level/) |
[rhsm_register](/resource_rhsm_register/) |
[rhsm_repo](/resource_rhsm_repo/) |
[rhsm_subscription](/resource_rhsm_subscription/) |
[route](/resource_route/) |
[rpm_package](/resource_rpm_package/) |
[ruby](/resource_ruby/) | [ruby_block](/resource_ruby_block/)
| [script](/resource_script/) | [service](/resource_service/)
| [smartos_package](/resource_smartos_package/) |
[snap_package](/resource_snap_package/) |
[solaris_package](/resource_solaris_package/) |
[ssh_known_hosts_entry](/resource_ssh_known_hosts_entry/) |
[subversion](/resource_subversion/) | [sudo](/resource_sudo/)
| [swap_file](/resource_swap_file/) |
[sysctl](/resource_sysctl/) |
[systemd_unit](/resource_systemd_unit/) |
[template](/resource_template/) |
[timezone](/resource_timezone/) | [user](/resource_user/) |
[windows_ad_join](/resource_windows_ad_join/) |
[windows_auto_run](/resource_windows_auto_run/) |
[windows_certificate](/resource_windows_certificate/) |
[windows_dfs_folder](/resource_windows_dfs_folder/) |
[windows_dfs_namespace](/resource_windows_dfs_namespace/) |
[windows_dfs_server](/resource_windows_dfs_server/) |
[windows_dns_record](/resource_windows_dns_record/) |
[windows_dns_zone](/resource_windows_dns_zone/) |
[windows_env](/resource_windows_env/) |
[windows_feature](/resource_windows_feature/) |
[windows_feature_dism](/resource_windows_feature_dism/) |
[windows_feature_powershell](/resource_windows_feature_powershell/)
| [windows_firewall_rule](/resource_windows_firewall_rule/) |
[windows_font](/resource_windows_font/) |
[windows_package](/resource_windows_package/) |
[windows_pagefile](/resource_windows_pagefile/) |
[windows_path](/resource_windows_path/) |
[windows_printer](/resource_windows_printer/) |
[windows_printer_port](/resource_windows_printer_port/) |
[windows_service](/resource_windows_service/) |
[windows_share](/resource_windows_share/) |
[windows_shortcut](/resource_windows_shortcut/) |
[windows_task](/resource_windows_task/) |
[windows_uac](/resource_windows_uac/) |
[windows_workgroup](/resource_windows_workgroup/) |
[yum_package](/resource_yum_package/) |
[yum_repository](/resource_yum_repository/) |
[zypper_package](/resource_zypper_package/) |
[zypper_repository](/resource_zypper_repository/)

[Templates](/templates/) | [Cookbook Repo](/cookbook_repo/) |
[metadata.rb](/config_rb_metadata.html) | [Cookbook
Versioning](/cookbook_versioning/) | [Ruby Guide](/ruby/)

**Chef Automate Cookbooks**: [build-cookbook
(cookbook)](/delivery_build_cookbook.html) | [delivery-truck
(cookbook)](/delivery_truck.html) | [Publish Cookbooks to Multiple Chef
Servers](/publish_cookbooks_multiple_servers/)

ChefDK
------

[About ChefDK](/about_chefdk/) | [Berkshelf](/berkshelf/) |
[chef-apply (executable)](/ctl_chef_apply.html) | [chef-shell
(executable)](/chef_shell.html)

**chef (executable)**: [chef env](/ctl_chef.html#chef-env) | [chef
exec](/ctl_chef.html#chef-exec) | [chef gem](/ctl_chef.html#chef-gem)
| [chef generate app](/ctl_chef.html#chef-generate-app) | [chef
generate attribute](/ctl_chef.html#chef-generate-attribute) | [chef
generate cookbook](/ctl_chef.html#chef-generate-cookbook) | [chef
generate build-cookbook](/ctl_chef.html#chef-generate-build-cookbook) |
[chef generate file](/ctl_chef.html#chef-generate-file) | [chef
generate resource](/ctl_chef.html#chef-generate-resource) | [chef
generate recipe](/ctl_chef.html#chef-generate-recipe) | [chef generate
repo](/ctl_chef.html#chef-generate-repo) | [chef generate
template](/ctl_chef.html#chef-generate-template) | [chef
shell-init](/ctl_chef.html#chef-shell-init)

**Chef Solo**: [About Chef Solo](/chef_solo/) | [chef-solo
(executable)](/ctl_chef_solo.html) | [solo.rb](/config_rb_solo.html) |
[chef-zero (local mode)](/ctl_chef_client.html#run-in-local-mode) |
[chef-vault](/chef_vault/) | [ChefSpec](/chefspec/)

**Configuration**: [config.rb](/config_rb.html) | [Optional config.rb
Settings](/config_rb_optional_settings.html) | [Multiple Config
Files](/config_rb_client.html#d-directories.html) |
[cookstyle](/cookstyle/) | [Delivery CLI](/delivery_cli/) |
[Foodcritic](/foodcritic/)

**Kitchen**: [About Kitchen](/kitchen/) | [kitchen
(executable)](/ctl_kitchen.html) |
[kitchen.yml](/config_yml_kitchen.html)
[kitchen-vagrant](/plugin_kitchen_vagrant/)

**Knife**: [About Knife](/knife/) | [Common
Options](/knife_options/) | [Setting up Knife](/knife_setup/)
| [knife bootstrap](/knife_bootstrap/) | [knife
client](/knife_client/) | [knife configure](/knife_configure/)
| [knife cookbook](/knife_cookbook/) | [knife cookbook
site](/knife_cookbook_site/) | [knife data
bag](/knife_data_bag/) | [knife delete](/knife_delete/) |
[knife deps](/knife_deps/) | [knife diff](/knife_diff/) |
[knife download](/knife_download/) | [knife edit](/knife_edit/)
| [knife environment](/knife_environment/) | [knife
exec](/knife_exec/) | [knife list](/knife_list/) | [knife
node](/knife_node/) | [knife raw](/knife_raw/) | [knife recipe
list](/knife_recipe_list/) | [knife role](/knife_role/) |
[knife search](/knife_search/) | [knife serve](/knife_serve/)
| [knife show](/knife_show/) | [knife ssh](/knife_ssh/) |
[knife ssl check](/knife_ssl_check/) | [knife ssl
fetch](/knife_ssl_fetch/) | [knife status](/knife_status/) |
[knife supermarket](/knife_supermarket/) | [knife
tag](/knife_tag/) | [knife upload](/knife_upload/) | [knife
user](/knife_user/) | [knife xargs](/knife_xargs/) | [knife
azure](/knife_azure/) | [knife_azurerm](knife_azurerm.html) |
[knife windows](knife_windows.html)

**knife opc**: [About knife opc](/plugin_knife_opc/) | [config.rb
Configuration](/plugin_knife_opc.html#plugin-knife-opc-knife-rb-configuration)
| [opc user
list](/plugin_knife_opc.html#plugin-knife-opc-opc-user-list) | [opc
user show](/plugin_knife_opc.html#plugin-knife-opc-opc-user-show) |
[opc user
create](/plugin_knife_opc.html#plugin-knife-opc-opc-user-create) | [opc
user delete](/plugin_knife_opc.html#plugin-knife-opc-opc-user-delete) |
[opc user delete](/plugin_knife_opc.html#plugin-knife-opc-opc-user-edit)
| [opc org list](/plugin_knife_opc.html#plugin-knife-opc-opc-org-list)
| [opc org show](/plugin_knife_opc.html#plugin-knife-opc-opc-org-show)
| [opc org
create](/plugin_knife_opc.html#plugin-knife-opc-opc-org-create) | [opc
org delete](/plugin_knife_opc.html#plugin-knife-opc-opc-org-delete) |
[opc org user
add](/plugin_knife_opc.html#plugin-knife-opc-opc-org-user-add) | [opc
org user
remove](/plugin_knife_opc.html#plugin-knife-opc-opc-org-user-remove) |
[knife spork](/plugin_knife_spork/)

**Ohai**: [About Ohai](/ohai/) | [ohai
(executable)](/ctl_ohai.html)

**Policyfile**: [About Policyfile](/policyfile/) |
[Policyfile.rb](/config_rb_policyfile.html)

[push-jobs-client (executable)](/ctl_push_jobs_client.html)

**Managing the Server**: [Runbook (Single Page)](/runbook.html) |
[Backend Cluster Failure Recovery](/backend_failure_recovery/) |
[Backup and Restore](/server_backup_restore/) | [Firewalls and
Ports](/server_firewalls_and_ports/) | [Active Directory and
LDAP](/server_ldap/) | [Log Files](/server_logs/) |
[Monitor](/server_monitor/) | [Organizations and
Groups](/server_orgs/) | [Secrets](/secrets/) |
[Security](/server_security/) | [Services](/server_services/)
| [Tuning](/server_tuning/) | [Upgrades](/upgrade_server/) |
[Upgrade HA Cluster](/upgrade_server_ha_v2/) |
[Users](/server_users/) | [chef-server-ctl](/ctl_chef_server/)
| [chef-backend-ctl](/ctl_chef_backend/) |
[chef-server.rb](/config_rb_server.html) | [Chef Server Optional
Settings](/config_rb_server_optional_settings/) |
[opscode-expander-ctl](/ctl_opscode_expander/) | [Chef Infra Server
API](/api_chef_server/)

**Push Jobs**: [knife push jobs](/plugin_knife_push_jobs/) |
[push-jobs-client](/ctl_push_jobs_client/) |
[push-jobs-client.rb](/config_rb_push_jobs_client.html) |
[push-jobs-server.rb](/config_rb_push_jobs_server.html) | [Push Jobs
API](/api_push_jobs/) | [Server Sent
Events](/server_sent_events/)

**Supermarket**: [Log Files](/supermarket_logs/) | [Backup and
Restore](/supermarket_backup_restore/) |
[Monitoring](/supermarket_monitor/) |
[supermarket.rb](/config_rb_supermarket.html) | [knife
supermarket](/knife_supermarket/) |
[supermarket-ctl](/ctl_supermarket/) | [Supermarket
API](/supermarket_api/)

**Management Console**: [Configure SAML](/server_configure_saml/) |
[Clients](/server_manage_clients/) |
[Cookbooks](/server_manage_cookbooks/) | [Data
Bags](/server_manage_data_bags/) |
[Environments](/server_manage_environments/) |
[Nodes](/server_manage_nodes/) | [Roles](/server_manage_roles/)
| [Users](/server_users.html#chef-manage.html) |
[manage.rb](/config_rb_manage.html) |
[chef-manage-ctl](/ctl_manage/)

Chef Automate
=============

[Chef Automate Documentation](https://automate.chef.io/docs/) | [Quick
Start Demo](https://automate.chef.io/docs/quickstart/) | [System
Requirements](https://automate.chef.io/docs/system-requirements/) |
[Upgrade from Chef Automate One](https://automate.chef.io/docs/upgrade/)
| [Installation Guide](https://automate.chef.io/docs/install/) |
[Backup and Restore](https://automate.chef.io/docs/backup/) |
[Configuration](https://automate.chef.io/docs/configuration/) | [Data
Collection](https://automate.chef.io/docs/data-collection/) | [Log
Management](https://automate.chef.io/docs/log-management/) |
[Telemetry](https://automate.chef.io/docs/telemetry/) | [Event
Feed](https://automate.chef.io/docs/event-feed/) | [Client
Runs](https://automate.chef.io/docs/client-runs/) | [Scan
Jobs](https://automate.chef.io/docs/scan-jobs/) | [Nodes
API](https://automate.chef.io/docs/nodes/) | [Cloud
Integrations](https://automate.chef.io/docs/integrations/) | [Asset
Store](https://automate.chef.io/docs/asset-store/) | [Admin
Panel](https://automate.chef.io/docs/admin/) |
[Credentials](https://automate.chef.io/docs/credentials/) |
[Notifications](https://automate.chef.io/docs/notifications/) | [Node
Integrations](https://automate.chef.io/docs/integrations-ui/) |
[Authorization](https://automate.chef.io/docs/authorization/) | [Users
and Teams](https://automate.chef.io/docs/users-and-teams/) | [API
Tokens](https://automate.chef.io/docs/api-tokens/) | [Default
Policies](https://automate.chef.io/docs/default-policies/) | [LDAP
Integration](https://automate.chef.io/docs/ldap/) |
[Architecture](https://automate.chef.io/docs/architectural-overview/) |
[Chef Automate CLI](https://automate.chef.io/docs/cli-chef-automate/) |
[ServiceNow
Integration](https://automate.chef.io/docs/servicenow-integration-install/)
| [Troubleshooting](https://automate.chef.io/docs/troubleshooting/)

Chef Habitat
============

**Documentation**: [Chef Habitat
Documentation](https://www.habitat.sh/docs/)

**Tutorials**: [Chef Habitat
Tutorials](https://www.habitat.sh/tutorials/)

Chef InSpec
===========

**Documentation**: [Chef InSpec
Documentation](https://www.inspec.io/docs/)

**Tutorials**: [Chef InSpec Tutorials](https://www.inspec.io/tutorials/)

Legacy
======

Chef Automate 1
---------------

**Overview**: [Chef Automate Overview](/chef_automate/) | [Workflow
Overview](/workflow/) | [Nodes Overview](/visibility/) |
[Compliance Overview](/chef_automate_compliance/) | [Administration
Overview](/automate_admin/)

**Getting Started**: [Installation Guide](/install_chef_automate/)
| [Configure a Pipeline](/delivery_pipeline/) | [Configure a
Project](/config_json_delivery/) | [Configure Data
Collection](/data_collection/) | [Data Collection and Chef
HA](/data_collection_ha/) | [Data Collection without Chef Infra
Server](/data_collection_without_server/) | [Stream
Data](/stream_data_chef_automate/) |
[Upgrades](/upgrade_chef_automate/)

**Release Notes**: [Release Notes](/release_notes_chef_automate/)

**Nodes**: [Node Notifications
w/Slack](/integrate_node_notifications_slack.html) | [Node
Notifications w/Webhooks](/integrate_node_notifications_webhook.html) |
[Node Search Reference](/search_query_chef_automate/)

**Compliance**: [Reporting](/automate_compliance_reporting/) |
[Scanner](/automate_compliance_scanner/) | [Profile
Store](/profile_store/) |
[Credentials](/automate_compliance_credentials/)

**Workflow**: [build-cookbook (cookbook)](/delivery_build_cookbook.html)
| [delivery-truck (cookbook)](/delivery_truck.html) | [Manage
Dependencies](/delivery_manage_dependencies/) |
[Runners](/runners/) | [Workflow
w/Bitbucket](/integrate_delivery_bitbucket.html) | [Workflow w/Email
(SMTP)](/integrate_delivery_smtp.html) | [Workflow
w/GitHub](/integrate_delivery_github.html) | [Workflow
w/Slack](/integrate_delivery_slack.html)

**Admin**: [Authentication w/LDAP](/integrate_delivery_ldap.html) |
[Authentication w/SAML](/integrate_chef_automate_saml.html)

**Managing the Server**: [Backups](/delivery_server_backup/) |
[Capacity Planning](/scaling_capacity_planning_chef_automate/) |
[Disaster Recovery](/delivery_server_disaster_recovery/) |
[Elasticsearch and Kibana
Authentication](/elasticsearch_and_kibana_auth/) |
[Secrets](/delivery_manage_secrets/) | [Data Retention Management
in Chef Automate](/data_retention_chef_automate/) |
[Tuning](/delivery_server_tuning/) | [Users and
Roles](/delivery_users_and_roles/)

**Reference**: [Chef Automate API](/api_automate/) | [Automate
CTL](/ctl_automate_server/) | [Delivery CLI](/delivery_cli/) |
[delivery.rb](/config_rb_delivery.html) | [Workflow
DSL](/dsl_delivery/)

**Chef Automate for Microsoft Azure**: [Chef Automate for Microsoft
Azure](/automate_azure/)

**AWS OpsWorks for Chef Automate**: [AWS OpsWorks for Chef
Automate](/aws_opsworks_chef_automate/)

**Troubleshooting**:
[Troubleshooting](/troubleshooting_chef_automate/)

Extension APIs
==============

Resources
---------

**Recipe DSL**: [attribute?](/dsl_recipe.html#attribute) |
[control](/dsl_recipe.html#control) |
[control_group](/dsl_recipe.html#control-group) |
[cookbook_name](/dsl_recipe.html#cookbook-name) |
[data_bag](/dsl_recipe.html#data-bag) |
[data_bag_item](/dsl_recipe.html#data-bag-item) |
[platform?](/dsl_recipe.html#platform) |
[platform_family?](/dsl_recipe.html#platform-family) |
[reboot_pending?](/dsl_recipe.html#reboot-pending) |
[recipe_name](/dsl_recipe.html#recipe-name) |
[registry_data_exists?](/dsl_recipe.html#registry-data-exists) |
[registry_get_subkeys](/dsl_recipe.html#registry-get-subkeys) |
[registry_get_values](/dsl_recipe.html#registry-get-values) |
[registry_has_subkeys?](/dsl_recipe.html#registry-has-subkeys) |
[registry_key_exists?](/dsl_recipe.html#registry-key-exists) |
[registry_value_exists?](/dsl_recipe.html#registry-value-exists) |
[resources](/dsl_recipe.html#resources) |
[search](/dsl_recipe.html#search) |
[shell_out](/dsl_recipe.html#shell-out) |
[shell_out!](/dsl_recipe.html#shell-out-bang) |
[shell_out_with_systems_locale](/dsl_recipe.html#shell-out-with-systems-locale)
| [tag](/dsl_recipe.html#tag-tagged-untag) |
[tagged?](/dsl_recipe.html#tag-tagged-untag) |
[untag](/dsl_recipe.html#tag-tagged-untag) |
[value_for_platform](/dsl_recipe.html#value-for-platform) |
[value_for_platform_family](/dsl_recipe.html#value-for-platform-family)
| [Windows Platform Helpers](/dsl_recipe.html#helpers) | [Custom
Resource DSL](/dsl_custom_resource) | [Community
Resources](https://supermarket.chef.io)

Handlers
--------

[Custom Handlers](/handlers.html#custom-handlers) | [Handler
DSL](/dsl_handler/) | [Community
Handlers](/plugin_community.html#handlers)

Knife Plugins
-------------

[Cloud Plugins](/plugin_knife/) | [Writing Custom
Plugins](/plugin_knife_custom/) | [Community Plugins
(knife)](/plugin_community.html#knife)

Ohai Plugins
------------

[Custom Plugins](/ohai_custom/) | [Community
Plugins](/plugin_community.html#ohai)

Chef Infra Client Plugins
-------------------------

[Chef Infra Client Plugins](/plugin_community.html#chef-infra-client)

Addenda
=======

[Available on GitHub](https://github.com/chef/chef-web-docs) | [Get
Chef](https://www.chef.io/chef/get-chef) | [Send
Feedback](/feedback/) | [Support](https://www.chef.io/support) |
[Site Map](/index/) |
[Archive](https://docs-archive.chef.io/index.html)

<div class="toctree" markdown="1" hidden="">

about_chefdk api_automate api_chef_server api_omnitruck
api_push_jobs attributes audit_cookbook auth automate_azure
automate_compliance_credentials automate_compliance_reporting
automate_compliance_scanner aws_marketplace
aws_opsworks_chef_automate azure_chef_cli azure_cwa_cloud_shell
azure_portal azure_powershell backend_failure_recovery berkshelf
chef_automate chef_automate_compliance chef_client_overview
chef_client_security chef_deprecations_client chef_license
chef_license_accept chef_overview chef_repo chef_search chef_shell
chef_solo chef_system_requirements chef_vault chefdk_setup chefspec
community community_contributions community_guidelines
config_json_delivery config_rb config_rb_client
config_rb_delivery config_rb_delivery_optional_settings
config_rb_manage config_rb_metadata config_rb_metadata
config_rb_optional_settings config_rb_policyfile
config_rb_push_jobs_client config_rb_push_jobs_server
config_rb_server config_rb_server_optional_settings
config_rb_solo config_rb_supermarket config_yml_kitchen
cookbook_repo cookbook_versioning cookbooks cookstyle
ctl_automate_server ctl_chef ctl_chef_apply ctl_chef_backend
ctl_chef_client ctl_chef_server ctl_chef_solo ctl_kitchen
ctl_manage ctl_ohai ctl_opscode_expander ctl_push_jobs_client
ctl_supermarket custom_resources custom_resources_notes data_bags
data_collection data_collection_ha data_collection_without_server
data_retention_chef_automate debug definitions
delivery_build_cookbook delivery_cli delivery_manage_dependencies
delivery_manage_secrets delivery_pipeline delivery_server_backup
delivery_server_disaster_recovery delivery_server_tuning
delivery_truck delivery_users_and_roles deprecations_attributes
deprecations_chef_gem_compile_time
deprecations_chef_platform_methods deprecations_chef_rest
deprecations_chocolatey_uninstall
deprecations_custom_resource_cleanups deprecations_deploy_resource
deprecations_dnf_package_allow_downgrade deprecations_easy_install
deprecations_epic_fail deprecations_erl_call_resource
deprecations_exit_code deprecations_internal_api
deprecations_json_auto_inflate deprecations_launchd_hash_property
deprecations_legacy_hwrp_mixins deprecations_local_listen
deprecations_locale_lc_all deprecations_map_collision
deprecations_namespace_collisions deprecations_ohai_amazon_linux
deprecations_ohai_cloud deprecations_ohai_cloud_v2
deprecations_ohai_digitalocean deprecations_ohai_filesystem
deprecations_ohai_filesystem_v2 deprecations_ohai_ipscopes
deprecations_ohai_legacy_config deprecations_ohai_libvirt_plugin
deprecations_ohai_run_command_helpers
deprecations_ohai_sigar_plugins deprecations_ohai_v6_plugins
deprecations_ohai_windows_cpu deprecations_property_name_collision
deprecations_resource_cloning deprecations_run_command
deprecations_shell_out deprecations_supports_property
deprecations_verify_file depreciations_ohai_system_profile
dk_windows dsl_custom_resource dsl_delivery dsl_handler dsl_recipe
elasticsearch_and_kibana_auth environment_variables environments
errors feedback files filter_compliance_scan fips foodcritic glossary
google handlers install_bootstrap install_chef_air_gap
install_chef_automate install_dk install_omnibus install_push_jobs
install_server install_server_ha install_server_pre
install_server_tiered install_supermarket install_windows
integrate_chef_automate_saml integrate_delivery_bitbucket
integrate_delivery_github integrate_delivery_ldap
integrate_delivery_slack integrate_delivery_smtp
integrate_node_notifications_slack
integrate_node_notifications_webhook junos kitchen knife knife_azure
knife_azurerm knife_bootstrap knife_client knife_configure
knife_cookbook knife_cookbook_site knife_data_bag knife_delete
knife_deps knife_diff knife_download knife_edit knife_environment
knife_exec knife_list knife_node knife_options knife_raw
knife_recipe_list knife_role knife_search knife_serve knife_setup
knife_show knife_ssh knife_ssl_check knife_ssl_fetch knife_status
knife_supermarket knife_tag knife_upload knife_user knife_windows
knife_xargs libraries manage nodes ohai ohai_custom packages
perform_compliance_scan platform_overview platforms plugin_community
plugin_kitchen_vagrant plugin_knife plugin_knife_custom
plugin_knife_opc plugin_knife_push_jobs plugin_knife_spork policy
policyfile profile_store provisioning provisioning_aws
provisioning_fog provisioning_vagrant proxies
publish_cookbooks_multiple_servers push_jobs quick_start recipes
release_notes release_notes_chef_automate release_notes_chefdk
release_notes_push_jobs release_notes_server resource
resource_apt_package resource_apt_preference
resource_apt_repository resource_apt_update resource_archive_file
resource_bash resource_batch resource_bff_package
resource_breakpoint resource_build_essential resource_cab_package
resource_chef_acl resource_chef_client resource_chef_container
resource_chef_data_bag resource_chef_data_bag_item
resource_chef_environment resource_chef_gem resource_chef_group
resource_chef_handler resource_chef_mirror resource_chef_node
resource_chef_organization resource_chef_role resource_chef_user
resource_chocolatey_feature resource_chocolatey_package
resource_common resource_cookbook_file resource_cron resource_csh
resource_deploy resource_directory resource_dmg_package
resource_dnf_package resource_dpkg_package resource_dsc_resource
resource_dsc_script resource_erlang_call resource_examples
resource_execute resource_file resource_freebsd_package
resource_gem_package resource_git resource_group
resource_homebrew_cask resource_homebrew_package
resource_homebrew_tap resource_hostname resource_http_request
resource_ifconfig resource_ips_package resource_ksh
resource_launchd resource_link resource_load_balancer resource_log
resource_machine resource_machine_batch resource_machine_execute
resource_machine_file resource_machine_image
resource_macos_userdefaults resource_macports_package
resource_mdadm resource_mount resource_msu_package resource_ohai
resource_ohai_hint resource_openbsd_package
resource_openssl_dhparam resource_openssl_ec_private_key
resource_openssl_ec_public_key resource_openssl_rsa_private_key
resource_openssl_rsa_public_key resource_openssl_x509_certificate
resource_openssl_x509_crl resource_openssl_x509_request
resource_osx_profile resource_package resource_pacman_package
resource_paludis_package resource_perl resource_portage_package
resource_powershell_package resource_powershell_script
resource_private_key resource_public_key resource_python
resource_reboot resource_reference resource_registry_key
resource_remote_directory resource_remote_file
resource_rhsm_errata resource_rhsm_errata_level
resource_rhsm_register resource_rhsm_repo
resource_rhsm_subscription resource_route resource_rpm_package
resource_ruby resource_ruby_block resource_script resource_service
resource_smartos_package resource_snap_package
resource_solaris_package resource_subversion resource_sudo
resource_swap_file resource_sysctl resource_systemd_unit
resource_template resource_timezone resource_user
resource_windows_ad_join resource_windows_auto_run
resource_windows_dfs_folder resource_windows_dfs_namespace
resource_windows_dfs_server resource_windows_dns_record
resource_windows_dns_zone resource_windows_env
resource_windows_feature resource_windows_feature_dism
resource_windows_feature_powershell resource_windows_font
resource_windows_package resource_windows_path
resource_windows_printer resource_windows_printer_port
resource_windows_service resource_windows_shortcut
resource_windows_task resource_windows_uac resource_yum_package
resource_yum_repository resource_zypper_package
resource_zypper_repository roles ruby run_lists runbook runners
scaling_capacity_planning_chef_automate
search_query_chef_automate secrets server_backup_restore
server_configure_saml server_firewalls_and_ports server_ldap
server_logs server_manage_clients server_manage_cookbooks
server_manage_data_bags server_manage_environments
server_manage_nodes server_manage_roles server_monitor server_orgs
server_overview server_security server_sent_events server_services
server_tuning server_users stream_data_chef_automate style_guide
supermarket supermarket_api supermarket_backup_restore
supermarket_logs supermarket_monitor supermarket_share_cookbook
templates troubleshooting_chef_automate uninstall
upgrade_chef_automate upgrade_client upgrade_server
upgrade_server_ha_v2 versions visibility vmware windows workflow

</div>
