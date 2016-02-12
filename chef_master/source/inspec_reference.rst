=====================================================
InSpec Reference
=====================================================

.. include:: ../../includes_inspec/includes_inspec.rst

See below for more information about each |inspec resource|, its related matchers, and examples of how to use it in a recipe.


apache_conf
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_apache_conf.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_apache_conf_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_apache_conf_matcher_service_name.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test for blocking .htaccess files on CentOS**

.. include:: ../../step_inspec/step_inspec_apache_conf_block_htaccess.rst

**Test ports for SSL**

.. include:: ../../step_inspec/step_inspec_apache_conf_test_ports_for_ssl.rst


apt
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_apt.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_apt_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_enabled
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_apt_matcher_be_enabled.rst

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_apt_matcher_exist.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test if apt repository exists and is enabled**

.. include:: ../../step_inspec/step_inspec_apt_repo_exists.rst

**Verify that a PPA repository exists and is enabled**

.. include:: ../../step_inspec/step_inspec_apt_ppa_repo_exists.rst

**Verify that a repository is not present**

.. include:: ../../step_inspec/step_inspec_apt_repo_not_present.rst


audit_policy
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_audit_policy.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_audit_policy_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource no_matcher|

Examples
-----------------------------------------------------
|inspec examples|

**Test that a parameter is not set to "No Auditing"**

.. include:: ../../step_inspec/step_inspec_audit_policy_no_auditing.rst

**Test that a parameter is set to "Success"**

.. include:: ../../step_inspec/step_inspec_audit_policy_success.rst


auditd_conf
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_auditd_conf.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_auditd_conf_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_auditd_conf_matcher_keyword.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test the auditd.conf file**

.. include:: ../../step_inspec/step_inspec_auditd_conf_settings.rst


auditd_rules
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_auditd_rules.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_auditd_rules_syntax.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test if a rule contains a matching element that is identified by a regular expression**

.. include:: ../../step_inspec/step_inspec_auditd_rules_match_element.rst


bond
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_bond.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_bond_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

content
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_bond_matcher_content.rst

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_bond_matcher_exist.rst

have_interface
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_bond_matcher_have_interface.rst

interfaces
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_bond_matcher_interfaces.rst

params
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_bond_matcher_params.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test if eth0 is a secondary interface for bond0**

.. include:: ../../step_inspec/step_inspec_bond_eth0_secondary_to_bond0.rst

**Test parameters for bond0**

.. include:: ../../step_inspec/step_inspec_bond_bond0_parameters.rst


bridge
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_bridge.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_bridge_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_bridge_matcher_exist.rst

have_interface
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_bridge_matcher_have_interface.rst

interfaces
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_bridge_matcher_interfaces.rst

.. 
.. Examples
.. -----------------------------------------------------
.. The following examples show how to use this InSpec resource.
.. 
.. **xxxxx** 
.. 
.. xxxxx
.. 
.. **xxxxx** 
.. 
.. xxxxx
.. 


command
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_command.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_command_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_command_matcher_exist.rst

exit_status
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_command_matcher_exit_status.rst

stderr
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_command_matcher_stderr.rst

stdout
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_command_matcher_stdout.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test for PostgreSQL database running a RC, development, or beta release**

.. include:: ../../step_inspec/step_inspec_command_postgresql_rc.rst

**Test standard output (stdout)**

.. include:: ../../step_inspec/step_inspec_command_stdout.rst

**Test standard error (stderr)**

.. include:: ../../step_inspec/step_inspec_command_stderr.rst

**Test an exit status code**

.. include:: ../../step_inspec/step_inspec_command_exit_status_code.rst

**Test if the command shell exists**

.. include:: ../../step_inspec/step_inspec_command_shell_exists.rst

**Test for a command that should not exist**

.. include:: ../../step_inspec/step_inspec_command_should_not_exist.rst


csv
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_csv.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_csv_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_csv_matcher_name.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test a CSV file**

.. include:: ../../step_inspec/step_inspec_csv_file.rst


directory
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_directory.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_directory_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_directory_matchers_same_as_file.rst

.. 
.. Examples
.. -----------------------------------------------------
.. The following examples show how to use this InSpec resource.
.. 
.. **xxxxx** 
.. 
.. xxxxx
.. 
.. **xxxxx** 
.. 
.. xxxxx
.. 


etc_group
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_group.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_group_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

gids
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_group_matcher_gids.rst

groups
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_group_matcher_groups.rst

users
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_group_matcher_users.rst

where
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_group_matcher_where.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test group identifiers (GIDs) for duplicates**

.. include:: ../../step_inspec/step_inspec_etc_group_duplicate_gids.rst

**Test all groups to see if a specific user belongs to one (or more) groups**

.. include:: ../../step_inspec/step_inspec_etc_group_all_groups_for_user.rst

**Test all groups for a specific user name**

.. include:: ../../step_inspec/step_inspec_etc_group_user_name.rst

**Filter a list of groups for a specific user**

.. include:: ../../step_inspec/step_inspec_etc_group_user.rst


file
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_block_device
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_block_device.rst

be_character_device
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_character_device.rst

be_directory
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_directory.rst

be_executable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_executable.rst

be_file
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_file.rst

be_grouped_into
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_grouped_into.rst

be_immutable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_immutable.rst

be_linked_to
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_linked_to.rst

be_mounted
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_mounted.rst

be_owned_by
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_owned_by.rst

be_pipe
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_pipe.rst

be_readable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_readable.rst

be_socket
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_socket.rst

be_symlink
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_symlink.rst

be_version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_version.rst

be_writable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_writable.rst

content
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_content.rst

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_exist.rst

file_version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_file_version.rst

group
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_group.rst

have_mode
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_have_mode.rst

link_path
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_link_path.rst

link_target
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_link_target.rst

md5sum
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_md5sum.rst

mode
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_mode.rst

mtime
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_mtime.rst

owner
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_owner.rst

product_version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_product_version.rst

selinux_label
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_selinux_label.rst

sha256sum
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_sha256sum.rst
   
size
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_size.rst

type
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_type.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test the contents of a file for MD5 requirements**

.. include:: ../../step_inspec/step_inspec_file_md5_contents.rst

**Test if a file exists**

.. include:: ../../step_inspec/step_inspec_file_exists.rst

**Test that a file does not exist**

.. include:: ../../step_inspec/step_inspec_file_does_not_exist.rst

**Test if a path is a directory**

.. include:: ../../step_inspec/step_inspec_file_is_directory.rst

**Test if a path is a file and not a directory**

.. include:: ../../step_inspec/step_inspec_file_is_file.rst

**Test if a file is a symbolic link**

.. include:: ../../step_inspec/step_inspec_file_is_symbolic_link.rst

**Test if a file is a character device**

.. include:: ../../step_inspec/step_inspec_file_is_character_device.rst

**Test if a file is a block device**

.. include:: ../../step_inspec/step_inspec_file_is_block_device.rst

**Test the mode for a file**

.. include:: ../../step_inspec/step_inspec_file_mode.rst

**Test the owner of a file**

.. include:: ../../step_inspec/step_inspec_file_owner.rst

**Test if a file is owned by the root user**

.. include:: ../../step_inspec/step_inspec_file_owned_by_root.rst

**Test the mtime for a file**

.. include:: ../../step_inspec/step_inspec_file_mtime.rst

**Test that a file's size is between 64 and 10240**

.. include:: ../../step_inspec/step_inspec_file_size_more_than_64.rst

**Test that a file's size is zero**

.. include:: ../../step_inspec/step_inspec_file_size_is_zero.rst

**Test that a file is not mounted**

.. include:: ../../step_inspec/step_inspec_file_not_mounted.rst

**Test an MD5 checksum**

.. include:: ../../step_inspec/step_inspec_file_md5_checksum.rst

**Test an SHA-256 checksum**

.. include:: ../../step_inspec/step_inspec_file_sha256_checksum.rst


gem
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_gem.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_gem_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_gem_matcher_be_installed.rst

version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_gem_matcher_version.rst

Examples
-----------------------------------------------------
|inspec examples|

**Verify that a gem package is installed, with a specific version**

.. include:: ../../step_inspec/step_inspec_gem_package_installed.rst

**Verify that a gem package is not installed**

.. include:: ../../step_inspec/step_inspec_gem_package_not_installed.rst


group
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_groups.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_groups_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_local
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_groups_matcher_be_local.rst

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_groups_matcher_exist.rst

gid
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_groups_matcher_gid.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test the group identifier for the root group**

.. include:: ../../step_inspec/step_inspec_group_gid_for_root_group.rst


host
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_host.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_host_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_reachable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_host_matcher_be_reachable.rst

be_resolvable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_host_matcher_be_resolvable.rst

ipaddress
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_host_matcher_ipaddress.rst

Examples
-----------------------------------------------------
|inspec examples|

**Verify host name is reachable over a specific protocol and port number**

.. include:: ../../step_inspec/step_inspec_host_name_is_reachable.rst

**Verify that a specific IP address can be resolved**

.. include:: ../../step_inspec/step_inspec_host_ip_address_resolved.rst


inetd_conf
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_inetd_conf.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_inetd_conf_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_inetd_conf_matcher_service_name.rst

Examples
-----------------------------------------------------
|inspec examples|

**Verify that FTP is disabled**

.. include:: ../../step_inspec/step_inspec_inetd_conf_ftp_disabled.rst

**Test if telnet is installed**

.. include:: ../../step_inspec/step_inspec_inetd_conf_telnet_installed.rst



interface
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_interface.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_interface_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_up
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_interface_matcher_be_up.rst

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_interface_matcher_name.rst

speed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_interface_matcher_speed.rst

..
.. Examples
.. -----------------------------------------------------
.. The following examples show how to use this InSpec audit resource.
..
.. **xxxxx**
..
.. xxxxx
..
.. **xxxxx**
..
.. xxxxx
..


iptables
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_iptables.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_iptables_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

have_rule
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_iptables_matcher_have_rule.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test if the IP table allows a packet through**

.. include:: ../../step_inspec/step_inspec_iptables_allows_packets.rst

**Test if the IP table allows a packet through, for a specific table and chain**

.. include:: ../../step_inspec/step_inspec_iptables_allows_packets_on_specific_table_and_chain.rst


json
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_json.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_json_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_json_matcher_name.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test a cookbook version in a policyfile.lock.json file**

.. include:: ../../step_inspec/step_inspec_json_policyfile_lock.rst


kernel_module
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_kernel_module.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_kernel_module_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_loaded
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_kernel_module_matcher_be_loaded.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test if a module is loaded**

.. include:: ../../step_inspec/step_inspec_kernel_module_loaded.rst


kernel_parameter
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_kernel_parameter.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_kernel_parameter_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

value
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_kernel_parameter_matcher_value.rst
   
Examples
-----------------------------------------------------
|inspec examples|

**Test if global forwarding is enabled for an IPv4 address**

.. include:: ../../step_inspec/step_inspec_kernel_parameter_ipv4_forwarding_enabled.rst

**Test if global forwarding is disabled for an IPv6 address**

.. include:: ../../step_inspec/step_inspec_kernel_parameter_ipv6_forwarding_disabled.rst

**Test if an IPv6 address accepts redirects**

.. include:: ../../step_inspec/step_inspec_kernel_parameter_ipv6_accepts_redirects.rst


limits_conf
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_limits_conf.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_limits_conf_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

domain
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_limits_conf_matcher_domain.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test limits**

.. include:: ../../step_inspec/step_inspec_limits_conf_settings.rst


login_defs
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_login_defs.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_login_defs_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_login_defs_matcher_name.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test password expiration settings**

.. include:: ../../step_inspec/step_inspec_login_defs_password_expiration.rst

**Test the encryption method**

.. include:: ../../step_inspec/step_inspec_login_defs_encryption_method.rst

**Test umask and password expiration**

.. include:: ../../step_inspec/step_inspec_login_defs_umask.rst


mysql_conf
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_mysql_conf.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_mysql_conf_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

setting
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_mysql_conf_matcher_setting.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test the maximum number of allowed connections**

.. include:: ../../step_inspec/step_inspec_mysql_conf_max_allowed_connections.rst

**Test slow query logging**

.. include:: ../../step_inspec/step_inspec_mysql_conf_slow_query_logging.rst

**Test the port and socket on which MySQL listens**

.. include:: ../../step_inspec/step_inspec_mysql_conf_port_and_socket.rst

**Test connection and thread variables**

.. include:: ../../step_inspec/step_inspec_mysql_conf_thread_variables.rst

**Test the safe-user-create parameter**

.. include:: ../../step_inspec/step_inspec_mysql_conf_safe_user_create.rst
  

mysql_session
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_mysql_session.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_mysql_session_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

output
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_mysql_session_matcher_output.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test for matching databases**

.. include:: ../../step_inspec/step_inspec_mysql_session_matching_databases.rst


npm
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_npm.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_npm_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_npm_matcher_be_installed.rst

version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_npm_matcher_version.rst

Examples
-----------------------------------------------------
|inspec examples|

**Verify that bower is installed, with a specific version**

.. include:: ../../step_inspec/step_inspec_npm_bower_is_installed.rst

**Verify that statsd is not installed**

.. include:: ../../step_inspec/step_inspec_npm_statsd_not_installed.rst


ntp_conf
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_ntp_conf.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_ntp_conf_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_ntp_conf_matcher_service_name.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test for clock drift against named servers**

.. include:: ../../step_inspec/step_inspec_ntp_clock_drift.rst


oneget
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_oneget.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_oneget_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_oneget_matcher_be_installed.rst

version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_oneget_matcher_version.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test if VLC is installed**

.. include:: ../../step_inspec/step_inspec_oneget_vlc_installed.rst


os
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_os.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_os_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource no_matcher|

Examples
-----------------------------------------------------
|inspec examples|

**Test for RedHat**

.. include:: ../../step_inspec/step_inspec_os_redhat.rst

**Test for Ubuntu**

.. include:: ../../step_inspec/step_inspec_os_ubuntu.rst

**Test for Microsoft Windows**

.. include:: ../../step_inspec/step_inspec_os_windows.rst


os_env
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_os_env.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_os_env_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

content
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_os_env_matcher_content.rst

split
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_os_env_matcher_split.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test the PATH environment variable**

.. include:: ../../step_inspec/step_inspec_os_env_path.rst


package
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_package.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_package_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_package_matcher_be_installed.rst

version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_package_matcher_version.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test if nginx version 1.9.5 is installed**

.. include:: ../../step_inspec/step_inspec_package_nginx_version_installed.rst

**Test that a package is not installed**

.. include:: ../../step_inspec/step_inspec_package_not_installed.rst

**Test if telnet is installed**

.. include:: ../../step_inspec/step_inspec_package_telnet_installed.rst

**Test if ClamAV (an antivirus engine) is installed and running**

.. include:: ../../step_inspec/step_inspec_package_clamav_installed.rst


parse_config
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_parse_config.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_parse_config_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_parse_config_options.rst

assignment_re
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_assign_regex.rst

comment_char
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_comment_char.rst

key_vals
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_key_values.rst

multiple_values
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_multiple_values.rst

standalone_comments
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_standalone.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test the expiration time for new account passwords**

.. include:: ../../step_inspec/step_inspec_parse_config_expiration_time_for_passwords.rst

**Test that bob is a user**

.. include:: ../../step_inspec/step_inspec_parse_config_bob_is_user.rst


parse_config_file
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_parse_config_file.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_parse_config_file_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_parse_config_file_options.rst

assignment_re
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_assign_regex.rst

comment_char
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_comment_char.rst

key_vals
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_key_values.rst

multiple_values
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_multiple_values.rst

standalone_comments
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_standalone.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test a configuration setting**

.. include:: ../../step_inspec/step_inspec_parse_config_file_settings.rst

**Use options, and then test a configuration setting**

.. include:: ../../step_inspec/step_inspec_parse_config_file_options_then_settings.rst


passwd
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd_syntax.rst

Matchers for ``passwd``
-----------------------------------------------------
|inspec resource matcher|

gids
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd_matcher_gids.rst

passwords
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd_matcher_passwords.rst

uids
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd_matcher_uids.rst

usernames
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd_matcher_usernames.rst

Matchers for ``passwd.uid(userid)``
-----------------------------------------------------
|inspec resource matcher|

count
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd_matcher_count.rst

uid
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd_matcher_uid.rst

username
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd_matcher_username.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test usernames and UIDs**

.. include:: ../../step_inspec/step_inspec_etc_passwd_uids.rst

**Select one user and test for multiple occurrences**

.. include:: ../../step_inspec/step_inspec_etc_passwd_multiple_users.rst


pip
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_pip.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_pip_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_pip_matcher_be_installed.rst

version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_pip_matcher_version.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test if Jinja2 is installed on the system**

.. include:: ../../step_inspec/step_inspec_pip_jinja2_installed.rst

**Test if Jinja2 2.8 is installed on the system**

.. include:: ../../step_inspec/step_inspec_pip_jinja2_version_installed.rst

port
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_port.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_port_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_listening
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_port_matcher_be_listening.rst

pid
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_port_matcher_pid.rst

processes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_port_matcher_process.rst

protocol
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_port_matcher_protocol.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test port 80, listening with the TCP protocol**

.. include:: ../../step_inspec/step_inspec_port_listen_with_tcp.rst

**Test port 80, listening with TCP version IPv6 protocol**

.. include:: ../../step_inspec/step_inspec_port_listen_with_tcp_and_ipv6.rst

**Test that only secure ports accept requests**

.. include:: ../../step_inspec/step_inspec_port_listen_on_secure_ports.rst


postgres_conf
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_postgres_conf.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_postgres_conf_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

setting
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_postgres_conf_matcher_setting.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test the maximum number of allowed client connections**

.. include:: ../../step_inspec/step_inspec_postgres_conf_max_allowed_clients.rst

**Test system logging**

.. include:: ../../step_inspec/step_inspec_postgres_conf_system_logging.rst

**Test the port on which PostgreSQL listens**

.. include:: ../../step_inspec/step_inspec_postgres_conf_port.rst

**Test the Unix socket settings**

.. include:: ../../step_inspec/step_inspec_postgres_conf_unix_socket.rst


postgres_session
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_postgres_session.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_postgres_session_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

output
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_postgres_session_matcher_output.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test the PostgreSQL shadow password**

.. include:: ../../step_inspec/step_inspec_postgres_session_shadow_password.rst

**Test for risky database entries**

.. include:: ../../step_inspec/step_inspec_postgres_session_risky_database_entry.rst


process
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_process.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_process_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

property_name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_process_matcher_property_name.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test if the list length for the mysqld process is 1**

.. include:: ../../step_inspec/step_inspec_process_list_length.rst

**Test if the init process is owned by the root user**

.. include:: ../../step_inspec/step_inspec_process_init_process.rst

**Test if a high-priority process is running**

.. include:: ../../step_inspec/step_inspec_process_high_priority_process.rst


registry_key
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_registry_key.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_registry_key_syntax.rst

Registry Key Path Separators
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_windows/includes_windows_registry_key_backslashes.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_registry_key_matcher_name.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test the start time for the Schedule service**

.. include:: ../../step_inspec/step_inspec_registry_key_schedule_service.rst


script
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_script.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_script_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

exit_status
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_script_matcher_exit_status.rst

stderr
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_script_matcher_stderr.rst

stdout
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_script_matcher_stdout.rst

Examples
-----------------------------------------------------
|inspec examples|

**Get all groups of Administrator user**

.. include:: ../../step_inspec/step_inspec_script_user_get_all_groups.rst


security_policy
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_security_policy.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_security_policy_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

policy_name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_security_policy_matcher_policy_name.rst

Examples
-----------------------------------------------------
|inspec examples|

**Verify that only the Administrators group has remote access**

.. include:: ../../step_inspec/step_inspec_security_policy_only_admin_group_has_remote_access.rst


service
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_service.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_service_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_enabled
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_service_matcher_be_enabled.rst

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_service_matcher_be_installed.rst

be_running
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_service_matcher_be_running.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test if the postgresql service is both running and enabled**

.. include:: ../../step_inspec/step_inspec_service_postgresql.rst

**Test if the mysql service is both running and enabled**

.. include:: ../../step_inspec/step_inspec_service_mysql.rst

**Test if ClamAV (an antivirus engine) is installed and running**

.. include:: ../../step_inspec/step_inspec_service_clamav.rst


ssh_config
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_ssh_config.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_ssh_config_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_ssh_config_matcher_name.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test SSH configuration settings**

.. include:: ../../step_inspec/step_inspec_ssh_config_settings.rst

**Test which variables from the local environment are sent to the server**

.. include:: ../../step_inspec/step_inspec_ssh_config_owner_and_group.rst

**Test owner and group permissions**

.. include:: ../../step_inspec/step_inspec_ssh_config_owner_and_group.rst

**Test SSH configuration**

.. include:: ../../step_inspec/step_inspec_ssh_config_ssh.rst


sshd_config
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_sshd_config.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_sshd_config_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_sshd_config_matcher_name.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test which variables may be sent to the server**

.. include:: ../../step_inspec/step_inspec_sshd_config_variables_sent_to_server.rst

**Test for IPv6-only addresses**

.. include:: ../../step_inspec/step_inspec_sshd_config_ipv6_only.rst

**Test the Protocol setting**

.. include:: ../../step_inspec/step_inspec_sshd_config_protocol.rst

**Test for approved, strong ciphers**

.. include:: ../../step_inspec/step_inspec_sshd_conf_use_strong_ciphers.rst

**Test SSH protocols**

.. include:: ../../step_inspec/step_inspec_sshd_config_ssh.rst


user
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_user.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_user_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_user_matcher_exist.rst

gid
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_user_matcher_gid.rst

group
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_user_matcher_group.rst

groups
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_user_matcher_groups.rst

home
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_user_matcher_home.rst

maxdays
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_user_matcher_maxdays.rst

mindays
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_user_matcher_mindays.rst

shell
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_user_matcher_shell.rst

uid
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_user_matcher_uid.rst

warndays
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_user_matcher_warndays.rst

Examples
-----------------------------------------------------
|inspec examples|

**Verify available users for the MySQL server**

.. include:: ../../step_inspec/step_inspec_user_mysql.rst

**Test users on multiple platforms**

.. include:: ../../step_inspec/step_inspec_user_multiple_platforms.rst


windows_feature
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_windows_feature.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_windows_feature_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_windows_feature_matcher_be_installed.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test the DHCP Server feature**

.. include:: ../../step_inspec/step_inspec_windows_feature_dhcp.rst


yaml
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_yaml.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_yaml_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_yaml_matcher_name.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test a kitchen.yml file driver**

.. include:: ../../step_inspec/step_inspec_yaml_kitchen_driver.rst


yum
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_yum.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_yum_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_enabled
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_yum_matcher_be_enabled.rst

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_yum_matcher_exist.rst

repo('name')
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_yum_matcher_repo_name.rst

repos
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_yum_matcher_repos.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test if the yum repo exists**

.. include:: ../../step_inspec/step_inspec_yum_repo_exists.rst

**Test if the 'base/7/x86_64' repo exists and is enabled**

.. include:: ../../step_inspec/step_inspec_yum_named_repo_exists_is_enabled.rst

**Test if a specific yum repo exists**

.. include:: ../../step_inspec/step_inspec_yum_named_repo_exists.rst
