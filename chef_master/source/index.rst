=====================================================
Site Map
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/index.rst>`__

This is the documentation for

- Chef, including the Chef server, the Chef client, the Chef
  development kit (Chef DK) and related tools
- Habitat
- InSpec
- Chef Automate

This page has links to each topic in this doc set. You can also use
the navigation tool or the search box to find what you're looking for.

If you need documentation for previous versions, you can use the dropdown
box labeled "Filter by product and version" to select the particular
component and version you want.

If this is your first visit, we recommend reading `how to learn Chef <https://learn.chef.io/skills/how-to-learn-chef>`_.

Overview
=====================================================

Platform Overview
-----------------------------------------------------

:doc:`Platform Overview </platform_overview>`

Community
-----------------------------------------------------

:doc:`About the Community </community>` |
:doc:`Contributing </community_contributions>` |
:doc:`Guidelines </community_guidelines>` |
:doc:`Docs Style Guide </style_guide>`

Packages and Platforms
-----------------------------------------------------
:doc:`Packages </packages>` |
:doc:`Platforms </platforms>` |
:doc:`Omnitruck API </api_omnitruck>` |
:doc:`Licensing </chef_license>`

Chef
=====================================================

Getting Started
-----------------------------------------------------
:doc:`Chef Overview </chef_overview>` |
:doc:`Quick Start </quick_start>` |
:doc:`System Requirements </chef_system_requirements>`

**Release Notes**:
:doc:`Chef Client </release_notes>` |
:doc:`Chef Server </release_notes_server>`

:doc:`Deprecations </chef_deprecations_client>`

Tutorials
-----------------------------------------------------

 `Learn the Basics <https://learn.chef.io/tutorials/learn-the-basics/>`_ |
 `Manage a Node <https://learn.chef.io/tutorials/manage-a-node/>`_ |
 `Develop Locally <https://learn.chef.io/tutorials/local-development/>`_ |
 `Manage a Web App <https://learn.chef.io/manage-a-web-app/>`_ |
 `Test Locally <https://learn.chef.io/tutorials/test-your-infrastructure-code/>`_ |

Concepts
-----------------------------------------------------

:doc:`Workstation </workstation>` |
:doc:`chef-repo </chef_repo>` |
:doc:`Nodes </nodes>` |
:doc:`chef-client </chef_client>` |
:doc:`Server </server_components>` |
:doc:`Search </chef_search>` |
:doc:`Cookbooks </cookbooks>` |
:doc:`Handlers </handlers>` |
:doc:`Management Console </manage>`

**Policy**: :doc:`About Policy </policy>` | :doc:`Data Bags </data_bags>` | :doc:`Environments </environments>` | :doc:`Roles </roles>`

:doc:`Push Jobs </push_jobs>` |
:doc:`Reporting </reporting>` |
:doc:`Run-lists </run_lists>`

**Security**:`Authentication <https://docs.chef.io/auth.html#authentication>`_ | `Authorization <https://docs.chef.io/auth.html#authorization>`_ | :doc:`Private Keys </chef_private_keys>` | `FIPS-mode <https://docs.chef.io/ctl_chef_client.html#run-in-fips-mode>`_

**Supermarket**: `Public Supermarket (overview) <https://docs.chef.io/supermarket.html#public-supermarket>`_ | `Private Supermarket (overview) <https://docs.chef.io/supermarket.html#private-supermarket>`_

:doc:`Microsoft Windows </windows>`

**Appendix**: :doc:`Env Variables </environment_variables>` | :doc:`Troubleshooting </errors>` | :doc:`Glossary </glossary>`

Setup
-----------------------------------------------------
:doc:`Proxies </proxies>` |
:doc:`Workstation </install_dk>`

**Nodes**::doc:`Install via Bootstrap </install_bootstrap>` | :doc:`Install via URL </install_omnibus>` | :doc:`Install on Windows </install_windows>` | :doc:`Install on Junos OS </junos>` | :doc:`chef-client (executable) </ctl_chef_client>` | :doc:`client.rb </config_rb_client>` | :doc:`Upgrades </upgrade_client>` | :doc:`Security </chef_client_security>`

**Server**: `Hosted Chef Server <https://manage.chef.io/signup>`_ | `Install Standalone <https://docs.chef.io/install_server.html#standalone>`_ | :doc:`Install High Availability </install_server_ha>` | :doc:`AWS Marketplace </aws_marketplace>` | :doc:`Microsoft Azure </azure_portal>` | :doc:`Openstack </openstack>`

**Supermarket**: `Public Supermarket <https://supermarket.chef.io>`_ | :doc:`Install Private Supermarket </install_supermarket>` | `Customize Supermarket <https://docs.chef.io/install_supermarket.html#customize-supermarket>`_ | `Run in Kitchen <https://docs.chef.io/install_supermarket.html#run-supermarket-in-kitchen>`_

`Management Console <https://docs.chef.io/ctl_chef_server.html#install>`_ |
:doc:`Push Jobs </install_push_jobs>` |
:doc:`Reporting </install_reporting>`

**Integrations**: :doc:`w/Chef Compliance </integrate_compliance_chef_server>`

:doc:`Uninstall </uninstall>`

Cookbook Reference
-----------------------------------------------------
:doc:`About Cookbooks </cookbooks>` |
:doc:`Attributes </attributes>` |
:doc:`Definitions </definitions>` |
:doc:`Files </files>` |
:doc:`Libraries </libraries>`

**Recipes**: :doc:`About Recipes </recipes>` | :doc:`Debug Recipes, Client Runs </debug>`

**Resources**: :doc:`About Resources </resource>` | :doc:`Common Functionality </resource_common>` | :doc:`Custom Resources </custom_resources>` | :doc:`All Resources (Single Page) </resources>` | :doc:`apt_package </resource_apt_package>` | :doc:`apt_repository </resource_apt_repository>` | :doc:`apt_update </resource_apt_update>` | :doc:`bash </resource_bash>` | :doc:`batch </resource_batch>` | :doc:`bff_package </resource_bff_package>` | :doc:`breakpoint </resource_breakpoint>` | :doc:`cab_package </resource_cab_package>` | :doc:`chef_acl </resource_chef_acl>` | :doc:`chef_client </resource_chef_client>` | :doc:`chef_container </resource_chef_container>` | :doc:`chef_data_bag </resource_chef_data_bag>` | :doc:`chef_data_bag_item </resource_chef_data_bag_item>` | :doc:`chef_environment </resource_chef_environment>` | :doc:`chef_gem </resource_chef_gem>` | :doc:`chef_group </resource_chef_group>` | :doc:`chef_handler </resource_chef_handler>` | :doc:`chef_mirror </resource_chef_mirror>` | :doc:`chef_node </resource_chef_node>` | :doc:`chef_organization </resource_chef_organization>` | :doc:`chef_role </resource_chef_role>` | :doc:`chef_user </resource_chef_user>` |  :doc:`chocolatey_package </resource_chocolatey_package>` | :doc:`cookbook_file </resource_cookbook_file>` | :doc:`cron </resource_cron>` | :doc:`csh </resource_csh>` | :doc:`deploy </resource_deploy>` | :doc:`directory </resource_directory>` | :doc:`dpkg_package </resource_dpkg_package>` | :doc:`dsc_resource </resource_dsc_resource>` | :doc:`dsc_script </resource_dsc_script>` | :doc:`easy_install_package </resource_easy_install_package>` | :doc:`env </resource_env>` | :doc:`erl_call </resource_erlang_call>` | :doc:`execute </resource_execute>` | :doc:`file </resource_file>` | :doc:`freebsd_package </resource_freebsd_package>` | :doc:`gem_package </resource_gem_package>` | :doc:`git </resource_git>` | :doc:`group </resource_group>` | :doc:`homebrew_package </resource_homebrew_package>` | :doc:`http_request </resource_http_request>` | :doc:`ifconfig </resource_ifconfig>` | :doc:`ips_package </resource_ips_package>` | :doc:`ksh </resource_ksh>` | :doc:`launchd </resource_launchd>` | :doc:`link </resource_link>` | :doc:`log </resource_log>` | :doc:`macports_package </resource_macports_package>` | :doc:`mdadm </resource_mdadm>` | :doc:`mount </resource_mount>` | :doc:`ohai </resource_ohai>` | :doc:`openbsd_package </resource_openbsd_package>` | :doc:`osx_profile </resource_osx_profile>` | :doc:`package </resource_package>` | :doc:`pacman_package </resource_pacman_package>` | :doc:`paludis_package </resource_paludis_package>` | :doc:`perl </resource_perl>` | :doc:`portage_package </resource_portage_package>` | :doc:`powershell_script </resource_powershell_script>` | :doc:`private_key </resource_private_key>` | :doc:`public_key </resource_public_key>` | :doc:`python </resource_python>` | :doc:`reboot </resource_reboot>` | :doc:`registry_key </resource_registry_key>` | :doc:`remote_directory </resource_remote_directory>` | :doc:`remote_file </resource_remote_file>` | :doc:`route </resource_route>` | :doc:`rpm_package </resource_rpm_package>` | :doc:`ruby </resource_ruby>` | :doc:`ruby_block </resource_ruby_block>` | :doc:`script </resource_script>` | :doc:`service </resource_service>` | :doc:`smartos_package </resource_smartos_package>` | :doc:`solaris_package </resource_solaris_package>` | :doc:`subversion </resource_subversion>` | :doc:`systemd_unit </resource_systemd_unit>` | :doc:`template </resource_template>` | :doc:`user </resource_user>` | :doc:`windows_package </resource_windows_package>` | :doc:`windows_service </resource_windows_service>` | :doc:`yum_package </resource_yum>` | :doc:`yum_repository </resource_yum_repository>` | :doc:`Examples (by Resource) </resource_examples>`

:doc:`Templates </templates>` |
:doc:`Cookbook Repo </cookbook_repo>` |
:doc:`metadata.rb </config_rb_metadata>` |
:doc:`Cookbook Versions </cookbook_versions>` |
:doc:`Ruby </ruby>`

**Chef Automate Cookbooks**: :doc:`build-cookbook (cookbook) </delivery_build_cookbook>` | :doc:`delivery-truck (cookbook) </delivery_truck>`

Chef DK
-----------------------------------------------------

:doc:`Berkshelf </berkshelf>` |
:doc:`chef-apply (executable) </ctl_chef_apply>`
:doc:`chef-shell (executable) </chef_shell>`

**chef (executable)**:`chef env <https://docs.chef.io/ctl_chef.html#chef-env>`_ | `chef exec <https://docs.chef.io/ctl_chef.html#chef-exec>`_ | `chef gem <https://docs.chef.io/ctl_chef.html#chef-gem>`_ | `chef generate app <https://docs.chef.io/ctl_chef.html#chef-generate-app>`_ | `chef generate attribute <https://docs.chef.io/ctl_chef.html#chef-generate-attribute>`_ | `chef generate cookbook <https://docs.chef.io/ctl_chef.html#chef-generate-cookbook>`_ | `chef generate file <https://docs.chef.io/ctl_chef.html#chef-generate-file>`_ | `chef generate lwrp <https://docs.chef.io/ctl_chef.html#chef-generate-lwrp>`_ | `chef generate recipe <https://docs.chef.io/ctl_chef.html#chef-generate-recipe>`_ | `chef generate repo <https://docs.chef.io/ctl_chef.html#chef-generate-repo>`_ | `chef generate template <https://docs.chef.io/ctl_chef.html#chef-generate-template>`_ | `chef provision <https://docs.chef.io/ctl_chef.html#chef-provision>`_ | `chef shell-init <https://docs.chef.io/ctl_chef.html#chef-shell-init>`_ | `chef verify <https://docs.chef.io/ctl_chef.html#chef-verify>`_

**Chef Solo**: :doc:`About Chef Solo </chef_solo>` | :doc:`chef-solo (executable) </ctl_chef_solo>` | :doc:`solo.rb </config_rb_solo>`

:doc:`chef-shell (executable) </ctl_chef_shell>` |
`chef-zero (local mode) <https://docs.chef.io/ctl_chef_client.html#run-in-local-mode>`_ |
:doc:`chef-vault </chef_vault>` |
:doc:`ChefSpec </chefspec>`

**Configuration**: :doc:`config.rb </config_rb>` | `Multiple Config Files <https://docs.chef.io/config_rb_client.html#d-directories>`_

:doc:`cookstyle </cookstyle>` |
:doc:`Delivery CLI </ctl_delivery>` |
:doc:`Foodcritic </foodcritic>`

**Kitchen**: :doc:`About Kitchen </kitchen>` | :doc:`kitchen (executable) </ctl_kitchen>` | :doc:`.kitchen.yml </config_yml_kitchen>` :doc:`kitchen-vagrant </plugin_kitchen_vagrant>`

**Knife**: :doc:`About Knife </knife>` | :doc:`Common Options </knife_common_options>` | :doc:`Using Knife </knife_using>` | :doc:`knife.rb </config_rb_knife>` | :doc:`knife bootstrap </knife_bootstrap>` | :doc:`knife client </knife_client>` | :doc:`knife configure </knife_configure>` | :doc:`knife cookbook </knife_cookbook>` | :doc:`knife cookbook site </knife_cookbook_site>` | :doc:`knife data bag </knife_data_bag>` | :doc:`knife delete </knife_delete>` | :doc:`knife deps </knife_deps>` | :doc:`knife diff </knife_diff>` | :doc:`knife download </knife_download>` | :doc:`knife edit </knife_edit>` | :doc:`knife environment </knife_environment>` | :doc:`knife exec </knife_exec>` | :doc:`knife list </knife_list>` | :doc:`knife node </knife_node>` | :doc:`knife raw </knife_raw>` | :doc:`knife recipe list </knife_recipe_list>` | :doc:`knife role </knife_role>` | :doc:`knife search </knife_search>` | :doc:`knife serve </knife_serve>` | :doc:`knife show </knife_show>` | :doc:`knife ssh </knife_ssh>` | :doc:`knife ssl_check </knife_ssl_check>` | :doc:`knife ssl_fetch </knife_ssl_fetch>` | :doc:`knife status </knife_status>` | :doc:`knife tag </knife_tag>` | :doc:`knife upload </knife_upload>` | :doc:`knife user </knife_user>` | :doc:`knife xargs </knife_xargs>`

**knife opc**: :doc:`About knife opc </plugin_knife_opc>` | :ref:`plugin_knife_opc-knife-rb-configuration` | :ref:`plugin_knife_opc-opc-user-list` | :ref:`plugin_knife_opc-opc-user-show` | :ref:`plugin_knife_opc-opc-user-create` | :ref:`plugin_knife_opc-opc-user-delete` | :ref:`plugin_knife_opc-opc-user-edit` | :ref:`plugin_knife_opc-opc-user-password` | :ref:`plugin_knife_opc-opc-org-list` | :ref:`plugin_knife_opc-opc-org-show` | :ref:`plugin_knife_opc-opc-org-create` | :ref:`plugin_knife_opc-opc-org-delete` | :ref:`plugin_knife_opc-opc-org-user-add` | :ref:`plugin_knife_opc-opc-org-user-remove`

:doc:`knife spork </plugin_knife_spork>` |

**knife supermarket**: `supermarket download <https://docs.chef.io/plugin_knife_supermarket.html#download>`_ | `supermarket install <https://docs.chef.io/plugin_knife_supermarket.html#install>`_ | `supermarket list <https://docs.chef.io/plugin_knife_supermarket.html#list>`_ | `supermarket search <https://docs.chef.io/plugin_knife_supermarket.html#search>`_ | `supermarket share <https://docs.chef.io/plugin_knife_supermarket.html#share>`_ | `supermarket show <https://docs.chef.io/plugin_knife_supermarket.html#show>`_ | `supermarket unshare <https://docs.chef.io/plugin_knife_supermarket.html#unshare>`_

**Ohai**: :doc:`About Ohai </ohai>` | :doc:`ohai (executable) </ctl_ohai>`

**Policyfile**: :doc:`About Policyfile </policyfile>` | :doc:`Policyfile.rb </config_rb_policyfile>`

**Provisioning**: :doc:`About Provisioning </provisioning>` | :doc:`load_balancer resource </resource_load_balancer>` | :doc:`machine resource </resource_machine>` | :doc:`machine_batch resource </resource_machine_batch>` | :doc:`machine_execute resource </resource_machine_execute>` | :doc:`machine_file resource </resource_machine_file>` | :doc:`machine_image resource </resource_machine_image>` | :doc:`AWS Driver Resources </provisioning_aws>` | :doc:`Fog Driver Resources </provisioning_fog>` | :doc:`Vagrant Driver Resources </provisioning_vagrant>`

:doc:`push-jobs-client (executable) </ctl_push_jobs_client>` |
:doc:`Rubocop </rubocop>`

Managing the Server
-----------------------------------------------------

:doc:`Runbook (Single Page) </runbook>` |
:doc:`Backup and Restore </server_backup_restore>` |
:doc:`Data Storage </server_data>` |
:doc:`Firewalls and Ports </server_firewalls_and_ports>` |
:doc:`Active Directory and LDAP </server_ldap>` |
:doc:`Log Files </server_logs>` |
:doc:`Monitor </server_monitor>` |
:doc:`Organizations and Groups </server_orgs>` |
:doc:`Secrets </secrets>` |
:doc:`Security </server_security>` |
:doc:`Services </server_services>` |
:doc:`Tuning </server_tuning>` |
:doc:`Upgrades </upgrade_server>` |
:doc:`Upgrade HA Cluster </upgrade_server_ha_v2>` |
:doc:`Users </server_users>` |
:doc:`chef-server-ctl </ctl_chef_server>` |
:doc:`chef-backend-ctl </ctl_chef_backend>` |
:doc:`chef-server.rb </config_rb_server>` |
:doc:`opscode-expander-ctl </ctl_opscode_expander>` |
:doc:`Chef Server API </api_chef_server>`

**Push Jobs**::doc:`knife push jobs </plugin_knife_push_jobs>` | :doc:`push-jobs-client </ctl_push_jobs_client>` | :doc:`push-jobs-client.rb </config_rb_push_jobs_client>` | :doc:`push-jobs-server.rb </config_rb_push_jobs_server>` | :doc:`Push Jobs API </api_push_jobs>` | :doc:`Server Sent Events </server_sent_events>`

**Reporting**::doc:`View Reports </server_manage_reports>` | :doc:`knife reporting </plugin_knife_reporting>` | :doc:`opscode-reporting-ctl </ctl_reporting>` | :doc:`Reporting API </api_reporting>`

**Supermarket**::doc:`Log Files </supermarket_logs>` | :doc:`Monitoring </supermarket_monitor>` | :doc:`supermarket.rb </config_rb_supermarket>` | :doc:`knife supermarket </plugin_knife_supermarket>` | :doc:`supermarket-ctl </ctl_supermarket>` | :doc:`Supermarket API </supermarket_api>`

**Management Console**: :doc:`Configure SAML </server_configure_saml>` | :doc:`Clients </server_manage_clients>` | :doc:`Cookbooks </server_manage_cookbooks>` | :doc:`Data Bags </server_manage_data_bags>` | :doc:`Environments </server_manage_environments>` | :doc:`Nodes </server_manage_nodes>` | :doc:`Roles </server_manage_roles>` | `Users <https://docs.chef.io/server_users.html#chef-manage>`_ | :doc:`manage.rb </config_rb_manage>` | :doc:`chef-manage-ctl </ctl_manage>`

Habitat
=====================================================

Habitat Overview
-----------------------------------------------------

:doc:`Habitat Overview </habitat>` |
:doc:`Prism </habitat_prism>`

Tutorials
-----------------------------------------------------

 `Getting started <https://www.habitat.sh/tutorials/getting-started-overview>`_

InSpec
=====================================================

InSpec Overview
-----------------------------------------------------

:doc:`InSpec Overview </inspec>`

Chef Automate
=====================================================

Getting Started
-----------------------------------------------------

:doc:`Chef Automate Overview </chef_automate>` |
:doc:`Installation Guide </install_chef_automate>`

Tutorials
-----------------------------------------------------

`Install Chef Automate <https://learn.chef.io/automate/install>`_ |
`Visibility into Infrastructure <https://learn.chef.io/automate/visibility>`_ |
`Deploy with Chef Automate <https://learn.chef.io/automate/deploy-cookbook>`_ |
`Assess for Compliance <https://learn.chef.io/tutorials/#compliance-assess>`_ |
`Remediate Compliance Failures <https://learn.chef.io/tutorials/#compliance-remediate>`_

Setup
-----------------------------------------------------
:doc:`Configure a Pipeline </delivery_pipeline>` |
:doc:`Configure a Project </config_json_delivery>` |
:doc:`Configure Data Collection </setup_visibility_chef_automate>`

Concepts
-----------------------------------------------------

**Workflow**: :doc:`Workflow Overview </workflow>` | :doc:`Manage Dependencies </delivery_manage_dependencies>`

:doc:`Visibility Overview </visibility>` |
:doc:`Compliance Overview </compliance>`

Delivery CLI
-----------------------------------------------------
:doc:`Delivery CLI </ctl_delivery>`

Integrations
-----------------------------------------------------
:doc:`w/Bitbucket </integrate_delivery_bitbucket>` |
:doc:`w/Email (SMTP) </integrate_delivery_smtp>` |
:doc:`w/GitHub </integrate_delivery_github>` |
:doc:`w/LDAP </integrate_delivery_ldap>` |
:doc:`w/SAML </integrate_chef_automate_saml>` |
:doc:`w/Slack </integrate_delivery_slack>`

Cookbooks
-----------------------------------------------------
:doc:`build-cookbook (cookbook) </delivery_build_cookbook>` |
:doc:`delivery-truck (cookbook) </delivery_truck>`

Workflow DSL
-----------------------------------------------------

:doc:`Workflow DSL </dsl_delivery>`

Job Dispatch
-----------------------------------------------------

:doc:`Job Dispatch </job_dispatch>`

Managing the Server
-----------------------------------------------------

:doc:`Backups </delivery_server_backup>` |
:doc:`Capacity Planning </scaling_capacity_planning_chef_automate>` |
:doc:`delivery.rb </config_rb_delivery>` |
:doc:`Chef Automate API </api_delivery>` |
:doc:`Disaster Recovery </delivery_server_disaster_recovery>` |
:doc:`Elasticsearch and Kibana Authentication </elasticsearch_and_kibana_auth>` |
:doc:`Secrets </delivery_manage_secrets>` |
:doc:`Manage Elasticsearch Indices </manage_indices_chef_automate>` |
:doc:`Node Search Reference </search_query_chef_automate>` |
:doc:`Stream Data </stream_data_chef_automate>` |
:doc:`Tuning </delivery_server_tuning>` |
:doc:`Upgrades </upgrade_chef_automate>` |
:doc:`Users and Roles </delivery_users_and_roles>` |
`cleanse <http://docs.chef.io/ctl_delivery_server.html#cleanse>`_ |
`create-enterprise <http://docs.chef.io/ctl_delivery_server.html#create-enterprise>`_ |
`create-user <http://docs.chef.io/ctl_delivery_server.html#create-user>`_ |
`delete-application <http://docs.chef.io/ctl_delivery_server.html#delete-application>`_ |
`delete-enterprise <http://docs.chef.io/ctl_delivery_server.html#delete-enterprise>`_ |
`delete-project <http://docs.chef.io/ctl_delivery_server.html#delete-project>`_ |
`delete-user <http://docs.chef.io/ctl_delivery_server.html#delete-user>`_ |
`install-runner <http://docs.chef.io/ctl_delivery_server.html#install-runner>`_ |
`list-applications <http://docs.chef.io/ctl_delivery_server.html#list-applications>`_ |
`list-enterprises <http://docs.chef.io/ctl_delivery_server.html#list-enterprises>`_ |
`list-users <http://docs.chef.io/ctl_delivery_server.html#list-users>`_ |
`migrate-change-description <http://docs.chef.io/ctl_delivery_server.html#migrate-change-description>`_ |
`migrate-patchset-diffs <http://docs.chef.io/ctl_delivery_server.html#migrate-patchset-diffs>`_ |
`reconfigure <http://docs.chef.io/ctl_delivery_server.html#reconfigure>`_ |
`rename-enterprise <http://docs.chef.io/ctl_delivery_server.html#rename-enterprise>`_ |
`revoke-token <http://docs.chef.io/ctl_delivery_server.html#revoke-token>`_ |
`show-config <http://docs.chef.io/ctl_delivery_server.html#show-config>`_ |
`uninstall <http://docs.chef.io/ctl_delivery_server.html#uninstall>`_ |
`update-project-hooks <http://docs.chef.io/ctl_delivery_server.html#update-project-hooks>`_

Compliance scanner
-----------------------------------------------------
:doc:`Overview </compliance>` |
:doc:`Installation Guide </install_compliance>` |
:doc:`Integrate w/Chef Server </integrate_compliance_chef_server>` |
:doc:`Integrate w/Chef Automate </integrate_compliance_chef_automate>` |
:doc:`Upgrade Compliance </upgrade_compliance>` |
:doc:`chef-compliance.rb </config_rb_compliance>` |
:doc:`Chef Compliance API </api_compliance>`

Troubleshooting
-----------------------------------------------------

:doc:`Troubleshooting </troubleshooting_chef_automate>`

Extension APIs
=====================================================

Resources
-----------------------------------------------------

**Recipe DSL**: `attribute? <https://docs.chef.io/dsl_recipe.html#attribute>`_ | `control <https://docs.chef.io/dsl_recipe.html#control>`_ | `control_group <https://docs.chef.io/dsl_recipe.html#control-group>`_ | `cookbook_name <https://docs.chef.io/dsl_recipe.html#cookbook-name>`_ | `data_bag <https://docs.chef.io/dsl_recipe.html#data-bag>`_ | `data_bag_item <https://docs.chef.io/dsl_recipe.html#data-bag-item>`_ | `platform? <https://docs.chef.io/dsl_recipe.html#platform>`_ | `platform_family? <https://docs.chef.io/dsl_recipe.html#platform-family>`_ | `reboot_pending? <https://docs.chef.io/dsl_recipe.html#reboot-pending>`_ | `recipe_name <https://docs.chef.io/dsl_recipe.html#recipe-name>`_ | `registry_data_exists? <https://docs.chef.io/dsl_recipe.html#registry-data-exists>`_ | `registry_get_subkeys <https://docs.chef.io/dsl_recipe.html#registry-get-subkeys>`_ | `registry_get_values <https://docs.chef.io/dsl_recipe.html#registry-get-values>`_ | `registry_has_subkeys? <https://docs.chef.io/dsl_recipe.html#registry-has-subkeys>`_ | `registry_key_exists? <https://docs.chef.io/dsl_recipe.html#registry-key-exists>`_ | `registry_value_exists? <https://docs.chef.io/dsl_recipe.html#registry-value-exists>`_ | `resources <https://docs.chef.io/dsl_recipe.html#resources>`_ | `search <https://docs.chef.io/dsl_recipe.html#search>`_ | `shell_out <https://docs.chef.io/dsl_recipe.html#shell-out>`_ | `shell_out! <https://docs.chef.io/dsl_recipe.html#shell-out-bang>`_ | `shell_out_with_systems_locale <https://docs.chef.io/dsl_recipe.html#shell-out-with-systems-locale>`_ | `tag <https://docs.chef.io/dsl_recipe.html#tag-tagged-untag>`_ | `tagged? <https://docs.chef.io/dsl_recipe.html#tag-tagged-untag>`_ | `untag <https://docs.chef.io/dsl_recipe.html#tag-tagged-untag>`_ | `value_for_platform <https://docs.chef.io/dsl_recipe.html#value-for-platform>`_ | `value_for_platform_family <https://docs.chef.io/dsl_recipe.html#value-for-platform-family>`_ | `Windows Platform Helpers <https://docs.chef.io/dsl_recipe.html#helpers>`_

 `Community Resources <https://supermarket.chef.io>`_

Handlers
-----------------------------------------------------
`Custom Handlers <https://docs.chef.io/handlers.html#custom-handlers>`_ |
:doc:`Handler DSL </dsl_handler>` |
`Community Handlers <https://docs.chef.io/plugin_community.html#handlers>`_

Knife Plugins
-----------------------------------------------------

:doc:`About Cloud Plugins </plugin_knife>` |
:doc:`Custom Plugins </plugin_knife_custom>` |
`Community Plugins (knife) <https://docs.chef.io/plugin_community.html#knife>`_

Ohai Plugins
-----------------------------------------------------
:doc:`Custom Plugins </ohai_custom>` | `Community Plugins <https://docs.chef.io/plugin_community.html#ohai>`_

Chef Client Plugins
-----------------------------------------------------

`Chef Client Plugins <https://docs.chef.io/plugin_community.html#chef-client>`_

Addenda
=====================================================

`Available on GitHub <https://github.com/chef/chef-web-docs>`_ |
`Get Chef <https://www.chef.io/get-chef>`_ |
:doc:`Send Feedback </feedback>` |
`Support <https://www.chef.io/support>`_ |
`Site Map <https://docs.chef.io/index.html>`_

.. Hide the TOC from this file.

.. toctree::
   :hidden:

   api_chef_server
   api_compliance
   api_delivery
   api_omnitruck
   api_push_jobs
   api_reporting
   attributes
   auth
   aws_marketplace
   azure_portal
   berkshelf
   chef_automate
   chef_client
   chef_client_security
   chef_deprecations_client
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
   compliance
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
   ctl_chef_shell
   ctl_chef_solo
   ctl_delivery
   ctl_delivery_server
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
   scaling_capacity_planning_chef_automate
   stream_data_chef_automate
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
   deprecations_chef_rest
   deprecations_custom_resource_cleanups
   deprecations_easy_install
   deprecations_exit_code
   deprecations_internal_api
   deprecations_json_auto_inflate
   deprecations_resource_cloning
   deprecations_supports_property
   deprecations_verify_file
   dsl_custom_resource
   dsl_delivery
   job_dispatch
   dsl_handler
   dsl_recipe
   elasticsearch_and_kibana_auth
   environment_variables
   environments
   errors
   error_messages
   feedback
   files
   foodcritic
   glossary
   habitat
   habitat_prism
   handlers
   inspec
   install_chef_automate
   install_bootstrap
   install_compliance
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
   integrate_compliance_chef_automate
   integrate_delivery_bitbucket
   integrate_delivery_github
   integrate_delivery_ldap
   integrate_delivery_slack
   integrate_delivery_smtp
   junos
   kitchen
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
   manage
   manage_indices_chef_automate
   nodes
   ohai
   ohai_custom
   openstack
   packages
   page_not_found
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
   proxies
   provisioning
   provisioning_aws
   provisioning_fog
   provisioning_vagrant
   push_jobs
   quick_start
   recipes
   reporting
   release_notes
   release_notes_server
   resource
   resource_apt_package
   resource_apt_repository
   resource_apt_update
   resource_bash
   resource_batch
   resource_bff_package
   resource_breakpoint
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
   resource_dpkg_package
   resource_dsc_resource
   resource_dsc_script
   resource_easy_install_package
   resource_env
   resource_erlang_call
   resource_examples
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
   resource_private_key
   resource_public_key
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
   resource_systemd_unit
   resource_template
   resource_user
   resource_windows_package
   resource_windows_service
   resource_yum
   resource_yum_repository
   resources
   roles
   rubocop
   ruby
   run_lists
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
   setup_visibility_chef_automate
   style_guide
   supermarket
   supermarket_api
   supermarket_logs
   supermarket_monitor
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
   windows
   workflow
   workstation
