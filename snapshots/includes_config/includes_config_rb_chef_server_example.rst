.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

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
