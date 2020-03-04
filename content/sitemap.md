+++
title = "Site Map"
draft = false

toc = false








+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/sitemap.md)

This is the documentation for:

-   Chef Infra Server, Chef Infra Client, Chef Workstation, and related
    tools

Documentation for other Chef products:

-   [Chef Automate 2.0](https://automate.chef.io/docs/quickstart)
-   [Chef Habitat](https://www.habitat.sh/docs/)
-   [Chef InSpec](https://www.inspec.io/docs/)

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

[Packages](/packages/) | [Platforms](/platforms/) | [Supported
Versions](/versions/) | [Omnitruck API](/api_omnitruck/)

**Licensing**: [About Licensing](/chef_license/) | [Accepting
License](/chef_license_accept/)

Chef Infra
==========

Getting Started
---------------

[Chef Infra Overview](/chef_overview/) | [Quick
Start](/quick_start/) | [System
Requirements](/chef_system_requirements/)

**Release Notes**: [Chef Infra Client](/release_notes/) |
[ChefDK](/release_notes_chefdk/) | [Chef Infra
Server](/release_notes_server/) | [Chef Push
Jobs](/release_notes_push_jobs/) |

[Deprecations](/chef_deprecations_client/)

Concepts
--------

[Chef Workstation](/about_workstation/) |
[chef-repo](/chef_repo/) | [Nodes](/nodes/) | [Chef Infra
Client Overview](/chef_client_overview/) | [Chef Infra Server
Overview](/server_overview/) | [Search](/chef_search/) |
[Cookbooks](/cookbooks/) | [Handlers](/handlers/)

**Policy**: [About Policy](/policy/) | [Data Bags](/data_bags/)
| [Environments](/environments/) | [Roles](/roles/)

[Push Jobs](/push_jobs/) | [Run-lists](/run_lists/)

**Security**: [Authentication](/auth/#authentication) |
[Authorization](/auth/#authorization) |
[FIPS-mode](/ctl_chef_client/#run-in-fips-mode.html)

**Supermarket**: [Supermarket](supermarket.html) | [Public Supermarket
(overview)](/supermarket/#public-supermarket) | [Private
Supermarket (overview)](/supermarket/#private-supermarket) | [Share
Cookbooks on the Chef Supermarket](/supermarket_share_cookbook/)

**Appendix**: [Troubleshooting](/errors/) |
[Glossary](/glossary/)

Guides
------

**Chef on Azure**: [Microsoft Azure Portal](/azure_portal/) | [Chef
Workstation in Azure Cloud Shell](/azure_cwa_cloud_shell/) |
[Microsoft Azure PowerShell](/azure_powershell/) | [Microsoft Azure
Chef Extension](/azure_chef_cli/) | Knife Azure
\</knife_azure.html\><span class="title-ref">__ | \`Knife Azurerm
\</knife_azurerm.html\></span>__

**Chef on Microsoft Windows**: [Chef for Microsoft
Windows](/windows/) | [Chef Infra Client on Windows
Nodes](/install_windows/) | [Knife Windows](/knife_windows/)

Setup
-----

[Proxies](/proxies/) | [Install Chef
Workstation](/install_workstation/)

**Nodes**: [Install via Bootstrap](/install_bootstrap/) | [Install
via Script](/install_omnibus/) | [chef-client
(executable)](/ctl_chef_client/) |
[client.rb](/config_rb_client/) | [Upgrades](/upgrade_client/)
| [Security](/chef_client_security/)

**Server**: [Hosted Chef Infra
Server](https://manage.chef.io/signup.html) | [Install
Standalone](/install_server/#standalone) | [Chef Infra Server
Prerequisites](/install_server_pre/) | [Tiered
Installation](/install_server_tiered/) | [Install High
Availability](/install_server_ha/) | [Upgrade High
Availability](/upgrade_server_ha_v2/)

**Supermarket**: [Public Supermarket](https://supermarket.chef.io.html)
| [Install Private Supermarket](/install_supermarket/) |
[Customize
Supermarket](/install_supermarket/#customize-supermarket.html) |
[Run in
Kitchen](/install_supermarket/#run-supermarket-in-kitchen.html)

[Management Console](/ctl_chef_server/#install) | [Push
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
Runs](/debug/)

**Resources**: [About Resources](/resource/) | [Common Resource
Functionality](/resource_common/) | [Custom
Resources](/custom_resources/) | [Custom Resources
Guide](/custom_resources_notes/) | [Converting Definitions to
Custom Resources](/definitions/)

[All Resources (Single Page)](/resources/) |
[apt_package](/resources/apt_package/) |
[apt_preference](/resources/apt_preference/) |
[apt_repository](/resources/apt_repository/) |
[apt_update](/resources/apt_update/) |
[archive_file](/resources/archive_file/) |
[bash](/resources/bash/) | [batch](/resources/batch/) |
[bff_package](/resources/bff_package/) |
[breakpoint](/resources/breakpoint/) |
[build_essential](/resources/build_essential/) |
[cab_package](/resources/cab_package/) |
[chef_acl](/resources/chef_acl/) |
[chef_client](/resources/chef_client/) |
[chef_container](/resources/chef_container/) |
[chef_data_bag](/resources/chef_data_bag/) |
[chef_data_bag_item](/resources/chef_data_bag_item/) |
[chef_environment](/resources/chef_environment/) |
[chef_gem](/resources/chef_gem/) |
[chef_group](/resources/chef_group/) |
[chef_handler](/resources/chef_handler/) |
[chef_mirror](/resources/chef_mirror/) |
[chef_node](/resources/chef_node/) |
[chef_organization](/resources/chef_organization/) |
[chef_role](/resources/chef_role/) |
[chef_sleep](/resources/chef_sleep/) |
[chef_user](/resources/chef_user/) |
[chocolatey_config](/resources/chocolatey_config/) |
[chocolatey_feature](/resources/chocolatey_feature/) |
[chocolatey_package](/resources/chocolatey_package/) |
[chocolatey_source](/resources/chocolatey_source/) |
[cookbook_file](/resources/cookbook_file/) |
[cron](/resources/cron/) | [cron_d](/resources/cron_d/) |
[cron_access](/resources/cron_access/) | [csh](/resources/csh/)
| [directory](/resources/directory/) |
[dmg_package](/resources/dmg_package/) |
[dnf_package](/resources/dnf_package/) |
[dpkg_package](/resources/dpkg_package/) |
[dsc_resource](/resources/dsc_resource/) |
[dsc_script](/resources/dsc_script/) |
[execute](/resources/execute/) | [file](/resources/file/) |
[freebsd_package](/resources/freebsd_package/) |
[gem_package](/resources/gem_package/) | [git](/resources/git/)
| [group](/resources/group/) |
[homebrew_cask](/resources/homebrew_cask/) |
[homebrew_package](/resources/homebrew_package/) |
[homebrew_tap](/resources/homebrew_tap/) |
[hostname](/resources/hostname/) |
[http_request](/resources/http_request/) |
[ifconfig](/resources/ifconfig/) |
[ips_package](/resources/ips_package/) |
[kernel_module](/resources/kernel_module/) |
[ksh](/resources/ksh/) | [launchd](/resources/launchd/) |
[link](/resources/link/) | [log](/resources/log/) |
[locale](/resources/locale/) |
[macos_userdefaults](/resources/macos_userdefaults/) |
[macports_package](/resources/macports_package/) |
[mdadm](/resources/mdadm/) | [mount](/resources/mount/) |
[msu_package](/resources/msu_package/) |
[ohai](/resources/ohai/) | [ohai_hint](/resources/ohai_hint/) |
[openbsd_package](/resources/openbsd_package/) |
[openssl_dhparam](/resources/openssl_dhparam/) |
[openssl_ec_private_key](/resources/openssl_ec_private_key/) |
[openssl_ec_public_key](/resources/openssl_ec_public_key/) |
[openssl_rsa_private_key](/resources/openssl_rsa_private_key/) |
[openssl_rsa_public_key](/resources/openssl_rsa_public_key/) |
[openssl_x509_certificate](/resources/openssl_x509_certificate/) |
[openssl_x509_crl](/resources/openssl_x509_crl/) |
[openssl_x509_request](/resources/openssl_x509_request/) |
[osx_profile](/resources/osx_profile/) |
[package](/resources/package/) |
[pacman_package](/resources/pacman_package/) |
[paludis_package](/resources/paludis_package/) |
[perl](/resources/perl/) |
[portage_package](/resources/portage_package/) |
[powershell_package](/resources/powershell_package/) |
[powershell_package_source](/resources/powershell_package_source/)
| [powershell_script](/resources/powershell_script/) |
[python](/resources/python/) | [reboot](/resources/reboot/) |
[registry_key](/resources/registry_key/) |
[remote_directory](/resources/remote_directory/) |
[remote_file](/resources/remote_file/) |
[rhsm_errata](/resources/rhsm_errata/) |
[rhsm_errata_level](/resources/rhsm_errata_level/) |
[rhsm_register](/resources/rhsm_register/) |
[rhsm_repo](/resources/rhsm_repo/) |
[rhsm_subscription](/resources/rhsm_subscription/) |
[route](/resources/route/) |
[rpm_package](/resources/rpm_package/) |
[ruby](/resources/ruby/) | [ruby_block](/resources/ruby_block/)
| [script](/resources/script/) | [service](/resources/service/)
| [smartos_package](/resources/smartos_package/) |
[snap_package](/resources/snap_package/) |
[solaris_package](/resources/solaris_package/) |
[ssh_known_hosts_entry](/resources/ssh_known_hosts_entry/) |
[subversion](/resources/subversion/) | [sudo](/resources/sudo/)
| [swap_file](/resources/swap_file/) |
[sysctl](/resources/sysctl/) |
[systemd_unit](/resources/systemd_unit/) |
[template](/resources/template/) |
[timezone](/resources/timezone/) | [user](/resources/user/) |
[windows_ad_join](/resources/windows_ad_join/) |
[windows_auto_run](/resources/windows_auto_run/) |
[windows_certificate](/resources/windows_certificate/) |
[windows_dfs_folder](/resources/windows_dfs_folder/) |
[windows_dfs_namespace](/resources/windows_dfs_namespace/) |
[windows_dfs_server](/resources/windows_dfs_server/) |
[windows_dns_record](/resources/windows_dns_record/) |
[windows_dns_zone](/resources/windows_dns_zone/) |
[windows_env](/resources/windows_env/) |
[windows_feature](/resources/windows_feature/) |
[windows_feature_dism](/resources/windows_feature_dism/) |
[windows_feature_powershell](/resources/windows_feature_powershell/)
| [windows_firewall_rule](/resources/windows_firewall_rule/) |
[windows_font](/resources/windows_font/) |
[windows_package](/resources/windows_package/) |
[windows_pagefile](/resources/windows_pagefile/) |
[windows_path](/resources/windows_path/) |
[windows_printer](/resources/windows_printer/) |
[windows_printer_port](/resources/windows_printer_port/) |
[windows_service](/resources/windows_service/) |
[windows_share](/resources/windows_share/) |
[windows_shortcut](/resources/windows_shortcut/) |
[windows_task](/resources/windows_task/) |
[windows_uac](/resources/windows_uac/) |
[windows_workgroup](/resources/windows_workgroup/) |
[yum_package](/resources/yum_package/) |
[yum_repository](/resources/yum_repository/) |
[zypper_package](/resources/zypper_package/) |
[zypper_repository](/resources/zypper_repository/)
[Templates](/templates/) | [Cookbook Repo](/cookbook_repo/) |
[metadata.rb](/config_rb_metadata/) | [Cookbook
Versioning](/cookbook_versioning/) | [Ruby Guide](/ruby/)

**Chef Automate Cookbooks**: [build-cookbook
(cookbook)](/delivery_build_cookbook/) | [delivery-truck
(cookbook)](/delivery_truck/) |

Chef Workstation
----------------

[About Chef Workstation](/about_workstation/) | [Configure Chef
Workstation](/workstation_setup/) | [Berkshelf](/berkshelf/) |
[chef-apply (executable)](/ctl_chef_apply/) | [chef-shell
(executable)](/chef_shell/)

**chef (executable)**: [chef env](/ctl_chef/#chef-env) | [chef
exec](/ctl_chef/#chef-exec) | [chef gem](/ctl_chef/#chef-gem)
| [chef generate app](/ctl_chef/#chef-generate-app) | [chef
generate attribute](/ctl_chef/#chef-generate-attribute) | [chef
generate cookbook](/ctl_chef/#chef-generate-cookbook) | [chef
generate build-cookbook](/ctl_chef/#chef-generate-build-cookbook) |
[chef generate file](/ctl_chef/#chef-generate-file) | [chef
generate resource](/ctl_chef/#chef-generate-resource) | [chef
generate recipe](/ctl_chef/#chef-generate-recipe) | [chef generate
repo](/ctl_chef/#chef-generate-repo) | [chef generate
template](/ctl_chef/#chef-generate-template) | [chef
shell-init](/ctl_chef/#chef-shell-init)

**Chef Solo**: [About Chef Solo](/chef_solo/) | [chef-solo
(executable)](/ctl_chef_solo/) | [solo.rb](/config_rb_solo/) |
[chef-zero (local mode)](/ctl_chef_client/#run-in-local-mode) |
[chef-vault](/chef_vault/) | [ChefSpec](/chefspec/)

**Configuration**: [config.rb](/config_rb/) | [Optional config.rb
Settings](/config_rb_optional_settings/) | [Multiple Config
Files](/config_rb_client/#d-directories.html) |
[cookstyle](/cookstyle/) | [Delivery CLI](/delivery_cli/) |
[Foodcritic](/foodcritic/)

**Kitchen**: [About Kitchen](/kitchen/) | [kitchen
(executable)](/ctl_kitchen/) |
[kitchen.yml](/config_yml_kitchen/)
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
Configuration](/plugin_knife_opc/#plugin-knife-opc-knife-rb-configuration)
| [opc user
list](/plugin_knife_opc/#plugin-knife-opc-opc-user-list) | [opc
user show](/plugin_knife_opc/#plugin-knife-opc-opc-user-show) |
[opc user
create](/plugin_knife_opc/#plugin-knife-opc-opc-user-create) | [opc
user delete](/plugin_knife_opc/#plugin-knife-opc-opc-user-delete) |
[opc user delete](/plugin_knife_opc/#plugin-knife-opc-opc-user-edit)
| [opc org list](/plugin_knife_opc/#plugin-knife-opc-opc-org-list)
| [opc org show](/plugin_knife_opc/#plugin-knife-opc-opc-org-show)
| [opc org
create](/plugin_knife_opc/#plugin-knife-opc-opc-org-create) | [opc
org delete](/plugin_knife_opc/#plugin-knife-opc-opc-org-delete) |
[opc org user
add](/plugin_knife_opc/#plugin-knife-opc-opc-org-user-add) | [opc
org user
remove](/plugin_knife_opc/#plugin-knife-opc-opc-org-user-remove)

**Ohai**: [About Ohai](/ohai/) | [ohai
(executable)](/ctl_ohai/)

**Policyfile**: [About Policyfile](/policyfile/) |
[Policyfile.rb](/config_rb_policyfile/)

[push-jobs-client (executable)](/ctl_push_jobs_client/)

**Managing Chef Infra Server**: [Runbook (Single Page)](/runbook/)
| [Backend Cluster Failure Recovery](/backend_failure_recovery/) |
[Backup and Restore]\(/runbook/server_backup_restore/) | [Firewalls and
Ports]\(/runbook/server_firewalls_and_ports/) | [Active Directory and
LDAP](/server_ldap/) | [Log Files]\(/runbook/server_logs/) |
[Monitor]\(/runbook/server_monitor/) | [Organizations and
Groups](/server_orgs/) | [Secrets](/secrets/) |
[Security]\(/runbook/server_security/) | [Services]\(/runbook/server_services/)
| [Tuning]\(/runbook/server_tuning/) | [Upgrades](/upgrade_server/) |
[Upgrade HA Cluster](/upgrade_server_ha_v2/) |
[Users](/server_users/) | [chef-server-ctl](/ctl_chef_server/)
| [chef-backend-ctl](/ctl_chef_backend/) |
[chef-server.rb](/config_rb_server/) | [Chef Server Optional
Settings](/config_rb_server_optional_settings/) |
[opscode-expander-ctl](/ctl_opscode_expander/) | [Chef Infra Server
API](/api_chef_server/)

**FIPS** [FIPS Overview](/fips/)

**Push Jobs**: [knife push jobs](/plugin_knife_push_jobs/) |
[push-jobs-client](/ctl_push_jobs_client/) |
[push-jobs-client.rb](/config_rb_push_jobs_client/) |
[push-jobs-server.rb](/config_rb_push_jobs_server/) | [Push Jobs
API](/api_push_jobs/) | [Server Sent
Events](/server_sent_events/)

**Supermarket**: [Log Files](/supermarket_logs/) | [Backup and
Restore](/supermarket_backup_restore/) |
[Monitoring](/supermarket_monitor/) |
[supermarket.rb](/config_rb_supermarket/) | [knife
supermarket](/knife_supermarket/) |
[supermarket-ctl](/ctl_supermarket/) | [Supermarket
API](/supermarket_api/)

**Management Console**: [About the Management Console](/manage/) |
[Configure SAML](/server_configure_saml/) |
[Clients](/server_manage_clients/) |
[Cookbooks](/server_manage_cookbooks/) | [Data
Bags](/server_manage_data_bags/) |
[Environments](/server_manage_environments/) |
[Nodes](/server_manage_nodes/) | [Roles](/server_manage_roles/)
| [Users](/server_users/#chef-manage.html) |
[manage.rb](/config_rb_manage/) |
[chef-manage-ctl](/ctl_manage/)

Chef Automate
=============

[Chef Automate Documentation](https://automate.chef.io/docs) | [Quick
Start Demo](https://automate.chef.io/docs/quickstart) | [System
Requirements](https://automate.chef.io/docs/system-requirements) |
[Installation Guide](https://automate.chef.io/docs/install) | [Upgrade
from Chef Automate One](https://automate.chef.io/docs/upgrade) |
[Airgapped Installation
Guide](https://automate.chef.io/docs/airgapped-installation) | [Install
Chef Habitat on-prem](https://automate.chef.io/docs/on-prem-builder) |
[Backup and Restore](https://automate.chef.io/docs/backup) |
[Configuration](https://automate.chef.io/docs/configuration) | [Data
Lifecycle](https://automate.chef.io/docs/data-lifecycle) | [Data
Collection](https://automate.chef.io/docs/data-collection) | [LDAP
Integration](https://automate.chef.io/docs/ldap) | [Log
Management](https://automate.chef.io/docs/log-management) | [SAML
Integration](https://automate.chef.io/docs/saml) |
[Telemetry](https://automate.chef.io/docs/telemetry) | [Setting up the
Applications
Dashboard](https://automate.chef.io/docs/applications-setup) | [Event
Feed](https://automate.chef.io/docs/event-feed) | [Client
Runs](https://automate.chef.io/docs/client-runs) | [Compliance
Reports](https://automate.chef.io/docs/reports) | [Scan
Jobs](https://automate.chef.io/docs/scan-jobs) | [Compliance
Profiles](https://automate.chef.io/docs/profiles) |
[Notifications](https://automate.chef.io/docs/notifications) | [Cloud
Integrations](https://automate.chef.io/docs/node-integrations) | [Node
Credentials](https://automate.chef.io/docs/node-credentials) | [Node
Lifecycle](https://automate.chef.io/docs/node-lifecycle) | [API
Tokens](https://automate.chef.io/docs/api-tokens) |
[Users](https://automate.chef.io/docs/users) |
[Teams](https://automate.chef.io/docs/teams) | [API
Tokens](https://automate.chef.io/docs/api-tokens) | [Chef Automate
CLI](https://automate.chef.io/docs/cli-chef-automate) |
[Troubleshooting](https://automate.chef.io/docs/troubleshooting) | [IAM
Overview](https://automate.chef.io/docs/iam-v2-overview) | [IAM Users
Guide](https://automate.chef.io/docs/iam-v2-guide) | [IAM API
Reference](https://automate.chef.io/docs/iam-v2-api-reference) |
[Architecture](https://automate.chef.io/docs/architectural-overview) |
[Chef Automate API](https://automate.chef.io/docs/api) | [Chef Automate
CLI](https://automate.chef.io/docs/cli-chef-automate) | [Monitoring
Chef Automate](https://automate.chef.io/docs/monitoring) |
[Troubleshooting](https://automate.chef.io/docs/troubleshooting)

Chef Habitat
============

**Documentation**: [Chef Habitat
Documentation](https://www.habitat.sh/docs)

**Tutorials**: [Chef Habitat
Tutorials](https://www.habitat.sh/tutorials)

Chef InSpec
===========

**Documentation**: [Chef InSpec
Documentation](https://www.inspec.io/docs)

**Tutorials**: [Chef InSpec Tutorials](https://www.inspec.io/tutorials)

Legacy
======

Workflow
--------

**Workflow Basics**: [Workflow Overview](/workflow/) | [Configure a
Pipeline](/delivery_pipeline/) | [Configure a
Project](/config_json_delivery/) | [Configure Data
Collection](/data_collection/) | [Data Collection with Chef
HA](/data_collection_ha/) | [Data Collection without Chef Infra
Server](/data_collection_without_server/) | [Audit
Cookbook](/audit_cookbook/)

**Managing Workflow**: [build-cookbook
(cookbook)](/delivery_build_cookbook/) | [delivery-truck
(cookbook)](/delivery_truck/) | [Manage
Dependencies](/delivery_manage_dependencies/) | [Manage
Secrets](/delivery_manage_secrets/) | [Publish Cookbooks to
Multiple Chef Servers](/publish_cookbooks_multiple_servers/) |
[Runners](/runners/) | [Workflow
w/Bitbucket](/integrate_delivery_bitbucket/) | [Workflow w/Email
(SMTP)](/integrate_delivery_smtp/) | [Workflow
w/GitHub](/integrate_delivery_github/) | [Workflow
w/Slack](/integrate_delivery_slack/) | [Users and
Roles](/delivery_users_and_roles/) | [Authentication
w/LDAP](/integrate_delivery_ldap/) | [Authentication
w/SAML](/integrate_chef_automate_saml/) | [Elastic Search and
Kibana Auth](/elasticsearch_and_kibana_auth/) | [Delivery Server
Backup](/delivery_server_backup/) | [Delivery Server Disaster
Recovery](/delivery_server_disaster_recovery/) | [Delivery Server
Tuning](/delivery_server_tuning/)

**Reference**: [Delivery CLI](/delivery_cli/) |
[delivery.rb](/config_rb_delivery/) | [delivery.rb Optional
Settings](/config_rb_delivery_optional_settings/) | [Workflow
DSL](/dsl_delivery/)

[AWS OpsWorks for Chef Automate](/aws_opsworks_chef_automate/) |
[Chef Automate for Microsoft Azure](/automate_azure/)

Extension APIs
==============

Resources
---------

**Recipe DSL**: [attribute?](/dsl_recipe/#attribute) |
[control](/dsl_recipe/#control) |
[control_group](/dsl_recipe/#control-group) |
[cookbook_name](/dsl_recipe/#cookbook-name) |
[data_bag](/dsl_recipe/#data-bag) |
[data_bag_item](/dsl_recipe/#data-bag-item) |
[platform?](/dsl_recipe/#platform) |
[platform_family?](/dsl_recipe/#platform-family) |
[reboot_pending?](/dsl_recipe/#reboot-pending) |
[recipe_name](/dsl_recipe/#recipe-name) |
[registry_data_exists?](/dsl_recipe/#registry-data-exists) |
[registry_get_subkeys](/dsl_recipe/#registry-get-subkeys) |
[registry_get_values](/dsl_recipe/#registry-get-values) |
[registry_has_subkeys?](/dsl_recipe/#registry-has-subkeys) |
[registry_key_exists?](/dsl_recipe/#registry-key-exists) |
[registry_value_exists?](/dsl_recipe/#registry-value-exists) |
[resources](/dsl_recipe/#resources) |
[search](/dsl_recipe/#search) |
[shell_out](/dsl_recipe/#shell-out) |
[shell_out!](/dsl_recipe/#shell-out-bang) |
[tag](/dsl_recipe/#tag-tagged-untag) |
[tagged?](/dsl_recipe/#tag-tagged-untag) |
[untag](/dsl_recipe/#tag-tagged-untag) |
[value_for_platform](/dsl_recipe/#value-for-platform) |
[value_for_platform_family](/dsl_recipe/#value-for-platform-family)
| [Custom
Resource DSL](/dsl_custom_resource/) | [Community
Resources](https://supermarket.chef.io)

Handlers
--------

[Custom Handlers](/handlers/#custom-handlers) | [Handler
DSL](/dsl_handler/) | [Community
Handlers](/plugin_community/#handlers)

Knife Plugins
-------------

[Cloud Plugins](/plugin_knife/) | [Writing Custom
Plugins](/plugin_knife_custom/) | [Community Plugins
(knife)](/plugin_community/#knife)

Ohai Plugins
------------

[Custom Plugins](/ohai_custom/) | [Community
Plugins](/plugin_community/#ohai)

Chef Infra Client Plugins
-------------------------

[Chef Infra Client Plugins](/plugin_community/#chef-infra-client)

Addenda
=======

[Available on GitHub](https://github.com/chef/chef-web-docs) | [Get
Chef](https://www.chef.io/chef/get-chef) | [Send
Feedback](/feedback/) | [Support](https://www.chef.io/support) |
[Site Map](/index/) |
[Archive](https://docs-archive.chef.io/index.html)
