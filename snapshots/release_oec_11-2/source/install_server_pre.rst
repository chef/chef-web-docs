.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.2

=====================================================
Prerequisites
=====================================================

The following prerequisites apply to every installation of the Chef server.

Apache Qpid
=====================================================
.. include:: ../../includes_install/includes_install_common_apache_qpid.rst

cron
=====================================================
.. include:: ../../includes_install/includes_install_common_cron.rst

Enterprise Linux Platform Updates
=====================================================
.. include:: ../../includes_install/includes_install_common_enterprise_linux_platform_updates.rst

Hostnames
=====================================================
.. include:: ../../includes_install/includes_install_common_hostname.rst

.. warning:: The FQDN for the Chef Analytics server should not exceed 64 characters when using OpenSSL. OpenSSL requires the ``CN`` in a certificate to be no longer than 64 characters. By default, Chef Analytics uses the FQDN of the server to determine the common name (``CN``). If the FQDN of the Chef Analytics server is longer than 64 characters, the ``private-chef-ctl reconfigure`` command will not fail, but an empty certificate file will be created. Nginx will not start if a certificate file is empty.

**To verify if a hostname is a FQDN**

.. include:: ../../includes_install/includes_install_common_hostname_is_fqdn.rst

**To verify is a hostname is resolvable**

.. include:: ../../includes_install/includes_install_common_hostname_is_resolvable.rst

**To change a hostname**

.. include:: ../../includes_install/includes_install_common_hostname_edit.rst

**To add a hostname to /etc/hosts**

.. include:: ../../includes_install/includes_install_common_hostname_add_to_etc_hosts.rst

Mail Relay
=====================================================
.. include:: ../../includes_install/includes_install_common_mail_relay.rst

NTP
=====================================================
.. include:: ../../includes_install/includes_install_common_ntp.rst

chef-client
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_common_ntp_chef_client.rst

Required Accounts
=====================================================
.. include:: ../../includes_install/includes_install_common_required_accounts.rst

Group Accounts
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_common_required_accounts_group.rst

User Accounts
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_common_required_accounts_user.rst
