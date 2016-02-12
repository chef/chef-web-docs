.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.0

=====================================================
|enterprise rb| Optional Settings
=====================================================

.. warning:: This topic documents the settings for |chef server oec|. The current version of the |chef server| is version 12. All of the documentation at https://docs.chef.io is about the current version of the |chef server|. The documentation for |chef server oec| has been moved: `Enterprise Chef 11.0 <https://docs.chef.io/release/oec_11-0/>`__, `Enterprise Chef 11.1 <https://docs.chef.io/release/oec_11-1/>`__, and `Enterprise Chef 11.2 <https://docs.chef.io/release/oec_11-1/>`__.

.. include:: ../../includes_config/includes_config_rb_chef_server_enterprise.rst

Settings
=====================================================
The following sections describe the various settings that are available in the |enterprise rb| file.

General
-----------------------------------------------------
This configuration file has the following general settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``api_fqdn``
     - The |fqdn| for the |chef server|. This setting is not in the |enterprise rb| file by default. When added, its value should be equal to the |fqdn| for the service URI used by the |chef server|. For example: ``api_fqdn 'chef.example.com'``.
   * - ``bootstrap``
     - Default value: ``true``.
   * - ``ip_version``
     - Use to set the IP version: ``ipv4`` or ``ipv6``. When configuring for IPv6 in a high availability configuration, be sure to set the netmask on the IPv6 ``backend_vip`` attribute. Default value: ``ipv4``.
   * - ``notification_email``
     - Default value: ``info@example.com``.
   * - ``role``
     - |role chef_server| Possible values: ``backend``, ``frontend``, or ``standalone``. Default value: ``'standalone'``.
   * - ``topology``
     - The topology of the |chef server|. Possible values: ``ha``, ``manual``, ``standalone``, and ``tier``. Default value: ``'standalone'``.

bookshelf
-----------------------------------------------------
The |service bookshelf| service has the following settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``bookshelf['access_key_id']``
     - Default value: ``generated-by-default``.
   * - ``bookshelf['data_dir']``
     - |directory generic_data| |default_value_recommended| Default value: ``/var/opt/chef-server/bookshelf/data``.
   * - ``bookshelf['dir']``
     - |directory generic| |default_value_recommended| Default value: ``/var/opt/chef-server/bookshelf``.
   * - ``bookshelf['enable']``
     - |enable service| Default value: ``true``.
   * - ``bookshelf['external_url']``
     - The base URL to which the service will return links to API resources. Use ``:host_header`` to ensure the URL is derived from the host header of the incoming HTTP request. Default value: ``:host_header``.
   * - ``bookshelf['ha']``
     - |use ha| |ha true| Default value: ``false``.
   * - ``bookshelf['listen']``
     - Default value: ``127.0.0.1``.
   * - ``bookshelf['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``/var/log/chef-server/bookshelf``.
   * - ``bookshelf['log_rotation']``
     - |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``
   * - ``bookshelf['port']``
     - |port service| Default value: ``4321``.
   * - ``bookshelf['secret_access_key']``
     - Default value: ``generated-by-default``.
   * - ``bookshelf['stream_download']``
     - Default value: ``true``.
   * - ``bookshelf['url']``
     - This value will default to the value of the URL for |nginx|, which is built from the configured ``api_fqdn`` and the SSL port for |nginx|.


bootstrap
-----------------------------------------------------
This configuration file has the following settings for bootstrap:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``bootstrap['enable']``
     - Indicates whether an attempt to bootstrap the |chef server oec| is made. Generally only enabled on systems that have bootstrap enabled via a ``server`` entry. Default value: ``true``.
   * - ``bootstrap['bootstrap_server']``
     - 

couchdb
-----------------------------------------------------
The |service couchdb| service has the following settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``couchdb['batch_save_interval']``
     - The time in milliseconds within which we will save documents to disk, regardless of how many have been written. Default value: ``1000``.
   * - ``couchdb['batch_save_size']``
     - The number of documents that will trigger a batch save. Default value: ``1000``.
   * - ``couchdb['bind_address']``
     - The address that CouchDB will bind to. Default value: ``'127.0.0.1'``.
   * - ``couchdb['data_dir']``
     - |directory generic_data| |default_value_recommended| Default value: ``'/var/opt/opscode/couchdb/db'``.
   * - ``couchdb['delayed_commits']``
     - Whether commits are delayed. For performance, we tune CouchDB to batch commits according to the ``batch_save_interval`` and ``batch_save_size`` options above. Default value: ``'true'``.
   * - ``couchdb['dir']``
     - |directory generic| |default_value_recommended| Default value: ``'/var/opt/opscode/couchdb'``.
   * - ``couchdb['enable']``
     - |enable service| Default value: ``true``.
   * - ``couchdb['ha']``
     - |use ha| |ha true| This is typically managed by the topology of the cluster and the role this server plays in that topology. This setting (when ``true``) will set the |couch db| service to be down. Default value: ``false``.
   * - ``couchdb['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``'/var/log/opscode/couchdb'``.
   * - ``couchdb['log_level']``
     - |log_level| Default value: ``'error'``.
   * - ``couchdb['log_rotation']``
     - |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``
   * - ``couchdb['max_attachment_chunk_size']``
     - The maximum attachment size. Default value: ``'4294967296'``.
   * - ``couchdb['max_dbs_open']``
     - The maximum number of open databases. Default value: ``10000``.
   * - ``couchdb['max_document_size']``
     - The maximum size of a document. Default value: ``'4294967296'``.
   * - ``couchdb['os_process_timeout']``
     - How long before timing out external processes, in milliseconds. Default value: ``'300000'``.
   * - ``couchdb['port']``
     - |port service| Default value: ``5984``.
   * - ``couchdb['reduce_limit']``
     - Disable limiting the number of reduces. Default value: ``'false'``.
   * - ``couchdb['vip']``
     - |ip_address virtual| Default value: ``'127.0.0.1'``.

drbd
-----------------------------------------------------
This configuration file has the following settings for |drbd|:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``drbd['data_dir']``
     - |directory generic_data| |default_value_recommended| Default value: ``'/var/opt/opscode/drbd/data'``.
   * - ``drbd['device']``
     - The device name to use for |drbd|. Default value: ``'/dev/drbd0'``.
   * - ``drbd['dir']``
     - |directory generic| |default_value_recommended| Default value: ``'/var/opt/opscode/drbd'``.
   * - ``drbd['disk']``
     - The local LVM logical volume to use behind |drbd|. Default value: ``'/dev/opscode/drbd'``.
   * - ``drbd['enable']``
     - Whether or not this server is using |drbd|. This is typically set by the ``role`` this server plays and is enabled on ``backend`` servers in the ``ha`` topology. Default value: ``false``.
   * - ``drbd['flexible_meta_disk']``
     - Where |drbd| meta-data is stored. Default value: ``'internal'``.
   * - ``drbd['primary']``
     - The ``fqdn``, ``ip`` and ``port`` of the server we consider the |drbd| *primary*. This is typically set automatically from the ``server`` entries with the ``backend`` ``role`` when in an ``ha`` topology. Default value: ``{'fqdn'=>'ubuntu.localdomain', 'ip'=>'192.168.4.131', 'port'=>'7788'}``.
   * - ``drbd['secondary']``
     - Identical to the ``drbd['primary']`` setting, including caveats. Default value: ``{'fqdn'=>'ubuntu.localdomain', 'ip'=>'192.168.4.131', 'port'=>'7788'}``.
   * - ``drbd['shared_secret']``
     - The shared secret for |drbd|. This attribute is randomly generated for you when you install the ``bootstrap`` server. You should not need to set it explicitly. Default value: ``'promisespromises'``.
   * - ``drbd['sync_rate']``
     - The amount of bandwidth to use for data synchronization; typically a small percentage of the available bandwidth available for |drbd| replication. Default value: ``'40M'``.
   * - ``drbd['version']``
     - The version of |drbd| that is installed on the system. Auto-detected. Default value: ``'8.4.1'``.

keepalived
-----------------------------------------------------
This configuration file has the following settings for |keepalived|:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``keepalived['dir']``
     - |directory generic| |default_value_recommended| Default value: ``'/var/opt/opscode/keepalived'``.
   * - ``keepalived['enable']``
     - |enable service| Backend servers in a high availability topologies should have this setting enabled. Default value: ``false``.
   * - ``keepalived['ipv6_on']``
     - Use to enable IPv6. Default value: ``false``.
   * - ``keepalived['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``'/var/log/opscode/keepalived'``.
   * - ``keepalived['log_rotation']``
     - |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``
   * - ``keepalived['service_posthooks']``
     - Default value: ``"{ 'rabbitmq' => '/opt/opscode/bin/wait-for-rabbit' }"``.
   * - ``keepalived['smtp_connect_timeout']``
     - |timeout smtp_connect| Default value: ``'30'``.
   * - ``keepalived['smtp_server']``
     - |smtp server| Default value: ``'127.0.0.1'``.
   * - ``keepalived['vrrp_instance_advert_int']``
     - |vrrp_instance_advert| Default value: ``'1'``.
   * - ``keepalived['vrrp_instance_interface']``
     - |vrrp_instance_interface| Should be set to the name of the dedicated interface for |keepalived|. Default value: ``'eth0'``.
   * - ``keepalived['vrrp_instance_ipaddress']``
     - |vrrp_instance_ipaddress| This is typically set by the ``backend_vip`` option. Default value: ``keepalived['vrrp_instance_ipaddress'] = '192.168.4.131'``.
   * - ``keepalived['vrrp_instance_ipaddress_dev']``
     - |vrrp_instance_ipaddress_device| Default value: ``'eth0'``. 
   * - ``keepalived['vrrp_instance_nopreempt']``
     - Default value: ``'true'``.
   * - ``keepalived['vrrp_instance_password']``
     - |vrrp_instance_password| This value is generated randomly when the bootstrap server is installed and does not need to be set explicitly. Default value: ``'sneakybeaky'``.
   * - ``keepalived['vrrp_instance_preempt_delay']``
     - Default value: ``'30'``.
   * - ``keepalived['vrrp_instance_priority']``
     - |vrrp_instance_priority| By default, all servers have equal priority. The server with the lowest value will have the highest priority. Default value: ``'100'``.
   * - ``keepalived['vrrp_instance_state']``
     - |vrrp_instance_state| This value should be the same for both servers in the backend. Default value: ``'MASTER'``.
   * - ``keepalived['vrrp_instance_virtual_router_id']``
     - |vrrp_instance_virtual_router_id| This value should be unique within the multicast domain used for |keepalived|. Default value: ``'1'``.
   * - ``keepalived['vrrp_sync_group']``
     - Default value: ``'PC_GROUP'``.
   * - ``keepalived['vrrp_sync_instance']``
     - Default value: ``'PC_VI'``.
   * - ``keepalived['vrrp_unicast_bind']``
     - |vrrp_unicast_bind| To use multicast, leave this value undefined. This value is configured automatically based on settings in |private chef rb|. |opscode_support| Default value: ``<ip address of cluster IP or eth0>``.
   * - ``keepalived['vrrp_unicast_peer']``
     - |vrrp_unicast_peer| To use multicast, leave this value undefined. This value is configured automatically based on settings in |private chef rb|. |opscode_support| Default value: ``<ip address of peer cluster IP or eth0>``.

ldap
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_chef_server_enterprise_settings_ldap.rst


load-balancer
-----------------------------------------------------
This configuration file has the following settings for load balancers:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``lb['api_fqdn']``
     - Default value: ``node['fqdn']``.
   * - ``lb['ban_refresh_interval']``
     - Default value: ``600``.
   * - ``lb['bookshelf']``
     - Default value: ``127.0.0.1``.
   * - ``lb['cache_cookbook_files']``
     - Default value: ``false``.
   * - ``lb['chef_max_version']``
     - Default value: ``11``.

       .. warning:: This setting is deprecated starting with |chef server oec| 11.2.5 to ensure that the |chef client| version 12 may communicate with the |chef server|. For older versions of |chef server oec|, add this setting to the |private chef rb| file and set the value to ``12``.

   * - ``lb['chef_min_version']``
     - Default value: ``10``.
   * - ``lb['chef_server_webui']``
     - Default value: ``127.0.0.1``.
   * - ``lb['debug']``
     - Default value: ``false``.
   * - ``lb['enable']``
     - Default value: ``true``.
   * - ``lb['erchef']``
     - Default value: ``127.0.0.1``.
   * - ``lb['maint_refresh_interval']``
     - Default value: ``600``.
   * - ``lb['redis_connection_pool_size']``
     - Default value: ``250``.
   * - ``lb['redis_connection_timeout']``
     - Default value: ``1000``.
   * - ``lb['redis_keepalive_timeout']``
     - Default value: ``2000``.
   * - ``lb['upstream']``
     - Default value:

       .. code-block:: ruby

          {
            'oc_bifrost'=>['127.0.0.1'],
            'opscode-account'=>['127.0.0.1'],
            'opscode-authz'=>['127.0.0.1'],
            'opscode-bookshelf'=>['127.0.0.1'],
            'opscode-erchef'=>['127.0.0.1'],
            'opscode-solr4'=>['127.0.0.1']
          }
   * - ``lb['vip']``
     - |ip_address virtual| Default value: ``127.0.0.1``.
   * - ``lb['web_ui_fqdn']``
     - Default value: ``node['fqdn']``.
   * - ``lb['xdl_defaults']['503_mode']``
     - Default value: ``false``.
   * - ``lb['xdl_defaults']['couchdb_acls']``
     - Default value: ``true``.
   * - ``lb['xdl_defaults']['couchdb_containers']``
     - Default value: ``true``.
   * - ``lb['xdl_defaults']['couchdb_groups']``
     - Default value: ``true``.

And for the internal load balancers:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``lb_internal['account_port']``
     - Default value: ``9685``.
   * - ``lb_internal['chef_port']``
     - Default value: ``9680``.
   * - ``lb_internal['enable']``
     - Default value: ``true``.
   * - ``lb_internal['oc_bifrost_port']``
     - Default value: ``9683``.
   * - ``lb_internal['vip']``
     - |ip_address virtual| Default value: ``'127.0.0.1'``.


nginx
-----------------------------------------------------
This configuration file has the following settings for |nginx|:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``nginx['cache_max_size']``
     - Default value: ``5000m``.
   * - ``nginx['client_max_body_size']``
     - Default value: ``250m``.
   * - ``nginx['dir']``
     - |directory generic| |default_value_recommended| Default value: ``/var/opt/chef-server/nginx``.
   * - ``nginx['enable']``
     - |enable service| Default value: ``true``.
   * - ``nginx['enable_ipv6']``
     - |enable ipv6| Default value: ``false``.
   * - ``nginx['enable_non_ssl']``
     - |enable non_ssl| Default value: ``false``.
   * - ``nginx['gzip']``
     - |enable gzip| Default value: ``on``.
   * - ``nginx['gzip_comp_level']``
     - |gzip compression_level| Default value: ``2``.
   * - ``nginx['gzip_http_version']``
     - |gzip http_version| Default value: ``1.0``.
   * - ``nginx['gzip_proxied']``
     - |gzip proxied| Default value: ``any``.
   * - ``nginx['gzip_types']``
     - |gzip types| Default value: ``[ 'text/plain', 'text/css', 'application/x-javascript', 'text/xml', 'application/xml', 'application/xml+rss', 'text/javascript', 'application/json' ]``.
   * - ``nginx['ha']``
     - |use ha| |ha true| Default value: ``false``.
   * - ``nginx['keepalive_timeout']``
     - |worker_max_keepalive| Default value: ``65``.
   * - ``nginx['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``/var/log/chef-server/nginx``.
   * - ``nginx['log_rotation']``
     - |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``
   * - ``nginx['non_ssl_port']``
     - |port non_ssl_nginx| Default value: ``80``. Use ``nginx['enable_non_ssl']`` to enable or disable |ssl| redirects on this port number. Set to ``false`` to disable non-SSL connections.
   * - ``nginx['sendfile']``
     - |use sendfile| Default value: ``on``.
   * - ``nginx['server_name']``
     - |server_fqdn| Default value: ``node['fqdn']``.
   * - ``nginx['ssl_certificate']``
     - |ssl_certificate| Default value: ``nil``.
   * - ``nginx['ssl_certificate_key']``
     - |ssl_certificate key| Default value: ``nil``.
   * - ``nginx['ssl_ciphers']``
     - |ssl_ciphers| To favor AES256 with ECDHE forward security, use ``HIGH:MEDIUM:!LOW:!kEDH:!aNULL:!ADH:!eNULL:!EXP:!SSLv2:!SEED:!CAMELLIA:!PSK``. See https://wiki.mozilla.org/Security/Server_Side_TLS#Recommended_Ciphersuite for more information. Default value: varies.
   * - ``nginx['ssl_company_name']``
     - Default value: ``YouCorp``.
   * - ``nginx['ssl_country_name']``
     - Default value: ``US``.
   * - ``nginx['ssl_email_address']``
     - Default value: ``you@example.com``.
   * - ``nginx['ssl_locality_name']``
     - Default value: ``Seattle``.
   * - ``nginx['ssl_organizational_unit_name']``
     - Default value: ``Operations``.
   * - ``nginx['ssl_port']``
     - Default value: ``443``.
   * - ``nginx['ssl_protocols']``
     - |version protocols_ssl| For the highest possible security, disable |ssl| 3.0 and allow only TLS: ``nginx['ssl_protocols'] 'TLSv1 TLSv1.1 TLSv1.2'``. Default value: varies, depending on the configuration of the |chef server| topology.
   * - ``nginx['ssl_state_name']``
     - Default value: ``WA``.
   * - ``nginx['tcp_nodelay']``
     - |use nagle| Default value: ``on``.
   * - ``nginx['tcp_nopush']``
     - |use tcpip| Default value: ``on``.
   * - ``nginx['url']``
     - Default value: ``https://#{node['fqdn']}``.
   * - ``nginx['worker_connections']``
     - |worker_connections| Use with ``nginx['worker_processes']`` to determine the maximum number of allowed clients. Default value: ``10240``.
   * - ``nginx['worker_processes']``
     - |worker_processes| Use with ``nginx['worker_connections']`` to determine the maximum number of allowed clients. Default value: ``node['cpu']['total'].to_i``.
   * - ``nginx['x_forwarded_proto']``
     - |x_forwarded_proto| This is the protocol used to connect to |chef server oec| by a |chef client| or a workstation. Default value: ``'https'``.


oc_chef_authz
-----------------------------------------------------
.. warning:: This table is available in |chef server oec| 11.2.5 (or higher).
 
This configuration file has the following settings for ``oc_chef_authz``:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``oc_chef_authz['http_cull_interval']``
     - Default value: ``'{1, min}'``.
   * - ``oc_chef_authz['http_init_count']``
     - Default value: ``25``.
   * - ``oc_chef_authz['http_max_age']``
     - Default value: ``'{70, sec}'``.
   * - ``oc_chef_authz['http_max_connection_duration']``
     - Default value: ``'{70, sec}'``.
   * - ``oc_chef_authz['http_max_count']``
     - Default value: ``100``.
   * - ``oc_chef_authz['ibrowse_options']``
     - |timeout authz| Default value: ``'[{connect_timeout, 5000}]'``.

oc_bifrost
-----------------------------------------------------
The |service bifrost| service has the following settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``oc_bifrost['db_pool_size']``
     - |db_pool_size| This value should be increased if failures indicate that the |service bifrost| service ran out of connections. This value should be tuned in conjunction with the ``postgresql['max_connections']`` setting for |postgresql|. Default value: ``20``.
   * - ``oc_bifrost['dir']``
     - |directory generic| |default_value_recommended| Default value: ``/var/opt/opscode/oc_bifrost``.
   * - ``oc_bifrost['enable']``
     - |enable service| Default value: ``true``.
   * - ``oc_bifrost['extended_perf_log']``
     - Default value: ``true``.
   * - ``oc_bifrost['ha']``
     - |use ha| |ha true|
   * - ``oc_bifrost['listen']``
     - Default value: ``'127.0.0.1'``.
   * - ``oc_bifrost['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``/var/log/opscode/oc_bifrost``.
   * - ``oc_bifrost['log_rotation']``
     - |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``
   * - ``oc_bifrost['port']``
     - |port service| Default value: ``9463``.
   * - ``oc_bifrost['sql_password']``
     - Default value: ``'challengeaccepted'``.
   * - ``oc_bifrost['sql_ro_password']``
     - Default value: ``'foreveralone'``.
   * - ``oc_bifrost['sql_ro_user']``
     - Default value: ``'bifrost_ro'``.
   * - ``oc_bifrost['sql_user']``
     - Default value: ``'bifrost'``.
   * - ``oc_bifrost['superuser_id']``
     - Default value: ``'5ca1ab1ef005ba111abe11eddecafbad'``.
   * - ``oc_bifrost['vip']``
     - Default value: ``'127.0.0.1'``.

oc-chef-pedant
-----------------------------------------------------
This configuration file has the following settings for |chef pedant|:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``oc_chef_pedant['dir']``
     - |directory generic| |default_value_recommended| Default value: ``/var/opt/chef-server/chef-pedant``.
   * - ``oc_chef_pedant['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``/var/log/chef-server/chef-pedant``.
   * - ``oc_chef_pedant['log_rotation']``
     - |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``
   * - ``oc_chef_pedant['log_http_requests']``
     - Default value: ``true``.

oc-id
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_server_settings_oc_id.rst

opscode-account
-----------------------------------------------------
The |service account| service has the following settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``opscode_account['backlog']``
     - Default value: ``1024``.
   * - ``opscode_account['dir']``
     - |directory generic| |default_value_recommended| Default value: ``'/var/opt/opscode/opscode-account'``.
   * - ``opscode_account['enable']``
     - |enable service| Default value: ``true``.
   * - ``opscode_account['environment']``
     - Default value: ``'privatechef'``.
   * - ``opscode_account['ha']``
     - |use ha| |ha true| Default value: ``false``.
   * - ``opscode_account['listen']``
     - Default value: ``'127.0.0.1:9465'``.
   * - ``opscode_account['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``'/var/log/opscode/opscode-account'``.
   * - ``opscode_account['log_rotation']``
     - |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``
   * - ``opscode_account['port']``
     - |port service| Default value: ``9465``.
   * - ``opscode_account['proxy_user']``
     - Default value: ``'pivotal'``.
   * - ``opscode_account['session_secret_key']``
     - Default value: ``'change-by-default'``.
   * - ``opscode_account['tcp_nodelay']``
     - |use nagle| Default value: ``true``.
   * - ``opscode_account['umask']``
     - Default value: ``'0022'``.
   * - ``opscode_account['url']``
     - Default value: ``'http://127.0.0.1:9465'``.
   * - ``opscode_account['validation_client_name']``
     - Default value: ``'chef'``.
   * - ``opscode_account['vip']``
     - |ip_address virtual| Default value: ``'127.0.0.1'``.
   * - ``opscode_account['worker_processes']``
     - |worker_processes| Default value: ``4``.
   * - ``opscode_account['worker_timeout']``
     - Default value: ``3600``.

opscode-certificate
-----------------------------------------------------
The |service certificate| service has the following settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``opscode_certificate['dir']``
     - |directory generic| |default_value_recommended| Default value: ``'/var/opt/opscode/opscode-certificate'``.
   * - ``opscode_certificate['enable']``
     - |enable service| Default value: ``true``.
   * - ``opscode_certificate['ha']``
     - |use ha| |ha true| Default value: ``false``.
   * - ``opscode_certificate['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``'/var/log/opscode/opscode-certificate'``.
   * - ``opscode_certificate['log_rotation']``
     - |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``
   * - ``opscode_certificate['num_certificates_per_worker']``
     - Default value: ``'50'``.
   * - ``opscode_certificate['num_workers']``
     - Default value: ``'2'``.
   * - ``opscode_certificate['port']``
     - |port service| Default value: ``5140``.
   * - ``opscode_certificate['vip']``
     - |ip_address virtual| Default value: ``'127.0.0.1'``.

opscode-erchef
-----------------------------------------------------
The |service erchef| service has the following settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``opscode_erchef['auth_skew']``
     - Default value: ``900``.
   * - ``opscode_erchef['authz_fanout']``
     - Default value: ``20``.
   * - ``opscode_erchef['authz_timeout']``
     - Default value: ``1000``.
   * - ``opscode_erchef['base_resource_url']``
     - The base URL to which the service will return links to API resources. Use ``:host_header`` to ensure the URL is derived from the host header of the incoming HTTP request. Default value: ``:host_header``.
   * - ``opscode_erchef['bulk_fetch_batch_size']``
     - Default value: ``5``.
   * - ``opscode_erchef['cache_ttl']``
     - Default value: ``3600``.
   * - ``opscode_erchef['couchdb_max_conn']``
     - Default value: ``'100'``.
   * - ``opscode_erchef['depsolver_timeout']``
     - The amount of time (in milliseconds) to wait for cookbook dependency problems to be solved. Default value: ``'5000'``.
   * - ``opscode_erchef['depsolver_worker_count']``
     - The number of |ruby| processes for which cookbook dependency problems are unsolved. Use the ``pgrep -fl depselector`` command to verify the number of depsolver workers that are running. Default value: ``'5'``.
   * - ``opscode_erchef['db_pool_size']``
     - |db_pool_size| Default value: ``20``.
   * - ``opscode_erchef['dir']``
     - |directory generic| |default_value_recommended| Default value: ``/var/opt/chef-server/erchef``.
   * - ``opscode_erchef['enable']``
     - |enable service| Default value: ``true``.
   * - ``opscode_erchef['enable_actionlog']``
     - Use to enable |chef actions|, an add-on for |chef server oec|. Default value: ``false``.
   * - ``opscode_erchef['ha']``
     - |use ha| |ha true| Default value: ``false``.
   * - ``opscode_erchef['ibrowse_max_pipeline_size']``
     - Default value: ``1``.
   * - ``opscode_erchef['ibrowse_max_sessions']``
     - Default value: ``256``.
   * - ``opscode_erchef['listen']``
     - Default value: ``127.0.0.1``.
   * - ``opscode_erchef['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``/var/log/chef-server/erchef``.
   * - ``opscode_erchef['log_rotation']``
     - |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``
   * - ``opscode_erchef['max_cache_size']``
     - Default value: ``10000``.
   * - ``opscode_erchef['max_request_size']``
     - Default value: ``2500000``.
   * - ``opscode_erchef['port']``
     - |port service| Default value: ``8000``.
   * - ``opscode_erchef['root_metric_key']``
     - Default value: ``chefAPI``.
   * - ``opscode_erchef['s3_bucket']``
     - Default value: ``bookshelf``.
   * - ``opscode_erchef['s3_parallel_ops_fanout']``
     - Default value: ``20``.
   * - ``opscode_erchef['s3_parallel_ops_timeout']``
     - Default value: ``5000``.
   * - ``opscode_erchef['s3_url_ttl']``
     - Default value: ``900``.
   * - ``opscode_erchef['udp_socket_pool_size']``
     - Default value: ``20``.
   * - ``opscode_erchef['umask']``
     - Default value: ``0022``.
   * - ``opscode_erchef['validation_client_name']``
     - Default value: ``chef-validator``.
   * - ``opscode_erchef['vip']``
     - |ip_address virtual| Default value: ``127.0.0.1``.
   * - ``opscode_erchef['web_ui_client_name']``
     - Default value: ``chef-webui``.


opscode-expander
-----------------------------------------------------
The |service expander| service has the following settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``opscode_expander['consumer_id']``
     - Default value: ``default``.
   * - ``opscode_expander['dir']``
     - |directory generic| |default_value_recommended| Default value: ``/var/opt/chef-server/chef-expander``.
   * - ``opscode_expander['enable']``
     - |enable service| Default value: ``true``.
   * - ``opscode_expander['ha']``
     - |use ha| |ha true| Default value: ``false``.
   * - ``opscode_expander['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``/var/log/chef-server/chef-expander``.
   * - ``opscode_expander['log_rotation']``
     - |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``
   * - ``opscode_expander['nodes']``
     - |worker_processes| Default value: ``2``.
   * - ``opscode_expander['reindexer_log_directory']``
     - Default value: ``/var/log/chef-server/chef-expander-reindexer``.


opscode-org-creator
-----------------------------------------------------
The |service orgcreator| service has the following settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``opscode_org_creator['create_splay_ms']``
     - Default value: ``25000``.
   * - ``opscode_org_creator['create_wait_ms']``
     - Default value: ``30000``.
   * - ``opscode_org_creator['dir']``
     - |directory generic| |default_value_recommended| Default value: ``'/var/opt/opscode/opscode-org-creator'``.
   * - ``opscode_org_creator['enable']``
     - Default value: ``true``.
   * - ``opscode_org_creator['ha']``
     - |use ha| |ha true| Default value: ``false``.
   * - ``opscode_org_creator['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``'/var/log/opscode/opscode-org-creator'``.
   * - ``opscode_org_creator['log_rotation']``
     - |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``
   * - ``opscode_org_creator['max_workers']``
     - Default value: ``1``.
   * - ``opscode_org_creator['port']``
     - |port service| Default value: ``4369``.
   * - ``opscode_org_creator['ready_org_depth']``
     - Default value: ``10``.


opscode-solr
-----------------------------------------------------
The |service solr| service has the following settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``opscode_solr['commit_interval']``
     - |solr_commit_interval| This value should be tuned carefully. |solr_update_frequency_caveat| Default value: ``60000`` (every 60 seconds).
   * - ``opscode_solr['data_dir']``
     - |directory generic_data| |default_value_recommended| Default value: ``/var/opt/chef-server/chef-solr/data``.
   * - ``opscode_solr['dir']``
     - |directory generic| |default_value_recommended| Default value: ``/var/opt/chef-server/chef-solr``.
   * - ``opscode_solr['enable']``
     - |enable service| Default value: ``true``.
   * - ``opscode_solr['ha']``
     - |use ha| |ha true| Default value: ``false``.
   * - ``opscode_solr['heap_size']``
     - |heap_size solr| The default value should work for many organizations with fewer than 25 nodes. For an organization with several hundred nodes, the amount of memory that is required often exceeds 3GB. Default value: ``nil``, which is equivalent to 25% of the system memory or 1024 (MB, but this setting is specified as an integer number of MB in EC11), whichever is smaller.
   * - ``opscode_solr['ip_address']``
     - Default value: ``127.0.0.1``.
   * - ``opscode_solr['java_opts']``
     - Default value: ``(empty)``.
   * - ``opscode_solr['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``/var/log/chef-server/chef-solr``.
   * - ``opscode_solr['log_rotation']``
     - |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``
   * - ``opscode_solr['max_commit_docs']``
     - |solr_max_commit_docs| This value should be tuned carefully.  |solr_update_frequency_caveat| Default value: ``1000`` (every 1000 documents).
   * - ``opscode_solr['max_field_length']``
     - |solr_max_field_length| Default value: ``100000`` (increased from the |apache solr| default value of ``10000``).
   * - ``opscode_solr['max_merge_docs']``
     - The maximum number of index segments allowed before they are merged into a single index. Default value: ``2147483647``.
   * - ``opscode_solr['merge_factor']``
     - The maximum number of document updates that can be stored in memory before being flushed and added to the current index segment. Default value: ``100``.
   * - ``opscode_solr['new_size']``
     - Default value: ``nil``.
   * - ``opscode_solr['poll_seconds']``
     - Default value: ``20``.
   * - ``opscode_solr['port']``
     - |port service| Default value: ``8983``.
   * - ``opscode_solr['ram_buffer_size']``
     - Default value: ``200``.
   * - ``opscode_solr['url']``
     - Default value: ``'http://localhost:8983'``.
   * - ``opscode_solr['vip']``
     - |ip_address virtual| Default value: ``127.0.0.1``.


opscode-webui
-----------------------------------------------------
The |service webui| service has the following settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``opscode_webui['backlog']``
     - Default value: ``1024``.
   * - ``opscode_webui['cookie_domain']``
     - Default value: ``all``.
   * - ``opscode_webui['cookie_secret']``
     - Default value: ``47b3b8d95dea455baf32155e95d1e64e``.
   * - ``opscode_webui['dir']``
     - |directory generic| |default_value_recommended| Default value: ``/var/opt/chef-server/chef-server-webui``.
   * - ``opscode_webui['enable']``
     - |enable service| Default value: ``true``.
   * - ``opscode_webui['environment']``
     - Default value: ``privatechef``.
   * - ``opscode_webui['ha']``
     - |use ha| |ha true| Default value: ``false``.
   * - ``opscode_webui['listen']``
     - Default value: ``127.0.0.1:9462``.
   * - ``opscode_webui['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``/var/log/chef-server/chef-server-webui``.
   * - ``opscode_webui['log_rotation']``
     - |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``
   * - ``opscode_webui['port']``
     - |port service| Default value: ``9462``.
   * - ``opscode_webui['session_key']``
     - Default value: ``_sandbox_session``.
   * - ``opscode_webui['tcp_nodelay']``
     - |use nagle| Default value: ``true``.
   * - ``opscode_webui['umask']``
     - |umask| Default value: ``0022``.
   * - ``opscode_webui['url']``
     - Default value: ``'http://127.0.0.1:9462'``.
   * - ``opscode_webui['validation_client_name']``
     - |webui validation_client_name| Default value: ``'chef'``.
   * - ``opscode_webui['vip']``
     - Default value: ``127.0.0.1``.
   * - ``opscode_webui['worker_processes']``
     - |worker_processes| Default value: ``2``.
   * - ``opscode_webui['worker_timeout']``
     - |timeout worker| Default value: ``3600``.


orgmapper
-----------------------------------------------------
This configuration file has the following settings for |orgmapper|:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``orgmapper['']``
     - 
   * - ``org-creator['']``
     - 

postgresql
-----------------------------------------------------
The |service postgresql| service has the following settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``postgresql['checkpoint_completion_target']``
     - |checkpoint_completion_target| Default value: ``0.9``.
   * - ``postgresql['checkpoint_segments']``
     - |checkpoint_segments| Default value: ``10``.
   * - ``postgresql['checkpoint_timeout']``
     - |checkpoint_timeout| Default value: ``5min``.
   * - ``postgresql['checkpoint_warning']``
     - |checkpoint_warning| Default value: ``30s``.
   * - ``postgresql['data_dir']``
     - |directory generic_data| |default_value_recommended| Default value: ``/var/opt/chef-server/postgresql/data``.
   * - ``postgresql['dir']``
     - |directory generic| |default_value_recommended| Default value: ``/var/opt/chef-server/postgresql``.
   * - ``postgresql['effective_cache_size']``
     - |effective_cache_size postgresql| Default value: ``#{(node['memory']['total'].to_i / 2) / (1024)}MB``.
   * - ``postgresql['enable']``
     - |enable service| Default value: ``true``.
   * - ``postgresql['ha']``
     - |use ha| |ha true| Default value: ``false``.
   * - ``postgresql['home']``
     - |directory postgresql_home| Default value: ``/var/opt/chef-server/postgresql``.
   * - ``postgresql['keepalives_count']``
     - Default value: ``2``.
   * - ``postgresql['keepalives_idle']``
     - Default value: ``60``.
   * - ``postgresql['keepalives_interval']``
     - Default value: ``15``.
   * - ``postgresql['listen_address']``
     - |port listen_postgresql| Default value: ``localhost``.
   * - ``postgresql['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``/var/log/chef-server/postgresql``.
   * - ``postgresql['log_min_duration_statement']``
     - |log_rotation min_duration| Possible values: ``-1`` (disabled, do not log any statements), ``0`` (log every statement), or an integer greater than zero. When the integer is greater than zero, this value is the amount of time (in milliseconds) that a query statement must have run before it is logged. Default value: ``-1``.

       .. warning:: This setting is available in |chef server oec| 11.2.5 (or higher).

   * - ``postgresql['log_rotation']``
     - |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``
   * - ``postgresql['max_connections']``
     - |max_connections| Default value: ``350``.
   * - ``postgresql['md5_auth_cidr_addresses']``
     - Default value: ``[ ]``.
   * - ``postgresql['port']``
     - |port service| Default value: ``5432``.
   * - ``postgresql['shared_buffers']``
     - |shared_buffers postgresql| Default value: ``#{(node['memory']['total'].to_i / 4) / (1024)}MB``.
   * - ``postgresql['shell']``
     - Default value: ``/bin/sh``.
   * - ``postgresql['shmall']``
     - The total amount of available shared memory. Default value: ``kernel['machine'] =~ /x86_64/ ? 4194304 : 1048575``.
   * - ``postgresql['shmmax']``
     - The maximum amount of shared memory. Default value: ``kernel['machine'] =~ /x86_64/ ? 17179869184 : 4294967295``.
   * - ``postgresql['sql_password']``
     - The password for the |postgresql| user account. Default value: ``snakepliskin``.
   * - ``postgresql['sql_ro_password']``
     - Default value: ``shmunzeltazzen``.
   * - ``postgresql['sql_ro_user']``
     - Default value: ``opscode_chef_ro``.
   * - ``postgresql['sql_user']``
     - Default value: ``opscode_chef``.
   * - ``postgresql['trust_auth_cidr_addresses']``
     - Default value: ``'127.0.0.1/32', '::1/128'``.
   * - ``postgresql['user_path']``
     - Default value: ``/opt/chef-server/embedded/bin:/opt/chef-server/bin:$PATH``.
   * - ``postgresql['username']``
     - |name user postgresql| Default value: ``opscode-pgsql``.
   * - ``postgresql['version']``
     - The (currently) hardcoded version of |postgresql|. Default value: ``'9.2'``.
   * - ``postgresql['vip']``
     - |ip_address virtual| Default value: ``127.0.0.1``.
   * - ``postgresql['work_mem']``
     - |work_mem| Default value: ``8MB``.


rabbitmq
-----------------------------------------------------
The |service rabbitmq| service has the following settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``rabbitmq['actions_exchange']``
     - The name of the exchange to which |chef actions| publishes actions data. Default value: ``'actions'``.
   * - ``rabbitmq['actions_password']``
     - The password for the ``actions_user``. Default value: ``'changeme'``.
   * - ``rabbitmq['actions_user']``
     - The user with permission to publish actions data. Default value: ``'actions'``.
   * - ``rabbitmq['actions_vhost']``
     - The virtual host to which |chef actions| publishes actions data. Default value: ``'/analytics'``.
   * - ``rabbitmq['consumer_id']``
     - Default value: ``'hotsauce'``.
   * - ``rabbitmq['data_dir']``
     - |directory generic_data| |default_value_recommended| Default value: ``'/var/opt/opscode/rabbitmq/db'``.
   * - ``rabbitmq['dir']``
     - |directory generic| |default_value_recommended| Default value: ``'/var/opt/opscode/rabbitmq'``.
   * - ``rabbitmq['enable']``
     - |enable service| Default value: ``true``.
   * - ``rabbitmq['ha']``
     - |use ha| |ha true| Default value: ``false``.
   * - ``rabbitmq['jobs_password']``
     - Default value: ``'workcomplete'``.
   * - ``rabbitmq['jobs_user']``
     - Default value: ``'jobs'``.
   * - ``rabbitmq['jobs_vhost']``
     - Default value: ``'/jobs'``.
   * - ``rabbitmq['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``'/var/log/opscode/rabbitmq'``.
   * - ``rabbitmq['log_rotation']``
     - |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``
   * - ``rabbitmq['node_ip_address']``
     - |ip_address rabbitmq| Default value: ``'127.0.0.1'``.

       |analytics rabbitmq_settings| When the |chef analytics| server is configured as a standalone server, change this value to ``0.0.0.0``.
   * - ``rabbitmq['node_port']``
     - |port service| Default value: ``'5672'``.
   * - ``rabbitmq['nodename']``
     - |name node| Default value: ``'rabbit@localhost'``.
   * - ``rabbitmq['password']``
     - |password rabbitmq| Default value: ``'chefrocks'``.
   * - ``rabbitmq['reindexer_vhost']``
     - Default value: ``'/reindexer'``.
   * - ``rabbitmq['user']``
     - Default value: ``'chef'``.
   * - ``rabbitmq['vhost']``
     - Default value: ``'/chef'``.
   * - ``rabbitmq['vip']``
     - |ip_address virtual| Default value: ``'127.0.0.1'``.

       |analytics rabbitmq_settings| When the |chef analytics| server is configured as a standalone server, change this value to the backend VIP address for the |chef server|.


redis
-----------------------------------------------------
The |service redis| service has the following settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``redis['appendfsync']``
     - |appendfsync| Default value: ``'everysec'``.
   * - ``redis['appendonly']``
     - |appendonly| Set to ``yes`` to dump data to an append-only log file. Default value: ``'no'``.
   * - ``redis['bind']``
     - |bind redis| Default value: ``'127.0.0.1'``.
   * - ``redis['databases']``
     - |database_quantity| Default value: ``'16'``.
   * - ``redis['dir']``
     - |directory generic| |default_value_recommended| Default value: ``'/var/opt/opscode/redis'``.
   * - ``redis['enable']``
     - |enable service| Default value: ``true``.
   * - ``redis['ha']``
     - |use ha| |ha true| Default value: ``false``.
   * - ``redis['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``'/var/log/opscode/redis'``.
   * - ``redis['loglevel']``
     - |log_level| Possible values: ``debug``, ``notice``, ``verbose``, and ``warning``. Default value: ``'notice'``.
   * - ``redis['maxmemory']``
     - |memory maximum_redis| Default value: ``'1g'``.
   * - ``redis['maxmemory_policy']``
     - |memory maximum_policy_redis| Default value: ``'volatile-lru'``.
   * - ``redis['port']``
     - |port service| Default value: ``'6379'``.
   * - ``redis['root']``
     - |root redis| Default value: ``'/var/opt/opscode/redis'``.
   * - ``redis['timeout']``
     - |timeout redis| Default value: ``'300'``.
   * - ``redis['vip']``
     - |ip_address virtual| Default value: ``'127.0.0.1'``.
   * - ``redis['vm']``
     - Default value:

       .. code-block:: ruby

          {
            'enabled'=>'no',
            'max_memory'=>'0',
            'page_size'=>'32',
            'pages'=>'134217728',
            'max_threads'=>'4'
          }


redis-lb
-----------------------------------------------------
The |service redis_lb| service has the following settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``redis_lb['activerehashing']``
     - |active_rehashing| Default value: ``'no'``.
   * - ``redis_lb['aof_rewrite_min_size']``
     - |appendonly_min_size| Default value: ``'16mb'``.
   * - ``redis_lb['aof_rewrite_percent']``
     - |appendonly_percent| Default value: ``'50'``.
   * - ``redis_lb['appendfsync']``
     - |appendfsync| Default value: ``'always'``.
   * - ``redis_lb['appendonly']``
     - |appendonly| Set to ``yes`` to dump data to an append-only log file. Default value: ``'no'``.
   * - ``redis_lb['bind']``
     - |bind redis| Default value: ``'127.0.0.1'``.
   * - ``redis_lb['data_dir']``
     - |directory generic_data| |default_value_recommended| Default value: ``'/var/opt/opscode/redis_lb/data'``.
   * - ``redis_lb['databases']``
     - |database_quantity| Default value: ``'16'``.
   * - ``redis_lb['dir']``
     - |directory generic| |default_value_recommended| Default value: ``'/var/opt/opscode/redis_lb'``.
   * - ``redis_lb['enable']``
     - |enable service| Default value: ``true``.
   * - ``redis_lb['ha']``
     - |use ha| |ha true| Default value: ``false``.
   * - ``redis_lb['keepalive']``
     - |keepalive request_time| Default value: ``'60'``.
   * - ``redis_lb['log_directory']``
     - |directory logs| The default value is the recommended value. Default value: ``'/var/log/opscode/redis_lb'``.
   * - ``redis_lb['log_rotation']``
     - |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``
   * - ``redis_lb['loglevel']``
     - |log_level|. Possible values: ``debug``, ``notice``, ``verbose``, and ``warning``. Default value: ``'notice'``.
   * - ``redis_lb['maxmemory']``
     - |memory maximum_redis| Default value: ``'8m'``.
   * - ``redis_lb['maxmemory_policy']``
     - |memory maximum_policy_redis| Default value: ``'noeviction'``.
   * - ``redis_lb['port']``
     - |port service| Default value: ``'16379'``.
   * - ``redis_lb['save_frequency']``
     - |save_frequency_redis| Default value: ``{ '900' => '1', '300' => '10', '60' => '1000' }``, which will save the database every 15 minutes if at least one key changes, every 5 minutes if at least 10 keys change, and every 60 seconds if 10000 keys change.
   * - ``redis_lb['timeout']``
     - |timeout redis| Default value: ``'300'``.
   * - ``redis_lb['vip']``
     - |ip_address virtual| Default value: ``'127.0.0.1'``.



users
-----------------------------------------------------
This configuration file has the following settings for users:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``user['home']``
     - Default value: ``/opt/chef-server/embedded``.
   * - ``user['shell']``
     - Default value: ``/bin/sh``.
   * - ``user['username']``
     - Default value: ``opscode``.


