=====================================================
|chef client_title| Security
=====================================================

.. include:: ../../includes_chef_auth/includes_chef_auth.rst

Authentication
=====================================================
.. include:: ../../includes_chef_auth/includes_chef_auth_authentication.rst

|chef validator|
-----------------------------------------------------
.. include:: ../../includes_security/includes_security_chef_validator.rst

During a |chef client_title| Run
-----------------------------------------------------
.. include:: ../../includes_chef_auth/includes_chef_auth_authentication_chef_run.rst

SSL Certificates
=====================================================
.. warning:: The following information does not apply to hosted |chef server| 12, only to on-premises |chef server| 12.

.. include:: ../../includes_server_security/includes_server_security_ssl_cert_client.rst

Changes Prior to |chef| 12
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_11-to-12_ssl_changes.rst

|path trusted_certs|
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_directory_trusted_certs.rst

SSL_CERT_FILE
-----------------------------------------------------
.. include:: ../../includes_environment_variables/includes_environment_variables_ssl_cert_file.rst

|client rb| Settings
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_ssl_config_settings.rst

|knife_title| Subcommands
-----------------------------------------------------
The |chef client| includes two |knife| commands for managing |ssl| certificates:

* Use `knife ssl check <https://docs.chef.io/knife_ssl_check>`__ to troubleshoot |ssl| certificate issues
* Use `knife ssl fetch <https://docs.chef.io/knife_ssl_fetch>`__ to pull down a certificate from the |chef server| to the |path trusted_certs| directory on the workstation.

After the workstation has the correct |ssl| certificate, bootstrap operations from that workstation will use the certificate in the |path trusted_certs| directory during the bootstrap operation.

knife ssl check
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Run the |subcommand knife ssl_check| command to verify the state of the |ssl| certificate, and then use the reponse to help troubleshoot issues that may be present.

**Verified**

.. include:: ../../step_knife/step_knife_ssl_check_verify_server_config.rst

**Unverified**

.. include:: ../../step_knife/step_knife_ssl_check_bad_ssl_certificate.rst

knife ssl fetch
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Run the |subcommand knife ssl_fetch| to download the self-signed certificate from the |chef server| to the |path trusted_certs| directory on a workstation.

**Verify Checksums**

.. include:: ../../step_knife/step_knife_ssl_fetch_verify_certificate.rst

