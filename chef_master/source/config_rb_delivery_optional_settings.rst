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

``bootstrap['enable']``
   Default value: ``true``.

``chef_base_path``
   Default value: ``"/opt/opscode"``.

``cookbook_path``
   Default value:

   .. code-block:: ruby

      File.join(
        node['delivery']['install_path'],
        "embedded", "cookbooks"
      )

``dir``
   |directory generic_working| |default_value_recommended| Default value: ``"/opt/delivery"``.

``install_path``
   Default value: ``"/opt/delivery"``.

``name``
   Default value: ``'delivery'``.

``default['delivery']['user']['comment']``
   This is the "GECOS" field for a Unix user (e.g., a human-readable name). Default value: ``"CHEF Delivery"``.


admin
-----------------------------------------------------
This configuration file has the following settings for ``admin``:

``admin['account_name']``
   Default value: ``'admin'``.

``admin['email']``
   Default value: ``'admin@example.com'``.

``admin['full_name']``
   Default value: ``'Chef Delivery Administrator'``.

``admin['password']``
   Default value: ``'snakes'``.


deliv_notify
-----------------------------------------------------
This configuration file has the following settings for ``deliv_notify``:

``deliv_notify['config']``
   Default value: ``[]``.


delivery
-----------------------------------------------------
This configuration file has the following settings for ``delivery``:

``delivery['api_port']``
   Default value: ``9611``.

``delivery['audit_max_events']``
   Maximum number of audit events to keep in memory. Default value: ``100``.

``delivery['backup_cron_job']``
   Default value: ``false``.

``delivery['backup_path']``
   Default value: ``'/var/opt/delivery/backups'``.

``delivery['ca_cert_chain_depth']``
   Default value: ``2``.

``delivery['chef_config']``
   Default value:

   .. code-block:: ruby

      File.join(node['delivery']['delivery']['etc_dir'], "erlang.cfg")

``delivery['chef_private_key']``
   Default value: ``"/etc/delivery/delivery-cd.pem"``.

``delivery['chef_server']``
   Default value: ``'https://localhost/organizations/cd'``.

``delivery['chef_server_webui']``
   This should be programmatically derived from the chef_server attribute above. Default value: ``'https://localhost'``.

``delivery['chef_username']``
   Default value: ``"delivery-cd"``.

``delivery['cron_backup_times']``
   The time vector for backup cron job; conforms to crontab format. Default value: ``'0 0 * * *'``.

``delivery['db_name']``
   Default value: ``"delivery"``.

``delivery['db_pool_init_count']``
   |db_pool_size| Default value: ``20``.

``delivery['db_pool_max_count']``
   The maximum number of open connections to PostgreSQL. Default value: ``100``.

``delivery['default_search']``
   The default search to use for build nodes if it is not specified in ``delivery.rb``. Default value:

   .. code-block:: ruby

      "(recipes:delivery_builder OR " +
        "recipes:delivery_builder\\\\:\\\\:default OR " +
        "recipes:delivery_build OR " +
        "recipes:delivery_build\\\\:\\\\:default)"

``delivery['dir']``
   |directory generic_working| |default_value_recommended| Default value: ``"/var/opt/delivery/delivery"``.

``delivery['enable']``
   |enable service| Default value: ``true``.

``delivery['etc_dir']``
   Default value: ``"/var/opt/delivery/delivery/etc"``.

``delivery['git_repo_template']``
   Where to look for the delivery git repo template must remain consistent with where omnibus-delivery's 'delivery' software definition puts it. Default value:

   .. code-block:: ruby

      ::File.join(node['delivery']['user']['home'], 'etc', 'deliv_git_repo_template')

``delivery['git_repos']``
   Default value:

   .. code-block:: ruby

      ::File.join(node['delivery']['delivery']['dir'], 'git_repos')

``delivery['git_working_tree_dir']``
   Define default directory location for the git working tree. Default value:

   .. code-block:: ruby

      ::File.join(node['delivery']['delivery']['dir'], 'git_workspace')

``delivery['is_dev_box']``
   Default value: ``false``.

``delivery['ldap_attr_full_name']``
   The attribute that contains a full or display name for a user. Default value: ``'fullName'``.

``delivery['ldap_attr_login']``
   The attribute that maps to a user's unique logon name. This is the attribute used for searching and will be used to map a user name into Delivery. Default value: ``'sAMAccountName'``.

``delivery['ldap_attr_mail']``
   The attribute that maps to user email address. Default value: ``'mail'``.

``delivery['ldap_base_dn']``
   |ldap base_dn| Default value:

   .. code-block:: ruby

      "OU=Employees,OU=Domain users,DC=examplecorp,DC=com"

``delivery['ldap_bind_dn']``
   |ldap bind_dn| Default value: ``"ldapbind"``.

``delivery['ldap_bind_dn_password']``
   |ldap bind_password| Default value: ``"secret123"``.

``delivery['ldap_encryption']``
   Default value: ``"start_tls"``.

``delivery['ldap_hosts']``
   |ldap host| Default value: ``[]``.

``delivery['ldap_port']``
   |ldap port| Default value: ``3269``.

``delivery['ldap_timeout']``
   |timeout| Default value: ``5000``.

``delivery['listen']``
   |ip_address virtual| Default value: ``'127.0.0.1'``.

``delivery['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``"/var/log/delivery/delivery"``.

``delivery['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``1024 * 1000 * 10``.

``delivery['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``10``.

``delivery['max_backups']``
   The maximum number of backups to be kept. Default value: ``7``.

``delivery['phase_job_confirmation_timeout']``
   Timeout for waiting for phase job to confirm completion. Default value: ``'5m'``.

``delivery['port']``
   |port service| Default value: ``9611``.

``delivery['primary']``
   Specifies if the |delivery| server is the primary server. Default value: ``true``.

``delivery['primary_ip']``
   The IP address for the primary |delivery| server. Default value: ``nil``.

``delivery['push_jobs_max_retries']``
   Maximum number of retries a push job can incur without an intervening nack. Default value: ``3``.

``delivery['push_jobs_overall_timeout']``
   Timeout for finding worker and then waiting for push job to complete. Default value: ``'2h'``.

``delivery['push_jobs_run_timeout']``
   Timeout for waiting for push job to complete once worker has been found. Default value: ``'75m'``.

``delivery['read_ttl']``
   These may be specified as strings with units (e.g., ``"4d"``, ``"3h"``, ``"2m"``, ``"1s"``), or as bare integers (which will be interpreted as seconds). Valid units are: ``d`` (days), ``h`` (hours), ``m`` (minutes), or ``s`` (seconds). While these values can be different, it's not recommended. Default value: ``'7d'``.

``delivery['restore_backup']``
   Set this option to true to restore the backup after it is made Default value: ``false``.

``delivery['sql_password']``
   Default value: ``'pokemon'``.

``delivery['sql_repl_password']``
   Default value: ``'pokemon_repl'``.

``delivery['sql_repl_user']``
   Default value: ``'delivery_repl'``.

``delivery['sql_ro_password']``
   Default value: ``'pokemon_ro'``.

``delivery['sql_ro_user']``
   Default value: ``'delivery_ro'``.

``delivery['sql_user']``
   Default value: ``'delivery'``.

``delivery['ssl_certificates']``
   A hash of SSL certificate files to use for FQDNs. Will use ``remote_file`` to download the key and crt specified. If you wanted to use a pre-generated SSL certificate for the main fqdn (``delivery_fqdn``) you could specify that here. For example:

   .. code-block:: ruby

      delivery['ssl_certificates'] = {
        'delivery.example.com' => {
          'key' => 'https://my_bucket/ssl_certificates/delivery.example.com.key',
          'crt' => 'https://my_bucket/ssl_certificates/delivery.example.com.crt'
        }
      }

``delivery['standby_ip']``
   The IP address for the cold standby |delivery| server. Default value: ``nil``.

``delivery['use_ssl_termination']``
   Default value: ``false``.

``delivery['write_ttl']``
   These may be specified as strings with units (e.g., ``"4d"``, ``"3h"``, ``"2m"``, ``"1s"``), or as bare integers (which will be interpreted as seconds). Valid units are: ``d`` (days), ``h`` (hours), ``m`` (minutes), or ``s`` (seconds). While these values can be different, it's not recommended. Default value: ``'7d'``.

``delivery['vip']``
   |ip_address virtual| Default value: ``'127.0.0.1'``.


delivery_web
-----------------------------------------------------
This configuration file has the following settings for ``delivery_web``:

``delivery_web['api_version']``
   Default value: ``"v0"``.

``delivery_web['build_version']``
   Default value: ``"0.0.1"``.

``delivery_web['embedly_api_key']``
   Default value: ``"e0435c6ccfd74dfaacf7dfc987c9a7fa"``.

``delivery_web['etc_dir']``
   |directory generic_working| |default_value_recommended| Default value: ``"/var/opt/delivery/delivery_web/etc"``.

``delivery_web['external_auth']``
   Default value: ``false``.

``delivery_web['password_recovery_url']``
   Default value: ``"http://google.com"``.

``delivery_web['root']``
   A hook to re-home the web ui for development and testing. Default value:

   .. code-block:: ruby

      "#{node['delivery']['install_path']}/embedded/service/delivery_web"


elasticsearch
-----------------------------------------------------
This configuration file has the following settings for ``elasticsearch``:

``elasticsearch['config_directory']``
   |directory generic_working| |default_value_recommended| Default value: ``"/var/opt/delivery/elasticsearch/conf"``.

``elasticsearch['home']``
   Default value: ``"#{node['delivery']['user']['home']}/elasticsearch"``.

``elasticsearch['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``"/var/log/delivery/elasticsearch"``.

``elasticsearch['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``100 * 1024 * 1024`` (100MB).

``elasticsearch['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``10``.

``elasticsearch['memory']``
   Default value:

   .. code-block:: ruby

      "#{(node.memory.total.to_i * 0.4 ).floor / 1024}m"


git
-----------------------------------------------------
This configuration file has the following settings for ``git``:

``git['authkeys']``
   Default value: ``git['ssh_dir'] + "/authorized_keys"``.

``git['home']``
   Default value: ``"/var/opt/delivery/home/git"``.

``git['shell']``
   Default value: ``"/opt/delivery/embedded/bin/git-shell"``.

``git['ssh_dir']``
   Default value: ``git['home'] + "/.ssh"``.

``git['username']``
   Default value: ``"git"``.


java
-----------------------------------------------------
This configuration file has the following settings for ``java``:

``java['java_home']``
   Default value:

   .. code-block:: ruby

      "#{node['delivery']['install_path']}/embedded/jre/bin"


kibana
-----------------------------------------------------
This configuration file has the following settings for ``kibana``:

``kibana['conf_dir']``
   |directory generic_working| |default_value_recommended| Default value: ``'/var/opt/delivery/kibana/'``.

``kibana['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``"/var/log/delivery/kibana"``.

``kibana['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``100 * 1024 * 1024`` (100MB).

``kibana['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``10``.

``kibana['port']``
   |port service| Default value: ``5601``.


lb
-----------------------------------------------------
This configuration file has the following settings for ``lb``:

``lb['debug']``
   Default value: ``false``.


logstash
-----------------------------------------------------
This configuration file has the following settings for ``logstash``:

``logstash['config_dir']``
   |directory generic_working| |default_value_recommended| Default value: ``"/var/opt/delivery/logstash"``.

``logstash['filebeats']['port']``
   Default value: 5044.

``logstash['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``"/var/log/delivery/logstash"``.

``logstash['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``100 * 1024 * 1024`` (100MB).

``logstash['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``10``.

``logstash['port']``
   |port service| Default value: ``8080``.


lsyncd
-----------------------------------------------------
This configuration file has the following settings for ``lsyncd``:

``lsyncd['dir']``
   |directory generic_working| |default_value_recommended| Default value: ``"/var/opt/delivery/lsyncd"``.

``lsyncd['enable']``
   |enable service| Default value: ``true``.

``lsyncd['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``"/var/log/delivery/lsyncd"``.

``lsyncd['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``100 * 1024 * 1024`` (100MB).

``lsyncd['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``10``.

``lsyncd['ssh_key']``
   Default value:

   .. code-block:: ruby

      "#{node['delivery']['user']['home']}/.ssh/id_rsa"

``lsyncd['user']``
   Default value: ``node['delivery']['user']['username']``.


nginx
-----------------------------------------------------
This configuration file has the following settings for ``nginx``:

``nginx['cache_max_size']``
   |nginx cache_max_size| Default value: ``'5000m'``.

``nginx['client_max_body_size']``
   |nginx client_max_body_size| Default value: ``'250m'``.

``nginx['dir']``
   |directory generic_working| |default_value_recommended| Default value: ``"/var/opt/delivery/nginx"``.

``nginx['enable']``
   |enable service| Default value: ``true``.

``nginx['enable_non_ssl']``
   |enable non_ssl| Default value: ``false``.

``nginx['fqdns']``
   An array of |fqdn| to which |nginx| responds. Default value: ``[]``.

``nginx['gzip']``
   |enable gzip| Possible values: ``on`` or ``off``. Default value: ``'on'``.

``nginx['gzip_comp_level']``
   |gzip compression_level| Possible values: any integer between ``1`` and ``9`` (inclusive). Default value: ``"2"``.

``nginx['gzip_http_version']``
   |gzip http_version| Possible values: ``1.0`` or ``1.1``. Default value: ``"1.0"``.

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

``nginx['ha']``
   |use ha| |ha true| Default value: ``false``.

``nginx['keepalive_timeout']``
   |worker_max_keepalive| Default value: ``65``.

``nginx['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``"/var/log/delivery/nginx"``.

``nginx['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``100 * 1024 * 1024`` (100MB).

``nginx['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``10``.

``nginx['non_ssl_port']``
   |port non_ssl_nginx| Default value: ``80``. Use ``nginx['enable_non_ssl']`` to enable or disable |ssl| redirects on this port number. Set to ``false`` to disable non-SSL connections.

``nginx['sendfile']``
   |use sendfile| Possible values: ``on`` or ``off``. Default value: ``'on'``.

``nginx['server_name']``
   |server_fqdn| Default value: ``node['delivery']['fqdn']``.

``nginx['ssl_certificate']``
   |ssl_certificate| Default value: created automatically during setup.

``nginx['ssl_certificate_key']``
   |ssl_certificate key| Default value: created automatically during setup.

``nginx['ssl_ciphers']``
   |ssl_ciphers| To favor AES256 with ECDHE forward security, drop the ``RC4-SHA:RC4-MD5:RC4:RSA`` prefix. See `this link <https://wiki.mozilla.org/Security/Server_Side_TLS>`__ for more information. Default value:

   .. code-block:: ruby

      "RC4-SHA:RC4-MD5:RC4:RSA:HIGH:MEDIUM:!LOW:!kEDH:!aNULL:!ADH:!eNULL:!EXP:!SSLv2:!SEED:!CAMELLIA:!PSK"

``nginx['ssl_company_name']``
   |nginx ssl_company_name| Default value: "Chef".

``nginx['ssl_country_name']``
   |nginx ssl_country_name| Default value: "US".

``nginx['ssl_email_address']``
   |nginx ssl_email_address| Default value: ``"delivery@getchef.com"``.

``nginx['ssl_locality_name']``
   |nginx ssl_locality_name| Default value: "Seattle".

``nginx['ssl_organizational_unit_name']``
   |nginx ssl_organizational_unit_name| Default value: "Engineering".

``nginx['ssl_port']``
   Default value: ``443``.

``nginx['ssl_protocols']``
   |version protocols_ssl| For the highest possible security, disable |ssl| 3.0 and allow only TLS:

   .. code-block:: ruby

      nginx['ssl_protocols'] = 'TLSv1 TLSv1.1 TLSv1.2'

   Default value: Default value: ``"SSLv3 TLSv1"``.

``nginx['ssl_state_name']``
   |nginx ssl_state_name| Default value: "WA".

``nginx['tcp_nodelay']``
   |use nagle| Possible values: ``on`` or ``off``. Default value: ``'on'``.

``nginx['tcp_nopush']``
   |use tcpip| Possible values: ``on`` or ``off``. Default value: ``'on'``.

``nginx['worker_connections']``
   |worker_connections| Use with ``nginx['worker_processes']`` to determine the maximum number of allowed clients. Default value: ``10240``.

``nginx['worker_processes']``
   |worker_processes| Use with ``nginx['worker_connections']`` to determine the maximum number of allowed clients. Default value: ``node['cpu']['total'].to_i``.


postgresql
-----------------------------------------------------
This configuration file has the following settings for ``postgresql``:

``postgresql['checkpoint_completion_target']``
   |checkpoint_completion_target| Default value: ``0.5``.

``postgresql['checkpoint_segments']``
   |checkpoint_segments| Default value: ``3``.

``postgresql['checkpoint_timeout']``
   |checkpoint_timeout| Default value: ``"5min"``.

``postgresql['checkpoint_warning']``
   |checkpoint_warning| Default value: ``"30s"``.

``postgresql['data_dir']``
   |directory generic_data| |default_value_recommended| Default value:

   .. code-block:: ruby

      "/var/opt/delivery/postgresql/#{node['delivery']['postgresql']['version']}/data"

``postgresql['debug']``
   Default value: ``false``.

``postgresql['dir']``
   |directory generic_working| |default_value_recommended| Default value:

   .. code-block:: ruby

      "/var/opt/delivery/postgresql/#{node['delivery']['postgresql']['version']}"

``postgresql['effective_cache_size']``
   |effective_cache_size postgresql| Default value: ``"128MB"``.

``postgresql['enable']``
   |enable service| Default value: ``true``.

``postgresql['ha']``
   |use ha| |ha true| Default value: ``false``.

``postgresql['home']``
   |directory postgresql_home| Default value: ``"/var/opt/delivery/postgresql"``.

``postgresql['listen_address']``
   |port listen_postgresql| Default value: ``'localhost'``. In a disaster recovery configuration, this value is similar to: ``'localhost,192.168.10.11'``.

``postgresql['log_directory']``
   |directory logs| |default_value_recommended| Default value:

   .. code-block:: ruby

      "/var/log/delivery/postgresql/#{node['delivery']['postgresql']['version']}"

``postgresql['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``100 * 1024 * 1024`` (100MB).

``postgresql['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``10``.

``postgresql['max_connections']``
   |max_connections| Default value: ``350``.

``postgresql['md5_auth_cidr_addresses']``
   |md5_auth_cidr_addresses| Default value: ``[ ]``.

``postgresql['port']``
   |port service| Default value: ``5432``.

``postgresql['shared_buffers']``
   |shared_buffers postgresql| Default value:

   .. code-block:: ruby

      "#{(node['memory']['total'].to_i / 4) / (1024)}MB"

``postgresql['shell']``
   Default value: ``"/bin/bash"``.

``postgresql['shmall']``
   |postgresql shmall| Default value: ``4194304``.

``postgresql['shmmax']``
   |postgresql shmax| Default value: ``17179869184``.

``postgresql['sql_password']``
   |password postgresql_user| Default value: ``"snakepliskin"``.

``postgresql['sql_ro_password']``
   Default value: ``"shmunzeltazzen"``.

``postgresql['sql_ro_user']``
   Default value: ``"chef_ro"``.

``postgresql['sql_user']``
   Default value: ``"chef"``.

``postgresql['trust_auth_cidr_addresses']``
   |trust_auth_cidr_addresses| See ``md5_auth_cidr_addresses``. Default value: ``[ '127.0.0.1/32', '::1/128' ]``.

``postgresql['user_path']``
   Default value:

   .. code-block:: ruby

      "/opt/delivery/embedded/bin:/opt/delivery/bin:$PATH"

``postgresql['username']``
   |name user postgresql| Default value: ``"chef-pgsql"``.

``postgresql['work_mem']``
   |work_mem| Default value: ``"8MB"``.

``postgresql['version']``
   |version postgresql| Default value: ``"9.2"``.

``postgresql['vip']``
   |ip_address virtual| Default value: ``"127.0.0.1"``.


rabbitmq
-----------------------------------------------------
This configuration file has the following settings for ``rabbitmq``:

``rabbitmq['dir']``
   |directory generic_working| |default_value_recommended| Default value: ``'/var/opt/delivery/rabbitmq'``.

``rabbitmq['data_dir']``
   |directory generic_data| |default_value_recommended| Default value: ``'/var/opt/delivery/rabbitmq/db'``.

``rabbitmq['env_path']``
   Default value:

   .. code-block:: ruby

      '/opt/delivery/bin:/opt/delivery/embedded/bin:/usr/bin:/bin'

``rabbitmq['log_directory']``
   |directory logs| |default_value_recommended| Default value:

   .. code-block:: ruby

      File.join(default_log_directory, "rabbitmq")

``rabbitmq['log_rotation']['file_maxbytes']``
   |log_rotation| Default value: ``100 * 1024 * 1024`` (100MB).

``rabbitmq['log_rotation']['num_to_keep']``
   |log_rotation| Default value: ``10``.

``rabbitmq['management_enabled']``
   |rabbitmq management_enabled| Default value: ``true``.

``rabbitmq['management_password']``
   |rabbitmq management_password| Default value: ``'chefrocks'``.

``rabbitmq['management_port']``
   |rabbitmq management_port| Default value: ``15672``.

``rabbitmq['management_user']``
   |rabbitmq management_user| Default value: ``'rabbitmgmt'``.

``rabbitmq['node_ip_address']``
   |ip_address rabbitmq| Default value: ``'0.0.0.0'``.

``rabbitmq['nodename']``
   |name node| Default value: ``'rabbit@localhost'``.

``rabbitmq['password']``
   |password rabbitmq| Default value: ``'chefrocks'``.

``rabbitmq['port']``
   |port service| Default value: ``'5672'``.

``rabbitmq['vip']``
   |ip_address virtual| Default value: ``'127.0.0.1'``.


ssh_git
-----------------------------------------------------
This configuration file has the following settings for ``ssh_git``:

``ssh_git['hostname']``
   Default value: ``nil``.

``ssh_git['keys_dir']``
   |directory generic_working| |default_value_recommended| Default value:

   .. code-block:: ruby

      "#{node['delivery']['delivery']['etc_dir']}/ssh_git_server_keys"

``ssh_git['port']``
   |port service| Default value: ``8989``.


user
-----------------------------------------------------
This configuration file has the following settings for ``user``:

``user['home']``
   The home directory for the delivery services user. Default value: ``"/opt/delivery/embedded"``.

``user['shell']``
   The shell for the delivery services user. Default value: ``"/bin/bash"``.

``user['username']``
   The username for the delivery services user. Default value: ``"delivery"``.

