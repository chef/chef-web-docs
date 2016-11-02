

=====================================================
chef-server.rb Optional Settings
=====================================================

.. tag config_rb_chef_server_2

The chef-server.rb file contains all of the non-default configuration settings used by the Open Source Chef server. (The default settings are built-in to the Chef server configuration and should only be added to the chef-server.rb file to apply non-default values.) These configuration settings are processed when the ``chef-server-ctl reconfigure`` command is run, such as immediately after setting up the Open Source Chef server or after making a change to the underlying configuration settings after the server has been deployed.

.. end_tag

Settings
=====================================================
The following sections describe the various settings that are available in the chef-server.rb file.

General
-----------------------------------------------------
.. tag config_rb_chef_server_settings_general

This configuration file has the following settings:

``api_fqdn``
   The FQDN for the Chef server. This setting is not in the private-chef.rb file by default. When added, its value should be equal to the FQDN for the service URI used by the Chef server. Then configure the same value for the ``bookshelf['vip']`` setting prior to installing the Chef server. For example: ``api_fqdn 'chef.example.com'``.

``bootstrap``
   Default value: ``true``.

``ip_version``
   Use to enable IPv6 and run Open Source Chef in "dual IPv4/IPv6 mode". When this setting is ``ipv6``, the Open Source Chef server will use IPv6 for all internal comunication and will be able to accept external communications that are using IPv6 (via the Nginx load balancer). Default value: ``ipv4``.

   .. note:: Setting ``ip_version`` to true will also set ``nginx['enable_ipv6']`` to ``true``.

``notification_email``
   Default value: ``info@example.com``.

``topology``
   Default value: ``standalone``.

.. end_tag

Bookshelf
-----------------------------------------------------
.. tag config_rb_chef_server_settings_bookshelf

This configuration file has the following settings:

``bookshelf['access_key_id']``
   Default value: ``generated-by-default``.

``bookshelf['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value: ``/var/opt/chef-server/bookshelf/data``.

``bookshelf['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/chef-server/bookshelf``.

``bookshelf['enable']``
   Default value: ``true``.

``bookshelf['external_url']``
   The base URL to which the service will return links to API resources. Use ``:host_header`` to ensure the URL is derived from the host header of the incoming HTTP request. Default value: ``:host_header``.

``bookshelf['ha']``
   Run the Chef server in a high availability topology. Default value: ``false``.

``bookshelf['listen']``
   Default value: ``0.0.0.0``.

``bookshelf['log_directory']``
   The directory in which log files are located. Default value: ``/var/log/chef-server/bookshelf``.

``bookshelf['port']``
   The port on which the service is to listen. Default value: ``4321``.

``bookshelf['secret_access_key']``
   Default value: ``generated-by-default``.

``bookshelf['stream_download']``
   Default value: ``true``.

``bookshelf['svlogd_num']``
   The number of svlogd log files to retain. Default value: ``10``.

``bookshelf['svlogd_size']``
   The size (in bytes) of the svlogd log file. Default value: ``1000000``.

``bookshelf['url']``
   This value will default to the value of the URL for Nginx, which is built from the configured ``api_fqdn`` and the SSL port for Nginx.

.. end_tag

Chef Expander
-----------------------------------------------------
.. tag config_rb_chef_server_settings_chef_expander

This configuration file has the following settings:

``chef_expander['consumer_id']``
   Default value: ``default``.

``chef_expander['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/chef-server/chef-expander``.

``chef_expander['enable']``
   Default value: ``true``.

``chef_expander['ha']``
   Run the Chef server in a high availability topology. Default value: ``false``.

``chef_expander['log_directory']``
   The directory in which log files are located. Default value: ``/var/log/chef-server/chef-expander``.

``chef_expander['nodes']``
   Default value: ``2``.

``chef_expander['reindexer_log_directory']``
   Default value: ``/var/log/chef-server/chef-expander-reindexer``.

.. end_tag

Chef Pedant
-----------------------------------------------------
.. tag config_rb_chef_server_settings_pedant

This configuration file has the following settings:

``chef_pedant['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/chef-server/chef-pedant``.

``chef_pedant['log_directory']``
   The directory in which log files are located. Default value: ``/var/log/chef-server/chef-pedant``.

``chef_pedant['log_http_requests']``
   Default value: ``true``.

.. end_tag

Chef Solr
-----------------------------------------------------
.. tag config_rb_chef_server_settings_chef_solr

This configuration file has the following settings:

``chef_solr['commit_interval']``
   The frequency (in seconds) at which node objects are added to the Apache Solr search index. When data is committed to the Apache Solr index, all incoming updates are blocked. If the duration between updates is too short, it is possible for the rate at which updates are asked to occur to be faster than the rate at which objects can be actually committed. Default value: ``60000`` (every 60 seconds).

``chef_solr['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value: ``/var/opt/chef-server/chef-solr/data``.

``chef_solr['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/chef-server/chef-solr``.

``chef_solr['enable']``
   Default value: ``true``.

``chef_solr['ha']``
   Run the Chef server in a high availability topology. Default value: ``false``.

``chef_solr['heap_size']``
   Default value: ``nil``.

``chef_solr['ip_address']``
   Default value: ``0.0.0.0``.

``chef_solr['java_opts']``
   Default value: ``(empty)``.

``chef_solr['log_directory']``
   The directory in which log files are located. Default value: ``/var/log/chef-server/chef-solr``.

``chef_solr['max_commit_docs']``
   The frequency (in documents) at which node objects are added to the Apache Solr search index. When data is committed to the Apache Solr index, all incoming updates are blocked. If the duration between updates is too short, it is possible for the rate at which updates are asked to occur to be faster than the rate at which objects can be actually committed. Default value: ``1000`` (every 1000 documents).

``chef_solr['max_field_length']``
   The maximum field length (in number of tokens/terms). If a field length exceeds this value, Apache Solr may not be able to complete building the index. Default value: ``100000`` (increased from the Apache Solr default value of ``10000``).

``chef_solr['max_merge_docs']``
   The maximum number of index segments allowed before they are merged into a single index. Default value: ``2147483647``.

``chef_solr['merge_factor']``
   The maximum number of document updates that can be stored in memory before being flushed and added to the current index segment. Default value: ``100``.

``chef_solr['new_size']``
   Default value: ``nil``.

``chef_solr['poll_seconds']``
   Default value: ``20``.

``chef_solr['port']``
   The port on which the service is to listen. Default value: ``8983``.

``chef_solr['ram_buffer_size']``
   Default value: ``200``.

``chef_solr['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.

.. end_tag

Erchef
-----------------------------------------------------
.. tag config_rb_chef_server_settings_erchef

This configuration file has the following settings:

``erchef['auth_skew']``
   Default value: ``900``.

``erchef['base_resource_url']``
   The base URL to which the service will return links to API resources. Use ``:host_header`` to ensure the URL is derived from the host header of the incoming HTTP request. Default value: ``:host_header``.

``erchef['bulk_fetch_batch_size']``
   Default value: ``5``.

``erchef['cache_ttl']``
   Default value: ``3600``.

``erchef['depsolver_timeout']``
   The amount of time (in milliseconds) to wait for cookbook dependency problems to be solved. Default value: ``'5000'``.

``erchef['depsolver_worker_count']``
   The number of Ruby processes for which cookbook dependency problems are unsolved. Use the ``pgrep -fl depselector`` command to verify the number of depsolver workers that are running. Default value: ``'5'``.

``erchef['db_pool_size']``
   Default value: ``20``.

``erchef['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/chef-server/erchef``.

``erchef['enable']``
   Default value: ``true``.

``erchef['ha']``
   Run the Chef server in a high availability topology. Default value: ``false``.

``erchef['ibrowse_max_pipeline_size']``
   Default value: ``1``.

``erchef['ibrowse_max_sessions']``
   Default value: ``256``.

``erchef['listen']``
   Default value: ``127.0.0.1``.

``erchef['log_directory']``
   The directory in which log files are located. Default value: ``/var/log/chef-server/erchef``.

``erchef['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``erchef['max_cache_size']``
   Default value: ``10000``.

``opscode_erchef['max_request_size']``
   Default value: ``2500000``.

``erchef['port']``
   The port on which the service is to listen. Default value: ``8000``.

``erchef['proxy_user']``
   Default value: ``pivotal``.

``erchef['root_metric_key']``
   Default value: ``chefAPI``.

``erchef['s3_bucket']``
   Default value: ``bookshelf``.

``erchef['s3_parallel_ops_fanout']``
   Default value: ``20``.

``erchef['s3_parallel_ops_timeout']``
   Default value: ``5000``.

``erchef['s3_url_ttl']``
   Default value: ``900``.

``erchef['svlogd_size']``
   The size (in bytes) of the svlogd log file. Default value: ``1000000``.

``erchef['svlogd_num']``
   The number of svlogd log files to retain. Default value: ``10``.

``erchef['umask']``
   Default value: ``0022``.

``erchef['validation_client_name']``
   Default value: ``chef-validator``.

``erchef['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.

``erchef['web_ui_client_name']``
   Default value: ``chef-webui``.

.. end_tag

Load Balancer
-----------------------------------------------------
.. tag config_rb_chef_server_settings_load_balancer

This configuration file has the following settings:

``lb['api_fqdn']``
   Default value: ``node['fqdn']``.

``lb['cache_cookbook_files']``
   Default value: ``false``.

``lb['debug']``
   Default value: ``false``.

``lb['enable']``
   Default value: ``true``.

``lb['web_ui_fqdn']``
   Default value: ``node['fqdn']``.

``lb['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.

``lb['upstream']['bookshelf']``
   Default value: ``127.0.0.1``.

``lb['upstream']['chef_server_webui']``
   Default value: ``127.0.0.1``.

``lb['upstream']['erchef']``
   Default value: ``127.0.0.1``.

.. end_tag

Nginx
-----------------------------------------------------
.. tag config_rb_chef_server_settings_nginx

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

.. end_tag

PostgreSQL
-----------------------------------------------------
.. tag config_rb_chef_server_settings_postgresql

This configuration file has the following settings:

``postgresql['checkpoint_completion_target']``
   A completion percentage that is used to determine how quickly a checkpoint should finish in relation to the completion status of the next checkpoint. For example, if the value is ``0.5``, then a checkpoint attempts to finish before 50% of the next checkpoint is done. Default value: ``0.9``.

``postgresql['checkpoint_segments']``
   The maximum amount (in megabytes) between checkpoints in log file segments. Default value: ``10``.

``postgresql['checkpoint_timeout']``
   The amount of time (in minutes) between checkpoints. Default value: ``5min``.

``postgresql['checkpoint_warning']``
   The frequency (in seconds) at which messages are sent to the server log files if checkpoint segments are being filled faster than their currently configured values. Default value: ``30s``.

``postgresql['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value: ``/var/opt/chef-server/postgresql/data``.

``postgresql['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/chef-server/postgresql``.

``postgresql['effective_cache_size']``
   The size of the disk cache that is used for data files. Default value: ``#{(node['memory']['total'].to_i / 2) / (1024)}MB``.

``postgresql['enable']``
   Enable a service. Default value: ``true``.

``postgresql['ha']``
   Run the Chef server in a high availability topology. Default value: ``false``.

``postgresql['home']``
   The home directory for PostgreSQL. Default value: ``/var/opt/chef-server/postgresql``.

``postgresql['listen_address']``
   The connection source to which PostgreSQL is to respond. Default value: ``0.0.0.0``.

``postgresql['log_directory']``
   The directory in which log data is stored. Default value: ``/var/log/chef-server/postgresql``.

``postgresql['max_connections']``
   The maximum number of allowed concurrent connections. Default value: ``200``.

``postgresql['md5_auth_cidr_addresses']``
   Default value: ``[ ]``.

``postgresql['port']``
   The port on which the service is to listen. Default value: ``5432``.

``postgresql['shared_buffers']``
   The amount of memory that is dedicated to PostgreSQL for data caching. Default value: ``#{(node['memory']['total'].to_i / 4) / (1024)}MB``.

``postgresql['shmall']``
   The total amount of available shared memory. Default value: ``kernel['machine'] =~ /x86_64/ ? 4194304 : 1048575``.

``postgresql['shmmax']``
   The maximum amount of shared memory. Default value: ``kernel['machine'] =~ /x86_64/ ? 17179869184 : 4294967295``.

``postgresql['shell']``
   Default value: ``/bin/sh``.

``postgresql['sql_password']``
   The password for the PostgreSQL user account. Default value: ``snakepliskin``.

``postgresql['sql_ro_password']``
   Default value: ``shmunzeltazzen``.

``postgresql['sql_ro_user']``
   Default value: ``opscode_chef_ro``.

``postgresql['sql_user']``
   Default value: ``opscode_chef``.

``postgresql['svlogd_num']``
   The number of svlogd log files to retain. Default value: ``10``.

``postgresql['svlogd_size']``
   The size (in bytes) of the svlogd log file. Default value: ``1000000``.

``postgresql['trust_auth_cidr_addresses']``
   Default value: ``'127.0.0.1/32', '::1/128'``.

``postgresql['user_path']``
   Default value: ``/opt/chef-server/embedded/bin:/opt/chef-server/bin:$PATH``.

``postgresql['username']``
   The PostgreSQL account user name. Default value: ``opscode-pgsql``.

``postgresql['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.

``postgresql['work_mem']``
   The size (in megabytes) of allowed in-memory sorting. Default value: ``8MB``.

.. end_tag

RabbitMQ
-----------------------------------------------------
.. tag config_rb_chef_server_settings_rabbitmq

This configuration file has the following settings:

``rabbitmq['consumer_id']``
   Default value: ``hotsauce``.

``rabbitmq['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value: ``/var/opt/chef-server/rabbitmq/db``.

``rabbitmq['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/chef-server/rabbitmq``.

``rabbitmq['enable']``
   Enable a service. Default value: ``true``.

``rabbitmq['ha']``
   Run the Chef server in a high availability topology. Default value: ``false``.

``rabbitmq['log_directory']``
   The directory in which log files are located. Default value: ``/var/log/chef-server/rabbitmq``.

``rabbitmq['node_ip_address']``
   The bind IP address for RabbitMQ. Default value: ``0.0.0.0``.

``rabbitmq['node_port']``
   The port on which the service is to listen. Default value: ``5672``.

``rabbitmq['nodename']``
   The name of the node.  Default value: ``rabbit@localhost``.

``rabbitmq['password']``
   The password for the RabbitMQ user. Default value: ``chefrocks``.

``rabbitmq['user']``
   The user. Default value: ``chef``.

``rabbitmq['vhost']``
   The virtual host. Default value: ``/chef``.

``rabbitmq['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.

.. end_tag

User
-----------------------------------------------------
.. tag config_rb_chef_server_settings_users

This configuration file has the following settings:

``user['home']``
   Default value: ``/opt/chef-server/embedded``.

``user['shell']``
   Default value: ``/bin/sh``.

``user['username']``
   Default value: ``chef_server``.

.. end_tag

WebUI
-----------------------------------------------------
.. tag config_rb_chef_server_settings_webui

This configuration file has the following settings:

``chef_server_webui['backlog']``
   Default value: ``1024``.

``chef_server_webui['cookie_domain']``
   Default value: ``all``.

``chef_server_webui['cookie_secret']``
   Default value: ``47b3b8d95dea455baf32155e95d1e64e``.

``chef_server_webui['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/chef-server/chef-server-webui``.

``chef_server_webui['enable']``
   Enable a service. Default value: ``true``.

``chef_server_webui['environment']``
   Default value: ``chefserver``.

``chef_server_webui['ha']``
   Run the Chef server in a high availability topology. Default value: ``false``.

``chef_server_webui['listen']``
   Default value: ``127.0.0.1:9462``.

``chef_server_webui['log_directory']``
   The directory in which log files are located. Default value: ``/var/log/chef-server/chef-server-webui``.

``chef_server_webui['port']``
   The port on which the service is to listen. Default value: ``9462``.

``chef_server_webui['session_key']``
   Default value: ``_sandbox_session``.

``chef_server_webui['tcp_nodelay']``
   Enable the Nagle buffering algorithm. Default value: ``true``.

``chef_server_webui['umask']``
   The file mode creation mask, or umask. Default value: ``0022``.

``chef_server_webui['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.

``chef_server_webui['web_ui_admin_default_password']``
   Default value: ``p@ssw0rd1``.

``chef_server_webui['web_ui_admin_user_name']``
   The name of the administrator for the web user interface. Default value: ``admin``.

``chef_server_webui['web_ui_client_name']``
   The name of the Chef server web user interface. Default value: ``chef-webui``.

``chef_server_webui['worker_processes']``
   The number of allowed worker processes. Default value: ``2``.

``chef_server_webui['worker_timeout']``
   The amount of time (in seconds) that a worker can be silent before it is killed and restarted. Default value: ``3600``.

.. end_tag

Example
==========================================================================
.. tag config_rb_chef_server_example

The following example shows how the settings look when added to the configuration file:

.. code-block:: ruby

   # Bookshelf settings

   bookshelf['access_key_id'] = generated-by-default
   bookshelf['data_dir'] = /var/opt/chef-server/bookshelf/data
   bookshelf['dir'] = /var/opt/chef-server/bookshelf
   bookshelf['enable'] = true
   bookshelf['ha'] = false
   bookshelf['listen'] = 0.0.0.0
   bookshelf['log_directory'] = /var/log/chef-server/bookshelf
   bookshelf['port'] = 4321
   bookshelf['secret_access_key'] = generated-by-default
   bookshelf['stream_download'] = true
   bookshelf['svlogd_num'] = 10
   bookshelf['svlogd_size'] = 1000000
   bookshelf['url'] = 
   bookshelf['vip'] = node['fqdn']

   # Expander settings

   chef_expander['consumer_id'] = default
   chef_expander['dir'] = /var/opt/chef-server/chef-expander
   chef_expander['enable'] = true
   chef_expander['ha'] = false
   chef_expander['log_directory'] = /var/log/chef-server/chef-expander
   chef_expander['nodes'] = 2
   chef_expander['reindexer_log_directory'] = /var/log/chef-server/chef-expander-reindexer

   # Solr settings

   chef_solr['commit_interval'] = 60000
   chef_solr['data_dir'] = /var/opt/chef-server/chef-solr/data
   chef_solr['dir'] = /var/opt/chef-server/chef-solr
   chef_solr['enable'] = true
   chef_solr['ha'] = false
   chef_solr['heap_size'] = nil
   chef_solr['ip_address'] = 0.0.0.0
   chef_solr['java_opts'] = (empty)
   chef_solr['log_directory'] = /var/log/chef-server/chef-solr
   chef_solr['max_commit_docs'] = 1000
   chef_solr['max_field_length'] = 100000
   chef_solr['max_merge_docs'] = 2147483647
   chef_solr['merge_factor'] = 100
   chef_solr['new_size'] = nil
   chef_solr['poll_seconds'] = 20
   chef_solr['port'] = 8983
   chef_solr['ram_buffer_size'] = 200
   chef_solr['vip'] = 127.0.0.1

   # Erchef settings

   erchef['auth_skew'] = 900
   erchef['bulk_fetch_batch_size'] = 5
   erchef['cache_ttl'] = 3600
   erchef['db_pool_size'] = 20
   erchef['dir'] = /var/opt/chef-server/erchef
   erchef['enable'] = true
   erchef['ha'] = false
   erchef['ibrowse_max_pipeline_size'] = 1
   erchef['ibrowse_max_sessions'] = 256
   erchef['listen'] = 127.0.0.1
   erchef['log_directory'] = /var/log/chef-server/erchef
   erchef['max_cache_size'] = 10000
   erchef['port'] = 8000
   erchef['proxy_user'] = pivotal
   erchef['root_metric_key'] = chefAPI
   erchef['s3_bucket'] = bookshelf
   erchef['s3_parallel_ops_fanout'] = 20
   erchef['s3_parallel_ops_timeout'] = 5000
   erchef['s3_url_ttl'] = 900
   erchef['svlogd_size'] = 1000000
   erchef['svlogd_num'] = 10
   erchef['umask'] = 0022
   erchef['validation_client_name'] = chef-validator
   erchef['vip'] = 127.0.0.1
   erchef['web_ui_client_name'] = chef-webui

   # General settings

   api_fqdn 'chef.example.com'
   bootstrap true
   ip_version ipv4
   notification_email info@example.com
   topology standalone

   # Load balancer settings

   lb['api_fqdn'] = node['fqdn']
   lb['bookshelf'] = 127.0.0.1
   lb['cache_cookbook_files'] = false
   lb['chef_server_webui'] = 127.0.0.1
   lb['debug'] = false
   lb['enable'] = true
   lb['erchef'] = 127.0.0.1
   lb['web_ui_fqdn'] = node['fqdn']
   lb['vip'] = 127.0.0.1

   # Nginx settings

   nginx['cache_max_size'] = 5000m
   nginx['client_max_body_size'] = 250m
   nginx['dir'] = /var/opt/chef-server/nginx
   nginx['enable'] = true
   nginx['enable_ipv6'] = false
   nginx['enable_non_ssl'] = false
   nginx['gzip'] = on
   nginx['gzip_comp_level'] = 2
   nginx['gzip_http_version'] = 1.0
   nginx['gzip_proxied'] = any
   nginx['gzip_types'] = [ 'text/plain', 'text/css', 'application/x-javascript', 'text/xml', 'application/xml', 'application/xml+rss', 'text/javascript', 'application/json' ]
   nginx['ha'] = false
   nginx['keepalive_timeout'] = 65
   nginx['log_directory'] = /var/log/chef-server/nginx
   nginx['non_ssl_port'] = 80
   nginx['sendfile'] = on
   nginx['server_name'] = node['fqdn']
   nginx['ssl_certificate'] = nil
   nginx['ssl_certificate_key'] = nil
   nginx['ssl_ciphers'] = 
   nginx['ssl_company_name'] = YouCorp
   nginx['ssl_country_name'] = US
   nginx['ssl_email_address'] = you@example.com
   nginx['ssl_locality_name'] = Seattle
   nginx['ssl_organizational_unit_name'] = Operations
   nginx['ssl_port'] = 443
   nginx['ssl_protocols'] = 
   nginx['ssl_state_name'] = WA
   nginx['tcp_nodelay'] = on
   nginx['tcp_nopush'] = on
   nginx['url'] = https://#{node['fqdn']}
   nginx['worker_connections'] = 10240
   nginx['worker_processes'] = node['cpu']['total'].to_i

   # Pedant settings

   chef_pedant['dir'] = /var/opt/chef-server/chef-pedant
   chef_pedant['log_directory'] = /var/log/chef-server/chef-pedant
   chef_pedant['log_http_requests'] = true

   # PostgreSQL settings

   postgresql['checkpoint_completion_target'] = 0.9
   postgresql['checkpoint_segments'] = 10
   postgresql['checkpoint_timeout'] = 5min
   postgresql['checkpoint_warning'] = 30s
   postgresql['data_dir'] = /var/opt/chef-server/postgresql/data
   postgresql['dir'] = /var/opt/chef-server/postgresql
   postgresql['effective_cache_size'] = #{(node['memory']['total'].to_i / 2) / (1024)}MB
   postgresql['enable'] = true
   postgresql['ha'] = false
   postgresql['home'] = /var/opt/chef-server/postgresql
   postgresql['listen_address'] = 0.0.0.0
   postgresql['log_directory'] = /var/log/chef-server/postgresql
   postgresql['max_connections'] = 200
   postgresql['md5_auth_cidr_addresses'] = [ ]
   postgresql['port'] = 5432
   postgresql['shared_buffers'] = #{(node['memory']['total'].to_i / 4) / (1024)}MB
   postgresql['shmall'] = kernel['machine'] =~ /x86_64/ ? 4194304 : 1048575
   postgresql['shmmax'] = kernel['machine'] =~ /x86_64/ ? 17179869184 : 4294967295
   postgresql['shell'] = /bin/sh
   postgresql['sql_password'] = snakepliskin
   postgresql['sql_ro_password'] = shmunzeltazzen
   postgresql['sql_ro_user'] = opscode_chef_ro
   postgresql['sql_user'] = opscode_chef
   postgresql['svlogd_num'] = 10
   postgresql['svlogd_size'] = 1000000
   postgresql['trust_auth_cidr_addresses'] = '127.0.0.1/32', '::1/128'
   postgresql['user_path'] = /opt/chef-server/embedded/bin:/opt/chef-server/bin:$PATH
   postgresql['username'] = opscode-pgsql
   postgresql['vip'] = 127.0.0.1
   postgresql['work_mem'] = 8MB

   # RabbitMQ settings

   rabbitmq['consumer_id'] = hotsauce
   rabbitmq['data_dir'] = /var/opt/chef-server/rabbitmq/db
   rabbitmq['dir'] = /var/opt/chef-server/rabbitmq
   rabbitmq['enable'] = true
   rabbitmq['ha'] = false
   rabbitmq['log_directory'] = /var/log/chef-server/rabbitmq
   rabbitmq['node_ip_address'] = 0.0.0.0
   rabbitmq['node_port'] = 5672
   rabbitmq['nodename'] = rabbit@localhost
   rabbitmq['password'] = chefrocks
   rabbitmq['user'] = chef
   rabbitmq['vhost'] = /chef
   rabbitmq['vip'] = 127.0.0.1

   # User settings

   user['home'] = /opt/chef-server/embedded
   user['shell'] = /bin/sh
   user['username'] = chef_server

   # Default web user interface settings

   chef_server_webui['backlog'] = 1024
   chef_server_webui['cookie_domain'] = all
   chef_server_webui['cookie_secret'] = 47b3b8d95dea455baf32155e95d1e64e
   chef_server_webui['dir'] = /var/opt/chef-server/chef-server-webui
   chef_server_webui['enable'] = true
   chef_server_webui['environment'] = chefserver
   chef_server_webui['ha'] = false
   chef_server_webui['listen'] = 127.0.0.1:9462
   chef_server_webui['log_directory'] = /var/log/chef-server/chef-server-webui
   chef_server_webui['port'] = 9462
   chef_server_webui['session_key'] = _sandbox_session
   chef_server_webui['tcp_nodelay'] = true
   chef_server_webui['umask'] = 0022
   chef_server_webui['vip'] = 127.0.0.1
   chef_server_webui['web_ui_admin_default_password'] = p@ssw0rd1
   chef_server_webui['web_ui_admin_user_name'] = admin
   chef_server_webui['web_ui_client_name'] = chef-webui
   chef_server_webui['worker_processes'] = 2
   chef_server_webui['worker_timeout'] = 3600

.. end_tag

