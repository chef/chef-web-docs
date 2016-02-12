.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for |ssl|:

``supermarket['ssl']['certificate']``
   |ssl_certificate|

``supermarket['ssl']['certificate_key']``
   |ssl_certificate key|

``supermarket['ssl']['company_name']``
   |nginx ssl_company_name| Default value: ``'My Supermarket'``.

``supermarket['ssl']['country_name']``
   |nginx ssl_country_name| Default value: ``'US'``.

``supermarket['ssl']['directory']``
   |directory generic| Default value: ``'/var/opt/supermarket/ssl'``.

``supermarket['ssl']['email_address']``
   |nginx ssl_email_address| Default value: ``'you@example.com'``.

``supermarket['ssl']['locality_name']``
   |nginx ssl_locality_name| Default value: ``'Seattle'``.

``supermarket['ssl']['openssl_bin']``
   Default value: ``"#{node['supermarket']['install_directory']}/embedded/bin/openssl"``.

``supermarket['ssl']['organizational_unit_name']``
   |nginx ssl_organizational_unit_name| Default value: ``'Operations'``.

``supermarket['ssl']['session_cache']``
   Default value: ``'shared:SSL:4m'``.

``supermarket['ssl']['session_timeout']``
   Default value: ``'5m'``.

``supermarket['ssl']['ciphers']``
   |ssl_ciphers| To favor AES256 with ECDHE forward security, drop the ``RC4-SHA:RC4-MD5:RC4:RSA`` prefix. See https://wiki.mozilla.org/Security/Server_Side_TLS#Recommended_Ciphersuite for more information. For example:

   .. code-block:: ruby

      nginx['ssl_ciphers'] = HIGH:MEDIUM:!LOW:!kEDH:!aNULL:!ADH:!eNULL:!EXP:!SSLv2:!SEED:!CAMELLIA:!PSK

``supermarket['ssl']['protocols']``
   |version protocols_ssl| Default value: ``'TLSv1 TLSv1.1 TLSv1.2'``.

``supermarket['ssl']['state_name']``
   |nginx ssl_state_name| Default value: ``'WA'``.
