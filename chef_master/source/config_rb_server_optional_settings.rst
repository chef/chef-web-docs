=====================================================
chef-server.rb Optional Settings
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/config_rb_server_optional_settings.rst>`__

.. tag config_rb_server_summary

The chef-server.rb file contains all of the non-default configuration settings used by the Chef server. (The default settings are built-in to the Chef server configuration and should only be added to the chef-server.rb file to apply non-default values.) These configuration settings are processed when the ``chef-server-ctl reconfigure`` command is run, such as immediately after setting up the Chef server or after making a change to the underlying configuration settings after the server has been deployed. The chef-server.rb file is a Ruby file, which means that conditional statements can be used in the configuration file.

.. end_tag

.. note:: .. tag notes_config_rb_server_does_not_exist_by_default

          The chef-server.rb file does not exist by default. To modify the settings for the Chef server, create a file named ``chef-server.rb`` in the ``/etc/opscode/`` directory.

          .. end_tag

.. note:: .. tag notes_config_rb_server_was_private_chef_rb

          This file was named private-chef.rb in previous versions of Enterprise Chef. After an upgrade to Chef server 12 from Enterprise Chef, the private-chef.rb file is symlinked to chef-server.rb. The private-chef.rb file is deprecated, starting with Chef server 12.

          .. end_tag

Settings
=====================================================
The following sections describe the various settings that are available in the chef-server.rb file.

.. note:: .. tag notes_config_rb_server_must_reconfigure

          When changes are made to the chef-server.rb file the Chef server must be reconfigured by running the following command:

          .. code-block:: bash

             $ chef-server-ctl reconfigure

          .. end_tag

General
-----------------------------------------------------
This configuration file has the following general settings:

``addons['install']``
   Default value: ``false``.

``addons['path']``
   Default value: ``nil``.

``addons['packages']``
   Default value:

   .. code-block:: ruby

      %w{opscode-reporting chef-manage opscode-analytics opscode-push-jobs-server}

``api_version``
   The version of the Chef server. Default value: ``'12.0.0'``.

``default_orgname``
   The Chef server API used by the Open Source Chef server does not have an ``/organizations/ORG_NAME`` endpoint. Use this setting to ensure that migrated Open Source Chef servers are able to connect to the Chef server API. This value should be the same as the name of the organization that was created during the upgrade from Open Source Chef version 11 to Chef server version 12, which means it will be identical to the ``ORG_NAME`` part of the ``/organizations`` endpoint in Chef server version 12. Default value: the name of the organization specified during the upgrade process from Open Source Chef 11 to Chef server 12.

``flavor``
   Default value: ``'cs'``.

``from_email``
   Default value: ``'"Opscode" <donotreply@chef.io>"'``.

``fips``
  Set to `true` to run the server in FIPS compliance mode. Set to `false` to force the server to run without FIPS compliance mode. Default value is whatever the kernel is configured to.

``install_path``
   The directory in which the Chef server is installed. Default value: ``'/opt/opscode'``.

``from_email``
   The email address from which invitations to the Chef management console are sent. Default value: ``'"Opscode" <donotreply@opscode.com>'``.

``license['nodes']``
   The number of licensed nodes. Default value: ``25``.

``license['upgrade_url']``
   The URL to visit for more information about how to update the number of nodes licensed for an organization. Default value: ``'http://www.chef.io/contact/on-premises-simple'``.

``notification_email``
   The email addressed to which email notifications are sent. Default value: ``'pc-default@opscode.com'``.

``role``
   The configuration type of the Chef server. Possible values: ``backend``, ``frontend``, or ``standalone``. Default value: ``'standalone'``.

``topology``
   The topology of the Chef server. Possible values: ``ha``, ``manual``, ``standalone``, and ``tier``. Default value: ``'standalone'``.

bookshelf
-----------------------------------------------------
.. tag server_services_bookshelf

The **bookshelf** service is an Amazon Simple Storage Service (S3)-compatible service that is used to store cookbooks, including all of the files---recipes, templates, and so on---that are associated with each cookbook.

.. end_tag

.. note:: .. tag notes_server_aws_cookbook_storage

          To `configure the server for external cookbook storage </server_components.html#aws-settings>`_, updates are made to settings for both the **bookshelf** and **opscode-erchef** services.

          .. end_tag

This configuration file has the following settings for ``bookshelf``:

``bookshelf['access_key_id']``
   The access key identifier. (This is configurable and may be pointed at external storage locations, such as Amazon EC2. Four settings require configuration when pointing at an external cookbook storage location: ``bookshelf['vip']``, for the endpoint used by the chef-client; ``bookshelf['external_url']``, for the endpoint used by the Chef server; ``bookshelf['access_key_id']``, for user access key; ``bookshelf['secret_access_key']``, for secret key; and ``opscode_erchef['s3_bucket']``, for the bucket name. Reconfigure the Chef server after changing these settings. Default value: generated by default.

``bookshelf['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value: ``/var/opt/opscode/bookshelf/data``.

``bookshelf['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/opscode/bookshelf``.

``bookshelf['enable']``
   Enable a service. Default value: ``true``.

``bookshelf['external_url']``
   The base URL to which the service is to return links to API resources. Use ``:host_header`` to ensure the URL is derived from the host header of the incoming HTTP request. Default value: ``:host_header``.

``bookshelf['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``bookshelf['listen']``
   The IP address on which the service is to listen. Default value: ``127.0.0.1``.

``bookshelf['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``/var/log/opscode/bookshelf``.

``bookshelf['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``bookshelf['port']``
   The port on which the service is to listen. Default value: ``4321``.

``bookshelf['secret_access_key']``
   The secret key. (This is configurable and may be pointed at external storage locations, such as Amazon EC2. Four settings require configuration when pointing at an external cookbook storage location: ``bookshelf['vip']``, for the endpoint used by the chef-client; ``bookshelf['external_url']``, for the endpoint used by the Chef server; ``bookshelf['access_key_id']``, for user access key; ``bookshelf['secret_access_key']``, for secret key; and ``opscode_erchef['s3_bucket']``, for the bucket name. Reconfigure the Chef server after changing these settings. Default value: generated by default.

``bookshelf['stream_download']``
   Enable stream downloading of cookbooks. This setting (when ``true``) typically results in improved cookbook download performance, especially with the memory usage of the **bookshelf** service and the behavior of load balancers and proxies in-between the chef-client and the Chef server. Default value: ``true``.

``bookshelf['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.

bootstrap
-----------------------------------------------------
This configuration file has the following settings for ``bootstrap``:

``bootstrap['enable']``
   Indicates whether an attempt to bootstrap the Chef server is made. Generally only enabled on systems that have bootstrap enabled via a ``server`` entry. Default value: ``true``.

compliance forwarding
-----------------------------------------------------
The configuration file has the following settings for forwarding ``compliance`` requests using the chef server authentication system.

``profiles['root_url']``
   If set, any properly signed requests arriving at ``/organizations/ORGNAME/owners/OWNER/compliance`` will be forwarded to this URL. This is expected to be a fully qualified resource, e.g. ``http://compliance.example.org/owners/OWNER/compliance``.

dark_launch
-----------------------------------------------------
This configuration file has the following settings for ``dark_launch``:

``dark_launch['actions']``
   Enable Chef actions. Default value: ``true``.

``dark_launch['add_type_and_bag_to_items']``
   Default value: ``true``.

``dark_launch['new_theme']``
   Default value: ``true``.

``dark_launch['private-chef']``
   Default value: ``true``.

``dark_launch['quick_start']``
   Default value: ``false``.

``dark_launch['reporting']``
   Enable Reporting, which performs data collection during a chef-client run. Default value: ``true``.

``dark_launch['sql_users']``
   Default value: ``true``.

data_collector
-----------------------------------------------------
This configuration file has the following settings for ``data_collector``:

``data_collector['root_url']``
   The fully qualified URL to the data collector server API. When present, it will enable the data collector in **opscode-erchef**. This also enables chef-server authenticated forwarding any properly signed requests arriving at ``/organizations/ORGNAME/data-collector`` to this URL with the data collector token appended. This is also target for requests authenticated and forwarded by the ``/organizations/ORGNAME/data-collector`` endpoint. For the forwarding to work correctly the ``data_collector['token']`` field must also be set.
   For example, if the data collector in Chef Automate is being used, the URI would look like:
   ``http://my_automate_server.example.org/data-collector/v0/``.

``data_collector['token']``
   The shared data collector security token. When configured, the token will be passed as an HTTP header named ``x-data-collector-token`` which the server can choose to accept or reject.
``data_collector['timeout']``
   The amount of time (in milliseconds) before a request to the data collector API times out. Default value: `30000`.
``data_collector['http_init_count']``
   The initial worker count for the HTTP connection pool that is used by the data collector. Default value: `25`.
``data_collector['http_max_count']``
   The maximum worker count for the HTTP connection pool that is used by the data collector. Default value: `100`.
``data_collector['http_max_age']``
   The maximum connection worker age (in seconds) for the HTTP connection pool that is used by the data collector. Default value: `"{70, sec}"`.
``data_collector['http_cull_interval']``
   The maximum cull interval (in minutes) for the HTTP connection pool that is used by the data collector. Default value: `"{1, min}"`.
``data_collector['http_max_connection_duration']``
   The maximum connection duration (in seconds) for the HTTP connection pool that is used by the data collector. Default value: `"{70, sec}"`.
``data_collector['ibrowse_options']``
   An array of comma-separated key-value pairs of ibrowse options for the HTTP connection pool that is used by the data collector. Default value: `"[{connect_timeout, 10000}]"`.

estatsd
-----------------------------------------------------
This configuration file has the following settings for ``estatsd``:

``estatsd['dir']``
   The working directory. The default value is the recommended value. Default value: ``'/var/opt/opscode/estatsd'``.

``estatsd['enable']``
   Enable a service. Default value: ``true``.

``estatsd['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``'/var/log/opscode/estatsd'``.

``estatsd['port']``
   The port on which the service is to listen. Default value: ``9466``.

``estatsd['protocol']``
   Use to send application statistics with StatsD protocol formatting. Set this value to ``statsd`` to apply StatsD protocol formatting.

``estatsd['vip']``
   The virtual IP address. Default value: ``'127.0.0.1'``.

jetty
-----------------------------------------------------
This configuration file has the following settings for ``jetty``:

``jetty['enable']``
   Enable a service. Default value: ``'false'``. This value should not be modified.

``jetty['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``'false'``.

``jetty['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value:

   .. code-block:: ruby

      '/var/opt/opscode/opscode-solr4/jetty/logs'

keepalived
-----------------------------------------------------
.. tag server_services_keepalived

The **keepalived** service manages the virtual IP address (VIP) between the backend machines in a high availability topology that uses DRBD.

.. end_tag

This configuration file has the following settings for ``keepalived``:

``keepalived['dir']``
   The working directory. The default value is the recommended value. Default value: ``'/var/opt/opscode/keepalived'``.

``keepalived['enable']``
   Enable a service. Enable this setting for backend servers in high availability topologies. Default value: ``false``.

``keepalived['ipv6_on']``
   Enable Internet Protocol version 6 (IPv6) addresses. Default value: ``false``.

``keepalived['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``'/var/log/opscode/keepalived'``.

``keepalived['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``keepalived['service_posthooks']``
   The directory to which Keepalived is to send ``POST`` hooks. Default value:

   .. code-block:: ruby

      '{ 'rabbitmq' => '/opt/opscode/bin/wait-for-rabbit' }'

``keepalived['smtp_connect_timeout']``
   The amount of time (in seconds) to wait for a connection to an SMTP server. Default value: ``'30'``.

``keepalived['smtp_server']``
   The SMTP server to which a connection is made. Default value: ``'127.0.0.1'``.

``keepalived['vrrp_instance_advert_int']``
   The frequency (in seconds) at which the primary VRRP server is to advertise. Default value: ``'1'``.

``keepalived['vrrp_instance_interface']``
   The interface over which VRRP traffic is sent. Should be set to the name of the dedicated interface for Keepalived. Default value: ``'eth0'``.

``keepalived['vrrp_instance_ipaddress']``
   The virtual IP address to be managed. This is typically set by the ``backend_vip`` option. Default value: ``node['ipaddress']``.

``keepalived['vrrp_instance_ipaddress_dev']``
   The device to which the virtual IP address is added. Default value: ``'eth0'``.

``keepalived['vrrp_instance_nopreempt']``
   Specify that a lower priority machine maintains the master role, even if a higher priority machine is available. (This setting configures the ``noprempt`` value in VRRP.) Default value: ``'true'``.

``keepalived['vrrp_instance_password']``
   The secret key for VRRP pairs. This value is generated randomly when the bootstrap server is installed and does not need to be set explicitly. Default value: ``'sneakybeaky'``.

``keepalived['vrrp_instance_preempt_delay']``
   The ``prempt_delay`` value for the VRRP instance. Default value: ``'30'``.

``keepalived['vrrp_instance_priority']``
   The priority for this server. By default, all servers have equal priority. The server with the lowest value will have the highest priority. Default value: ``'100'``.

``keepalived['vrrp_instance_state']``
   The state of the VRRP server. This value should be the same for both servers in the backend. Default value: ``'BACKUP'``.

``keepalived['vrrp_instance_virtual_router_id']``
   The virtual router identifier used by the Keepalived pair. This value should be unique within the multicast domain used for Keepalived. Default value: ``'1'``.

``keepalived['vrrp_sync_group']``
   The name of the VRRP synchronization group. Default value: ``'PC_GROUP'``.

``keepalived['vrrp_sync_instance']``
   The name of the VRRP synchronization instance. Default value: ``'PC_VI'``.

``keepalived['vrrp_unicast_bind']``
   The unicast cluster IP address to which Keepalived binds. To use multicast, leave this value undefined. This value is configured automatically based on settings in private-chef.rb. This setting should not be changed without first consulting a Chef support engineer. Default value: ``node['ipaddress']``.

``keepalived['vrrp_unicast_peer']``
   The unicast cluster IP address used by Keepalived to talk to its peer. To use multicast, leave this value undefined. This value is configured automatically based on settings in private-chef.rb. This setting should not be changed without first consulting a Chef support engineer. Default value: ``nil``.

lb / lb_internal
-----------------------------------------------------
This configuration file has the following settings for ``lb``:

``lb['api_fqdn']``
   Default value: ``node['fqdn']``.

``lb['ban_refresh_interval']``
   Default value: ``600``.

``lb['bookshelf']``
   Default value: ``127.0.0.1``.

``lb['cache_cookbook_files']``
   Default value: ``false``.

``lb['chef_max_version']``
   The maximum version of the chef-client that is allowed to access the Chef server via the Chef server API. Default value: ``11``.

``lb['chef_min_version']``
   The minimum version of the chef-client that is allowed to access the Chef server via the Chef server API. Default value: ``10``.

``lb['chef_server_webui']``
   Default value: ``127.0.0.1``.

``lb['debug']``
   Default value: ``false``.

``lb['enable']``
   Enable a service. Default value: ``true``.

``lb['erchef']``
   Default value: ``127.0.0.1``.

``lb['maint_refresh_interval']``
   Default value: ``600``.

``lb['redis_connection_pool_size']``
   Default value: ``250``.

``lb['redis_connection_timeout']``
   The amount of time (in milliseconds) to wait before timing out. Default value: ``1000``.

``lb['redis_keepalive_timeout']``
   The amount of time (in milliseconds) to wait before timing out. Default value: ``2000``.

``lb['upstream']['bookshelf']``
   The default value is the recommended value. Default value: ``[ '127.0.0.1' ]``.

``lb['upstream']['oc_bifrost']``
   The default value is the recommended value. Default value: ``[ '127.0.0.1' ]``.

``lb['upstream']['opscode_erchef']``
   The default value is the recommended value. Default value: ``[ '127.0.0.1' ]``.

``lb['upstream']['opscode_solr4']``
   The default value is the recommended value. Default value: ``[ '127.0.0.1' ]``.

``lb['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.

``lb['web_ui_fqdn']``
   Default value: ``node['fqdn']``.

``lb['xdl_defaults']['503_mode']``
   The default value is the recommended value. Default value: ``false``.

``lb['xdl_defaults']['couchdb_acls']``
   The default value is the recommended value. Default value: ``true``.

``lb['xdl_defaults']['couchdb_association_requests']``
   The default value is the recommended value. Default value: ``true``.

``lb['xdl_defaults']['couchdb_associations']``
   The default value is the recommended value. Default value: ``true``.

``lb['xdl_defaults']['couchdb_containers']``
   The default value is the recommended value. Default value: ``true``.

``lb['xdl_defaults']['couchdb_groups']``
   The default value is the recommended value. Default value: ``true``.

``lb['xdl_defaults']['couchdb_organizations']``
   The default value is the recommended value. Default value: ``true``.

And for the internal load balancers:

``lb_internal['account_port']``
   Default value: ``9685``.

``lb_internal['chef_port']``
   Default value: ``9680``.

``lb_internal['enable']``
   Default value: ``true``.

``lb_internal['oc_bifrost_port']``
   Default value: ``9683``.

``lb_internal['vip']``
   The virtual IP address. Default value: ``'127.0.0.1'``.

ldap
-----------------------------------------------------
.. tag config_rb_server_settings_ldap

This configuration file has the following settings for ``ldap``:

``ldap['base_dn']``
   The root LDAP node under which all other nodes exist in the directory structure. For Active Directory, this is typically ``cn=users`` and then the domain. For example:

   .. code-block:: ruby

      'OU=Employees,OU=Domain users,DC=example,DC=com'

   Default value: ``nil``.

``ldap['bind_dn']``
   The distinguished name used to bind to the LDAP server. The user the Chef server will use to perform LDAP searches. This is often the administrator or manager user. This user needs to have read access to all LDAP users that require authentication. The Chef server must do an LDAP search before any user can log in. Many Active Directory and LDAP systems do not allow an anonymous bind. If anonymous bind is allowed, leave the ``bind_dn`` and ``bind_password`` settings blank. If anonymous bind is not allowed, a user with ``READ`` access to the directory is required. This user must be specified as an LDAP distinguished name similar to:

   .. code-block:: ruby

      'CN=user,OU=Employees,OU=Domainuser,DC=example,DC=com'

   Default value: ``nil``.

``ldap['bind_password']``
   The password for the binding user. The password for the user specified by ``ldap['bind_dn']``. Leave this value and ``ldap['bind_dn']`` unset if anonymous bind is sufficient. Default value: ``nil``.

``ldap['group_dn']``
   The distinguished name for a group. When set to the distinguished name of a group, only members of that group can log in. This feature filters based on the ``memberOf`` attribute and only works with LDAP servers that provide such an attribute. In OpenLDAP, the ``memberOf`` overlay provides this attribute. For example, if the value of the ``memberOf`` attribute is ``CN=abcxyz,OU=users,DC=company,DC=com``, then use:

   .. code-block:: ruby

      ldap['group_dn'] = 'CN=user,OU=Employees,DC=example,DC=com'

``ldap['host']``
   The name (or IP address) of the LDAP server. The hostname of the LDAP or Active Directory server. Be sure the Chef server is able to resolve any host names. Default value: ``ldap-server-host``.

``ldap['login_attribute']``
   The LDAP attribute that holds the user's login name. Use to specify the Chef server user name for an LDAP user. Default value: ``sAMAccountName``.

``ldap['port']``
   An integer that specifies the port on which the LDAP server listens. The default value is an appropriate value for most configurations. Default value: ``389`` or ``636`` when ``ldap['encryption']`` is set to ``:simple_tls``.

``ldap['ssl_enabled']``
   Cause the Chef server to connect to the LDAP server using SSL. Default value: ``false``. Must be ``false`` when ``ldap['tls_enabled']`` is ``true``.

   .. note:: Previous versions of the Chef server used the ``ldap['ssl_enabled']`` setting to first enable SSL, and then the ``ldap['encryption']`` setting to specify the encryption type. These settings are deprecated.

``ldap['system_adjective']``
   A descriptive name for the login system that is displayed to users in the Chef server management console. If a value like "corporate" is used, then the Chef management console user interface will display strings like "the corporate login server", "corporate login", or "corporate password." Default value: ``AD/LDAP``.

   .. warning:: This setting is **not** used by the Chef server. It is used only by the Chef management console.

``ldap['timeout']``
   The amount of time (in seconds) to wait before timing out. Default value: ``60000``.

``ldap['tls_enabled']``
   Enable TLS. When enabled, communication with the LDAP server is done via a secure SSL connection on a dedicated port. When ``true``, ``ldap['port']`` is also set to ``636``. Default value: ``false``. Must be ``false`` when ``ldap['ssl_enabled']`` is ``true``.

   .. note:: Previous versions of the Chef server used the ``ldap['ssl_enabled']`` setting to first enable SSL, and then the ``ldap['encryption']`` setting to specify the encryption type. These settings are deprecated.

.. end_tag

nginx
-----------------------------------------------------
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

``nginx['enable_stub_status']``
   Enables the Nginx ``stub_status`` module. See ``nginx['stub_status']['allow_list']``, ``nginx['stub_status']['listen_host']``, ``nginx['stub_status']['listen_port']``, and ``nginx['stub_status']['location']``. Default value: ``true``.

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

``nginx['log_x_forwarded_for']``
  Log $http_x_forwarded_for ("X-Forwarded-For") instead of $remote_addr if ``true``.  Default value ``false``.

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

``nginx['stub_status']['allow_list']``
   The IP address on which accessing the ``stub_status`` endpoint is allowed. Default value: ``["127.0.0.1"]``.

``nginx['stub_status']['listen_host']``
   The host on which the Nginx ``stub_status`` module listens. Default value: ``"127.0.0.1"``.

``nginx['stub_status']['listen_port']``
   The port on which the Nginx ``stub_status`` module listens. Default value: ``"9999"``.

``nginx['stub_status']['location']``
   The name of the Nginx ``stub_status`` endpoint used to access data generated by the Nginx ``stub_status`` module. Default value: ``"/nginx_status"``.

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

oc_bifrost
-----------------------------------------------------
.. tag server_services_bifrost

The **oc_bifrost** service ensures that every request to view or manage objects stored on the Chef server is authorized.

.. end_tag

This configuration file has the following settings for ``oc_bifrost``:

``oc_bifrost['db_pool_size']``
   The number of open connections to PostgreSQL that are maintained by the service. This value should be increased if failures indicate that the **oc_bifrost** service ran out of connections. This value should be tuned in conjunction with the ``postgresql['max_connections']`` setting for PostgreSQL. Default value: ``20``.

``oc_bifrost['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/opscode/oc_bifrost``.

``oc_bifrost['enable']``
   Enable a service. Default value: ``true``.

``oc_bifrost['extended_perf_log']``
   Default value: ``true``.

``oc_bifrost['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``.

``oc_bifrost['listen']``
   The IP address on which the service is to listen. Default value: ``'127.0.0.1'``.

``oc_bifrost['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``/var/log/opscode/oc_bifrost``.

``oc_bifrost['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``oc_bifrost['port']``
   The port on which the service is to listen. Default value: ``9463``.

``oc_bifrost['sql_password']``
   The password for the ``sql_user``. Default value: ``'challengeaccepted'``.

``oc_bifrost['sql_ro_password']``
   The password for the ``sql_ro_user``. Default value: ``'foreveralone'``.

``oc_bifrost['sql_ro_user']``
   Default value: ``'bifrost_ro'``.

``oc_bifrost['sql_user']``
   The user with permission to publish data. Default value: ``'bifrost'``.

``oc_bifrost['superuser_id']``
   Default value: ``'5ca1ab1ef005ba111abe11eddecafbad'``.

``oc_bifrost['vip']``
   The virtual IP address. Default value: ``'127.0.0.1'``.

oc_chef_authz
-----------------------------------------------------
.. tag server_services_authz

The **opscode-authz** service is used to handle authorization requests to the Chef server.

.. end_tag

.. tag config_rb_server_settings_oc_chef_authz

This configuration file has the following settings for ``oc_chef_authz``:

``oc_chef_authz['http_cull_interval']``
   Default value: ``'{1, min}'``.

``oc_chef_authz['http_init_count']``
   Default value: ``25``.

``oc_chef_authz['http_max_age']``
   Default value: ``'{70, sec}'``.

``oc_chef_authz['http_max_connection_duration']``
   Default value: ``'{70, sec}'``.

``oc_chef_authz['http_max_count']``
   Default value: ``100``.

``oc_chef_authz['ibrowse_options']``
   The amount of time (in milliseconds) to wait for a connection to be established. Default value: ``'[{connect_timeout, 5000}]'``.

.. end_tag

oc-chef-pedant
-----------------------------------------------------
This configuration file has the following settings for ``oc-chef-pedant``:

``oc_chef_pedant['debug_org_creation']``
   Run tests with full output. Default value: ``false``.

``oc_chef_pedant['dir']``
   The working directory. The default value is the recommended value. Default value:

   .. code-block:: ruby

      '/var/opt/opscode/oc-chef-pedant'

``oc_chef_pedant['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value:

   .. code-block:: ruby

      '/var/log/opscode/oc-chef-pedant'

``oc_chef_pedant['log_http_requests']``
   Log HTTP requests in a file named ``http-traffic.log`` that is located in the path specified by ``log_directory``. Default value: ``true``.

``oc_chef_pedant['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

oc-id
-----------------------------------------------------
.. tag server_services_oc_id

The **oc-id** service enables OAuth 2.0 authentication to the Chef server by external applications, including Chef Supermarket and Chef Analytics. OAuth 2.0 uses token-based authentication, where external applications use tokens that are issued by the **oc-id** provider. No special credentials---``webui_priv.pem`` or privileged keys---are stored on the external application.

.. end_tag

This configuration file has the following settings for ``oc-id``:

``oc_id['administrators']``
   An array of Chef server user names who may add applications to the identity service. For example, ``['user1', 'user2']``. Default value: ``[ ]``.

``oc_id['applications']``
   A Hash that contains OAuth 2 application information. Default value: ``{ }``.

   .. tag config_ocid_application_hash_supermarket

   To define OAuth 2 information for Chef Supermarket, create a Hash similar to:

      .. code-block:: ruby

         oc_id['applications'] ||= {}
         oc_id['applications']['supermarket'] = {
           'redirect_uri' => 'https://supermarket.mycompany.com/auth/chef_oauth2/callback'
         }

   .. end_tag

   To define OAuth 2 information for Chef Analytics, create a Hash similar to:

      .. code-block:: ruby

         oc_id['applications'] ||= {}
         oc_id['applications']['analytics'] = {
           'redirect_uri' => 'https://analytics.rhel.aws'
         }

``oc_id['db_pool_size']``
   The number of open connections to PostgreSQL that are maintained by the service. Default value: ``'20'``.

``oc_id['dir']``
   The working directory. The default value is the recommended value. Default value: none.

``oc_id['enable']``
   Enable a service. Default value: ``true``.

``oc_id['email_from_address']``
   New in Chef server 12.12.

   Outbound email address. Defaults to the ``'from_email'`` value.

``oc_id['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``oc_id['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``'/var/opt/opscode/oc_id'``.

``oc_id['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``oc_id['origin']``
   New in Chef server 12.12.

   The FQDN for the server that is sending outbound email. Defaults to the ``'api_fqdn'`` value, which is the FQDN for the Chef server.

``oc_id['num_to_keep']``
   The number of log files to keep. Default value: ``10``.

``oc_id['port']``
   The port on which the service is to listen. Default value: ``9090``.

``oc_id['sql_database']``
   The name of the database. Default value: ``oc_id``.

``oc_id['sql_password']``
   The password for the ``sql_user``. Default value: ``snakepliskin``.

``oc_id['sql_user']``
   The user with permission to write to ``sql_database``. Default value: ``oc_id``.

``oc_id['vip']``
   The virtual IP address. Default value: ``'127.0.0.1'``.

opscode-chef-mover
-----------------------------------------------------
This configuration file has the following settings for ``opscode-chef-mover``:

``opscode_chef_mover['bulk_fetch_batch_size']``
   Default value: ``'5'``.

``opscode_chef_mover['cache_ttl']``
   Default value: ``'3600'``.

``opscode_chef_mover['db_pool_size']``
   The number of open connections to PostgreSQL that are maintained by the service. Default value: ``'5'``.

``opscode_chef_mover['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value:

   .. code-block:: ruby

      '/var/opt/opscode/opscode-chef-mover/data'

``opscode_chef_mover['dir']``
   The working directory. The default value is the recommended value. Default value:

   .. code-block:: ruby

      '/var/opt/opscode/opscode-chef-mover'

``opscode_chef_mover['enable']``
   Enable a service. Default value: ``true``.

``opscode_chef_mover['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``opscode_chef_mover['ibrowse_max_pipeline_size']``
   Default value: ``1``.

``opscode_chef_mover['ibrowse_max_sessions']``
   Default value: ``256``.

``opscode_chef_mover['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value:

   .. code-block:: ruby

      '/var/log/opscode/opscode-chef-mover'

``opscode_chef_mover['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``opscode_chef_mover['max_cache_size']``
   Default value: ``'10000'``.

``opscode_chef_mover['solr_http_cull_interval']``
   Default value: ``'{1, min}'``.

``opscode_chef_mover['solr_http_init_count']``
   Default value: ``25``.

``opscode_chef_mover['solr_http_max_age']``
   Default value: ``'{70, sec}'``.

``opscode_chef_mover['solr_http_max_connection_duration']``
   Default value: ``'{70, sec}'``.

``opscode_chef_mover['solr_http_max_count']``
   Default value: ``100``.

``opscode_chef_mover['solr_ibrowse_options']``
   Default value: ``'[{connect_timeout, 10000}]'``.

``opscode_chef_mover['solr_timeout']``
   Default value: ``30000``.

opscode-erchef
-----------------------------------------------------
.. tag server_services_erchef

The **opscode-erchef** service is an Erlang-based service that is used to handle Chef server API requests to the following areas within the Chef server:

* Cookbooks
* Data bags
* Environments
* Nodes
* Roles
* Sandboxes
* Search

.. end_tag

This configuration file has the following settings for ``opscode-erchef``:

``opscode_erchef['auth_skew']``
   Default value: ``900``.

``opscode_erchef['authz_fanout']``
   Default value: ``20``.

``opscode_erchef['authz_timeout']``
   The amount of time (in seconds) before a request to the **oc_bifrost** service times out. Default value: ``2000``.

``opscode_erchef['base_resource_url']``
   The base URL to which the service is to return links to API resources. Use ``:host_header`` to ensure the URL is derived from the host header of the incoming HTTP request. Default value: ``:host_header``.

``opscode_erchef['bulk_fetch_batch_size']``
   The number of nodes that may be deserialized. Currently only applies to the ``/search`` endpoint in the Chef server API. The default value is the recommended value. Default value: ``5``.

``opscode_erchef['cache_ttl']``
   Default value: ``3600``.

``opscode_erchef['cleanup_batch_size']``
   Default value: ``0``.

``opscode_erchef['couchdb_max_conn']``
   Default value: ``'100'``.

``opscode_erchef['db_pool_size']``
   The number of open connections to PostgreSQL that are maintained by the service. Default value: ``20``.

``opscode_erchef['depsolver_timeout']``
   The amount of time (in milliseconds) to wait for cookbook dependency problems to be solved. Default value: ``'5000'``.

``opscode_erchef['depsolver_worker_count']``
   The number of Ruby processes for which cookbook dependency problems are unsolved. Use the ``pgrep -fl depselector`` command to verify the number of depsolver workers that are running. If you are seeing 503 service unavailable errors, increase this value. Default value: ``'5'``.

``opscode_erchef['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/opscode/opscode-erchef``.

``opscode_erchef['enable']``
   Enable a service. Default value: ``true``.

``opscode_erchef['enable_actionlog']``
   Use to enable Chef actions, a premium feature of the Chef server. Default value: ``false``.

``opscode_erchef['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``opscode_erchef['ibrowse_max_pipeline_size']``
   Default value: ``1``.

``opscode_erchef['ibrowse_max_sessions']``
   Default value: ``256``.

``opscode_erchef['listen']``
   The IP address on which the service is to listen. Default value: ``127.0.0.1``.

``opscode_erchef['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``/var/log/opscode/opscode-erchef``.

``opscode_erchef['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``opscode_erchef['max_cache_size']``
   Default value: ``10000``.

``opscode_erchef['max_request_size']``
   Default value: ``1000000``.

``opscode_erchef['nginx_bookshelf_caching']``
   Whether Nginx is used to cache cookbooks. When ``:on``, Nginx serves up the cached content instead of forwarding the request. Default value: ``:off``.

``opscode_erchef['port']``
   The port on which the service is to listen. Default value: ``8000``.

``opscode_erchef['reindex_batch_size']``
  The number of items to fetch from the database and send to the search index at a time. Default value: ``10``.

``opscode_erchef['reindex_sleep_min_ms']``
  The minimum number of milliseconds to sleep before retrying a failed attempt to index an item. Retries are delayed a random number of miliseconds between ``reindex_sleep_min_ms`` and ``reindex_sleep_max_ms``. Set both this and ``reindex_sleep_max_ms`` to 0 to retry without delay. Default value: ``500``

``opscode_erchef['reindex_sleep_max_ms']``
  The maximum number of milliseconds to sleep before retrying a failed attempt to index an item. Retries are delayed a random number of miliseconds between ``reindex_sleep_min_ms`` and ``reindex_sleep_max_ms``. Set both this and ``reindex_sleep_min_ms`` to 0 to retry without delay. Default value: ``2000``

``opscode_erchef['reindex_item_retries']``
  The number of times to retry sending an object for indexing in the case of failure. Default value: ``3``

``opscode_erchef['root_metric_key']``
   Default value: ``chefAPI``.

``opscode_erchef['s3_bucket']``
   The name of the Amazon Simple Storage Service (S3) bucket. (This is configurable and may be pointed at external storage locations, such as Amazon EC2. Four settings require configuration when pointing at an external cookbook storage location: ``bookshelf['vip']``, for the endpoint used by the chef-client; ``bookshelf['external_url']``, for the endpoint used by the Chef server; ``bookshelf['access_key_id']``, for user access key; ``bookshelf['secret_access_key']``, for secret key; and ``opscode_erchef['s3_bucket']``, for the bucket name. Reconfigure the Chef server after changing these settings. Default value: ``bookshelf``.

``opscode_erchef['s3_parallel_ops_fanout']``
   Default value: ``20``.

``opscode_erchef['s3_parallel_ops_timeout']``
   Default value: ``5000``.

``opscode_erchef['s3_url_expiry_window_size']``
   The frequency at which unique URLs are generated. This value may be a specific amount of time, i.e. ``15m`` (fifteen minutes) or a percentage of the value of ``s3_url_ttl``, i.e. ``10%``. Default value: ``:off``.

``opscode_erchef['s3_url_ttl']``
   The amount of time (in seconds) before connections to the server expire. If node bootstraps are timing out, increase this setting. Default value: ``28800``.

``opscode_erchef['strict_search_result_acls']``
   .. tag settings_strict_search_result_acls

   Use to specify that search results only return objects to which an actor (user, client, etc.) has read access, as determined by ACL settings. This affects all searches. When ``true``, the performance of the Chef management console may increase because it enables the Chef management console to skip redundant ACL checks. To ensure the Chef management console is configured properly, after this setting has been applied with a ``chef-server-ctl reconfigure`` run ``chef-manage-ctl reconfigure`` to ensure the Chef management console also picks up the setting. Default value: ``false``.

   .. warning:: When ``true``, ``opscode_erchef['strict_search_result_acls']`` affects all search results and any actor (user, client, etc.) that does not have read access to a search result will not be able to view it. For example, this could affect search results returned during chef-client runs if a chef-client does not have permission to read the information.

   .. end_tag

``opscode_erchef['udp_socket_pool_size']``
   Default value: ``20``.

``opscode_erchef['umask']``
   Default value: ``0022``.

``opscode_erchef['validation_client_name']``
   Default value: ``chef-validator``.

``opscode_erchef['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.

opscode-expander
-----------------------------------------------------
.. tag server_services_expander

The **opscode-expander** service is used to process data (pulled from the **rabbitmq** service's message queue) so that it can be properly indexed by the **opscode-solr4** service.

.. end_tag

This configuration file has the following settings for ``opscode-expander``:

``opscode_expander['consumer_id']``
   The identity of the consumer to which messages are published. Default value: ``default``.

``opscode_expander['dir']``
   The working directory. The default value is the recommended value. Default value:

   .. code-block:: ruby

      /var/opt/opscode/opscode-expander

``opscode_expander['enable']``
   Enable a service. Default value: ``true``.

``opscode_expander['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``opscode_expander['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value:

   .. code-block:: ruby

      /var/log/opscode/opscode-expander

``opscode_expander['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``opscode_expander['nodes']``
   The number of allowed worker processes. Default value: ``2``.

``opscode_expander['reindexer_log_directory']``
   The directory in which ``opscode-expander-reindexer`` logs files are located. Default value:

   .. code-block:: ruby

      /var/log/opscode/opscode-expander-reindexer

opscode-solr4
-----------------------------------------------------
.. tag server_services_solr4

The **opscode-solr4** service is used to create the search indexes used for searching objects like nodes, data bags, and cookbooks. (This service ensures timely search results via the Chef server API; data that is used by the Chef platform is stored in PostgreSQL.)

.. end_tag

This configuration file has the following settings for ``opscode-solr4``:

``opscode_solr4['auto_soft_commit']``
   The maximum number of documents before a soft commit is triggered. Default value: ``1000``.

``opscode_solr4['commit_interval']``
   The frequency (in seconds) at which node objects are added to the Apache Solr search index. This value should be tuned carefully. When data is committed to the Apache Solr index, all incoming updates are blocked. If the duration between updates is too short, it is possible for the rate at which updates are asked to occur to be faster than the rate at which objects can be actually committed. Default value: ``60000`` (every 60 seconds).

``opscode_solr4['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value:

   .. code-block:: ruby

      /var/opt/opscode/opscode-solr4/data

``opscode_solr4['dir']``
   The working directory. The default value is the recommended value. Default value:

   .. code-block:: ruby

      /var/opt/opscode/opscode-solr4

``opscode_solr4['enable']``
   Enable a service. Default value: ``true``.

``opscode_solr4['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``opscode_solr4['heap_size']``
   The amount of memory (in MBs) available to Apache Solr. If there is not enough memory available, search queries made by nodes to Apache Solr may fail. The amount of memory that must be available also depends on the number of nodes in the organization, the frequency of search queries, and other characteristics that are unique to each organization. In general, as the number of nodes increases, so does the amount of memory. The default value should work for many organizations with fewer than 25 nodes. For an organization with several hundred nodes, the amount of memory that is required often exceeds 3GB. Default value: ``nil``, which is equivalent to 25% of the system memory or 1024 (MB, but this setting is specified as an integer number of MB in EC11), whichever is smaller.

``opscode_solr4['ip_address']``
   The IP address for the machine on which Apache Solr is running. Default value: ``127.0.0.1``.

``opscode_solr4['java_opts']``
   A Hash of ``JAVA_OPTS`` environment variables to be set. (``-XX:NewSize`` is configured using the ``new_size`` setting.) Default value: ``' '`` (empty).

``opscode_solr4['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value:

   .. code-block:: ruby

      /var/log/opscode/opscode-solr4

``opscode_solr4['log_gc']``
   New in Chef server 12.12.

   Enable or disable GC logging. Default is ``true``.

``opscode_solr4['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``opscode_solr4['max_commit_docs']``
   The frequency (in documents) at which node objects are added to the Apache Solr search index. This value should be tuned carefully.  When data is committed to the Apache Solr index, all incoming updates are blocked. If the duration between updates is too short, it is possible for the rate at which updates are asked to occur to be faster than the rate at which objects can be actually committed. Default value: ``1000`` (every 1000 documents).

``opscode_solr4['max_field_length']``
   The maximum field length (in number of tokens/terms). If a field length exceeds this value, Apache Solr may not be able to complete building the index. Default value: ``100000`` (increased from the Apache Solr default value of ``10000``).

``opscode_solr4['max_merge_docs']``
   The maximum number of index segments allowed before they are merged into a single index. Default value: ``2147483647``.

``opscode_solr4['merge_factor']``
   The maximum number of document updates that can be stored in memory before being flushed and added to the current index segment. Default value: ``15``.

``opscode_solr4['new_size']``
   Configure the ``-XX:NewSize`` ``JAVA_OPTS`` environment variable. Default value: ``nil``.

``opscode_solr4['poll_seconds']``
   The frequency (in seconds) at which the secondary machine polls the primary. Default value: ``20``.

``opscode_solr4['port']``
   The port on which the service is to listen. Default value: ``8983``.

``opscode_solr4['ram_buffer_size']``
   The size (in megabytes) of the RAM buffer. When document updates exceed this amout, pending updates are flushed. Default value: ``100``.

``opscode_solr4['url']``
   Default value: ``'http://localhost:8983/solr'``.

``opscode_solr4['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.

postgresql
-----------------------------------------------------
.. tag server_services_postgresql

The **postgresql** service is used to store node, object, and user data.

.. end_tag

This configuration file has the following settings for ``postgresql``:

``postgresql['checkpoint_completion_target']``
   A completion percentage that is used to determine how quickly a checkpoint should finish in relation to the completion status of the next checkpoint. For example, if the value is ``0.5``, then a checkpoint attempts to finish before 50% of the next checkpoint is done. Default value: ``0.5``.

``postgresql['checkpoint_segments']``
   The maximum amount (in megabytes) between checkpoints in log file segments. Default value: ``3``.

``postgresql['checkpoint_timeout']``
   The amount of time (in minutes) between checkpoints. Default value: ``5min``.

``postgresql['checkpoint_warning']``
   The frequency (in seconds) at which messages are sent to the server log files if checkpoint segments are being filled faster than their currently configured values. Default value: ``30s``.

``postgresql['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value: ``/var/opt/opscode/postgresql/#{node['private_chef']['postgresql']['version']}/data``.

``postgresql['db_superuser']``
   Default value: ``opscode-pgsql``. If ``username`` is set, set ``db_superuser`` to the same value.

``postgresql['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/opscode/postgresql/#{node['private_chef']['postgresql']['version']}``.

``postgresql['effective_cache_size']``
   The size of the disk cache that is used for data files. Default value: 50% of available RAM.

``postgresql['enable']``
   Enable a service. Default value: ``true``.

``postgresql['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``postgresql['home']``
   The home directory for PostgreSQL. Default value: ``/var/opt/opscode/postgresql``.

``postgresql['keepalives_count']``
   The maximum number of keepalive proves that should be sent before dropping a connection. Default value: ``2``.

``postgresql['keepalives_idle']``
   The amount of time (in seconds) a connection must remain idle before keepalive probes will resume. Default value: ``60``.

``postgresql['keepalives_interval']``
   The amount of time (in seconds) between probes. Default value: ``15``.

``postgresql['listen_address']``
   The connection source to which PostgreSQL is to respond. Default value: ``localhost``.

``postgresql['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``/var/log/opscode/postgresql/#{node['private_chef']['postgresql']['version']}``.

``postgresql['log_min_duration_statement']``
   When to log a slow PostgreSQL query statement. Possible values: ``-1`` (disabled, do not log any statements), ``0`` (log every statement), or an integer greater than zero. When the integer is greater than zero, this value is the amount of time (in milliseconds) that a query statement must have run before it is logged. Default value: ``-1``.

``postgresql['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``postgresql['max_connections']``
   The maximum number of allowed concurrent connections. Default value: ``350``.

``postgresql['md5_auth_cidr_addresses']``
   Use instead of ``trust_auth_cidr_addresses`` to encrypt passwords using MD5 hashes. Default value: ``[ '127.0.0.1/32', '::1/128' ]``.

``postgresql['port']``
   The port on which the service is to listen. Default value: ``5432``.

``postgresql['shared_buffers']``
   The amount of memory that is dedicated to PostgreSQL for data caching. Default value: ``#{(node['memory']['total'].to_i / 4) / (1024)}MB``.

``postgresql['shell']``
   Default value: ``/bin/sh``.

``postgresql['shmall']``
   The total amount of available shared memory. Default value: ``4194304``.

``postgresql['shmmax']``
   The maximum amount of shared memory. Default value: ``17179869184``.

``postgresql['sql_password']``
   The password for the PostgreSQL user account. Default value: ``snakepliskin``.

``postgresql['sql_ro_password']``
   Default value: ``shmunzeltazzen``.

``postgresql['sql_ro_user']``
   Default value: ``opscode_chef_ro``.

``postgresql['sql_user']``
   Default value: ``opscode_chef``.

``postgresql['trust_auth_cidr_addresses']``
   Use for clear-text passwords. See ``md5_auth_cidr_addresses``. Default value: ``'127.0.0.1/32', '::1/128'``.

``postgresql['user_path']``
   Default value: ``/opt/opscode/embedded/bin:/opt/opscode/bin:$PATH``.

``postgresql['username']``
   The PostgreSQL account user name. Default value: ``opscode-pgsql``. If setting this value, must set ``db_superuser`` to the same value.

``postgresql['version']``
   The (currently) hardcoded version of PostgreSQL. Default value: ``'9.2'``.

``postgresql['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.

``postgresql['work_mem']``
   The size (in megabytes) of allowed in-memory sorting. Default value: ``8MB``.

rabbitmq
-----------------------------------------------------
.. tag server_services_rabbitmq

The **rabbitmq** service is used to provide the message queue that is used by the Chef server to get search data to Apache Solr so that it can be indexed for search. When Chef Analytics is confiugred, the **rabbitmq** service is also used to send data from the Chef server to the Chef Analytics server.

.. end_tag

This configuration file has the following settings for ``rabbitmq``:

``rabbitmq['actions_exchange']``
   The name of the exchange to which Chef actions publishes actions data. Default value: ``'actions'``.

``rabbitmq['actions_password']``
   The password for the ``actions_user``. Default value: ``'changeme'``.

``rabbitmq['actions_user']``
   The user with permission to publish actions data. Default value: ``'actions'``.

``rabbitmq['actions_vhost']``
   The virtual host to which Chef actions publishes actions data. Default value: ``'/analytics'``.

``rabbitmq['analytics_max_length']``
   The maximum number of messages that can be queued before RabbitMQ automatically drops messages from the front of the queue to make room for new messages. Default value: ``10000``.

``rabbitmq['consumer_id']``
   The identity of the consumer to which messages are published. Default value: ``'hotsauce'``.

``rabbitmq['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value: ``'/var/opt/opscode/rabbitmq/db'``.

``rabbitmq['dir']``
   The working directory. The default value is the recommended value. Default value: ``'/var/opt/opscode/rabbitmq'``.

``rabbitmq['drop_on_full_capacity']``
   Specify if messages will stop being sent to the RabbitMQ queue when it is at capacity. Default value: ``true``.

``rabbitmq['enable']``
   Enable a service. Default value: ``true``.

``rabbitmq['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``rabbitmq['jobs_password']``
   Default value: ``'workcomplete'``.

``rabbitmq['jobs_user']``
   Default value: ``'jobs'``.

``rabbitmq['jobs_vhost']``
   Default value: ``'/jobs'``.

``rabbitmq['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``'/var/log/opscode/rabbitmq'``.

``rabbitmq['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``rabbitmq['management_enabled']``
   Specify if the rabbitmq-management plugin is enabled. Default value: ``true``.

``rabbitmq['management_password']``
   The rabbitmq-management plugin password. Default value: ``'chefrocks'``.

``rabbitmq['management_port']``
   The rabbitmq-management plugin port. Default value: ``15672``.

``rabbitmq['management_user']``
   The rabbitmq-management plugin user. Default value: ``'rabbitmgmt'``.

``rabbitmq['node_ip_address']``
   The bind IP address for RabbitMQ. Default value: ``'127.0.0.1'``.

   Chef Analytics uses the same RabbitMQ service that is configured on the Chef server. When the Chef Analytics server is configured as a standalone server, the default settings for ``rabbitmq['node_ip_address']`` and ``rabbitmq['vip']`` must be updated. When the Chef Analytics server is configured as a standalone server, change this value to ``0.0.0.0``.

``rabbitmq['node_port']``
   The port on which the service is to listen. Default value: ``'5672'``.

``rabbitmq['nodename']``
   The name of the node. Default value: ``'rabbit@localhost'``.

``rabbitmq['password']``
   The password for the RabbitMQ user. Default value: ``'chefrocks'``.

``rabbitmq['prevent_erchef_startup_on_full_capacity']``
   Specify if the Chef server will start when the monitored RabbitMQ queue is full. Default value: ``false``.

``rabbitmq['queue_at_capacity_affects_overall_status']``
   Specify if the ``_status`` endpoint in the Chef server API will fail if the monitored queue is at capacity. Default value: ``false``.

``rabbitmq['queue_length_monitor_enabled']``
   Specify if the queue length monitor is enabled. Default value: ``true``.

``rabbitmq['queue_length_monitor_millis']``
   The frequency (in milliseconds) at which the length of the RabbitMQ queue is checked. Default value: ``30000``.

``rabbitmq['queue_length_monitor_timeout_millis']``
   The timeout (in milliseconds) at which calls to the queue length monitor will stop if the Chef server is overloaded. Default value: ``5000``.

``rabbitmq['queue_length_monitor_queue']``
   The RabbitMQ queue that is observed by queue length monitor. Default value: ``'alaska'``.

``rabbitmq['queue_length_monitor_vhost']``
   The virtual host for the RabbitMQ queue that is observed by queue length monitor. Default value: ``'/analytics'``.

``rabbitmq['rabbit_mgmt_http_cull_interval']``
   The maximum cull interval (in seconds) for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``60``.

``rabbitmq['rabbit_mgmt_http_init_count']``
   The initial worker count for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``25``.

``rabbitmq['rabbit_mgmt_http_max_age']``
   The maximum connection worker age (in seconds) for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``70``.

``rabbitmq['rabbit_mgmt_http_max_connection_duration']``
   The maximum connection duration (in seconds) for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``70``.

``rabbitmq['rabbit_mgmt_http_max_count']``
   The maximum worker count for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``100``.

``rabbitmq['rabbit_mgmt_ibrowse_options']``
   An array of comma-separated key-value pairs of ibrowse options for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``'{connect_timeout, 10000}'``.

``rabbitmq['rabbit_mgmt_timeout']``
   The timeout for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``30000``.

``rabbitmq['reindexer_vhost']``
   Default value: ``'/reindexer'``.

``rabbitmq['ssl_versions']``
   The SSL versions used by the rabbitmq-management plugin. (See also |url rabbitmqssl|.) Default value: ``['tlsv1.2', 'tlsv1.1']``.

``rabbitmq['user']``
   Default value: ``'chef'``.

``rabbitmq['vhost']``
   Default value: ``'/chef'``.

``rabbitmq['vip']``
   The virtual IP address. Default value: ``'127.0.0.1'``.

   Chef Analytics uses the same RabbitMQ service that is configured on the Chef server. When the Chef Analytics server is configured as a standalone server, the default settings for ``rabbitmq['node_ip_address']`` and ``rabbitmq['vip']`` must be updated. When the Chef Analytics server is configured as a standalone server, this value should be updated to be the backend VIP address for the Chef server.

redis_lb
-----------------------------------------------------
.. tag server_services_redis

Key-value store used in conjunction with Nginx to route requests and populate request data used by the Chef server.

.. end_tag

This configuration file has the following settings for ``redis_lb``:

``redis_lb['activerehashing']``
   Enable active rehashing. Default value: ``'no'``.

``redis_lb['aof_rewrite_min_size']``
   The minimum size of the append-only file. Only files larger than this value are rewritten. Default value: ``'16mb'``.

``redis_lb['aof_rewrite_percent']``
   The size of the current append-only file, as compared to the base size. The append-only file is rewritten when the current file exceeds the base size by this value. Default value: ``'50'``.

``redis_lb['appendfsync']``
   The frequency at which the operating system writes data on-disk, instead of waiting for more data. Possible values: ``no`` (don't fsync, let operating system flush data), ``always`` (fsync after every write to the append-only log file), and ``everysec`` (fsync only once time per second). Default value: ``'always'``.

``redis_lb['appendonly']``
   Dump data asynchronously on-disk or to an append-only log file. Set to ``yes`` to dump data to an append-only log file. Default value: ``'no'``.

``redis_lb['bind']``
   Bind Redis to the specified IP address. Default value: ``'127.0.0.1'``.

``redis_lb['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value: ``'/var/opt/opscode/redis_lb/data'``.

``redis_lb['databases']``
   The number of databases. Default value: ``'16'``.

``redis_lb['dir']``
   The working directory. The default value is the recommended value. Default value: ``'/var/opt/opscode/redis_lb'``.

``redis_lb['enable']``
   Enable a service. Default value: ``true``.

``redis_lb['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``redis_lb['keepalive']``
   The amount of time (in seconds) to wait for requests on a connection. Default value: ``'60'``.

``redis_lb['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``'/var/log/opscode/redis_lb'``.

``redis_lb['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``redis_lb['loglevel']``
   The level of logging to be stored in a log file.. Possible values: ``debug``, ``notice``, ``verbose``, and ``warning``. Default value: ``'notice'``.

``redis_lb['maxmemory']``
   The maximum amount of memory (in bytes). Default value: ``'8m'``.

``redis_lb['maxmemory_policy']``
   The policy applied when the maximum amount of memory is reached. Possible values: ``allkeys-lru`` (remove keys, starting with those used least frequently), ``allkeys-random`` (remove keys randomly), ``noeviction`` (don't expire, return an error on write operation), ``volatile-lru`` (remove expired keys, starting with those used least frequently), ``volatile-random`` (remove expired keys randomly), and ``volatile-ttl`` (remove keys, starting with nearest expired time). Default value: ``'noeviction'``.

``redis_lb['port']``
   The port on which the service is to listen. Default value: ``'16379'``.

``redis_lb['save_frequency']``
   Set the save frequency. Pattern: ``{ "seconds" => "keys", "seconds" => "keys", "seconds" => "keys" }``. Default value:

   .. code-block:: ruby

      { '900' => '1', '300' => '10', '60' => '1000' }

   Which saves the database every 15 minutes if at least one key changes, every 5 minutes if at least 10 keys change, and every 60 seconds if 10000 keys change.

``redis_lb['timeout']``
   The amount of time (in seconds) a client may be idle before timeout. Default value: ``'300'``.

``redis_lb['vip']``
   The virtual IP address. Default value: ``'127.0.0.1'``.

upgrades
-----------------------------------------------------
This configuration file has the following settings for ``upgrades``:

``upgrades['dir']``
   The working directory. The default value is the recommended value. Default value: ``'/var/opt/opscode/upgrades'``.

user
-----------------------------------------------------
This configuration file has the following settings for ``user``:

``user['home']``
   The home directory for the user under which Chef server services run. Default value: ``/opt/opscode/embedded``.

``user['shell']``
   The shell for the user under which Chef server services run. Default value: ``/bin/sh``.

``user['username']``
   The user name under which Chef server services run. Default value: ``opscode``.
