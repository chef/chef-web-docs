.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

 
This configuration file has the following settings for ``nginx``:

``nginx['cache_max_size']``
   The ``max_size`` parameter used by the Nginx cache manager, which is part of the ``proxy_cache_path`` directive. When the size of file storage exceeds this value, the Nginx cache manager removes the least recently used data. Default value: ``5000m``.

``nginx['client_max_body_size']``
   The maximum accepted body size for a client request, as indicated by the ``Content-Length`` request header. When the maximum accepted body size is greater than this value, a ``413 Request Entity Too Large`` error is returned. Default value: ``250m``.

``nginx['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/opscode/nginx``.

``nginx['enable']``
   Enable a service. Default value: ``true``.

``nginx['enable_ipv6']``
   Enable Internet Protocol version 6 (IPv6) addresses. Default value: ``false``.

``nginx['enable_non_ssl']``
   Allow port 80 redirects to port 443. When this value is set to ``true``, load balancers on the front-end hardware are allowed to do SSL termination of the WebUI and API. Default value: ``false``.

``nginx['gzip']``
   Enable  gzip compression. Default value: ``on``.

``nginx['gzip_comp_level']``
   The compression level used with gzip, from least amount of compression (``1``, fastest) to the most (``2``, slowest). Default value: ``2``.

``nginx['gzip_http_version']``
   Enable gzip depending on the version of the HTTP request. Default value: ``1.0``.

``nginx['gzip_proxied']``
   The type of compression used based on the request and response. Default value: ``any``.

``nginx['gzip_types']``
   Enable compression for the specified MIME-types. Default value:

   .. code-block:: ruby

      [ 'text/plain',
        'text/css',
        'application/x-javascript',
        'text/xml', 'application/xml',
        'application/xml+rss',
        'text/javascript',
        'application/json'
        ]

``nginx['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``nginx['keepalive_timeout']``
   The amount of time (in seconds) to wait for requests on a Keepalived connection. Default value: ``65``.

``nginx['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``/var/log/opscode/nginx``.

``nginx['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``nginx['non_ssl_port']``
   The port on which the WebUI and API are bound for non-SSL connections. Default value: ``80``. Use ``nginx['enable_non_ssl']`` to enable or disable SSL redirects on this port number. Set to ``false`` to disable non-SSL connections.

``nginx['sendfile']``
   Copy data between file descriptors when ``sendfile()`` is used. Default value: ``on``.

``nginx['server_name']``
   The FQDN for the server. Default value: ``node['fqdn']``.

``nginx['ssl_certificate']``
   The SSL certificate used to verify communication over HTTPS. Default value: ``nil``.

``nginx['ssl_certificate_key']``
   The certificate key used for SSL communication. Default value: ``nil``.

``nginx['ssl_ciphers']``
   The list of supported cipher suites that are used to establish a secure connection. To favor AES256 with ECDHE forward security, drop the ``RC4-SHA:RC4-MD5:RC4:RSA`` prefix. See `this link <https://wiki.mozilla.org/Security/Server_Side_TLS>`__ for more information. For example:

   .. code-block:: ruby

      nginx['ssl_ciphers'] = HIGH: ... :!PSK

``nginx['ssl_company_name']``
   The name of your company. Default value: ``YouCorp``.

``nginx['ssl_country_name']``
   The country in which your company is located. Default value: ``US``.

``nginx['ssl_email_address']``
   The default email address for your company. Default value: ``you@example.com``.

``nginx['ssl_locality_name']``
   The city in which your company is located. Default value: ``Seattle``.

``nginx['ssl_organizational_unit_name']``
   The organization or group within your company that is running the Chef server. Default value: ``Operations``.

``nginx['ssl_port']``
   Default value: ``443``.

``nginx['ssl_protocols']``
   The SSL protocol versions that are enabled. For the highest possible security, disable SSL 3.0 and allow only TLS:

   .. code-block:: ruby

      nginx['ssl_protocols'] = 'TLSv1 TLSv1.1 TLSv1.2'

   Default value: ``TLSv1 TLSv1.1 TLSv1.2``.

``nginx['ssl_state_name']``
   The state, province, or region in which your company is located. Default value: ``WA``.

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

``nginx['x_forwarded_proto']``
   The protocol used to connect to the server. Possible values: ``http`` and ``https``. This is the protocol used to connect to the Chef server by a chef-client or a workstation. Default value: ``'https'``.
