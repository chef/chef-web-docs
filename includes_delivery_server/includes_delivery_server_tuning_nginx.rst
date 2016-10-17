.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following settings are often modified from the default as part of the tuning effort for the |service nginx| service and to configure the |delivery| server to use |ssl| certificates:

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
   |ssl_ciphers| To favor AES256 with ECDHE forward security, drop the ``RC4-SHA:RC4-MD5:RC4:RSA`` prefix. See `this link <https://wiki.mozilla.org/Security/Server_Side_TLS>`__ for more information. Default value:

   .. code-block:: ruby

      "RC4-SHA:RC4-MD5:RC4:RSA:HIGH:MEDIUM:!LOW:!kEDH:!aNULL:!ADH:!eNULL:!EXP:!SSLv2:!SEED:!CAMELLIA:!PSK"

``nginx['ssl_protocols']``
   |version protocols_ssl| For the highest possible security, disable |ssl| 3.0 and allow only TLS:

   .. code-block:: ruby

      nginx['ssl_protocols'] = 'TLSv1 TLSv1.1 TLSv1.2'

   Default value: Default value: ``"SSLv3 TLSv1"``.

.. note:: See https://wiki.mozilla.org/Security/Server_Side_TLS for more information about the values used with the ``nginx['ssl_ciphers']`` and ``nginx['ssl_protocols']`` settings.

For example, after copying the |ssl| certificate files to the |delivery| server, update the ``delivery['ssl_certificates']`` hash settings to specify the paths to those files, and then (optionally) update the ``nginx['ssl_ciphers']`` and ``nginx['ssl_protocols']`` settings to reflect the desired level of hardness for the |delivery| server:

.. code-block:: ruby

   delivery['ssl_certificates'] = {
      'delivery.example.com' => {
         'key' => 'file:///etc/ssl_certificates/delivery.example.com.key',
         'crt' => 'file:///etc/ssl_certificates/delivery.example.com.crt'
      }
   }
   nginx['ssl_ciphers'] = "HIGH:MEDIUM:!LOW:!kEDH:!aNULL:!ADH:!eNULL:!EXP:!SSLv2:!SEED:!CAMELLIA:!PSK"
   nginx['ssl_protocols'] = "TLSv1 TLSv1.1 TLSv1.2"

