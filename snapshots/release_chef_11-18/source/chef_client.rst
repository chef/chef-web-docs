.. THIS PAGE DOCUMENTS chef-client version 11.18

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

Bootstrap Operations
=====================================================

.. include:: ../../includes_install/includes_install_chef_client.rst

.. include:: ../../includes_chef_client/includes_chef_client_bootstrap_node.rst

.. include:: ../../includes_chef_client/includes_chef_client_bootstrap_stages.rst

