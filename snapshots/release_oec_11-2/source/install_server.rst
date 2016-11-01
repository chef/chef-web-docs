

=====================================================
Install Enterprise Chef
=====================================================

.. include:: ../../includes_chef_server/includes_chef_server.rst

The steps below describe the process for installing Enterprise Chef.

Steps
=====================================================
To install Enterprise Chef on-premises, do the following:

#. Go to http://downloads.chef.io/enterprise-chef/.
#. Choose your platform.
#. Download the package.
#. Review the :doc:`prerequisites <install_server_pre>`.
#. Choose a topology---:doc:`standalone <install_server_standalone>`, :doc:`scaled back end <install_server_be>`, and :doc:`scaled front end <install_server_fe>`---and then follow the steps for that scenario.

About the Hostname
=====================================================
.. include:: ../../includes_install/includes_install_common_hostname.rst

.. warning:: The FQDN for the Enterprise Chef server should not exceed 64 characters when using OpenSSL. OpenSSL requires the ``CN`` in a certificate to be no longer than 64 characters. By default, Enterprise Chef uses the FQDN of the server to determine the common name (``CN``). If the FQDN of the Enterprise Chef server is longer than 64 characters, the ``private-chef-ctl reconfigure`` command will not fail, but an empty certificate file will be created. Nginx will not start if a certificate file is empty.

**To verify if a hostname is a FQDN**

.. include:: ../../includes_install/includes_install_common_hostname_is_fqdn.rst

**To verify is a hostname is resolvable**

.. include:: ../../includes_install/includes_install_common_hostname_is_resolvable.rst

**To change a hostname**

.. include:: ../../includes_install/includes_install_common_hostname_edit.rst

**To add a hostname to /etc/hosts**

.. include:: ../../includes_install/includes_install_common_hostname_add_to_etc_hosts.rst
