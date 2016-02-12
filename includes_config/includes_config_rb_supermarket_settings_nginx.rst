.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for |nginx|:

``supermarket['nginx']['access_log_options']``
   

``supermarket['nginx']['cache']['directory']``
   Default value: ``"#{node['supermarket']['var_directory']}/nginx//cache"``.

``supermarket['nginx']['cache']['enable']``
   Default value: ``false``.

``supermarket['nginx']['client_body_buffer_size']``
   

``supermarket['nginx']['client_max_body_size']``
   |nginx client_max_body_size| Default value: ``250m``.

``supermarket['nginx']['daemon_disable']``
   Default value: ``true``.

``supermarket['nginx']['default']['modules']``
   Default value: ``[]``.

``supermarket['nginx']['default_site_enabled']``
   Default value: ``false``.

``supermarket['nginx']['dir']``
   |directory generic| |default_value_recommended| Default value: ``node['supermarket']['nginx']['directory']``.

``supermarket['nginx']['disable_access_log']``
   Default value: ``false``.

``supermarket['nginx']['error_log_options']``
   

``supermarket['nginx']['enable']``
   |enable service| Default value: ``true``.

``supermarket['nginx']['event']``
   

``supermarket['nginx']['force_ssl']``
   Default value: ``true``.

``supermarket['nginx']['group']``
   Default value: ``node['supermarket']['group']``.

``supermarket['nginx']['gzip']``
   |enable gzip| Default value: ``on``.

``supermarket['gzip_buffers']``
   

``supermarket['nginx']['gzip_comp_level']``
   |gzip compression_level| Default value: ``2``.

``supermarket['gzip_disable']``
   Default value: ``'MSIE [1-6]\.'``.

``supermarket['nginx']['gzip_http_version']``
   |gzip http_version| Default value: ``1.0``.

``supermarket['gzip_min_length']``
   Default value: ``1000``.

``supermarket['nginx']['gzip_proxied']``
   |gzip proxied| Default value: ``any``.

``supermarket['nginx']['gzip_static']``
   Default value: ``'off'``.

``supermarket['nginx']['gzip_types']``
   |gzip types| Default value: ``[ 'text/plain', 'text/css', 'application/x-javascript', 'text/xml', 'application/xml', 'application/xml+rss', 'application/atom+xml', 'text/javascript', 'application/javascript', 'application/json' ]``.

``supermarket['gzip_vary']``
   Default value: ``'off'``.

``supermarket['nginx']['keepalive']``
   Use to enable |keepalived|. Default value: ``'on'``.

``supermarket['nginx']['keepalive_timeout']``
   |worker_max_keepalive| Default value: ``65``.

``supermarket['nginx']['log_dir']``
   |directory logs| |default_value_recommended| Default value: ``node['supermarket']['nginx']['log_directory']``.

``supermarket['nginx']['log_rotation']``
   |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``supermarket['nginx']['multi_accept']``
   Default value: ``false``.

``supermarket['nginx']['non_ssl_port']``
   |port non_ssl_nginx| Default value: ``80``. Set to ``false`` to disable non-SSL connections.

``supermarket['nginx']['pid']``
   Default value: ``"#{node['supermarket']['nginx']['directory']}/nginx.pid"``.

``supermarket['nginx']['proxy_read_timeout']``
   

``supermarket['nginx']['redirect_to_canonical']``
   Default value: ``true``.

``supermarket['nginx']['sendfile']``
   |use sendfile| Default value: ``on``.

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
   |worker_connections| Use with ``nginx['worker_processes']`` to determine the maximum number of allowed clients. Default value: ``1024``.

``supermarket['nginx']['worker_rlimit_nofile']``
   

``supermarket['nginx']['worker_processes']``
   |worker_processes| Use with ``nginx['worker_connections']`` to determine the maximum number of allowed clients. Default value: ``node['cpu'] && node['cpu']['total'] ? node['cpu']['total'] : 1``.
