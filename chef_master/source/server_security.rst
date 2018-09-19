=====================================================
Security
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_security.rst>`__

This guide covers the security features available in Chef server.

SSL Certificates
=====================================================
Initial configuration of the Chef server is done automatically using a self-signed certificate to create the certificate and private key files for Nginx. This section details the process for updating a Chef server's SSL certificate.

Automatic Installation (recommended)
-----------------------------------------------------

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

For example:

.. code-block:: ruby

   nginx['ssl_certificate']  = "/etc/pki/tls/certs/your-host.crt"
   nginx['ssl_certificate_key']  = "/etc/pki/tls/private/your-host.key"

Save the file, and then run the following command:

.. code-block:: bash

   $ sudo chef-server-ctl reconfigure

For more information about the server configuration file, see `chef-server.rb </config_rb_server.html>`__.

Manual Installation
-----------------------------------------------------

SSL certificates can be updated manually by placing the certificate and private key file obtained from the certifying authority in the correct files, after the initial configuration of Chef server.

The locations of the certificate and private key files are:

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

.. warning:: The FQDN for the Chef server should not exceed 64 characters when using OpenSSL. OpenSSL requires the ``CN`` in a certificate to be no longer than 64 characters.

SSL Protocols
-----------------------------------------------------
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

**Example: Configure SSL Keys for Nginx**

The following example shows how the Chef server sets up and configures SSL certificates for Nginx. The cipher suite used by Nginx `is configurable </config_rb_server.html#ssl-protocols>`_ using the ``ssl_protocols`` and ``ssl_ciphers`` settings.

.. code-block:: ruby

   ssl_keyfile = File.join(nginx_ca_dir, "#{node['private_chef']['nginx']['server_name']}.key")
   ssl_crtfile = File.join(nginx_ca_dir, "#{node['private_chef']['nginx']['server_name']}.crt")
   ssl_signing_conf = File.join(nginx_ca_dir, "#{node['private_chef']['nginx']['server_name']}-ssl.conf")

   unless File.exist?(ssl_keyfile) && File.exist?(ssl_crtfile) && File.exist?(ssl_signing_conf)
     file ssl_keyfile do
       owner 'root'
       group 'root'
       mode '0755'
       content '/opt/opscode/embedded/bin/openssl genrsa 2048'
       not_if { File.exist?(ssl_keyfile) }
     end

     file ssl_signing_conf do
       owner 'root'
       group 'root'
       mode '0755'
       not_if { File.exist?(ssl_signing_conf) }
       content <<-EOH
     [ req ]
     distinguished_name = req_distinguished_name
     prompt = no
     [ req_distinguished_name ]
     C                      = #{node['private_chef']['nginx']['ssl_country_name']}
     ST                     = #{node['private_chef']['nginx']['ssl_state_name']}
     L                      = #{node['private_chef']['nginx']['ssl_locality_name']}
     O                      = #{node['private_chef']['nginx']['ssl_company_name']}
     OU                     = #{node['private_chef']['nginx']['ssl_organizational_unit_name']}
     CN                     = #{node['private_chef']['nginx']['server_name']}
     emailAddress           = #{node['private_chef']['nginx']['ssl_email_address']}
     EOH
     end

     ruby_block 'create crtfile' do
       block do
         r = Chef::Resource::File.new(ssl_crtfile, run_context)
         r.owner 'root'
         r.group 'root'
         r.mode '0755'
         r.content "/opt/opscode/embedded/bin/openssl req -config '#{ssl_signing_conf}' -new -x509 -nodes -sha1 -days 3650 -key '#{ssl_keyfile}'"
         r.not_if { File.exist?(ssl_crtfile) }
         r.run_action(:create)
       end
     end
   end

Chef Analytics
-----------------------------------------------------
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

Knife, chef-client
-----------------------------------------------------
.. tag server_security_ssl_cert_client

Chef server 12 enables SSL verification by default for all requests made to the server, such as those made by knife and the chef-client. The certificate that is generated during the installation of the Chef server is self-signed, which means the certificate is not signed by a trusted certificate authority (CA) that ships with the chef-client. The certificate generated by the Chef server must be downloaded to any machine from which knife and/or the chef-client will make requests to the Chef server.

For example, without downloading the SSL certificate, the following knife command:

.. code-block:: bash

   $ knife client list

responds with an error similar to:

.. code-block:: bash

   ERROR: SSL Validation failure connecting to host: chef-server.example.com ...
   ERROR: OpenSSL::SSL::SSLError: SSL_connect returned=1 errno=0 state=SSLv3 ...

This is by design and will occur until a verifiable certificate is added to the machine from which the request is sent.

.. end_tag

See `Chef client SSL Certificates </chef_client_security.html#ssl-certificates>`__ for more information on how knife and Chef client use SSL certificates generated by the Chef server.

Private Certificate Authority
-----------------------------------------------------
If an organization is using an internal certificate authority, then the root certificate will not appear in any ``cacerts.pem`` file that ships by default with operating systems and web browsers. Because of this, no currently deployed system will be able to verify certificates that are issued in this manner. To allow other systems to trust certificates from an internal certificate authority, this root certificate will need to be configured so that other systems can follow the chain of authority back to the root certificate. (An intermediate certificate is not enough because the root certificate is not already globally known.)

To use an internal certificate authority, append both the server (optionally, any intermediate cert as well) and root certificates into a single ``.crt`` file. For example:

.. code-block:: bash

   $ cat server.crt [intermediate.crt] root.crt >> /var/opt/opscode/nginx/ca/FQDN.crt

You can check the validity of your new combined cert like this, on the Chef Server. The cacert.pem only needs to contain your root CA's cert file. This is not the usual treatment, but mimics how ChefDK behaves after a ``knife ssl fetch`` followed by a ``knife ssl verify``

.. code-block:: bash

   $ openssl verify -verbose -purpose sslserver -CAfile cacert.pem  /var/opt/opscode/nginx/ca/FQDN.crt 

Intermediate Certificates
-----------------------------------------------------
For use with 3rd party certificate providers, for example, Verisign.

To use an intermediate certificate, append both the server and intermediate certificates into a single ``.crt`` file. For example:

.. code-block:: bash

   $ cat server.crt intermediate.crt >> /var/opt/opscode/nginx/ca/FQDN.crt

Verify Certificate Was Signed by Proper Key
-----------------------------------------------------
It's possible that a certificate/key mismatch can occur during the CertificateSigningRequest (CSR) process. During a CSR, the original key for the server in question should always be used. If the output of the following commands don't match, then it's possible the CSR for a new key for this host was generated using a random key or a newly generated key. The symptoms of this issue will look like the following in the nginx log files

.. code-block:: bash

   nginx: [emerg] SSL_CTX_use_PrivateKey_file("/var/opt/opscode/nginx/ca/YOUR_HOSTNAME.key") failed (SSL: error:0B080074:x509    certificate routines:X509_check_private_key:key values mismatch)

Here's how to tell for sure when the configured certificate doesn't match the key

.. code-block:: bash

   # openssl x509 -in /var/opt/opscode/nginx/ca/chef-432.lxc.crt -noout -modulus | openssl sha1
   (stdin)= 05b4f62e52fe7ce2351ff81d3e1060c0cdf1fa24

   # openssl rsa -in /var/opt/opscode/nginx/ca/chef-432.lxc.key -noout -modulus | openssl sha1
   (stdin)= 05b4f62e52fe7ce2351ff81d3e1060c0cdf1fa24

To fix this, you will need to generate a new CSR using the original key for the server, the same key that was used to produce the CSR for the previous certificates. Install that new certificates along with the original key and the mismatch error should go away.

Regenerate Certificates
-----------------------------------------------------
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

Chef Server Credentials Management
=====================================================
**New in Chef server 12.14:** Chef server limits where it writes service passwords and keys to disk. In the default configuration, credentials are only written to files in ``/etc/opscode``.

By default, Chef server still writes service credentials to multiple locations inside ``/etc/opscode``.  This is designed to maintain compatibility with add-ons. Chef server 12.14 introduces the ``insecure_addon_compat`` configuration option in ``/etc/opscode/chef-server.rb``, which allows you to further restrict where credentials are written.  ``insecure_addon_compat`` can be used if you are not using add-ons, or if you are using the latest add-on versions. However, ``insecure_addon_compat`` **cannot** be used with Analytics. Setting ``insecure_addon_compat`` to ``false`` writes credentials to only one location: ``/etc/opscode/private-chef-secrets.json``.

User-provided secrets (such as the password for an external PostgreSQL instance) can still be set in ``/etc/opscode/chef-server.rb`` or via the `Secrets Management </ctl_chef_server.html#ctl-chef-server-secrets-management>`__ commands.  These commands allow you to provide external passwords without including them in your configuration file.

Add-on Compatibility
-----------------------------------------------------

The following table lists which add-on versions support the more restrictive ``insecure_addon_compat false`` setting. These version also now **require** Chef server 12.14.0 or greater:

.. list-table::
   :widths: 1 1
   :header-rows: 1

   * - Add-on Name
     - Minimum Version
   * - Chef Backend
     - *all*
   * - Chef Manage
     - 2.5.0
   * - Push Jobs Server
     - 2.2.0
   * - Reporting
     - 1.7.0
   * - Analytics
     - *none*

These newer add-ons will also write all of their secrets to ``/etc/opscode/private-chef-secrets.json``. Older versions of the add-ons will still write their configuration to locations in ``/etc`` and ``/var/opt``.

/etc/opscode/private-chef-secrets.json
-----------------------------------------------------

``/etc/opscode/private-chef-secrets.json``'s default permissions allow only the root user to read or write the file. This file contains all of the secrets for access to the Chef server's underlying data stores and thus access to it should be restricted to trusted users.

While the file does not contain passwords in plaintext, it is not safe to share with untrusted users. The format of the secrets file allows Chef server deployments to conform to regulations that forbid the appearance of sensitive data in plain text in configuration files; however, it does not make the file meaningfully more secure.

DRBD and Keepalived
-----------------------------------------------------

In the DRBD-based HA configuration, Chef server will render passwords for keepalived and DRBD to configuration files in ``/var/opt/opscode``.

Key Rotation
=====================================================
See the `chef-server-ctl key rotation commands </ctl_chef_server.html#key-rotation>`__ for more information about user key management.
