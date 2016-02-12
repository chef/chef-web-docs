.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following settings are often modified from the default as part of the tuning effort for the |service nginx| service and to configure the |chef server| to use |ssl| certificates:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``nginx['ssl_certificate']``
     - |ssl_certificate| Default value: ``nil``.
   * - ``nginx['ssl_certificate_key']``
     - |ssl_certificate key| Default value: ``nil``.
   * - ``nginx['ssl_ciphers']``
     - |ssl_ciphers| To favor AES256 with ECDHE forward security, drop the ``RC4-SHA:RC4-MD5:RC4:RSA`` prefix. For example:

       .. code-block:: ruby

          nginx['ssl_ciphers'] =  "HIGH:MEDIUM:!LOW:!kEDH: \
                                   !aNULL:!ADH:!eNULL:!EXP: \
                                   !SSLv2:!SEED:!CAMELLIA: \
                                   !PSK"

   * - ``nginx['ssl_protocols']``
     - |version protocols_ssl| |ssl| 3.0 is supported by the |chef server|; however, |ssl| 3.0 is an obsolete and insecure protocol. Transport Layer Security (TLS)---TLS 1.0, TLS 1.1, and TLS 1.2---has effectively replaced |ssl| 3.0, which provides for authenticated version negotiation between the |chef client| and |chef server|, which ensures the latest version of the TLS protocol is used. For the highest possible security, it is recommended to disable |ssl| 3.0 and allow all versions of the TLS protocol.  For example:

       .. code-block:: ruby

          nginx['ssl_protocols'] = "TLSv1 TLSv1.1 TLSv1.2"

.. note:: See https://wiki.mozilla.org/Security/Server_Side_TLS#Recommended_Ciphersuite for more information about the values used with the ``nginx['ssl_ciphers']`` and ``nginx['ssl_protocols']`` settings.

For example, after copying the |ssl| certificate files to the |chef server|, update the ``nginx['ssl_certificate']`` and ``nginx['ssl_certificate_key']`` settings to specify the paths to those files, and then (optionally) update the ``nginx['ssl_ciphers']`` and ``nginx['ssl_protocols']`` settings to reflect the desired level of hardness for the |chef server|:

.. code-block:: ruby

   nginx['ssl_certificate'] = "/etc/pki/tls/private/name.of.pem"
   nginx['ssl_certificate_key'] = "/etc/pki/tls/private/name.of.key"
   nginx['ssl_ciphers'] = "HIGH:MEDIUM:!LOW:!kEDH:!aNULL:!ADH:!eNULL:!EXP:!SSLv2:!SEED:!CAMELLIA:!PSK"
   nginx['ssl_protocols'] = "TLSv1 TLSv1.1 TLSv1.2"

