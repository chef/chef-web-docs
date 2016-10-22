=====================================================
supermarket.rb Settings
=====================================================

.. tag config_rb_supermarket_summary

The supermarket.rb file contains all of the non-default configuration settings used by the Chef Supermarket. (The default settings are built-in to the Chef Supermarket configuration and should only be added to the supermarket.rb file to apply non-default values.) These configuration settings are processed when the ``supermarket-ctl reconfigure`` command is run, such as immediately after setting up Chef Supermarket or after making a change to the underlying configuration settings after the server has been deployed. The supermarket.rb file is a Ruby file, which means that conditional statements can be used in the configuration file.

.. end_tag

.. note:: The supermarket.rb file does not exist by default. To modify the settings for the Chef server, create a file named ``supermarket.rb`` in the ``/etc/supermarket/`` directory.

Settings
=====================================================
The following settings are may be configured in the supermarket.rb file.

.. note:: When changes are made to the chef-server.rb file the Chef server must be reconfigured by running the ``supermarket-ctl reconfigure`` command.

General
-----------------------------------------------------
This configuration file has the following general settings:

``enterprise['name']``
   Default value: ``'supermarket'``.

``supermarket['app_directory']``
   Default value: ``"#{node['supermarket']['install_directory']}/embedded/service/supermarket"``.

``supermarket['chef_server_url']``
   The URL for the Chef server.

``supermarket['config_directory']``
   Default value: ``'/etc/supermarket'``.

``supermarket['features']``
   Use to enable announcments, CLA features, a service that reports on cookbook quality, GitHub integration, enable joining of corporate CLAs, and tools. Default value: ``'tools'``.

``supermarket['fqdn']``
   Default value: ``node['fqdn']``.

``supermarket['group']``
   Default value: ``'supermarket'``.

``supermarket['install_directory']``
   Default value: ``'/opt/supermarket'``.

``supermarket['install_path']``
   The directory in which Chef Supermarket is installed. Default value: ``node['supermarket']['install_directory']``.

``supermarket['log_directory']``
   Default value: ``'/var/log/supermarket'``.

``supermarket['sysvinit_id']``
   Use to specify 1-4 characters that define a unique identifier for the file located in ``/etc/inittab``. Default value: ``SUP``.

``supermarket['user']``
   Default value: ``'supermarket'``.

``supermarket['var_directory']``
   Default value: ``'/var/opt/supermarket'``.

.. there are these as well:
.. 
.. supermarket['fieri_url'] = nil
.. supermarket['fieri_key'] = nil
.. supermarket['from_email'] = nil
.. supermarket['github_access_token'] = nil
.. supermarket['github_key'] = nil
.. supermarket['github_secret'] = nil
.. supermarket['google_analytics_id'] = nil
.. supermarket['host'] = node['supermarket']['fqdn']
.. supermarket['newrelic_agent_enabled'] = 'false'
.. supermarket['newrelic_app_name'] = nil
.. supermarket['newrelic_license_key'] = nil
.. supermarket['port'] = node['supermarket']['nginx']['force_ssl'] ? node['supermarket']['nginx']['ssl_port'] : node['supermarket']['non_ssl_port']
.. supermarket['protocol'] = node['supermarket']['nginx']['force_ssl'] ? 'https' : 'http'
.. supermarket['pubsubhubbub_callback_url'] = nil
.. supermarket['pubsubhubbub_secret'] = nil
.. supermarket['redis_url'] = "redis://#{node['supermarket']['redis']['bind']}:#{node['supermarket']['redis']['port']}/0/supermarket"
.. supermarket['sentry_url'] = nil

Amazon Simple Storage Service (S3)
-----------------------------------------------------
This configuration file has the following settings for uploading cookbooks to a specified Amazon Simple Storage Service (S3) bucket:

``supermarket['cdn_url']``
   The URL for the content delivery network.

``supermarket['s3_access_key_id']``
   The secret key.

``supermarket['s3_bucket']``
   The bucket name.

``supermarket['s3_secret_access_key']``
   The access key identifier.

CLA
-----------------------------------------------------
This configuration file has the following settings for the Chef Supermarket Contributor License Agreement (CLA):

``supermarket['ccla_version']``

``supermarket['cla_report_email']``

``supermarket['cla_signature_notification_email']``

``supermarket['curry_cla_location']``

``supermarket['curry_success_label']``

``supermarket['icla_location']``

``supermarket['icla_version']``

``supermarket['seed_cla_data']``

Database
-----------------------------------------------------
This configuration file has the following settings for database configurations:

``supermarket['database']['extensions']``
   Default value: ``{ 'pgpsql' => true, 'pg_trgm' => 'true' }``.

``supermarket['database']['host']``
   Default value: ``node['supermarket']['postgresql']['listen_address']``.

``supermarket['database']['name']``
   Default value: ``'supermarket'``.

``supermarket['database']['pool']``
   Default value: ``node['supermarket']['sidekiq']['concurrency']``.

``supermarket['database']['port']``
   Default value: ``node['supermarket']['postgresql']['port']``.

``supermarket['database']['user']``
   Default value: ``node['supermarket']['postgresql']['username']``.

Nginx
-----------------------------------------------------
This configuration file has the following settings for Nginx:

``supermarket['nginx']['access_log_options']``

``supermarket['nginx']['cache']['directory']``
   Default value: ``"#{node['supermarket']['var_directory']}/nginx//cache"``.

``supermarket['nginx']['cache']['enable']``
   Default value: ``false``.

``supermarket['nginx']['client_body_buffer_size']``

``supermarket['nginx']['client_max_body_size']``
   The maximum accepted body size for a client request, as indicated by the ``Content-Length`` request header. When the maximum accepted body size is greater than this value, a ``413 Request Entity Too Large`` error is returned. Default value: ``250m``.

``supermarket['nginx']['daemon_disable']``
   Default value: ``true``.

``supermarket['nginx']['default']['modules']``
   Default value: ``[]``.

``supermarket['nginx']['default_site_enabled']``
   Default value: ``false``.

``supermarket['nginx']['dir']``
   The working directory. The default value is the recommended value. Default value: ``node['supermarket']['nginx']['directory']``.

``supermarket['nginx']['disable_access_log']``
   Default value: ``false``.

``supermarket['nginx']['error_log_options']``

``supermarket['nginx']['enable']``
   Enable a service. Default value: ``true``.

``supermarket['nginx']['event']``

``supermarket['nginx']['force_ssl']``
   Default value: ``true``.

``supermarket['nginx']['group']``
   Default value: ``node['supermarket']['group']``.

``supermarket['nginx']['gzip']``
   Enable  gzip compression. Default value: ``on``.

``supermarket['gzip_buffers']``

``supermarket['nginx']['gzip_comp_level']``
   The compression level used with gzip, from least amount of compression (``1``, fastest) to the most (``2``, slowest). Default value: ``2``.

``supermarket['gzip_disable']``
   Default value: ``'MSIE [1-6]\.'``.

``supermarket['nginx']['gzip_http_version']``
   Enable gzip depending on the version of the HTTP request. Default value: ``1.0``.

``supermarket['gzip_min_length']``
   Default value: ``1000``.

``supermarket['nginx']['gzip_proxied']``
   The type of compression used based on the request and response. Default value: ``any``.

``supermarket['nginx']['gzip_static']``
   Default value: ``'off'``.

``supermarket['nginx']['gzip_types']``
   Enable compression for the specified MIME-types. Default value: ``[ 'text/plain', 'text/css', 'application/x-javascript', 'text/xml', 'application/xml', 'application/xml+rss', 'application/atom+xml', 'text/javascript', 'application/javascript', 'application/json' ]``.

``supermarket['gzip_vary']``
   Default value: ``'off'``.

``supermarket['nginx']['keepalive']``
   Use to enable Keepalived. Default value: ``'on'``.

``supermarket['nginx']['keepalive_timeout']``
   The amount of time (in seconds) to wait for requests on a Keepalived connection. Default value: ``65``.

``supermarket['nginx']['log_dir']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``node['supermarket']['nginx']['log_directory']``.

``supermarket['nginx']['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``supermarket['nginx']['multi_accept']``
   Default value: ``false``.

``supermarket['nginx']['non_ssl_port']``
   The port on which the WebUI and API are bound for non-SSL connections. Default value: ``80``. Set to ``false`` to disable non-SSL connections.

``supermarket['nginx']['pid']``
   Default value: ``"#{node['supermarket']['nginx']['directory']}/nginx.pid"``.

``supermarket['nginx']['proxy_read_timeout']``

``supermarket['nginx']['redirect_to_canonical']``
   Default value: ``true``.

``supermarket['nginx']['sendfile']``
   Copy data between file descriptors when ``sendfile()`` is used. Default value: ``on``.

``supermarket['nginx']['server_names_hash_bucket_size']``
   Default value: ``64``.

``supermarket['nginx']['server_tokens']``

``supermarket['nginx']['ssl_port']``
   Default value: ``443``.

``supermarket['nginx']['types_hash_bucket_size']``
   Default value: ``64``.

``supermarket['nginx']['types_hash_max_size']``
   Default value: ``2048``.

``supermarket['nginx']['user']``
   Default value: ``node['supermarket']['user']``.

``supermarket['nginx']['worker_connections']``
   The maximum number of simultaneous clients. Use with ``nginx['worker_processes']`` to determine the maximum number of allowed clients. Default value: ``1024``.

``supermarket['nginx']['worker_rlimit_nofile']``

``supermarket['nginx']['worker_processes']``
   The number of allowed worker processes. Use with ``nginx['worker_connections']`` to determine the maximum number of allowed clients. Default value: ``node['cpu'] && node['cpu']['total'] ? node['cpu']['total'] : 1``.

Oauth2
-----------------------------------------------------
This configuration file has the following settings for the Chef server identity service:

``supermarket['chef_oauth2_app_id']``

``supermarket['chef_oauth2_secret']``

``supermarket['chef_oauth2_url']``
   Default value: ``node['supermarket']['chef_server_url']``.

``supermarket['chef_oauth2_verify_ssl']``
   Default value: ``true``.

PostgreSQL
-----------------------------------------------------
This configuration file has the following settings for PostgreSQL:

``supermarket['postgresql']['checkpoint_completion_target']``
   A completion percentage that is used to determine how quickly a checkpoint should finish in relation to the completion status of the next checkpoint. For example, if the value is ``0.5``, then a checkpoint attempts to finish before 50% of the next checkpoint is done. Default value: ``0.5``.

``supermarket['postgresql']['checkpoint_segments']``
   The maximum amount (in megabytes) between checkpoints in log file segments. Default value: ``3``.

``supermarket['postgresql']['checkpoint_timeout']``
   The amount of time (in minutes) between checkpoints. Default value: ``'5min'``.

``supermarket['postgresql']['checkpoint_warning']``
   The frequency (in seconds) at which messages are sent to the server log files if checkpoint segments are being filled faster than their currently configured values. Default value: ``'30s'``.

``supermarket['postgresql']['data_directory']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value: ``"#{node['supermarket']['var_directory']}/postgresql/9.3/data"``.

``supermarket['postgresql']['effective_cache_size']``
   The size of the disk cache that is used for data files. Default value: ``'128MB'``.

``supermarket['postgresql']['enable']``
   Enable a service. Default value: ``true``.

``supermarket['postgresql']['listen_address']``
   The connection source to which PostgreSQL is to respond. Default value: ``'127.0.0.1'``.

``supermarket['postgresql']['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``"#{node['supermarket']['log_directory']}/postgresql"``.

``supermarket['postgresql']['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``supermarket['postgresql']['max_connections']``
   The maximum number of allowed concurrent connections. Default value: ``350``.

``supermarket['postgresql']['md5_auth_cidr_addresses']``
   Use to encrypt passwords using MD5 hashes. Default value: ``['127.0.0.1/32', '::1/128']``.

``supermarket['postgresql']['port']``
   The port on which the service is to listen. Default value: ``15432``.

``supermarket['postgresql']['shared_buffers']``
   The amount of memory that is dedicated to PostgreSQL for data caching. Default value: ``"#{(node['memory']['total'].to_i / 4) / (1024)}MB"``.

``supermarket['postgresql']['shmall']``
   The total amount of available shared memory. Default value: ``4194304``.

``supermarket['postgresql']['shmmax']``
   The maximum amount of shared memory. Default value: ``17179869184``.

``supermarket['postgresql']['work_mem']``
   The size (in megabytes) of allowed in-memory sorting. Default value: ``'8MB'``.

Redis
-----------------------------------------------------
This configuration file has the following settings for Redis:

``supermarket['redis']['bind']``
   Bind Redis to the specified IP address. Default value: ``'127.0.0.1'``.

``supermarket['redis']['directory']``
   The working directory. The default value is the recommended value. Default value: ``"#{node['supermarket']['var_directory']}/redis"``.

``supermarket['redis']['enable']``
   Enable a service. Default value: ``true``.

``supermarket['redis']['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``"#{node['supermarket']['log_directory']}/redis"``.

``supermarket['redis']['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``supermarket['redis']['port']``
   The port on which the service is to listen. Default value: ``'16379'``.

Ruby on Rails
-----------------------------------------------------
This configuration file has the following settings for Ruby on Rails:

``supermarket['rails']['enable']``
   Enable a service. Default value: ``true``.

``supermarket['rails']['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``"#{node['supermarket']['log_directory']}/rails"``.

``supermarket['rails']['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``supermarket['rails']['port']``
   The port on which the service is to listen. Default value: ``13000``.

runit
-----------------------------------------------------
This configuration file has the following settings for runit:

``supermarket['runit']['svlogd_bin']``
   Default value: ``"#{node['supermarket']['install_directory']}/embedded/bin/svlogd"``.

Sidekiq
-----------------------------------------------------
This configuration file has the following settings for background processes that are managed by Sidekiq:

``supermarket['sidekiq']['concurrency']``
   Default value: ``25``.

``supermarket['sidekiq']['enable']``
   Enable a service. Default value: ``true``.

``supermarket['sidekiq']['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``"#{node['supermarket']['log_directory']}/sidekiq"``.

``supermarket['sidekiq']['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``supermarket['sidekiq']['timeout']``
   Default value: ``30``.

SMTP
-----------------------------------------------------
This configuration file has the following settings for SMTP:

``supermarket['smtp_address']``

``supermarket['smtp_password']``

``supermarket['smtp_port']``
   The port on which the service is to listen.

``supermarket['smtp_user_name']``

SSL
-----------------------------------------------------
This configuration file has the following settings for SSL:

``supermarket['ssl']['certificate']``
   The SSL certificate used to verify communication over HTTPS.

``supermarket['ssl']['certificate_key']``
   The certificate key used for SSL communication.

``supermarket['ssl']['company_name']``
   The name of your company. Default value: ``'My Supermarket'``.

``supermarket['ssl']['country_name']``
   The country in which your company is located. Default value: ``'US'``.

``supermarket['ssl']['directory']``
   The working directory. Default value: ``'/var/opt/supermarket/ssl'``.

``supermarket['ssl']['email_address']``
   The default email address for your company. Default value: ``'you@example.com'``.

``supermarket['ssl']['locality_name']``
   The city in which your company is located. Default value: ``'Seattle'``.

``supermarket['ssl']['openssl_bin']``
   Default value: ``"#{node['supermarket']['install_directory']}/embedded/bin/openssl"``.

``supermarket['ssl']['organizational_unit_name']``
   The organization or group within your company that is running the Chef server. Default value: ``'Operations'``.

``supermarket['ssl']['session_cache']``
   Default value: ``'shared:SSL:4m'``.

``supermarket['ssl']['session_timeout']``
   Default value: ``'5m'``.

``supermarket['ssl']['ciphers']``
   The list of supported cipher suites that are used to establish a secure connection. To favor AES256 with ECDHE forward security, drop the ``RC4-SHA:RC4-MD5:RC4:RSA`` prefix. See https://wiki.mozilla.org/Security/Server_Side_TLS for more information. For example:

   .. code-block:: ruby

      nginx['ssl_ciphers'] = HIGH:MEDIUM:!LOW:!kEDH:!aNULL:!ADH:!eNULL:!EXP:!SSLv2:!SEED:!CAMELLIA:!PSK

``supermarket['ssl']['protocols']``
   The SSL protocol versions that are enabled. Default value: ``'TLSv1 TLSv1.1 TLSv1.2'``.

``supermarket['ssl']['state_name']``
   The state, province, or region in which your company is located. Default value: ``'WA'``.

StatsD
-----------------------------------------------------
This configuration file has the following settings for reporting to a StatsD server:

``supermarket['statsd_port']``
   The port on which the service is to listen.

``supermarket['statsd_url']``
   The URL to which reporting metrics are sent.

Unicorn
-----------------------------------------------------
This configuration file has the following settings for Unicorn:

``supermarket['unicorn']['after_fork']``

``supermarket['unicorn']['copy_on_write']``
   Default value: ``true``.

``supermarket['unicorn']['before_exec']``

``supermarket['unicorn']['before_fork']``

``supermarket['unicorn']['enable_stats']``
   Default value: ``false``.

``supermarket['unicorn']['forked_group']``
   Default value: ``node['supermarket']['group']``.

``supermarket['unicorn']['forked_user']``
   Default value: ``node['supermarket']['user']``.

``supermarket['unicorn']['listen']``
   The IP address on which the service is to listen. Default value: ``["127.0.0.1:#{node['supermarket']['rails']['port']}"]``.

``supermarket['unicorn']['name']``
   Default value: ``'supermarket'``.

``supermarket['unicorn']['pid']``
   Default value: ``"#{node['supermarket']['var_directory']}/rails/run/unicorn.pid"``.

``supermarket['unicorn']['preload_app']``
   Default value: ``true``.

``supermarket['unicorn']['stderr_path']``

``supermarket['unicorn']['stdout_path']``

``supermarket['unicorn']['unicorn_command_line']``

``supermarket['unicorn']['worker_processes']``
   The number of allowed worker processes. Default value: ``node['nginx']['worker_processes']``.

``supermarket['unicorn']['worker_timeout']``
   The amount of time (in seconds) before a worker process times out. Default value: ``15``.

``supermarket['unicorn']['working_directory']``

URLs
-----------------------------------------------------
This configuration file has the following settings for URLs:

``supermarket['chef_blog_url']``
   Default value: ``"https://www.#{node['supermarket']['chef_domain']}/blog"``.

``supermarket['chef_docs_url']``
   Default value: ``"https://docs.#{node['supermarket']['chef_domain']}"``.

``supermarket['chef_downloads_url']``
   Default value: ``"https://downloads.#{node['supermarket']['chef_domain']}"``.

``supermarket['chef_domain']``
   Default value: ``'chef.io'``.

``supermarket['chef_identity_url']``
   Default value: ``"#{node['supermarket']['chef_server_url']}/id"``.

``supermarket['chef_manage_url']``
   Default value: ``node['supermarket']['chef_server_url']``.

``supermarket['chef_profile_url']``
   Default value: ``node['supermarket']['chef_server_url']``.

``supermarket['chef_sign_up_url']``
   Default value: ``"#{node['supermarket']['chef_server_url']}/signup?ref=community"``.

``supermarket['chef_www_url']``
   Default value: ``"https://www.#{node['supermarket']['chef_domain']}"``.

``supermarket['learn_chef_url']``
   Default value: ``"https://learn.#{node['supermarket']['chef_domain']}"``.
