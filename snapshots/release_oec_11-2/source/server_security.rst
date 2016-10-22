.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.2

=====================================================
Security
=====================================================

.. include:: ../../includes_server_security/includes_server_security_ssl.rst

.. warning:: The FQDN for the Chef server should not exceed 64 characters when using OpenSSL. OpenSSL requires the ``CN`` in a certificate to be no longer than 64 characters.

.. warning:: By default, the Chef server uses the FQDN to determine the common name (``CN``). If the FQDN of the Chef server is longer than 64 characters, the ``reconfigure`` command will not fail, but an empty certificate file will be created. Nginx will not start if a certificate file is empty.

SSL Certificates
=====================================================
.. include:: ../../includes_server_security/includes_server_security_ssl_cert_custom.rst

For more information about the server configuration file, see :doc:`private-chef.rb </config_rb_chef_server_enterprise>`.

Chef Analytics
-----------------------------------------------------
.. include:: ../../includes_server_security/includes_server_security_ssl_cert_custom_analytics.rst

Regenerate Certificates
-----------------------------------------------------
.. include:: ../../includes_server_security/includes_server_security_ssl_cert_regenerate.rst

SSL Protocols
=====================================================
.. include:: ../../includes_server_tuning/includes_server_tuning_nginx.rst

chef-client Settings
=====================================================
The client.rb file has the following settings for configuring SSL for chef-client interaction with the Chef server:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``ssl_ca_file``
     - The file in which the OpenSSL key is saved. This setting is generated automatically by the chef-client and most users do not need to modify it.
   * - ``ssl_ca_path``
     - The path to where the OpenSSL key is located. This setting is generated automatically by the chef-client and most users do not need to modify it.
   * - ``ssl_client_cert``
     - The OpenSSL X.509 certificate used for mutual certificate validation. This setting is only necessary when mutual certificate validation is configured on the Chef server. Default value: ``nil``.
   * - ``ssl_client_key``
     - The OpenSSL X.509 key used for mutual certificate validation. This setting is only necessary when mutual certificate validation is configured on the Chef server. Default value: ``nil``.
   * - ``ssl_verify_mode``
     - Set the verify mode for HTTPS requests.
       
       * Use ``:verify_none`` to do no validation of SSL certificates.
       * Use ``:verify_peer`` to do validation of all SSL certificates, including the Chef server connections, S3 connections, and any HTTPS **remote_file** resource URLs used in the chef-client run. This is the recommended setting.
       
       Depending on how OpenSSL is configured, the ``ssl_ca_path`` may need to be specified.
   * - ``verify_api_cert``
     - Verify the SSL certificate on the Chef server. When ``true``, the chef-client always verifies the SSL certificate. When ``false``, the chef-client uses the value of ``ssl_verify_mode`` to determine if the SSL certificate requires verification. Default value: ``false``.

