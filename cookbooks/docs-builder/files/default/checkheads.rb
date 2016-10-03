#
# This script checks Chef docs topics against heading conventions
# (described below)
#
# The input comes from stdin as a list of files (one per line) to be checked.
#

H1REGEX = /\A=+\s*\z/
H2REGEX = /\A=+\s*\z/
H3REGEX = /\A-+\s*\z/
H4REGEX = /\A\++\s*\z/
H5REGEX = /\A\^+\s*\z/
BLANKREGEX = /\A\s*\z/
TITLEREGEX = /[A-Za-z]+/ 
SECTIONCHARS = ['=', '-', '`', ':', '.', '\'', '"', '~', '^', '_', '*', '+', '#']  

# Check that line is a valid section title
def check_title(file, lineNo, line) 
 fail_at(file, lineNo, "invalid title - #{line}") unless line.match(TITLEREGEX)
end

# Is line a section adornment?
def is_section(line)
  # must start with one of the section chars and consist of only that char
  line.length > 5 && SECTIONCHARS.include?(line[0]) && line.strip.chars.to_a.uniq.length == 1
end

# Print error
def fail_at(id, lineNo, errMsg)
 fail "In #{id}:#{lineNo}, #{errMsg}"
end

#
# check_headings 
#
# The function validates conventions used by chef-docs. It does not
# handle generalized restructuredText, which has a more complicated
# annotation scheme for headings. Sections in rst are explained in
# http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#sections.
#
# It checks that that:
#
# - H1 headings have overline *and* underline adornment using the "=" character.
#
# - Section headings other H1 use underline adornment only.
#
# - H2 headings use the "=" character for their underline adornment.
#
# - H3 headings use the "-" character for their underline adornment.
#
# - H4 headings use the "+" character for their underline adornment.
#
# - H5 headings use the "^" character for their underline adornment.
#
# - Nesting is consecutve; for example, H3 can follow H2 but not H1
#
def check_headings(id, instr) 
  # parsing state
  h1Mode = 0       # H1 states: 0=ready, 1=expecting title, 2=expecting underline
  lineNo = 1       # current line number
  prevLine = ""    # contents of the previous line
  level = 0        # current heading level (1=H1, 2=H2, etc.)

  instr.each_line do |line|
    
    # H1 overline
    if h1Mode == 0 && prevLine.match(BLANKREGEX) && line.match(H1REGEX)
      h1Mode = 1   # consume overline and enter H1 "expecting title" mode
      level = 1

    # H1 title
    elsif h1Mode == 1
      check_title(id, lineNo, line)
      h1Mode = 2   # enter H1 "expecting underline" mode
      
    # H1 underline
    elsif h1Mode == 2 
      fail_at(id, lineNo, "expected H1 underline, saw #{line}") unless line.match(H1REGEX)
      h1Mode = 0                        # exit H1 parsing mode
      
    # H2
    elsif line.match(H2REGEX)
      fail_at(id, lineNo, "H2 seen without H1") if level < 1
      check_title(id, lineNo, prevLine)
      level = 2
      
    # H3
    elsif line.match(H3REGEX)
      fail_at(id, lineNo, "H3 seen without H2") if level < 2
      check_title(id, lineNo, prevLine)
      level = 3

    # H4
    elsif line.match(H4REGEX)
      fail_at(id, lineNo, "H4 seen without H3") if level < 3
      check_title(id, lineNo, prevLine)
      level = 4

    # H5
    elsif line.match(H5REGEX)
      fail_at(id, lineNo, "H5 seen without H4") if level < 4
      check_title(id, lineNo, prevLine)
      level = 5
      
    # all other lines
    else
     fail_at(id, lineNo, "unexpected section break #{line}") if is_section(line)
     
    end

    lineNo += 1
    prevLine = line
  end
end

#
# check_all_headings
#
def check_all_headings(topics)
  topics.each_line do |fileNameLine|
    fileName = fileNameLine.strip
    File.open(fileName, "r") do |topic|
    check_headings(fileName, topic)
    end
  end
end

ALLTOPICS = [
"api_chef_server.rst",
"api_compliance.rst",
"api_cookbooks_site.rst",
# fail 10 "api_delivery.rst",
"api_omnitruck.rst",
"api_push_jobs.rst",
"api_reporting.rst",
"attributes.rst",
"auth.rst",
"aws_marketplace.rst",
"azure_portal.rst",
"berkshelf.rst",
"chef_automate.rst",
"chef_client.rst",
"chef_client_security.rst",
"chef_cookbooks.rst",
"chef_license.rst",
"chef_overview.rst",
"chef_private_keys.rst",
"chef_quick_overview.rst",
"chef_repo.rst",
"chef_search.rst",
"chef_server.rst",
"chef_shell.rst",
# fail 8 "chef_solo.rst",
"chefspec.rst",
"chef_system_requirements.rst",
"chef_vault.rst",
"community_contributions.rst",
"community_guidelines.rst",
"community.rst",
"compliance.rst",
"config_json_delivery.rst",
#fail 12 "config_rb_chef_sync.rst",
"config_rb_client.rst",
"config_rb_compliance.rst",
"config_rb_delivery_optional_settings.rst",
"config_rb_delivery.rst",
"config_rb_knife_optional_settings.rst",
"config_rb_knife.rst",
"config_rb_manage.rst",
"config_rb_metadata.rst",
"config_rb_policyfile.rst",
"config_rb_push_jobs_client.rst",
"config_rb_push_jobs_server.rst",
"config_rb_reporting.rst",
"config_rb.rst",
"config_rb_server_optional_settings.rst",
"config_rb_server.rst",
"config_rb_solo.rst",
"config_rb_supermarket.rst",
"config_yml_kitchen.rst",
"containers.rst",
"cookbook_repo.rst",
"cookbooks.rst",
"cookbook_versions.rst",
"cookstyle.rst",
"ctl_chef_apply.rst",
"ctl_chef_backend.rst",
"ctl_chef_client.rst",
"ctl_chef.rst",
"ctl_chef_server.rst",
"ctl_chef_shell.rst",
"ctl_chef_solo.rst",
"ctl_chef_sync.rst",
"ctl_delivery.rst",
"ctl_delivery_server.rst",
"ctl_kitchen.rst",
"ctl_manage.rst",
"ctl_ohai.rst",
"ctl_opscode_expander.rst",
#fail 10 "ctl_push_jobs_client.rst",
"ctl_reporting.rst",
"ctl_supermarket.rst",
"custom_resources_notes.rst",
"custom_resources.rst",
"data_bags.rst",
"debug.rst",
"definitions.rst",
"delivery_build_cookbook.rst",
"delivery_manage_dependencies.rst",
"delivery_manage_secrets.rst",
"delivery_pipeline.rst",
"delivery_server_disaster_recovery.rst",
"delivery_server_tuning.rst",
"delivery_truck.rst",
"delivery_users_and_roles.rst",
"dsl_custom_resource.rst",
"dsl_delivery.rst",
"dsl_handler.rst",
"dsl_recipe.rst",
"environments.rst",
"environment_variables.rst",
"error_messages.rst",
"errors.rst",
"feedback.rst",
"files.rst",
"foodcritic.rst",
"glossary.rst",
"habitat_prism.rst",
"habitat.rst",
"handlers.rst",
"index.rst",
"inspec.rst",
"install_bootstrap.rst",
"install_chef_automate.rst",
"install_compliance.rst",
"install_delivery_aws_legacy.rst",
"install_delivery_ssh_legacy.rst",
"install_dk.rst",
"install_omnibus.rst",
"install_push_jobs.rst",
"install_reporting.rst",
"install.rst",
"install_server_ha_aws.rst",
"install_server_ha_drbd.rst",
"install_server_ha.rst",
"install_server_post.rst",
"install_server_pre.rst",
"install_server.rst",
"install_server_tiered.rst",
"install_supermarket.rst",
"install_windows.rst",
"integrate_chef_automate_saml.rst",
"integrate_compliance_chef_server.rst",
"integrate_delivery_bitbucket.rst",
"integrate_delivery_github.rst",
"integrate_delivery_ldap.rst",
"integrate_delivery_slack.rst",
"integrate_delivery_smtp.rst",
# fail 14 "junos.rst",
"kitchen.rst",
"knife_bootstrap.rst",
"knife_client.rst",
"knife_common_options.rst",
"knife_configure.rst",
"knife_cookbook.rst",
"knife_cookbook_site.rst",
"knife_data_bag.rst",
"knife_delete.rst",
"knife_deps.rst",
"knife_diff.rst",
"knife_download.rst",
"knife_edit.rst",
"knife_environment.rst",
"knife_exec.rst",
"knife_list.rst",
"knife_node.rst",
"knife_raw.rst",
"knife_recipe_list.rst",
"knife_role.rst",
"knife.rst",
"knife_search.rst",
"knife_serve.rst",
"knife_show.rst",
"knife_ssh.rst",
"knife_ssl_check.rst",
"knife_ssl_fetch.rst",
"knife_status.rst",
"knife_tag.rst",
"knife_upload.rst",
"knife_user.rst",
"knife_using.rst",
"knife_xargs.rst",
"libraries.rst",
"manage.rst",
"nodes.rst",
"ohai_custom.rst",
"ohai.rst",
"openstack.rst",
"packages.rst",
"page_not_found.rst",
"platform_overview.rst",
"platforms.rst",
"plugin_community.rst",
"plugin_kitchen_vagrant.rst",
"plugin_knife_custom.rst",
"plugin_knife_push_jobs.rst",
"plugin_knife_reporting.rst",
"plugin_knife.rst",
"plugin_knife_spork.rst",
"plugin_knife_supermarket.rst",
"plugin_knife_windows.rst",
"policyfile.rst",
"policy.rst",
"provisioning_aws.rst",
"provisioning_fog.rst",
"provisioning.rst",
"provisioning_vagrant.rst",
"proxies.rst",
"push_jobs.rst",
"quick_start.rst",
"recipes.rst",
"release_notes.rst",
"release_notes_server.rst",
"releases.rst",
"reporting.rst",
"resource_apt_package.rst",
"resource_apt_update.rst",
"resource_bash.rst",
"resource_batch.rst",
"resource_bff_package.rst",
"resource_breakpoint.rst",
"resource_chef_acl.rst",
"resource_chef_client.rst",
"resource_chef_container.rst",
"resource_chef_data_bag_item.rst",
"resource_chef_data_bag.rst",
"resource_chef_environment.rst",
"resource_chef_gem.rst",
"resource_chef_group.rst",
"resource_chef_handler.rst",
"resource_chef_mirror.rst",
"resource_chef_node.rst",
"resource_chef_organization.rst",
"resource_chef_role.rst",
"resource_chef_user.rst",
"resource_chocolatey_package.rst",
"resource_common.rst",
"resource_cookbook_file.rst",
"resource_cron.rst",
"resource_csh.rst",
"resource_deploy.rst",
"resource_directory.rst",
"resource_dpkg_package.rst",
"resource_dsc_resource.rst",
"resource_dsc_script.rst",
"resource_easy_install_package.rst",
"resource_env.rst",
"resource_erlang_call.rst",
"resource_examples.rst",
"resource_execute.rst",
"resource_file.rst",
"resource_freebsd_package.rst",
"resource_gem_package.rst",
"resource_git.rst",
"resource_group.rst",
"resource_homebrew_package.rst",
"resource_http_request.rst",
"resource_ifconfig.rst",
"resource_ips_package.rst",
"resource_ksh.rst",
"resource_launchd.rst",
"resource_link.rst",
"resource_load_balancer.rst",
"resource_log.rst",
"resource_machine_batch.rst",
"resource_machine_execute.rst",
"resource_machine_file.rst",
"resource_machine_image.rst",
"resource_machine.rst",
"resource_macports_package.rst",
"resource_mdadm.rst",
"resource_mount.rst",
"resource_ohai.rst",
"resource_openbsd_package.rst",
"resource_osx_profile.rst",
"resource_package.rst",
"resource_pacman_package.rst",
"resource_paludis_package.rst",
"resource_perl.rst",
"resource_portage_package.rst",
"resource_powershell_script.rst",
"resource_private_key.rst",
"resource_public_key.rst",
"resource_python.rst",
"resource_reboot.rst",
"resource_registry_key.rst",
"resource_remote_directory.rst",
"resource_remote_file.rst",
"resource_route.rst",
"resource_rpm_package.rst",
# fail 14 "resource.rst",
"resource_ruby_block.rst",
"resource_ruby.rst",
"resource_script.rst",
"resource_service.rst",
"resource_smartos_package.rst",
"resource_solaris_package.rst",
"resources_prologue.rst",
"resources.rst",
"resource_subversion.rst",
"resource_systemd_unit.rst",
"resource_template.rst",
"resource_user.rst",
"resource_windows_package.rst",
"resource_windows_service.rst",
"resource_yum_repository.rst",
"resource_yum.rst",
"roles.rst",
"rubocop.rst",
"ruby.rst",
"runbook_prologue.rst",
"runbook.rst",
"run_lists.rst",
"search_query_chef_automate.rst",
"secrets.rst",
"security_notes.rst",
"server_backup_restore.rst",
"server_components.rst",
#fail 10 "server_configure_saml.rst",
#fail 12 "server_data.rst",
"server_firewalls_and_ports.rst",
"server_high_availability.rst",
"server_ldap.rst",
"server_logs.rst",
"server_manage_clients.rst",
"server_manage_cookbooks.rst",
"server_manage_data_bags.rst",
"server_manage_environments.rst",
"server_manage_nodes.rst",
"server_manage_reports.rst",
"server_manage_roles.rst",
"server_monitor.rst",
"server_orgs.rst",
"server_replication.rst",
"server_security.rst",
#fail 11 "server_sent_events.rst",
"server_services.rst",
"server_tuning.rst",
"server_users.rst",
"server_webui_tasks.rst",
"setup_visibility_chef_automate.rst",
"simple_walkthrough.rst",
"slides.rst",
"stream_data_chef_automate.rst",
"style_guide.rst",
"supermarket_logs.rst",
"supermarket_monitor.rst",
"supermarket.rst",
"templates.rst",
"troubleshooting_chef_automate.rst",
"uninstall.rst",
"upgrade_chef_automate.rst",
"upgrade_client_notes.rst",
"upgrade_client.rst",
"upgrade_compliance.rst",
"upgrade_server_ha_v2.rst",
"upgrade_server_notes.rst",
"upgrade_server_open_source_notes.rst",
"upgrade_server.rst",
#fail 8 "verify_packages.rst",
"visibility.rst",
"windows.rst",
"workflow.rst",
"workstation.rst"
]


check_all_headings($stdin.read)
