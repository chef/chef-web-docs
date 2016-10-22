.. THIS PAGE IS IDENTICAL TO docs.chef.io/config_rb_delivery.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/delivery/ PATH.

.. THIS PAGE IS IDENTICAL TO docs.chef.io/config_rb_delivery_optional_settings.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /delivery/ PATH.

=====================================================
delivery.rb Settings
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

The ``delivery.rb`` file contains all of the non-default configuration settings used by the Chef Automate. (The default settings are built-in to the Chef Automate configuration and should only be added to the ``delivery.rb`` file to apply non-default values.) These configuration settings are processed when the ``delivery-server-ctl reconfigure`` command is run, such as immediately after setting up Chef Automate or after making a change to the underlying configuration settings after the server has been deployed. The ``delivery.rb`` file is a Ruby file, which means that conditional statements can be used in the configuration file.

Recommended Settings
=====================================================
.. include:: ../../includes_delivery_server/includes_delivery_server_tuning_general.rst

SSL Protocols
-----------------------------------------------------
The following settings are often modified from the default as part of the tuning effort for the **nginx** service and to configure the Chef Automate server to use SSL certificates:

``delivery['ssl_certificates']``
   A hash of SSL certificate files to use for FQDNs. Will use ``remote_file`` to download the key and crt specified. If you wanted to use a pre-generated SSL certificate for the main fqdn (``delivery_fqdn``) you could specify that here. For example:

   .. code-block:: ruby

      delivery['ssl_certificates'] = {
        'delivery.example.com' => {
          'key' => 'file:///etc/ssl_certificates/delivery.example.com.key',
          'crt' => 'file:///etc/ssl_certificates/delivery.example.com.crt'
        }
      }

``nginx['ssl_ciphers']``
   The list of supported cipher suites that are used to establish a secure connection. To favor AES256 with ECDHE forward security, drop the ``RC4-SHA:RC4-MD5:RC4:RSA`` prefix. See `this link <https://wiki.mozilla.org/Security/Server_Side_TLS>`__ for more information. Default value:

   .. code-block:: ruby

      "RC4-SHA:RC4-MD5:RC4:RSA:HIGH:MEDIUM:!LOW:!kEDH:!aNULL:!ADH:!eNULL:!EXP:!SSLv2:!SEED:!CAMELLIA:!PSK"

``nginx['ssl_protocols']``
   The SSL protocol versions that are enabled. For the highest possible security, disable SSL 3.0 and allow only TLS:

   .. code-block:: ruby

      nginx['ssl_protocols'] = 'TLSv1 TLSv1.1 TLSv1.2'

   Default value: Default value: ``"SSLv3 TLSv1"``.

.. note:: See https://wiki.mozilla.org/Security/Server_Side_TLS for more information about the values used with the ``nginx['ssl_ciphers']`` and ``nginx['ssl_protocols']`` settings.

For example, after copying the SSL certificate files to the Chef Automate server, update the ``delivery['ssl_certificates']`` hash settings to specify the paths to those files, and then (optionally) update the ``nginx['ssl_ciphers']`` and ``nginx['ssl_protocols']`` settings to reflect the desired level of hardness for the Chef Automate server:

.. code-block:: ruby

   delivery['ssl_certificates'] = {
      'delivery.example.com' => {
         'key' => 'file:///etc/ssl_certificates/delivery.example.com.key',
         'crt' => 'file:///etc/ssl_certificates/delivery.example.com.crt'
      }
   }
   nginx['ssl_ciphers'] = "HIGH:MEDIUM:!LOW:!kEDH:!aNULL:!ADH:!eNULL:!EXP:!SSLv2:!SEED:!CAMELLIA:!PSK"
   nginx['ssl_protocols'] = "TLSv1 TLSv1.1 TLSv1.2"


Optional Settings
=====================================================
Additional settings are available for performance tuning of the Chef Automate server.

.. note:: When changes are made to the ``delivery.rb`` file the Chef Automate server must be reconfigured by running the following command:
          
          .. code-block:: bash
          
             $ delivery-server-ctl reconfigure

.. note:: Review the full list of :doc:`optional settings </config_rb_delivery_optional_settings>` that can be added to the ``delivery.rb`` file. Many of these optional settings should not be added without first consulting with Chef support.
