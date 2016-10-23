.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``nginx['cache_max_size']``
   Default value: ``5000m``.

``nginx['client_max_body_size']``
   Default value: ``250m``.

``nginx['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/chef-server/nginx``.

``nginx['enable']``
   Enable a service. Default value: ``true``.

``nginx['enable_ipv6']``
   Enable Internet Protocol version 6 (IPv6) addresses. Default value: ``false``. This setting is automatically set to true when ``ip_version`` is set to ``ipv6``.

``nginx['enable_non_ssl']``
   Allow port 80 redirects to port 443. When this value is set to ``false``, load balancers on the front-end hardware are allowed to do SSL termination of the WebUI and API. Default value: ``false``.

``nginx['gzip']``
   Indicates that gzip compression is enabled. Default value: ``on``.

``nginx['gzip_comp_level']``
   The compression level used with gzip, from least amount of compression (``1``, fastest) to the most (``2``, slowest). Default value: ``2``.

``nginx['gzip_http_version']``
   Enables gzip depending on the version of the HTTP request. Default value: ``1.0``.

``nginx['gzip_proxied']``
   The type of compression used based on the request and response. Default value: ``any``.

``nginx['gzip_types']``
   Enables compression for the specified MIME-types. Default value: ``[ 'text/plain', 'text/css', 'application/x-javascript', 'text/xml', 'application/xml', 'application/xml+rss', 'text/javascript', 'application/json' ]``.

``nginx['ha']``
   Run the Chef server in a high availability topology. Default value: ``false``.

``nginx['keepalive_timeout']``
   The amount of time (in seconds) that a connection will be allowed to stay open. Default value: ``65``.

``nginx['log_directory']``
   The directory in which log files are located. Default value: ``/var/log/chef-server/nginx``.

``nginx['non_ssl_port']``
   The port on which the WebUI and API are bound for non-SSL connections. Default value: ``80``. Use ``nginx['enable_non_ssl']`` to enable or disable SSL redirects on this port number. Set to ``false`` to disable non-SSL connections.

``nginx['sendfile']``
   Indicates whether ``sendfile()`` is used to copy data between file descriptors. Default value: ``on``.

``nginx['server_name']``
   The FQDN of the server. Default value: ``node['fqdn']``.

``nginx['ssl_certificate']``
   The SSL certificate used to verify communication over HTTPS. Default value: ``nil``.

``nginx['ssl_certificate_key']``
   The certificate key used for SSL communication. Default value: ``nil``.

``nginx['ssl_ciphers']``
   The list of supported cipher suites that are used to establish a secure connection. To favor AES256 with ECDHE forward security, use the following:

   .. code-block:: ruby

      nginx['ssl_ciphers'] =  'HIGH:MEDIUM:!LOW:!kEDH: \
                              !aNULL:!ADH:!eNULL:!EXP: \
                              !SSLv2:!SEED:!CAMELLIA: \
                              !PSK'

   See https://wiki.mozilla.org/Security/Server_Side_TLS for more information. Default value: varies.

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
   The SSL protocol versions that are enabled. For the highest possible security, disable SSL 3.0 and allow only TLS: ``nginx['ssl_protocols'] 'TLSv1 TLSv1.1 TLSv1.2'``. Default value: varies, depending on the configuration of the Chef server topology.

``nginx['ssl_state_name']``
   Default value: ``WA``.

``nginx['tcp_nodelay']``
   Enable the Nagle buffering algorithm. Default value: ``on``.

``nginx['tcp_nopush']``
   Enable TCP/IP transactions. Default value: ``on``.

``nginx['url']``
   Default value: ``https://#{node['fqdn']}``.

``nginx['worker_connections']``
   The maximum number of simultaneous clients. Use with ``nginx['worker_processes']`` to determine the maximum number of allowed clients. Default value: ``10240``.

``nginx['worker_processes']``
   The number of allowed worker processes. Use with ``nginx['worker_connections']`` to determine the maximum number of allowed clients. Default value: ``node['cpu']['total'].to_i``.
