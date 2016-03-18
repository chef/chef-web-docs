=====================================================
delivery.rb Optional Settings 
=====================================================

.. warning:: The configuration settings in the ``delivery.rb`` file should not be modified before discussing those changes with |company_name|. Some of these settings should be considered for tuning (see :doc:`Delivery Server Tuning </delivery_server_tuning>`), but many of them should be left as default values.

Settings
=====================================================
The following sections describe the various settings that are available in the ``delivery.rb`` file.

General
-----------------------------------------------------
This configuration file has the following settings for ``rabbitmq``:

``name``
   Default value: ``'delivery'``.

``install_path``
   Default value: ``"/opt/delivery"``.

``cookbook_path``
   Default value:

   .. code-block:: ruby

      File.join(
        node['delivery']['install_path'],
        "embedded", "cookbooks"
      )

``dir``
   |directory generic_working| |default_value_recommended| Default value: ``"/opt/delivery"``.

``bootstrap['enable']``
   Default value: ``true``.

``chef_base_path``
   Default value: ``"/opt/opscode"``.

user
-----------------------------------------------------
This configuration file has the following settings for ``user``:

``user['username']``
   The username for the delivery services user. Default value: ``"delivery"``.

``user['shell']``
   The shell for the delivery services user. Default value: ``"/bin/bash"``.

``user['home']``
   The home directory for the delivery services user. Default value: ``"/opt/delivery/embedded"``.

default
-----------------------------------------------------
This configuration file has the following settings for ``default``:

``default['delivery']['user']['comment']``
   This is the "GECOS" field for a Unix user (e.g., a human-readable name). Default value: ``"CHEF Delivery"``.

``default_log_directory``
   |directory generic_working| |default_value_recommended| Default value: ``"/var/log/delivery"``.

``default_num_logs_to_keep``
   |log_rotation| Default value: ``10``.

``default_log_size_in_bytes``
   |log_rotation| Default value: ``100 * 1024 * 1024``.

delivery
-----------------------------------------------------
This configuration file has the following settings for ``delivery``:

``delivery['enable']``
   |enable service| Default value: ``true``.

``delivery['dir']``
   |directory generic_working| |default_value_recommended| Default value: ``"/var/opt/delivery/delivery"``.

``delivery['etc_dir']``
   Default value: ``"/var/opt/delivery/delivery/etc"``.

``delivery['chef_config']``
   Default value: ``File.join(node['delivery']['delivery']['etc_dir'], "erlang.cfg")``.

``delivery['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``File.join(default_log_directory, "delivery")``.

``delivery['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``1024 * 1000 * 10``.

``delivery['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``default_num_logs_to_keep``.

``delivery['vip']``
   |ip_address virtual| Default value: ``'127.0.0.1'``.

``delivery['listen']``
   |ip_address virtual| Default value: ``'127.0.0.1'``.

``delivery['port']``
   |port service| Default value: ``9611``.

``delivery['ssl_certificates']``
   A hash of SSL certificate files to use for FQDNs. Will use ``remote_file`` to download the key and crt specified. If you wanted to use a pre-generated SSL certificate for the main fqdn (``delivery_fqdn``) you could specify that here. For example:

   .. code-block:: ruby

      delivery['ssl_certificates'] = {
        'delivery.example.com' => {
          'key' => 's3://my_bucket/ssl_certificates/delivery.example.com.key',
          'crt' => 's3://my_bucket/ssl_certificates/delivery.example.com.crt'
        }
      }

``delivery['ca_cert_chain_depth']``
   Default value: ``2``.

``delivery['api_port']``
   Default value: ``9611``.

``delivery['db_pool_max_count']``
   The maximum number of open connections to PostgreSQL. Default value: ``100``.

``delivery['db_pool_init_count']``
   |db_pool_size| Default value: ``20``.

``delivery['chef_username']``
   Default value: ``"delivery-cd"``.

``delivery['chef_private_key']``
   Default value: ``"/etc/delivery/delivery-cd.pem"``.

``delivery['chef_server']``
   Default value: ``'https://localhost/organizations/cd'``.

``delivery['default_search']``
   The default search to use for build nodes if it is not specified in ``delivery.rb``. Default value:

   .. code-block:: ruby

      "(recipes:delivery_builder OR " +
        "recipes:delivery_builder\\\\:\\\\:default OR " +
        "recipes:delivery_build OR " +
        "recipes:delivery_build\\\\:\\\\:default)"

``delivery['chef_server_webui']``
   This should be programmatically derived from the chef_server attribute above. Default value: ``'https://localhost'``.

``delivery['db_name']``
   Default value: ``"delivery"``.

``delivery['sql_user']``
   Default value: ``'delivery'``.

``delivery['sql_password']``
   Default value: ``'pokemon'``.

``delivery['sql_ro_user']``
   Default value: ``'delivery_ro'``.

``delivery['sql_ro_password']``
   Default value: ``'pokemon_ro'``.

``delivery['sql_repl_user']``
   Default value: ``'delivery_repl'``.

``delivery['sql_repl_password']``
   Default value: ``'pokemon_repl'``.

``delivery['backup_path']``
   Default value: ``'/var/opt/delivery/backups'``.

``delivery['max_backups']``
   Default value: ``7``.

``delivery['backup_cron_job']``
   Default value: ``false``.

``delivery['restore_backup']``
   Set this option to true to restore the backup after it is made Default value: ``false``.

``delivery['cron_backup_times']``
   The time vector for backup cron job; conforms to crontab format. Default value: ``'0 0 * * *'``.

``delivery['git_repo_template']``
   Where to look for the delivery git repo template must remain consistent with where omnibus-delivery's 'delivery' software definition puts it. Default value: ``::File.join(node['delivery']['user']['home'], 'etc', 'deliv_git_repo_template')``.

``delivery['git_repos']``
   Default value: ``::File.join(node['delivery']['delivery']['dir'], 'git_repos')``.

``delivery['git_working_tree_dir']``
   Define default directory location for the git working tree. Default value: ``::File.join(node['delivery']['delivery']['dir'], 'git_workspace')``.

``delivery['push_jobs_max_retries']``
   Maximum number of retries a push job can incur without an intervening nack. Default value: ``3``.

``delivery['push_jobs_overall_timeout']``
   Timeout for finding worker and then waiting for push job to complete. Default value: ``'2h'``.

``delivery['push_jobs_run_timeout']``
   Timeout for waiting for push job to complete once worker has been found. Default value: ``'75m'``.

``delivery['phase_job_confirmation_timeout']``
   Timeout for waiting for phase job to confirm completion. Default value: ``'5m'``.

``delivery['is_dev_box']``
   Default value: ``false``.

``delivery['audit_max_events']``
   Maximum number of audit events to keep in memory. Default value: ``100``.

``delivery['read_ttl']``
   These may be specified as strings with units (e.g., ``"4d"``, ``"3h"``, ``"2m"``, ``"1s"``), or as bare integers (which will be interpreted as seconds). Valid units are: ``d`` (days), ``h`` (hours), ``m`` (minutes), or ``s`` (seconds). While these values can be different, it's not recommended. Default value: ``'7d'``.

``delivery['write_ttl']``
   These may be specified as strings with units (e.g., ``"4d"``, ``"3h"``, ``"2m"``, ``"1s"``), or as bare integers (which will be interpreted as seconds). Valid units are: ``d`` (days), ``h`` (hours), ``m`` (minutes), or ``s`` (seconds). While these values can be different, it's not recommended. Default value: ``'7d'``.

``delivery['ldap_hosts']``
   |ldap host| Default value: ``[]``.

``delivery['ldap_port']``
   |ldap port| Default value: ``3269``.

``delivery['ldap_timeout']``
   Default value: ``5000``.

``delivery['ldap_base_dn']``
   |ldap base_dn| Default value: ``"OU=Employees,OU=Domain users,DC=examplecorp,DC=com"``.

``delivery['ldap_bind_dn']``
   |ldap bind_dn| Default value: ``"ldapbind"``.

``delivery['ldap_bind_dn_password']``
   |ldap bind_password| Default value: ``"secret123"``.

``delivery['ldap_encryption']``
   Default value: ``"start_tls"``.

``delivery['ldap_attr_login']``
   The attribute that maps to a user's unique logon name. This is the attribute used for searching and will be used to map a user name into Delivery. Default value: ``'sAMAccountName'``.

``delivery['ldap_attr_mail']``
   The attribute that maps to user email address. Default value: ``'mail'``.

``delivery['ldap_attr_full_name']``
   The attribute that contains a full or display name for a user. Default value: ``'fullName'``.

``delivery['primary']``
   Default value: ``true``.

``delivery['primary_ip']``
   Default value: ``nil``.

``delivery['standby_ip']``
   Default value: ``nil``.

``delivery['use_ssl_termination']``
   Default value: ``false``.


delivery_web
-----------------------------------------------------
This configuration file has the following settings for ``delivery_web``:

``delivery_web['etc_dir']``
   |directory generic_working| |default_value_recommended| Default value: ``"/var/opt/delivery/delivery_web/etc"``.

``delivery_web['external_auth']``
   Default value: ``false``.

``delivery_web['password_recovery_url']``
   Default value: ``"http://google.com"``.

``delivery_web['build_version']``
   Default value: ``"0.0.1"``.

``delivery_web['api_version']``
   Default value: ``"v0"``.

``delivery_web['embedly_api_key']``
   Default value: ``"e0435c6ccfd74dfaacf7dfc987c9a7fa"``.

``delivery_web['root']``
   A hook to re-home the web ui for development and testing. Default value:

   .. code-block:: ruby

      "#{node['delivery']['install_path']}/embedded/service/delivery_web"

lsyncd
-----------------------------------------------------
This configuration file has the following settings for ``lsyncd``:

``lsyncd['enable']``
   |enable service| Default value: ``true``.

``lsyncd['dir']``
   |directory generic_working| |default_value_recommended| Default value: ``"/var/opt/delivery/lsyncd"``.

``lsyncd['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``File.join(default_log_directory, "lsyncd")``.

``lsyncd['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``default_log_size_in_bytes``.

``lsyncd['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``default_num_logs_to_keep``.

``lsyncd['user']``
   Default value: ``node['delivery']['user']['username']``.

``lsyncd['ssh_key']``
   Default value: ``"#{node['delivery']['user']['home']}/.ssh/id_rsa"``.

postgresql
-----------------------------------------------------
This configuration file has the following settings for ``postgresql``:

``postgresql['version']``
   |version postgresql| Default value: ``"9.2"``.

``postgresql['enable']``
   |enable service| Default value: ``true``.

``postgresql['ha']``
   |use ha| |ha true| Default value: ``false``.

``postgresql['dir']``
   |directory generic_working| |default_value_recommended| Default value: ``"/var/opt/delivery/postgresql/#{node['delivery']['postgresql']['version']}"``.

``postgresql['data_dir']``
   |directory generic_data| |default_value_recommended| Default value: ``"/var/opt/delivery/postgresql/#{node['delivery']['postgresql']['version']}/data"``.

``postgresql['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``File.join(default_log_directory, "postgresql/#{node['delivery']['postgresql']['version']}")``.

``postgresql['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``default_log_size_in_bytes``.

``postgresql['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``default_num_logs_to_keep``.

``postgresql['username']``
   |name user postgresql| Default value: ``"chef-pgsql"``.

``postgresql['sql_user']``
   Default value: ``"chef"``.

``postgresql['shell']``
   Default value: ``"/bin/bash"``.

``postgresql['home']``
   |directory postgresql_home| Default value: ``"/var/opt/delivery/postgresql"``.

``postgresql['user_path']``
   Default value: ``"/opt/delivery/embedded/bin:/opt/delivery/bin:$PATH"``.

``postgresql['sql_password']``
   |password postgresql_user| Default value: ``"snakepliskin"``.

``postgresql['sql_ro_user']``
   Default value: ``"chef_ro"``.

``postgresql['sql_ro_password']``
   Default value: ``"shmunzeltazzen"``.

``postgresql['vip']``
   |ip_address virtual| Default value: ``"127.0.0.1"``.

``postgresql['port']``
   |port service| Default value: ``5432``.

``postgresql['listen_address']``
   |port listen_postgresql| Default value: ``'localhost'``.

``postgresql['max_connections']``
   |max_connections| Default value: ``350``.

``postgresql['md5_auth_cidr_addresses']``
   |md5_auth_cidr_addresses| Default value: ``[ ]``.

``postgresql['trust_auth_cidr_addresses']``
   |trust_auth_cidr_addresses| See ``md5_auth_cidr_addresses``. Default value: ``[ '127.0.0.1/32', '::1/128' ]``.

``postgresql['shmmax']``
   |postgresql shmax| Default value: ``17179869184``.

``postgresql['shmall']``
   |postgresql shmall| Default value: ``4194304``.

``postgresql['shared_buffers']``
   |shared_buffers postgresql| Default value:

   .. code-block:: ruby

      "#{(node['memory']['total'].to_i / 4) / (1024)}MB"

``postgresql['work_mem']``
   |work_mem| Default value: ``"8MB"``.

``postgresql['effective_cache_size']``
   |effective_cache_size postgresql| Default value: ``"128MB"``.

``postgresql['checkpoint_segments']``
   |checkpoint_segments| Default value: ``3``.

``postgresql['checkpoint_timeout']``
   |checkpoint_timeout| Default value: ``"5min"``.

``postgresql['checkpoint_completion_target']``
   |checkpoint_completion_target| Default value: ``0.5``.

``postgresql['checkpoint_warning']``
   |checkpoint_warning| Default value: ``"30s"``.

``postgresql['debug']``
   Default value: ``false``.

ssh_git
-----------------------------------------------------
This configuration file has the following settings for ``ssh_git``:

``ssh_git['hostname']``
   Default value: ``nil``.

``ssh_git['port']``
   |port service| Default value: ``8989``.

``ssh_git['keys_dir']``
   |directory generic_working| |default_value_recommended| Default value: ``"#{node['delivery']['delivery']['etc_dir']}/ssh_git_server_keys".``

elasticsearch
-----------------------------------------------------
This configuration file has the following settings for ``elasticsearch``:

``elasticsearch['home']``
   Default value: ``"#{node['delivery']['user']['home']}/elasticsearch"``.

``elasticsearch['config_directory']``
   |directory generic_working| |default_value_recommended| Default value: ``"/var/opt/delivery/elasticsearch/conf"``.

``elasticsearch['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``File.join(default_log_directory, "elasticsearch")``.

``elasticsearch['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``default_log_size_in_bytes``.

``elasticsearch['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``default_num_logs_to_keep``.

``elasticsearch['memory']``
   Default value: ``"#{(node.memory.total.to_i * 0.4 ).floor / 1024}m"``.

logstash
-----------------------------------------------------
This configuration file has the following settings for ``logstash``:

``logstash['config_dir']``
   |directory generic_working| |default_value_recommended| Default value: ``"/var/opt/delivery/logstash"``.

``logstash['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``File.join(default_log_directory, "logstash")``.

``logstash['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``default_log_size_in_bytes``.

``logstash['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``default_num_logs_to_keep``.

``logstash['port']``
   |port service| Default value: ``8080``.

``logstash['filebeats']['port']``
   Default value: 5044.

kibana
-----------------------------------------------------
This configuration file has the following settings for ``kibana``:

``kibana['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``File.join(default_log_directory, "kibana")``.

``kibana['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``default_log_size_in_bytes``.

``kibana['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``default_num_logs_to_keep``.

``kibana['conf_dir']``
   |directory generic_working| |default_value_recommended| Default value: ``'/var/opt/delivery/kibana/'``.

``kibana['port']``
   |port service| Default value: ``5601``.

rabbitmq
-----------------------------------------------------
This configuration file has the following settings for ``rabbitmq``:

``rabbitmq['dir']``
   |directory generic_working| |default_value_recommended| Default value: ``'/var/opt/delivery/rabbitmq'``.

``rabbitmq['data_dir']``
   |directory generic_data| |default_value_recommended| Default value: ``'/var/opt/delivery/rabbitmq/db'``.

``rabbitmq['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``File.join(default_log_directory, "rabbitmq")``.

``rabbitmq['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``default_log_size_in_bytes``.

``rabbitmq['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``default_num_logs_to_keep``.

``rabbitmq['password']``
   |password rabbitmq| Default value: ``'chefrocks'``.

``rabbitmq['node_ip_address']``
   |ip_address rabbitmq| Default value: ``'0.0.0.0'``.

``rabbitmq['port']``
   |port service| Default value: ``'5672'``.

``rabbitmq['nodename']``
   |name node| Default value: ``'rabbit@localhost'``.

``rabbitmq['vip']``
   |ip_address virtual| Default value: ``'127.0.0.1'``.

``rabbitmq['env_path']``
   Default value: ``'/opt/delivery/bin:/opt/delivery/embedded/bin:/usr/bin:/bin'``.

``rabbitmq['management_user']``
   |rabbitmq management_user| Default value: ``'rabbitmgmt'``.

``rabbitmq['management_password']``
   |rabbitmq management_password| Default value: ``'chefrocks'``.

``rabbitmq['management_port']``
   |rabbitmq management_port| Default value: ``15672``.

``rabbitmq['management_enabled']``
   |rabbitmq management_enabled| Default value: ``true``.

lb
-----------------------------------------------------
This configuration file has the following settings for ``lb``:

``lb['debug']``
   Default value: ``false``.

nginx
-----------------------------------------------------
This configuration file has the following settings for ``nginx``:

``nginx['enable']``
   |enable service| Default value: ``true``.

``nginx['ha']``
   |use ha| |ha true| Default value: ``false``.

``nginx['dir']``
   |directory generic_working| |default_value_recommended| Default value: ``"/var/opt/delivery/nginx"``.

``nginx['fqdns']``
   All the FQDNs that Nginx will respond to. Default value: ``[]``.

``nginx['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``File.join(default_log_directory, "nginx")``.

``nginx['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``default_log_size_in_bytes``.

``nginx['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``default_num_logs_to_keep``.

``nginx['ssl_port']``
   Default value: ``443``.

``nginx['enable_non_ssl']``
   |enable non_ssl| Default value: ``false``.

``nginx['non_ssl_port']``
   |port non_ssl_nginx| Default value: ``80``. Use ``nginx['enable_non_ssl']`` to enable or disable |ssl| redirects on this port number. Set to ``false`` to disable non-SSL connections.

``nginx['server_name']``
   |server_fqdn| Default value: ``node['delivery']['fqdn']``.

``nginx['ssl_protocols']``
   |version protocols_ssl| For the highest possible security, disable |ssl| 3.0 and allow only TLS:

   .. code-block:: ruby

      nginx['ssl_protocols'] = 'TLSv1 TLSv1.1 TLSv1.2'

   Default value: Default value: ``"SSLv3 TLSv1"``.

``nginx['ssl_ciphers']``
   |ssl_ciphers| To favor AES256 with ECDHE forward security, drop the ``RC4-SHA:RC4-MD5:RC4:RSA`` prefix. See `this link <https://wiki.mozilla.org/Security/Server_Side_TLS>`__ for more information. Default value: ``"RC4-SHA:RC4-MD5:RC4:RSA:HIGH:MEDIUM:!LOW:!kEDH:!aNULL:!ADH:!eNULL:!EXP:!SSLv2:!SEED:!CAMELLIA:!PSK"``.

``nginx['ssl_certificate']``
   |ssl_certificate| Default value: created automatically during setup.

``nginx['ssl_certificate_key']``
   |ssl_certificate key| Default value: created automatically during setup.

``nginx['ssl_country_name']``
   |nginx ssl_country_name| Default value: "US".

``nginx['ssl_state_name']``
   |nginx ssl_state_name| Default value: "WA".

``nginx['ssl_locality_name']``
   |nginx ssl_locality_name| Default value: "Seattle".

``nginx['ssl_company_name']``
   |nginx ssl_company_name| Default value: "Chef".

``nginx['ssl_organizational_unit_name']``
   |nginx ssl_organizational_unit_name| Default value: "Engineering".

``nginx['ssl_email_address']``
   |nginx ssl_email_address| Default value: ``"delivery@getchef.com"``.

``nginx['worker_processes']``
   |worker_processes| Use with ``nginx['worker_connections']`` to determine the maximum number of allowed clients. Default value: ``node['cpu']['total'].to_i``.

``nginx['worker_connections']``
   |worker_connections| Use with ``nginx['worker_processes']`` to determine the maximum number of allowed clients. Default value: ``10240``.

``nginx['sendfile']``
   |use sendfile| Possible values: ``on`` or ``off``. Default value: ``'on'``.

``nginx['tcp_nopush']``
   |use tcpip| Possible values: ``on`` or ``off``. Default value: ``'on'``.

``nginx['tcp_nodelay']``
   |use nagle| Possible values: ``on`` or ``off``. Default value: ``'on'``.

``nginx['gzip']``
   |enable gzip| Possible values: ``on`` or ``off``. Default value: ``'on'``.

``nginx['gzip_http_version']``
   |gzip http_version| Possible values: ``1.0`` or ``1.1``. Default value: ``"1.0"``.

``nginx['gzip_comp_level']``
   |gzip compression_level| Possible values: any integer between ``1`` and ``9`` (inclusive). Default value: ``"2"``.

``nginx['gzip_proxied']``
   |gzip proxied| Possible values: ``any`` (gzip everything), ``auth``, ``expired``, ``no-cache``, ``no-store``, ``no_etag``, ``no_last_modified``, ``off``, or ``private``. Default value: `"any"`.

``nginx['gzip_types']``
   |gzip types| Default value:

   .. code-block:: ruby

      [ "text/plain", "text/css",
        "application/x-javascript", "text/xml",
        "application/javascript", "application/xml",
        "application/xml+rss", "text/javascript",
        "application/json" ]
      ]

``nginx['keepalive_timeout']``
   |worker_max_keepalive| Default value: ``65``.

``nginx['client_max_body_size']``
   |nginx client_max_body_size| Default value: ``'250m'``.

``nginx['cache_max_size']``
   |nginx cache_max_size| Default value: ``'5000m'``.

java
-----------------------------------------------------
This configuration file has the following settings for ``java``:

``java['java_home']``
   Default value: ``"#{node['delivery']['install_path']}/embedded/jre/bin"``.

admin
-----------------------------------------------------
This configuration file has the following settings for ``admin``:

``admin['account_name']``
   Default value: ``'admin'``.

``admin['full_name']``
   Default value: ``'Chef Delivery Administrator'``.

``admin['email']``
   Default value: ``'admin@example.com'``.

``admin['password']``
   Default value: ``'snakes'``.

git
-----------------------------------------------------
This configuration file has the following settings for ``git``:

``git['username']``
   Default value: ``"git"``.

``git['home']``
   Default value: ``"/var/opt/delivery/home/git"``.

``git['ssh_dir']``
   Default value: ``git['home'] + "/.ssh"``.

``git['authkeys']``
   Default value: ``git['ssh_dir'] + "/authorized_keys"``.

``git['shell']``
   Default value: ``"/opt/delivery/embedded/bin/git-shell"``.

deliv_notify
-----------------------------------------------------
This configuration file has the following settings for ``deliv_notify``:

``deliv_notify['config']``
   Default value: ``[]``.