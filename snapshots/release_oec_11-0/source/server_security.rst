

=====================================================
Security
=====================================================

.. tag server_security_ssl

Configuration of SSL for the Chef server using certificate authority-verified certificates is done by placing the certificate and private key file obtained from the certifying authority in the correct files after the initial configuration of Chef server.

Initial configuration of the Chef server is done automatically using a self-signed certificate to create the certificate and private key files for Nginx.

The locations of the certificate and private key files are

* ``/var/opt/opscode/nginx/ca/FQDN.crt``
* ``/var/opt/opscode/nginx/ca/FQDN.key``

Because the FQDN has already been configured, do the following:

#. Replace the contents of ``/var/opt/opscode/nginx/ca/FQDN.crt`` and ``/var/opt/opscode/nginx/ca/FQDN.key`` with the certifying authority's files.
#. Reconfigure the Chef server:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Restart the Nginx service to load the new key and certificate:

   .. code-block:: bash

      $ chef-server-ctl restart nginx

.. end_tag

.. warning:: The FQDN for the Chef server should not exceed 64 characters when using OpenSSL. OpenSSL requires the ``CN`` in a certificate to be no longer than 64 characters.

.. warning:: By default, the Chef server uses the FQDN to determine the common name (``CN``). If the FQDN of the Chef server is longer than 64 characters, the ``reconfigure`` command will not fail, but an empty certificate file will be created. Nginx will not start if a certificate file is empty.

SSL Certificates
=====================================================
.. tag server_security_ssl_cert_custom

The Chef server can be configured to use SSL certificates by adding the following settings to the server configuration file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``nginx['ssl_certificate']``
     - The SSL certificate used to verify communication over HTTPS.
   * - ``nginx['ssl_certificate_key']``
     - The certificate key used for SSL communication.

and then setting their values to define the paths to the certificate and key.

.. end_tag

For more information about the server configuration file, see :doc:`private-chef.rb </config_rb_chef_server_enterprise>`.

Chef Analytics
-----------------------------------------------------
.. tag server_security_ssl_cert_custom_analytics

The Chef Analytics server can be configured to use SSL certificates by adding the following settings in the server configuration file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``ssl['certificate']``
     - The SSL certificate used to verify communication over HTTPS.
   * - ``ssl['certificate_key']``
     - The certificate key used for SSL communication.

and then setting their values to define the paths to the certificate and key.

For example:

.. code-block:: ruby

   ssl['certificate']  = "/etc/pki/tls/certs/your-host.crt"
   ssl['certificate_key']  = "/etc/pki/tls/private/your-host.key"

Save the file, and then run the following command:

.. code-block:: bash

   $ sudo opscode-analytics-ctl reconfigure

.. end_tag

Regenerate Certificates
-----------------------------------------------------
.. tag server_security_ssl_cert_regenerate

SSL certificates should be regenerated periodically. This is an important part of protecting the Chef server from vulnerabilities and helps to prevent the information stored on the Chef server from being compromised.

To regenerate SSL certificates:

#. Run the following command:

   .. code-block:: bash

      $ chef-server-ctl stop

#. The Chef server can regenerate them. These certificates will be located in ``/var/opt/opscode/nginx/ca/`` and will be named after the FQDN for the Chef server. To determine the FQDN for the server, run the following command:

   .. code-block:: bash

      $ hostname -f

   Please delete the files found in the ca directory with names like this ``$FQDN.crt`` and ``$FQDN.key``.

#. If your organization has provided custom SSL certificates to the Chef server, the locations of that custom certificate and private key are defined in ``/etc/opscode/chef-server.rb`` as values for the ``nginx['ssl_certificate']`` and ``nginx['ssl_certificate_key']`` settings. Delete the files referenced in those two settings and regenerate new keys using the same authority.

#. Run the following command, Chef server-generated SSL certificates will automatically be created if necessary:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Run the following command:

   .. code-block:: bash

      $ chef-server-ctl start

.. end_tag

SSL Protocols
=====================================================
.. tag server_tuning_nginx

The following settings are often modified from the default as part of the tuning effort for the **nginx** service and to configure the Chef server to use SSL certificates:

``nginx['ssl_certificate']``
   The SSL certificate used to verify communication over HTTPS. Default value: ``nil``.

``nginx['ssl_certificate_key']``
   The certificate key used for SSL communication. Default value: ``nil``.

``nginx['ssl_ciphers']``
   The list of supported cipher suites that are used to establish a secure connection. To favor AES256 with ECDHE forward security, drop the ``RC4-SHA:RC4-MD5:RC4:RSA`` prefix. For example:

   .. code-block:: ruby

      nginx['ssl_ciphers'] =  "HIGH:MEDIUM:!LOW:!kEDH: \
                               !aNULL:!ADH:!eNULL:!EXP: \
                               !SSLv2:!SEED:!CAMELLIA: \
                               !PSK"

``nginx['ssl_protocols']``
   The SSL protocol versions that are enabled. SSL 3.0 is supported by the Chef server; however, SSL 3.0 is an obsolete and insecure protocol. Transport Layer Security (TLS)---TLS 1.0, TLS 1.1, and TLS 1.2---has effectively replaced SSL 3.0, which provides for authenticated version negotiation between the chef-client and Chef server, which ensures the latest version of the TLS protocol is used. For the highest possible security, it is recommended to disable SSL 3.0 and allow all versions of the TLS protocol.  For example:

   .. code-block:: ruby

      nginx['ssl_protocols'] = "TLSv1 TLSv1.1 TLSv1.2"

.. note:: See https://wiki.mozilla.org/Security/Server_Side_TLS for more information about the values used with the ``nginx['ssl_ciphers']`` and ``nginx['ssl_protocols']`` settings.

For example, after copying the SSL certificate files to the Chef server, update the ``nginx['ssl_certificate']`` and ``nginx['ssl_certificate_key']`` settings to specify the paths to those files, and then (optionally) update the ``nginx['ssl_ciphers']`` and ``nginx['ssl_protocols']`` settings to reflect the desired level of hardness for the Chef server:

.. code-block:: ruby

   nginx['ssl_certificate'] = "/etc/pki/tls/private/name.of.pem"
   nginx['ssl_certificate_key'] = "/etc/pki/tls/private/name.of.key"
   nginx['ssl_ciphers'] = "HIGH:MEDIUM:!LOW:!kEDH:!aNULL:!ADH:!eNULL:!EXP:!SSLv2:!SEED:!CAMELLIA:!PSK"
   nginx['ssl_protocols'] = "TLSv1 TLSv1.1 TLSv1.2"

.. end_tag

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

