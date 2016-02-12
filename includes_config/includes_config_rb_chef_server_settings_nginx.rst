.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``nginx['cache_max_size']``
   Default value: ``5000m``.

``nginx['client_max_body_size']``
   Default value: ``250m``.

``nginx['dir']``
   |directory generic| |default_value_recommended| Default value: ``/var/opt/chef-server/nginx``.

``nginx['enable']``
   |enable service| Default value: ``true``.

``nginx['enable_ipv6']``
   |enable ipv6| Default value: ``false``. This setting is automatically set to true when ``ip_version`` is set to ``ipv6``.

``nginx['enable_non_ssl']``
   |port enable_non_ssl_nginx| Default value: ``false``.

``nginx['gzip']``
   Indicates that |gzip| compression is enabled. Default value: ``on``.

``nginx['gzip_comp_level']``
   The compression level used with |gzip|, from least amount of compression (``1``, fastest) to the most (``2``, slowest). Default value: ``2``.

``nginx['gzip_http_version']``
   Enables |gzip| depending on the version of the HTTP request. Default value: ``1.0``.

``nginx['gzip_proxied']``
   The type of compression used based on the request and response. Default value: ``any``.

``nginx['gzip_types']``
   Enables compression for the specified MIME-types. Default value: ``[ 'text/plain', 'text/css', 'application/x-javascript', 'text/xml', 'application/xml', 'application/xml+rss', 'text/javascript', 'application/json' ]``.

``nginx['ha']``
   |use ha| Default value: ``false``.

``nginx['keepalive_timeout']``
   The amount of time (in seconds) that a connection will be allowed to stay open. Default value: ``65``.

``nginx['log_directory']``
   The directory in which log files are located. Default value: ``/var/log/chef-server/nginx``.

``nginx['non_ssl_port']``
   |port non_ssl_nginx| Default value: ``80``. Use ``nginx['enable_non_ssl']`` to enable or disable |ssl| redirects on this port number. Set to ``false`` to disable non-SSL connections.

``nginx['sendfile']``
   Indicates whether ``sendfile()`` is used to copy data between file descriptors. Default value: ``on``.

``nginx['server_name']``
   The |fqdn| of the server. Default value: ``node['fqdn']``.

``nginx['ssl_certificate']``
   |ssl_certificate| Default value: ``nil``.

``nginx['ssl_certificate_key']``
   |ssl_certificate key| Default value: ``nil``.

``nginx['ssl_ciphers']``
   |ssl_ciphers| To favor AES256 with ECDHE forward security, use the following:

   .. code-block:: ruby

      nginx['ssl_ciphers'] =  'HIGH:MEDIUM:!LOW:!kEDH: \
                              !aNULL:!ADH:!eNULL:!EXP: \
                              !SSLv2:!SEED:!CAMELLIA: \
                              !PSK'

   See https://wiki.mozilla.org/Security/Server_Side_TLS#Recommended_Ciphersuite for more information. Default value: varies.

``nginx['ssl_company_name']``
   Default value: ``YouCorp``.

``nginx['ssl_country_name']``
   Default value: ``US``.

``nginx['ssl_email_address']``
   Default value: ``you@example.com``.

``nginx['ssl_locality_name']``
   Default value: ``Seattle``.

``nginx['ssl_organizational_unit_name']``
   Default value: ``Operations``.

``nginx['ssl_port']``
   Default value: ``443``.

``nginx['ssl_protocols']``
   |version protocols_ssl| For the highest possible security, disable |ssl| 3.0 and allow only TLS: ``nginx['ssl_protocols'] 'TLSv1 TLSv1.1 TLSv1.2'``. Default value: varies, depending on the configuration of the |chef server| topology.

``nginx['ssl_state_name']``
   Default value: ``WA``.

``nginx['tcp_nodelay']``
   |use nagle| Default value: ``on``.

``nginx['tcp_nopush']``
   |use tcpip| Default value: ``on``.

``nginx['url']``
   Default value: ``https://#{node['fqdn']}``.

``nginx['worker_connections']``
   |worker_connections| Use with ``nginx['worker_processes']`` to determine the maximum number of allowed clients. Default value: ``10240``.

``nginx['worker_processes']``
   |worker_processes| Use with ``nginx['worker_connections']`` to determine the maximum number of allowed clients. Default value: ``node['cpu']['total'].to_i``.
