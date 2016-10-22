=====================================================
chef-client
=====================================================

.. include:: ../../includes_chef_client/includes_chef_client.rst

.. note:: The chef-client executable can be run as a daemon.

Node Types
=====================================================

.. include:: ../../includes_node/includes_node.rst

.. include:: ../../includes_node/includes_node_types.rst

.. include:: ../../includes_node/includes_node_components.rst

The chef-client Run
=====================================================
.. include:: ../../includes_chef_client/includes_chef_client_run.rst

Authentication
-----------------------------------------------------
.. include:: ../../includes_chef_auth/includes_chef_auth.rst

.. include:: ../../includes_chef_auth/includes_chef_auth_authentication.rst

chef-validator
-----------------------------------------------------
.. include:: ../../includes_security/includes_security_chef_validator.rst

.. include:: ../../includes_security/includes_security_chef_validator_context.rst

SSL Certificates
=====================================================
.. include:: ../../includes_node/includes_node_certificate.rst

Signed Headers
-----------------------------------------------------
.. include:: ../../includes_security/includes_security_signed_header_authentication.rst

During a chef-client Run
-----------------------------------------------------
.. include:: ../../includes_chef_auth/includes_chef_auth_authentication_chef_run.rst


SSL Verification
=====================================================
.. warning:: The following information does not apply to hosted Chef server 12, only to on-premises Chef server 12.

.. include:: ../../includes_server_security/includes_server_security_ssl_cert_client.rst

Changes Prior to Chef 12
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_11-to-12_ssl_changes.rst

``/.chef/trusted_certs``
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_directory_trusted_certs.rst

SSL_CERT_FILE
-----------------------------------------------------
.. include:: ../../includes_environment_variables/includes_environment_variables_ssl_cert_file.rst

client.rb Settings
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_ssl_config_settings.rst

Knife Subcommands
-----------------------------------------------------
The chef-client includes two knife commands for managing SSL certificates:

* Use :doc:`knife ssl check </knife_ssl_check>` to troubleshoot SSL certificate issues
* Use :doc:`knife ssl fetch </knife_ssl_fetch>` to pull down a certificate from the Chef server to the ``/.chef/trusted_certs`` directory on the workstation.

After the workstation has the correct SSL certificate, bootstrap operations from that workstation will use the certificate in the ``/.chef/trusted_certs`` directory during the bootstrap operation.

knife ssl check
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Run the ``knife ssl check`` subcommand to verify the state of the SSL certificate, and then use the reponse to help troubleshoot issues that may be present.

**Verified**

.. include:: ../../step_knife/step_knife_ssl_check_verify_server_config.rst

**Unverified**

.. include:: ../../step_knife/step_knife_ssl_check_bad_ssl_certificate.rst

knife ssl fetch
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Run the ``knife ssl fetch`` to download the self-signed certificate from the Chef server to the ``/.chef/trusted_certs`` directory on a workstation. For example:

.. include:: ../../step_knife/step_knife_ssl_fetch_verify_certificate.rst

**Verify Checksums**

.. include:: ../../step_knife/step_knife_ssl_fetch_verify_certificate.rst


Bootstrap Operations
=====================================================

.. include:: ../../includes_install/includes_install_chef_client.rst

.. include:: ../../includes_chef_client/includes_chef_client_bootstrap_node.rst

.. include:: ../../includes_chef_client/includes_chef_client_bootstrap_stages.rst
