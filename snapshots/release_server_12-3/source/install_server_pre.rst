.. THIS PAGE DOCUMENTS Chef server version 12.3

=====================================================
Prerequisites
=====================================================

The following prerequisites apply to every installation of the Chef server.

Platforms
=====================================================
.. include:: ../../includes_adopted_platforms/includes_adopted_platforms_server.rst

Untested Platforms
-----------------------------------------------------
.. include:: ../../includes_adopted_platforms/includes_adopted_platforms_server_other.rst

Capacity Planning
=====================================================
Read the `guidance around capacity planning <https://docs.chef.io/release/server_12-3/server_components.html#capacity-planning>`__ for information about how to choose the right toplogy for the Chef server.

Software Requirements
=====================================================
.. include:: ../../includes_system_requirements/includes_system_requirements_server_etc.rst

UIDs and GIDs
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_common_uid_max.rst

SELinux
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_common_selinux.rst

AppArmor
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_common_apparmor.rst

Apache Qpid
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_common_apache_qpid.rst

cron
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_common_cron.rst

Enterprise Linux Updates
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_common_enterprise_linux_platform_updates.rst

Hostnames
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_common_hostname.rst

Configure Hostnames
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the following sections to verify the hostnames that is used by the Chef server.

**To verify if a hostname is a FQDN**

.. include:: ../../includes_install/includes_install_common_hostname_is_fqdn.rst

**To verify the FQDN is all lowercase**

.. include:: ../../includes_install/includes_install_common_hostname_is_lowercase.rst

**To verify a hostname is resolvable**

.. include:: ../../includes_install/includes_install_common_hostname_is_resolvable.rst

**To change a hostname**

.. include:: ../../includes_install/includes_install_common_hostname_edit.rst

**To add a hostname to /etc/hosts**

.. include:: ../../includes_install/includes_install_common_hostname_add_to_etc_hosts.rst

Chef Analytics
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_install/includes_install_analytics_hostname.rst

.. warning:: The FQDN for the Chef Analytics server should not exceed 64 characters when using OpenSSL. OpenSSL requires the ``CN`` in a certificate to be no longer than 64 characters. By default, Chef Analytics uses the FQDN of the server to determine the common name (``CN``). If the FQDN of the Chef Analytics server is longer than 64 characters, the ``chef-server-ctl reconfigure`` command will not fail, but an empty certificate file will be created. Nginx will not start if a certificate file is empty.

Mail Relay
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_common_mail_relay.rst

NTP
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_common_ntp.rst

chef-client
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_install/includes_install_common_ntp_chef_client.rst

Required Accounts
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_common_required_accounts.rst

Group Accounts
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_install/includes_install_common_required_accounts_group.rst

User Accounts
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_install/includes_install_common_required_accounts_user.rst
