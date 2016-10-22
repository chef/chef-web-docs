.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use following client.rb settings to manage SSL certificate preferences:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``local_key_generation``
     - Whether the Chef server or chef-client generates the private/public key pair. When ``true``, the chef-client generates the key pair, and then sends the public key to the Chef server. Default value: ``true``.
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
       
       Depending on how OpenSSL is configured, the ``ssl_ca_path`` may need to be specified. Default value: ``:verify_peer``.
   * - ``verify_api_cert``
     - Verify the SSL certificate on the Chef server. When ``true``, the chef-client always verifies the SSL certificate. When ``false``, the chef-client uses the value of ``ssl_verify_mode`` to determine if the SSL certificate requires verification. Default value: ``false``.
