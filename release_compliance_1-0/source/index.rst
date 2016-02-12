=====================================================
About Chef Compliance
=====================================================

.. include:: ../../includes_compliance/includes_compliance.rst

The Chef Compliance Server
=====================================================
.. include:: ../../includes_compliance/includes_compliance_server.rst

.. image:: ../../images/compliance_components.svg
   :width: 600px
   :align: center

Compliance Profiles
-----------------------------------------------------
.. include:: ../../includes_compliance/includes_compliance_profiles.rst

Audit Resources
=====================================================
.. include:: ../../includes_inspec/includes_inspec.rst

.. include:: ../../includes_inspec/includes_inspec_resources_list.rst

Examples
-----------------------------------------------------
The following examples show how to use the |inspec resource| collection to build tests.

**Only accept requests on secure ports**

This code uses the ``port`` resource to ensure that the web server is only listening on well-secured ports.

.. include:: ../../step_inspec/step_inspec_port_listen_on_secure_ports.rst

**Use approved strong ciphers**

This code uses the ``sshd_config`` resource to ensure that only enterprise-compliant ciphers are used for |ssh| servers.

.. include:: ../../step_inspec/step_inspec_sshd_conf_use_strong_ciphers.rst

**Test a kitchen.yml file driver**

This code uses the ``yaml`` resource to ensure that the |kitchen| driver is |vagrant|.

.. include:: ../../step_inspec/step_inspec_yaml_kitchen_driver.rst



.. Hide the TOC from this file.

.. toctree::
   :hidden:

   api_compliance
   ctl_inspec
   dsl_compliance
   inspec_apache_conf
   inspec_apt
   inspec_audit_policy
   inspec_auditd_conf
   inspec_auditd_rules
   inspec_bond
   inspec_bridge
   inspec_command
   inspec_csv
   inspec_directory
   inspec_etc_group
   inspec_etc_passwd
   inspec_file
   inspec_gem
   inspec_group
   inspec_host
   inspec_inetd_conf
   inspec_interface
   inspec_iptables
   inspec_json
   inspec_kernel_module
   inspec_kernel_parameter
   inspec_limits_conf
   inspec_login_def
   inspec_mysql_conf
   inspec_mysql_session
   inspec_npm
   inspec_ntp_conf
   inspec_oneget
   inspec_os_env
   inspec_os
   inspec_package
   inspec_parse_config_file
   inspec_parse_config
   inspec_pip
   inspec_port
   inspec_postgres_conf
   inspec_postgres_session
   inspec_process
   inspec_registry_key
   inspec_script
   inspec_security_policy
   inspec_service
   inspec_ssh_config
   inspec_sshd_config
   inspec_user
   inspec_windows_feature
   inspec_yaml
   inspec_yum
   install_compliance
   upgrade_compliance
