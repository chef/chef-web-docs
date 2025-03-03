+++
title = "chef-server.rb Optional Settings"
draft = false
gh_repo = "chef-server"

[menu]
  [menu.server]
    title = "Chef Infra Server Optional Settings"
    identifier = "server/configure/Chef Infra Server Optional Settings"
    parent = "server/configure"
    weight = 20
+++

{{< readfile file="content/server/reusable/md/config_rb_server_summary.md" >}}

## Settings

The following sections describe the various settings that are available
in the chef-server.rb file.

{{< note >}}
{{< readfile file="content/server/reusable/md/notes_config_rb_server_must_reconfigure.md" >}}
{{< /note >}}

### General

This configuration file has the following general settings:

`addons['install']`

:   Default value: `false`.

`addons['path']`

:   Default value: `nil`.

`addons['packages']`

:   Default value: `%w{chef-manage}`

`api_version`

:   The version of the Chef Infra Server.

    Default value: `'12.0.0'`.

`default_orgname`

:   The `ORG_NAME` part of the `/organizations` endpoint in Chef Infra
    Server.

`flavor`

:   Default value: `'cs'`.

    Setting new in Chef Infra Server 14.

`fips`

:   Set to `true` to run the server in FIPS compliance mode. Set to
    `false` to force the server to run without FIPS compliance mode.

    Default value: The value in the kernel configuration.

    {{< note >}}

    Chef Infra Server versions earlier than 14.5 configured with `nginx['enable_non_ssl'] = false` and `fips = true` require `export CSC_LB_URL=https://127.0.0.1` to run the command `chef-server-ctl reindex <options>`

    {{< /note >}}

`insecure_addon_compat`

:   Set to `true` to keep Chef Infra Server compatible with older add-on
    versions by rendering secrets and credentials to
    `/etc/opscode/chef-server-running.json` and other files in
    `/etc/opscode/`. When set to `false`, secrets are **only** written
    to `/etc/opscode/private-chef-secrets.json` and **not** to any other
    files.

    Default value: `true`.

    See [Add-on Compatibility]({{< relref "/server/server_security#add-on-compatibility" >}}) for the
    minimum add-on versions supporting `insecure_addon_compat false`.

`install_path`

:   The directory in which the Chef Infra Server is installed.

    Default value: `'/opt/opscode'`.

`from_email`

:   The email address from which invitations to the Chef management
    console are sent.

    Default value: `'"Opscode" <donotreply@chef.io>'`.

`license['nodes']`

:   The number of licensed nodes.

    Default value: `25`.

`license['upgrade_url']`

:   The URL to visit for more information about how to update the number
    of nodes licensed for an organization.

    Default value: `'https://www.chef.io/pricing'`.

`notification_email`

:   The email addressed to which email notifications are sent.

    Default value: `'pc-default@chef.io'`.

`role`

:   The configuration type of the Chef Infra Server.

    Possible values: `backend`, `frontend`, or `standalone`.

    Default value: `'standalone'`.

`topology`

:   The topology of the Chef Infra Server.

    Possible values: `manual`, `standalone`, and `tier`.

    Default value: `'standalone'`.

### bookshelf

{{< readfile file="content/server/reusable/md/server_services_bookshelf.md" >}}

{{< note >}}
{{< readfile file="content/server/reusable/md/notes_server_aws_cookbook_storage.md" >}}
{{< /note >}}

This configuration file has the following settings for `bookshelf`:

`bookshelf['access_key_id']`

:   Deprecated. Use `chef-server-ctl set-secret bookshelf access_key_id` from
    the [Secrets Management]({{< relref "/server/ctl_chef_server#secrets-management" >}})
    commands.

    The access key identifier. This may point at an external storage
    location, such as Amazon EC2. See [AWS external bookshelf
    settings]({{< relref "/server#aws-settings" >}}) for more information on configuring external bookshelf.

    Default value: **generated**.

`bookshelf['data_dir']`

:   The directory in which on-disk data is stored. The default value is
    the recommended value.

    Default value:     `/var/opt/opscode/bookshelf/data`.

`bookshelf['dir']`

:   The working directory. The default value is the recommended value.

    Default value: `/var/opt/opscode/bookshelf`.

`bookshelf['enable']`

:   Enable a service.

    Default value: `true`.

`bookshelf['enable_request_logging']`

:   Use to configure request logging for the bookshelf service.

    Default value: `false`.

`bookshelf['external_url']`

:   The base URL to which the service is to return links to API
    resources. Use `:host_header` to ensure the URL is derived from the
    host header of the incoming HTTP request.

    Default value: `:host_header`.

`bookshelf['listen']`

:   The IP address on which the service is to listen.

    Default value: `127.0.0.1`.

`bookshelf['log_directory']`

:   The directory in which log data is stored. The default value is the
    recommended value.

    Default value: `/var/log/opscode/bookshelf`.

`bookshelf['log_rotation']`

:   The log rotation policy for this service. Log files are rotated when
    they exceed `file_maxbytes`. The maximum number of log files in the
    rotation is defined by `num_to_keep`.

    Default value: `{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }`

`bookshelf['port']`

:   The port on which the service is to listen.

    Default value: `4321`.

`bookshelf['secret_access_key']`

:   Deprecated. Use `chef-server-ctl set-secret bookshelf secret_access_key`
    from the [Secrets Management]({{< relref "/server/ctl_chef_server#secrets-management" >}})
    commands.

    The secret key. This may point at an external storage location, such
    as Amazon EC2. See [AWS external bookshelf
    settings]({{< relref "/server#aws-settings" >}}) for
    more information on configuring external bookshelf.

    Default value: **generated**.

`bookshelf['storage_type']`

:   Determines where cookbooks are stored.

    Default value: `:filesystem`.

    In instances that require cookbooks to be stored within a SQL
    backend, such as in a high availability setup, you must set
    `storage_type` to `:sql`:

    ```ruby
    bookshelf['storage_type'] = :sql
    ```

`bookshelf['stream_download']`

:   Enable stream downloading of cookbooks. This setting (when `true`)
    typically results in improved cookbook download performance,
    especially with the memory usage of the **bookshelf** service and
    the behavior of load balancers and proxies in-between Chef Infra
    Client and the Chef Infra Server.

    Default value: `true`.

`bookshelf['sql_connection_user']`

:   The PostgreSQL user name in `'username@hostname'` format (e.g.
    `'bookshelf@my_postgresql.postgres.database.azure.com'`), where
    `username` would normally equal the value of `bookshelf['sql_user']`
    (default: `'bookshelf'`). This setting is **required** in an
    external Azure PostgreSQL database-as-a-service configuration. If
    set to `nil`, Chef Infra Server assumes that the database is not on
    Azure and the PostgreSQL connection will be made using the value
    specified in `bookshelf['sql_user']`.

    Default value: `nil`.

`bookshelf['vip']`

:   The virtual IP address. This may point at an external storage
    location, such as Amazon EC2. See [AWS external bookshelf
    settings]({{< relref "/server#aws-settings" >}}) for
    more information on configuring external bookshelf.

    Default value: `127.0.0.1`.

### bootstrap

This configuration file has the following settings for `bootstrap`:

`bootstrap['enable']`

:   Indicates whether an attempt to bootstrap the Chef Infra Server is
    made. Generally only enabled on systems that have bootstrap enabled
    via a `server` entry.

    Default value: `true`.

### compliance forwarding

The configuration file has the following settings for forwarding
`compliance` requests using the Chef Infra Server authentication system.

`profiles['root_url']`

:   If set, any properly signed requests arriving at
    `/organizations/ORGNAME/owners/OWNER/compliance` will be forwarded
    to this URL. This is expected to be a fully qualified resource, e.g.
    `http://compliance.example.org/owners/OWNER/compliance`.

### dark_launch

This configuration file has the following settings for `dark_launch`:

`dark_launch['actions']`

:   Enable Chef actions.

    Default value: `true`.

`dark_launch['add_type_and_bag_to_items']`

:   Default value: `true`.

`dark_launch['new_theme']`

:   Default value: `true`.

`dark_launch['private-chef']`

:   Default value: `true`.

`dark_launch['quick_start']`

:   Default value: `false`.

`dark_launch['reporting']`

:   Enable Reporting, which performs data collection during a Chef Infra
    Client run.

    Default value: `true`.

`dark_launch['sql_users']`

:   Default value: `true`.

### data_collector

This configuration file has the following settings for `data_collector`:

`data_collector['root_url']`

:   The fully qualified URL to the data collector server API. When
    present, it will enable the data collector in **opscode-erchef**.
    This also enables Chef Infra Server authenticated forwarding any properly
    signed requests arriving at `/organizations/ORGNAME/data-collector`
    to this URL with the data collector token appended. This is also
    target for requests authenticated and forwarded by the
    `/organizations/ORGNAME/data-collector` endpoint. For the forwarding
    to work correctly the `data_collector['token']` field must also be
    set. For example, if the data collector in Chef Automate is being
    used, the URI would look like:
    `http://my_automate_server.example.org/data-collector/v0/`.

`data_collector['proxy']`

:   If set to `true`, Chef Infra Server will proxy all requests sent to
    `/data-collector` to the configured Chef Automate
    `data_collector['root_url']`. Note that *this route* does not check
    the request signature and add the right data_collector token, but
    just proxies the Chef Automate endpoint **as-is**.

    Default value: `nil`.

`data_collector['token']`

:   Deprecated. Use `chef-server-ctl set-secret data_collector token` from
    the [Secrets Management]({{< relref "/server/ctl_chef_server#secrets-management" >}})
    commands.

    Legacy configuration for shared data collector security token. When
    configured, the token will be passed as an HTTP header named
    `x-data-collector-token` which the server can choose to accept or
    reject.

`data_collector['timeout']`

:   The amount of time (in milliseconds) before a request to the data
    collector API times out.

    Default value: `30000`.

`data_collector['http_init_count']`

:   The initial worker count for the HTTP connection pool that is used
    by the data collector.

    Default value: `25`.

`data_collector['http_max_count']`

:   The maximum worker count for the HTTP connection pool that is used
    by the data collector.

    Default value: `100`.

`data_collector['http_max_age']`

:   The maximum connection worker age (in seconds) for the HTTP
    connection pool that is used by the data collector.

    Default value: `{70, sec}`.

`data_collector['http_cull_interval']`

:   The maximum cull interval (in minutes) for the HTTP connection pool
    that is used by the data collector.

    Default value: `{1, min}`.

`data_collector['http_max_connection_duration']`

:   The maximum connection duration (in seconds) for the HTTP connection
    pool that is used by the data collector.

    Default value: `"{70, sec}"`.

`data_collector['ibrowse_options']`

:   An array of comma-separated key-value pairs of ibrowse options for
    the HTTP connection pool that is used by the data collector.

    Default value: `[{connect_timeout, 10000}]`.

`data_collector['health_check']`

:   A boolean that controls whether the data collector health is
    included in the overall health at the `_status` endpoint. When set
    to `true`, Chef Infra Server will report that healthy front end Chef
    HA cluster members have failed when the `data_collector['root_url']`
    cannot be reached. As a result, the load balancer
    will remove those members from the load balancer pool.

    Default value: `true`.

### estatsd

This configuration file has the following settings for `estatsd`:

`estatsd['dir']`

:   The working directory. The default value is the recommended value.

    Default value: `'/var/opt/opscode/estatsd'`.

`estatsd['enable']`

:   Enable a service.

    Default value: `true`.

`estatsd['log_directory']`

:   The directory in which log data is stored. The default value is the
    recommended value.

    Default value: `'/var/log/opscode/estatsd'`.

`estatsd['port']`

:   The port on which the service is to listen.

    Default value: `9466`.

`estatsd['protocol']`

:   Use to send application statistics with StatsD protocol formatting.
    Set this value to `statsd` to apply StatsD protocol formatting.

`estatsd['vip']`

:   The virtual IP address.

    Default value: `'127.0.0.1'`.

### jetty

This configuration file has the following settings for `jetty`:

`jetty['enable']`

:   **Setting EOL in Chef Infra Server 14.**

    Enable a service. This value should not be modified.

    Default value: `'false'`

`jetty['log_directory']`

:   **Setting EOL in Chef Infra Server 14.**

    The directory in which log data is stored. The default value is the
    recommended value.

    Default value: `'/var/opt/opscode/opscode-solr4/jetty/logs'`

### lb / lb_internal

This configuration file has the following settings for `lb`:

`lb['api_fqdn']`

:   The FQDN for the Chef Infra Server. FQDNs must always be in lowercase.

    Default value: `node['fqdn']`.

`lb['ban_refresh_interval']`

:   Default value: `600`.

`lb['bookshelf']`

:   Default value: `127.0.0.1`.

`lb['cache_cookbook_files']`

:   Default value: `false`.

`lb['chef_max_version']`

:   The maximum version of Chef Infra Client that is allowed to access
    the Chef Infra Server via the Chef Infra Server API.

    Default value: `11`.

`lb['chef_min_version']`

:   The minimum version of Chef Infra Client that is allowed to access
    the Chef Infra Server via the Chef Infra Server API.

    Default value: `10`.

`lb['chef_server_webui']`

:   Default value: `127.0.0.1`.

`lb['debug']`

:   Default value: `false`.

`lb['enable']`

:   Enable a service.

    Default value: `true`.

`lb['erchef']`

:   Default value: `127.0.0.1`.

`lb['maint_refresh_interval']`

:   Default value: `600`.

`lb['redis_connection_pool_size']`

:   Default value: `250`.

`lb['redis_connection_timeout']`

:   The amount of time (in milliseconds) to wait before timing out.

    Default value: `1000`.

`lb['redis_keepalive_timeout']`

:   The amount of time (in milliseconds) to wait before timing out.

    Default value: `2000`.

`lb['upstream']['bookshelf']`

:   The default value is the recommended value.

    Default value: `[ '127.0.0.1' ]`.

`lb['upstream']['oc_bifrost']`

:   The default value is the recommended value.

    Default value: `[ '127.0.0.1' ]`.

`lb['upstream']['opscode_erchef']`

:   The default value is the recommended value.

    Default value: `[ '127.0.0.1' ]`.

`lb['upstream']['opscode_solr4']`

:   The default value is the recommended value.

    Default value: `[ '127.0.0.1' ]`.

`lb['vip']`

:   The virtual IP address.

    Default value: `127.0.0.1`.

`lb['web_ui_fqdn']`

:   FQDNs must always be in lowercase.

    Default value: `node['fqdn']`.

`lb['xdl_defaults']['503_mode']`

:   The default value is the recommended value.

    Default value: `false`.

`lb['xdl_defaults']['couchdb_acls']`

:   The default value is the recommended value.

    Default value: `true`.

`lb['xdl_defaults']['couchdb_association_requests']`

:   The default value is the recommended value.

    Default value: `true`.

`lb['xdl_defaults']['couchdb_associations']`

:   The default value is the recommended value.

    Default value: `true`.

`lb['xdl_defaults']['couchdb_containers']`

:   The default value is the recommended value.

    Default value: `true`.

`lb['xdl_defaults']['couchdb_groups']`

:   The default value is the recommended value.

    Default value: `true`.

`lb['xdl_defaults']['couchdb_organizations']`

:   The default value is the recommended value.

    Default value: `true`.

And for the internal load balancers:

`lb_internal['account_port']`

:   Default value: `9685`.

`lb_internal['chef_port']`

:   Default value: `9680`.

`lb_internal['enable']`

:   Default value: `true`.

`lb_internal['oc_bifrost_port']`

:   Default value: `9683`.

`lb_internal['vip']`

:   The virtual IP address.

    Default value: `'127.0.0.1'`.

### ldap

{{< warning >}}

The following settings **MUST** be in the config file for LDAP
authentication to Active Directory to work:

- `base_dn`
- `bind_dn`
- `group_dn`
- `host`

If those settings are missing, you will get authentication errors and be
unable to proceed.

{{< /warning >}}

This configuration file has the following settings for `ldap`:

`ldap['base_dn']`

:   The root LDAP node under which all other nodes exist in the
    directory structure. For Active Directory, this is typically
    `cn=users` and then the domain. For example:

    ```ruby
    'OU=Employees,OU=Domain users,DC=example,DC=com'
    ```

    Default value: `nil`.

`ldap['bind_dn']`

:   The distinguished name used to bind to the LDAP server. The user the
    Chef Infra Server will use to perform LDAP searches. This is often
    the administrator or manager user. This user needs to have read
    access to all LDAP users that require authentication. The Chef Infra
    Server must do an LDAP search before any user can log in. Many
    Active Directory and LDAP systems do not allow an anonymous bind. If
    anonymous bind is allowed, leave the `bind_dn` and `bind_password`
    settings blank. If anonymous bind is not allowed, a user with `READ`
    access to the directory is required. This user must be specified as
    an LDAP distinguished name similar to:

    ```ruby
    'CN=user,OU=Employees,OU=Domainuser,DC=example,DC=com'
    ```

    {{< note >}}

    If you need to escape characters in a distinguished name, such as
    when using Active Directory, they must be [escaped with a backslash
    escape character](https://social.technet.microsoft.com/wiki/contents/articles/5312.active-directory-characters-to-escape.aspx).

    ```ruby
    'CN=example\\user,OU=Employees,OU=Domainuser,DC=example,DC=com'
    ```

    {{< /note >}}

    Default value: `nil`.

`ldap['bind_password']`

:   Deprecated. Use `chef-server-ctl set-secret ldap bind_password` from the
    [Secrets Management](/ctl_chef_server.html#ctl-chef-server-secrets-management)
    commands.

    Legacy configuration for the password of the binding user. The
    password for the user specified by `ldap['bind_dn']`. Leave this
    value and `ldap['bind_dn']` unset if anonymous bind is sufficient.

    Default value: `nil`.

    ```bash
    chef-server-ctl set-secret ldap bind_password
    Enter ldap bind_password:    (no terminal output)
    Re-enter ldap bind_password: (no terminal output)
    ```

    Remove a set password via

    ```bash
    chef-server-ctl remove-secret ldap bind_password
    ```

`ldap['group_dn']`

:   The distinguished name for a group. When set to the distinguished
    name of a group, only members of that group can log in. This feature
    filters based on the `memberOf` attribute and only works with LDAP
    servers that provide such an attribute. In OpenLDAP, the `memberOf`
    overlay provides this attribute. For example, if the value of the
    `memberOf` attribute is `CN=abcxyz,OU=users,DC=company,DC=com`, then
    use:

    ```ruby
    ldap['group_dn'] = 'CN=abcxyz,OU=users,DC=company,DC=com'
    ```

`ldap['host']`

:   The name (or IP address) of the LDAP server. The hostname of the
    LDAP or Active Directory server. Be sure the Chef Infra Server is
    able to resolve any host names.

    Default value: `ldap-server-host`.

`ldap['login_attribute']`

:   The LDAP attribute that holds the user's login name. Use to specify
    the Chef Infra Server user name for an LDAP user.

    Default value: `sAMAccountName`.

`ldap['port']`

:   An integer that specifies the port on which the LDAP server listens.
    The default value is an appropriate value for most configurations.

    Default value: `389` or `636` when `ldap['encryption']` is set to
    `:simple_tls`.

`ldap['ssl_enabled']`

:   Cause the Chef Infra Server to connect to the LDAP server using SSL.
    Must be `false` when `ldap['tls_enabled']` is `true`.

    Default value: `false`.

    {{< note >}}

    Enable SSL for Active Directory.

    {{< /note >}}

    {{< note >}}

    Previous versions of Chef Infra Server used the
    `ldap['ssl_enabled']` setting to first enable SSL, and then the
    `ldap['encryption']` setting to specify the encryption type. These
    settings are deprecated.

    {{< /note >}}

`ldap['system_adjective']`

:   A descriptive name for the login system that is displayed to users
    in the Chef Infra Server management console. If a value like
    "corporate" is used, then the Chef management console user interface
    will display strings like "the corporate login server", "corporate
    login", or "corporate password."

    Default value: `AD/LDAP`.

    {{< warning >}}

    This setting is **not** used by the Chef Infra Server. It is used
    only by the Chef management console.

    {{< /warning >}}

`ldap['timeout']`

:   The amount of time (in seconds) to wait before timing out.

    Default value: `60000`.

`ldap['tls_enabled']`

:   Enable TLS. When enabled, communication with the LDAP server is done
    via a secure SSL connection on a dedicated port. When `true`,
    `ldap['port']` is also set to `636`. Must be `false` when `ldap['ssl_enabled']` is `true`.

    Default value: `false`.

    {{< note >}}

    Previous versions of Chef Infra Server used the
    `ldap['ssl_enabled']` setting to first enable SSL, and then the
    `ldap['encryption']` setting to specify the encryption type. These
    settings are deprecated.

    {{< /note >}}

### nginx

This configuration file has the following settings for `nginx`:

`nginx['cache_max_size']`

:   The `max_size` parameter used by the Nginx cache manager, which is
    part of the `proxy_cache_path` directive. When the size of file
    storage exceeds this value, the Nginx cache manager removes the
    least recently used data.

    Default value: `5000m`.

`nginx['client_max_body_size']`

:   The maximum accepted body size for a client request, as indicated by
    the `Content-Length` request header.

    Default value: `250m`.

`nginx['dir']`

:   The working directory. The default value is the recommended value.

    Default value: `/var/opt/opscode/nginx`.

`nginx['enable']`

:   Enable a service.

    Default value: `true`.

`nginx['enable_ipv6']`

:   Enable Internet Protocol version 6 (IPv6) addresses.

    Default value: `false`.

`nginx['enable_non_ssl']`

:   Allow port 80 redirects to port 443. Set to
    `true`, to enable SSL termination by the front-end hardware load balancers for WebUI and API endpoints.

    Default value: `false`.

{{< note   >}}
Chef Infra Server versions earlier than 14.5 configured with `nginx['enable_non_ssl'] = false` and `fips = true` require `export CSC_LB_URL=https://127.0.0.1` to run the command `chef-server-ctl reindex <options>`
{{< /note >}}

`nginx['enable_stub_status']`

:   Enables the Nginx `stub_status` module. See
    `nginx['stub_status']['allow_list']`,
    `nginx['stub_status']['listen_host']`,
    `nginx['stub_status']['listen_port']`, and
    `nginx['stub_status']['location']`.

    Default value: `true`.

`nginx['gzip']`

:   Enable gzip compression.

    Default value: `on`.

`nginx['gzip_comp_level']`

:   The compression level used with gzip, from least amount of
    compression (`1`, fastest) to the most (`2`, slowest).

    Default value: `2`.

`nginx['gzip_http_version']`

:   Enable gzip depending on the version of the HTTP request.

    Default value: `1.0`.

`nginx['gzip_proxied']`

:   The type of compression used based on the request and response.

    Default value: `any`.

`nginx['gzip_types']`

:   Enable compression for the specified MIME-types.

    Default value:

    ```ruby
    [ 'text/plain',
      'text/css',
      'application/x-javascript',
      'text/xml', 'application/xml',
      'application/xml+rss',
      'text/javascript',
      'application/json'
      ]
    ```

`nginx['hsts_max_age']`

:   Time duration in seconds till which the browser caches the `HSTS` information.

    Possible values: greater than or equal to `31536000` and less than or equal to `63072000`.

    Default value: `31536000` (1 year).

    **New in Chef Infra Server 14.3**

`nginx['keepalive_timeout']`

:   The amount of time (in seconds) to wait for requests on a HTTP
    keepalive connection.

    Default value: `65`.

`nginx['log_directory']`

:   The directory in which log data is stored. The default value is the
    recommended value.

    Default value: `/var/log/opscode/nginx`.

`nginx['log_rotation']`

:   The log rotation policy for this service. Log files are rotated when
    they exceed `file_maxbytes`. The maximum number of log files in the
    rotation is defined by `num_to_keep`.

    Default value: `{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }`

`nginx['log_x_forwarded_for']`

:   Log \$http_x_forwarded_for ("X-Forwarded-For") instead of
    \$remote_addr if `true`.

    Default value `false`.

`nginx['nginx_no_root']`

:   Whether the `nginx` processes, including the `master` process, should not
    run as the `root` user on a system and will instead run as `user['username']` (defaults to `opscode`).
    **REQUIRES** that `nginx['ssl_port']` and `nginx['non_ssl_port']` options are configured to non-privileged
    ports greater than `1024` or that the local system is otherwise allowed to bind to privileged ports
    with the user `user['username']`.

    Possible values: `true`, `false`.

    Default value: `false`.

    **New in Chef Infra Server 14.10**

`nginx['non_ssl_port']`

:   The port on which the WebUI and API are bound for non-SSL
    connections.

    Default value: `80`. Use `nginx['enable_non_ssl']` to
    enable or disable SSL redirects on this port number. Set to `false`
    to disable non-SSL connections.

`nginx['sendfile']`

:   Copy data between file descriptors when `sendfile()` is used.

    Default value: `on`.

`nginx['server_name']`

:   The FQDN for the server. FQDNs must always be in lowercase.

    Default value: `node['fqdn']`.

`nginx['ssl_certificate']`

:   The SSL certificate used to verify communication over HTTPS.

    Default value: `nil`.

`nginx['ssl_certificate_key']`

:   The certificate key used for SSL communication.

    Default value: `nil`.

`nginx['ssl_ciphers']`

:   The list of supported cipher suites that are used to establish a
    secure connection. To favor AES256 with ECDHE forward security, drop
    the `RC4-SHA:RC4-MD5:RC4:RSA` prefix. See [this
    link](https://www.openssl.org/docs/man1.1.1/man1/ciphers.html) for more
    information. For example:

    ```ruby
    nginx['ssl_ciphers'] = HIGH: ... :!PSK
    ```

`nginx['ssl_company_name']`

:   The name of your company.

    Default value: `YouCorp`.

`nginx['ssl_country_name']`

:   The country in which your company is located.

    Default value: `US`.

`nginx['ssl_email_address']`

:   The default email address for your company.

    Default value: `you@example.com`.

`nginx['ssl_locality_name']`

:   The city in which your company is located.

    Default value: `Seattle`.

`nginx['ssl_organizational_unit_name']`

:   The organization or group within your company that is running the
    Chef Infra Server.

    Default value: `Operations`.

`nginx['ssl_port']`

:   Default value: `443`.

`nginx['ssl_protocols']`

:   The SSL protocol versions that are enabled for the Chef Infra Server API.
    Starting with Chef Infra Server 14.3, this value defaults to `'TLSv1.2'` for
    enhanced security. Previous releases defaulted to `'TLSv1 TLSv1.1 TLSv1.2'`,
    which allowed for less secure SSL connections. TLS 1.2 is supported on
    Chef Infra Client 10.16.4 and later on Linux, Unix, and macOS, and on Chef
    Infra Client 12.8 and later on Windows. If it is necessary to support these older end-of-life
    Chef Infra Client releases, set this value to `'TLSv1.1 TLSv1.2'`.

    ```ruby
    nginx['ssl_protocols'] = 'TLSv1.2'
    ```

    Default value: `TLSv1.2`.

`nginx['ssl_state_name']`

:   The state, province, or region in which your company is located.

    Default value: `WA`.

`nginx['strict_host_header']`

:   Whether nginx should only respond to requests where the Host header
    matches one of the configured FQDNs.

    Default value: `false`.

`nginx['stub_status']['allow_list']`

:   The IP address on which accessing the `stub_status` endpoint is
    allowed.

    Default value: `["127.0.0.1"]`.

`nginx['stub_status']['listen_host']`

:   The host on which the Nginx `stub_status` module listens.

    Default value: `"127.0.0.1"`.

`nginx['stub_status']['listen_port']`

:   The port on which the Nginx `stub_status` module listens.

    Default value: `"9999"`.

`nginx['stub_status']['location']`

:   The name of the Nginx `stub_status` endpoint used to access data
    generated by the Nginx `stub_status` module.

    Default value: `"/nginx_status"`.

`nginx['tcp_nodelay']`

:   Enable the Nagle buffering algorithm.

    Default value: `on`.

`nginx['tcp_nopush']`

:   Enable TCP/IP transactions.

    Default value: `on`.

`nginx["time_format"]`

:   The time format of nginx `access.log`.

    **New in Chef Infra Server 14.1**

    Possible values:

    - `"time_iso8601"` (ex: [2020-10-21T07:22:00+00:00])
    - `"time_local"` (ex: [07/Jun/2018:01:05:11 +0900]).

    Default value: `"time_iso8601"`.

`nginx['url']`

:   Default value: `https://#{node['fqdn']}`.

`nginx['use_implicit_hosts']`

:   Automatically add `localhost` and any
    local IP addresses to the configured FQDNs. Useful in combination
    with `nginx['strict_host_header']`.

    Default value: `true`.

`nginx['show_welcome_page']`

:   Determines whether or not the default nginx welcome page is shown.

    Default value: `true`.

`nginx['worker_connections']`

:   The maximum number of simultaneous clients. Use with
    `nginx['worker_processes']` to determine the maximum number of
    allowed clients.

    Default value: `10240`.

`nginx['worker_processes']`

:   The number of allowed worker processes. Use with
    `nginx['worker_connections']` to determine the maximum number of
    allowed clients.

    Default value: `node['cpu']['total'].to_i`.

`nginx['x_forwarded_proto']`

:   The protocol used to connect to the server by a Chef Infra Client or a workstation.

    Possible values: `http`, `https`.

    Default value: `'https'`.

### oc_bifrost

{{< readfile file="content/server/reusable/md/server_services_bifrost.md" >}}

This configuration file has the following settings for `oc_bifrost`:

`oc_bifrost['db_pool_size']`

:   The number of open connections to PostgreSQL that are maintained by
    the service. This value should be increased if failures indicate
    that the **oc_bifrost** service ran out of connections. This value
    should be tuned in conjunction with the
    `postgresql['max_connections']` setting for PostgreSQL.

    Default value: `20`.

`oc_bifrost['dir']`

:   The working directory. The default value is the recommended value.

    Default value: `/var/opt/opscode/oc_bifrost`.

`oc_bifrost['enable']`

:   Enable a service.

    Default value: `true`.

`oc_bifrost['enable_request_logging']`

:   Use to configure request logging for the `oc_bifrost` service.

    Default value: `true`.

`oc_bifrost['extended_perf_log']`

:   Default value: `true`.

`oc_bifrost['listen']`

:   The IP address on which the service is to listen.

    Default value: `'127.0.0.1'`.

`oc_bifrost['log_directory']`

:   The directory in which log data is stored. The default value is the
    recommended value.

    Default value: `/var/log/opscode/oc_bifrost`.

`oc_bifrost['log_rotation']`

:   The log rotation policy for this service. Log files are rotated when
    they exceed `file_maxbytes`. The maximum number of log files in the
    rotation is defined by `num_to_keep`.

    Default value: `{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }`

`oc_bifrost['port']`

:   The port on which the service is to listen.

    Default value: `9463`.

`oc_bifrost['sql_connection_user']`

:   The PostgreSQL user name in `'username@hostname'` format (e.g.
    `'bifrost@my_postgresql.postgres.database.azure.com'`), where
    `username` would normally equal the value of
    `oc_bifrost['sql_user']` (default: `'bifrost'`). This setting is
    **required** in an external Azure PostgreSQL database-as-a-service
    configuration. If set to `nil`, Chef Infra Server assumes that the
    database is not on Azure and the PostgreSQL connection will be made
    using the value specified in `oc_bifrost['sql_user']`.

    Default value: `nil`.

`oc_bifrost['sql_password']`

:   The password for the `sql_user`.

    Default value: **generated**.

    To override the default value, use the [Secrets
    Management]({{< relref "/server/ctl_chef_server#secrets-management" >}})
    command: `chef-server-ctl set-secret oc_bifrost sql_password`.

`oc_bifrost['sql_ro_password']`

:   The password for the `sql_ro_user`.

    Default value: **generated**.

    To override the default value, use the [Secrets
    Management]({{< relref "/server/ctl_chef_server#secrets-management" >}})
    command: `chef-server-ctl set-secret oc_bifrost sql_ro_password`.

`oc_bifrost['sql_ro_user']`

:   Default value: `'bifrost_ro'`.

`oc_bifrost['sql_user']`

:   The user with permission to publish data.

    Default value: `'bifrost'`.

`oc_bifrost['superuser_id']`

:   Default value: **generated**.

`oc_bifrost['vip']`

:   The virtual IP address.

    Default value: `'127.0.0.1'`.

### oc_chef_authz

The **opscode-authz** service is used to handle authorization requests
from oc_erchef to oc_bifrost in the Chef Infra Server.

This configuration file has the following settings for `oc_chef_authz`:

`oc_chef_authz['http_cull_interval']`

:   Default value: `'{1, min}'`.

`oc_chef_authz['http_init_count']`

:   Default value: `25`.

`oc_chef_authz['http_max_age']`

:   Default value: `'{70, sec}'`.

`oc_chef_authz['http_max_connection_duration']`

:   Default value: `'{70, sec}'`.

`oc_chef_authz['http_max_count']`

:   Default value: `100`.

`oc_chef_authz['ibrowse_options']`

:   The amount of time (in milliseconds) to wait for a connection to be
    established.

    Default value: `'[{connect_timeout, 5000}]'`.

`oc_chef_authz['max_connection_request_limit']`

:   The maximum number of requests allowed per connection.

    Default value: `100`.

    **New in Chef Infra Client 14.11**

### oc-chef-pedant

This configuration file has the following settings for `oc-chef-pedant`:

`oc_chef_pedant['debug_org_creation']`

:   Run tests with full output.

    Default value: `false`.

`oc_chef_pedant['dir']`

:   The working directory. The default value is the recommended value.

    Default value: `'/var/opt/opscode/oc-chef-pedant'`.

`oc_chef_pedant['log_directory']`

:   The directory in which log data is stored. The default value is the
    recommended value.

    Default value: `'/var/log/opscode/oc-chef-pedant'`

`oc_chef_pedant['log_http_requests']`

:   Log HTTP requests in a file named `http-traffic.log` that is located
    in the path specified by `log_directory`.

    Default value: `true`.

`oc_chef_pedant['log_rotation']`

:   The log rotation policy for this service. Log files are rotated when
    they exceed `file_maxbytes`. The maximum number of log files in the
    rotation is defined by `num_to_keep`.

    Default value: `{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }`.

### oc-id

{{< readfile file="content/server/reusable/md/server_services_oc_id.md" >}}

This configuration file has the following settings for `oc-id`:

`oc_id['administrators']`

:   An array of Chef Infra Server user names who may add applications to
    the identity service. For example, `['user1', 'user2']`.

    Default value: `[ ]`.

`oc_id['applications']`

:   A Hash that contains OAuth 2 application information.

    Default value: `{ }`.

    {{< readfile file="content/server/reusable/md/config_ocid_application_hash_supermarket.md" >}}

`oc_id['db_pool_size']`

:   The number of open connections to PostgreSQL that are maintained by
    the service.

    Default value: `'20'`.

`oc_id['dir']`

:   The working directory. The default value is the recommended value.

    Default value: none.

`oc_id['enable']`

:   Enable a service.

    Default value: `true`.

`oc_id['email_from_address']`

:   Outbound email address.

    Defaults to the `'from_email'` value.

`oc_id['enable_onetrust']`

:   Whether to enable OneTrust cookie consent verification.

    Default value: `false`.

    **New in Chef Infra Server 15.9.20**

`oc_id['onetrust_id']`

:   The OneTrust data domain script ID for Chef Infra. You must also set `oc_id['enable_onetrust']` to `true`.

    Default value: `nil`.

    **New in Chef Infra Server 15.9.27**

`oc_id['log_directory']`

:   The directory in which log data is stored. The default value is the
    recommended value.

    Default value: `'/var/opt/opscode/oc_id'`.

`oc_id['log_rotation']`

:   The log rotation policy for this service. Log files are rotated when
    they exceed `file_maxbytes`. The maximum number of log files in the
    rotation is defined by `num_to_keep`.

    Default value: `{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }`

`oc_id['origin']`

:   The FQDN for the server that is sending outbound email. FQDNs must
    always be in lowercase.

    Defaults to the `'api_fqdn'` value, which is the FQDN for the Chef Infra Server.

`oc_id['num_to_keep']`

:   The number of log files to keep.

    Default value: `10`.

`oc_id['port']`

:   The port on which the service is to listen.

    Default value: `9090`.

`oc_id['sql_connection_user']`

:   The PostgreSQL user name in `'username@hostname'` format (e.g.
    `'oc_id@my_postgresql.postgres.database.azure.com'`), where
    `username` would normally equal the value of `oc_id['sql_user']`
    (default: `'od_id'`). This setting is **required** in an external
    Azure PostgreSQL database-as-a-service configuration. If set to
    `nil`, Chef Infra Server assumes that the database is not on Azure
    and the PostgreSQL connection will be made using the value specified
    in `oc_id['sql_user']`.

    Default value: `nil`.

`oc_id['sql_database']`

:   The name of the database.

    Default value: `oc_id`.

`oc_id['sql_password']`

:   The password for the `sql_user`.

    Default value: **generated**.

    To override the default value, use the [Secrets
    Management]({{< relref "/server/ctl_chef_server#secrets-management" >}})
    command: `chef-server-ctl set-secret oc_id sql_password`.

`oc_id['sql_user']`

:   The user with permission to write to `sql_database`.

    Default value: `oc_id`.

`oc_id['vip']`

:   The virtual IP address.

    Default value: `'127.0.0.1'`.

### opscode-chef-mover

This configuration file has the following settings for
`opscode-chef-mover`:

`opscode_chef_mover['bulk_fetch_batch_size']`

:   **Setting EOL in Chef Infra Server 14.**

    Default value: `'5'`.

`opscode_chef_mover['cache_ttl']`

:   **Setting EOL in Chef Infra Server 14.**

    Default value: `'3600'`.

`opscode_chef_mover['db_pool_size']`

:   **Setting EOL in Chef Infra Server 14.**

    The number of open connections to PostgreSQL that are maintained by
    the service.

    Default value: `'5'`.

`opscode_chef_mover['data_dir']`

:   **Setting EOL in Chef Infra Server 14.**

    The directory in which on-disk data is stored. The default value is
    the recommended value.

    Default value: `'/var/opt/opscode/opscode-chef-mover/data'`

`opscode_chef_mover['dir']`

:   **Setting EOL in Chef Infra Server 14.**

    The working directory. The default value is the recommended value.

    Default value: `'/var/opt/opscode/opscode-chef-mover'`.

`opscode_chef_mover['enable']`

:   **Setting EOL in Chef Infra Server 14.**

    Enable a service.

    Default value: `true`.

`opscode_chef_mover['ibrowse_max_pipeline_size']`

:   **Setting EOL in Chef Infra Server 14.**

    Default value: `1`.

`opscode_chef_mover['ibrowse_max_sessions']`

:   **Setting EOL in Chef Infra Server 14.**

    Default value: `256`.

`opscode_chef_mover['log_directory']`

:   The directory in which log data is stored. The default value is the
    recommended value. Default value:

    ```ruby
    '/var/log/opscode/opscode-chef-mover'
    ```

`opscode_chef_mover['log_rotation']`

:   The log rotation policy for this service. Log files are rotated when
    they exceed `file_maxbytes`. The maximum number of log files in the
    rotation is defined by `num_to_keep`. Default value:

    ```ruby
    { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }
    ```

`opscode_chef_mover['max_cache_size']`

:   **Setting EOL in Chef Infra Server 14.**

    Default value: `'10000'`.

`opscode_chef_mover['solr_http_cull_interval']`

:   **Setting EOL in Chef Infra Server 14.**

    Default value: `'{1, min}'`.

`opscode_chef_mover['solr_http_init_count']`

:   **Setting EOL in Chef Infra Server 14.**

    Default value: `25`.

`opscode_chef_mover['solr_http_max_age']`

:   **Setting EOL in Chef Infra Server 14.**

    Default value: `'{70, sec}'`.

`opscode_chef_mover['solr_http_max_connection_duration']`

:   **Setting EOL in Chef Infra Server 14.**

    Default value: `'{70, sec}'`.

`opscode_chef_mover['solr_http_max_count']`

:   **Setting EOL in Chef Infra Server 14.**

    Default value: `100`.

`opscode_chef_mover['solr_ibrowse_options']`

:   **Setting EOL in Chef Infra Server 14.**

    Default value: `'[{connect_timeout, 10000}]'`.

`opscode_chef_mover['solr_timeout']`

:   **Setting EOL in Chef Infra Server 14.**

    Default value: `30000`.

### opscode-erchef

{{< readfile file="content/server/reusable/md/server_services_erchef.md" >}}

This configuration file has the following settings for `opscode-erchef`:

`opscode_erchef["allow_email_update_only_from_manage"]`

:   Set to `true`, users can only update their email from the Chef management console.
    Set to `false`, users can update their email using knife and the Chef management console.

    Default value : `false`.

    **New in Chef Infra Server 14.5**

`opscode_erchef['auth_skew']`

:   Default value: `900`.

`opscode_erchef['authz_fanout']`

:   Default value: `20`.

`opscode_erchef['authz_timeout']`

:   The amount of time (in seconds) before a request to the
    **oc_bifrost** service times out.

    Default value: `2000`.

`opscode_erchef['base_resource_url']`

:   The base URL to which the service is to return links to API
    resources. Use `:host_header` to ensure the URL is derived from the
    host header of the incoming HTTP request.

    Default value: `:host_header`.

`opscode_erchef['bulk_fetch_batch_size']`

:   The number of nodes that may be deserialized. Currently only applies
    to the `/search` endpoint in the Chef Infra Server API. The default
    value is the recommended value.

    Default value: `5`.

`opscode_erchef['cache_ttl']`

:   Default value: `3600`.

`opscode_erchef['cbv_cache_enabled']`

:   Whether to enable cookbook version response caching. If you frequently see
    very long response times from `cookbook_versions` when under load, this is worth enabling.
    Enabling this makes it possible for a client to receive stale results. When a cookbook is updated
    in place (without incrementing the version), and the old response has not expired from the cache,
    the Infra Server will give the old response to the client. Subsequent client runs will receive the
    updated response.

    Possible values: `true`, `false`.

    Default value: `false`.

    **New in Chef Infra Server 14.11**

`opscode_erchef['cbv_cache_item_ttl']`

:   The maximum time in milliseconds that Chef Infra Server will keep any given cookbook version response in the cache when when `cbv_cache_enabled` is enabled.

    Default value: `30000`.

    {{< note >}}
    Be careful if increasing this number - requests for a given set of cookbook versions will be stale if the resolved cookbook versions are updated before the cache entry times out. This will
    not occur if you increment the version of a cookbook with every cookbook update, which is the recommended approach to updating cookbooks.
    {{< /note >}}

`opscode_erchef['cleanup_batch_size']`

:   Default value: `0`.

`opscode_erchef['couchdb_max_conn']`

:   Default value: `'100'`.

`opscode_erchef['db_pool_size']`

:   The number of open connections to PostgreSQL that are maintained by
    the service.

    Default value: `20`.

`opscode_erchef['depsolver_timeout']`

:   The amount of time (in milliseconds) to wait for cookbook dependency
    problems to be solved.

    Default value: `'5000'`.

`opscode_erchef['depsolver_worker_count']`

:   The number of Ruby processes for which cookbook dependency problems
    are unsolved. Use the `pgrep -fl depselector` command to verify the
    number of depsolver workers that are running. If you are seeing 503
    service unavailable errors, increase this value.

    Default value: `'5'`.

`opscode_erchef['dir']`

:   The working directory. The default value is the recommended value.

    Default value: `/var/opt/opscode/opscode-erchef`.

`opscode_erchef['enable']`

:   Enable a service.

    Default value: `true`.

`opscode_erchef['enable_actionlog']`

:   Use to enable Chef actions, a premium feature of the Chef Infra
    Server.

    Default value: `false`.

`opscode_erchef['enable_request_logging']`

:   Use to configure request logging for the `opscode_erchef` service.

    Default value: `true`.

`opscode_erchef['ibrowse_max_pipeline_size']`

:   Default value: `1`.

`opscode_erchef['ibrowse_max_sessions']`

:   Default value: `256`.

`opscode_erchef['enable_ibrowse_traces']`

:   Use to configure ibrowse logging for the `opscode_erchef` service.

    Default value: `false`.

    **New in Chef Infra Server 14.11**

`opscode_erchef["include_version_in_status"]`

:   Set to `true` to include `server_version` as part of the `/_status` endpoint.

    Default value : `false`.

    **New in Chef Infra Server 14.1**

`opscode_erchef['listen']`

:   The IP address on which the service is to listen.

    Default value: `127.0.0.1`.

`opscode_erchef['log_directory']`

:   The directory in which log data is stored. The default value is the
    recommended value.

    Default value: `/var/log/opscode/opscode-erchef`.

`opscode_erchef['log_rotation']`

:   The log rotation policy for this service. Log files are rotated when
    they exceed `file_maxbytes`. The maximum number of log files in the
    rotation is defined by `num_to_keep`.

    Default value: `{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }`

`opscode_erchef['max_cache_size']`

:   Default value: `10000`.

`opscode_erchef['max_request_size']`

:   When the request body size is greater than this value, a
    `413 Request Entity Too Large` error is returned.

    Default value: `2000000`.

`opscode_erchef['nginx_bookshelf_caching']`

:   Whether Nginx is used to cache cookbooks. When `:on`, Nginx serves
    up the cached content instead of forwarding the request.

    Default value: `:off`.

`opscode_erchef['port']`

:   The port on which the service is to listen.

    Default value: `8000`.

`opscode_erchef['reindex_batch_size']`

:   The number of items to fetch from the database and send to the
    search index at a time.

    Default value: `10`.

`opscode_erchef['reindex_sleep_min_ms']`

:   The minimum number of milliseconds to sleep before retrying a failed
    attempt to index an item. Retries are delayed a random number of
    miliseconds between `reindex_sleep_min_ms` and
    `reindex_sleep_max_ms`. Set both this and `reindex_sleep_max_ms` to
    0 to retry without delay.

    Default value: `500`

`opscode_erchef['reindex_sleep_max_ms']`

:   The maximum number of milliseconds to sleep before retrying a failed
    attempt to index an item. Retries are delayed a random number of
    miliseconds between `reindex_sleep_min_ms` and
    `reindex_sleep_max_ms`. Set both this and `reindex_sleep_min_ms` to
    0 to retry without delay.

    Default value: `2000`

`opscode_erchef['reindex_item_retries']`

:   The number of times to retry sending an object for indexing in the
    case of failure.

    Default value: `3`

`opscode_erchef['root_metric_key']`

:   Default value: `chefAPI`.

`opscode_erchef['s3_bucket']`

:   The name of the Amazon Simple Storage Service (S3) bucket. This may
    point at external storage locations, such as Amazon EC2. See [AWS
    external bookshelf
    settings]({{< relref "/server#aws-settings" >}}) for
    more information on configuring external bookshelf.

`opscode_erchef['s3_parallel_ops_fanout']`

:   Default value: `20`.

`opscode_erchef['s3_parallel_ops_timeout']`

:   Default value: `5000`.

`opscode_erchef['s3_url_expiry_window_size']`

:   The frequency at which unique URLs are generated. This value may be
    a specific amount of time, i.e. `15m` (fifteen minutes) or a
    percentage of the value of `s3_url_ttl`, i.e. `10%`.

    Default value: `:off`.

`opscode_erchef['s3_url_ttl']`

:   The amount of time (in seconds) before connections to the server
    expire. If node bootstraps are timing out, increase this setting.

    Default value: `28800`.

`opscode_erchef['s3_url_type']`

:   The URL style to use (`path` or `vhost`) when connecting to S3.
    Mainly used to manually override the default setting. Note that
    Amazon may eliminate path-style URLs on some or all S3 buckets
    in the future.

    Default value: `vhost`.

    **New in Chef Infra Server 15.3**

`opscode_erchef['search_auth_password']`

: The OpenSearch password.

    Default value: `nil`.

    **New in Chef Infra Server 14.14.**

`opscode_erchef['search_auth_username']`

: The OpenSearch username.

    Default value: `opensearch_user`.

    **New in Chef Infra Server 14.14.**

`opscode_erchef['search_provider']`

: The search index provider.

    Default value: `elasticsearch`.

    **New in Chef Infra Server 14.14.**

`opscode_erchef['search_queue_mode']`

: The search index queue mode.

    Default value: `batch`.

    **New in Chef Infra Server 14.14.**

`opscode_erchef['sql_connection_user']`

:   The PostgreSQL user name in `'username@hostname'` format (e.g.
    `'opscode_chef@my_postgresql.postgres.database.azure.com'`), where
    `username` would normally equal the value of
    `opscode-erchef['sql_user']` (default: `'opscode_chef'`). This
    setting is **required** in an external Azure PostgreSQL
    database-as-a-service configuration. If set to `nil`, Chef Infra
    Server assumes that the database is not on Azure and the PostgreSQL
    connection will be made using the value specified in
    `opscode_erchef['sql_user']`.

    Default value: `nil`.

`opscode_erchef['strict_search_result_acls']`

:   {{< readfile file="content/server/reusable/md/settings_strict_search_result_acls.md" >}}

`opscode_erchef['udp_socket_pool_size']`

:   Default value: `20`.

`opscode_erchef['umask']`

:   Default value: `0022`.

`opscode_erchef['validation_client_name']`

:   Default value: `chef-validator`.

`opscode_erchef['vip']`

:   The virtual IP address.

    Default value: `127.0.0.1`.

`opscode_erchef['track_total_hits']`

:   If true, it will return the total number of matching documents. If false, the count capps at 10,000 documents.

    Default value: `false`.

{{< warning >}}

When `true`,`opscode_erchef['track_total_hits']` can increase query latency and memory usage by calculating the exact total of matching documents, which may impact performance.

{{< /warning >}}

### opscode-expander

{{< readfile file="content/server/reusable/md/server_services_expander.md" >}}

{{< note >}}

opscode-expander settings are EOL in Chef Infra Server 14.

{{< /note >}}

This configuration file has the following settings for
`opscode-expander`:

`opscode_expander['consumer_id']`

:   **Setting EOL in Chef Infra Server 14.**

    The identity of the consumer to which messages are published.
    Default value: `default`.

`opscode_expander['dir']`

:   **Setting EOL in Chef Infra Server 14.**

    The working directory. The default value is the recommended value.
    Default value:

    ```ruby
    /var/opt/opscode/opscode-expander
    ```

`opscode_expander['enable']`

:   **Setting EOL in Chef Infra Server 14.**

    Enable a service. Default value: `true`.

`opscode_expander['log_directory']`

:   **Setting EOL in Chef Infra Server 14.**

    The directory in which log data is stored. The default value is the
    recommended value. Default value:

    ```ruby
    /var/log/opscode/opscode-expander
    ```

`opscode_expander['log_rotation']`

:   **Setting EOL in Chef Infra Server 14.**

    The log rotation policy for this service. Log files are rotated when
    they exceed `file_maxbytes`. The maximum number of log files in the
    rotation is defined by `num_to_keep`. Default value:

    ```ruby
    { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }
    ```

`opscode_expander['nodes']`

:   **Setting EOL in Chef Infra Server 14.**

    The number of allowed worker processes. Default value: `2`.

`opscode_expander['reindexer_log_directory']`

:   **Setting EOL in Chef Infra Server 14.**

    The directory in which `opscode-expander-reindexer` logs files are
    located. Default value:

    ```ruby
    /var/log/opscode/opscode-expander-reindexer
    ```

### opscode-solr4

{{< readfile file="content/server/reusable/md/server_services_solr4.md" >}}

{{< note >}}

opscode-solr4 settings are EOL in Chef Infra Server 14.

{{< /note >}}

This configuration file has the following settings for `opscode-solr4`:

`opscode_solr4['auto_soft_commit']`

:   **Setting EOL in Chef Infra Server 14.**

    The maximum number of documents before a soft commit is triggered.
    Default value: `1000`.

`opscode_solr4['commit_interval']`

:   **Setting EOL in Chef Infra Server 14.**

    The frequency (in seconds) at which node objects are added to the
    Apache Solr search index. This value should be tuned carefully. When
    data is committed to the Apache Solr index, all incoming updates are
    blocked. If the duration between updates is too short, it is
    possible for the rate at which updates are asked to occur to be
    faster than the rate at which objects can be actually committed.
    Default value: `60000` (every 60 seconds).

`opscode_solr4['data_dir']`

:   **Setting EOL in Chef Infra Server 14.**

    The directory in which on-disk data is stored. The default value is
    the recommended value. Default value:

    ```ruby
    /var/opt/opscode/opscode-solr4/data
    ```

`opscode_solr4['dir']`

:   **Setting EOL in Chef Infra Server 14.**

    The working directory. The default value is the recommended value.
    Default value:

    ```ruby
    /var/opt/opscode/opscode-solr4
    ```

`opscode_solr4['enable']`

:   **Setting EOL in Chef Infra Server 14.**

    Enable a service. Default value: `true`.

`opscode_solr4['heap_size']`

:   **Setting EOL in Chef Infra Server 14.**

    The amount of memory (in MBs) available to Apache Solr. If there is
    not enough memory available, search queries made by nodes to Apache
    Solr may fail. The amount of memory that must be available also
    depends on the number of nodes in the organization, the frequency of
    search queries, and other characteristics that are unique to each
    organization. In general, as the number of nodes increases, so does
    the amount of memory. The default value should work for many
    organizations with fewer than 25 nodes. For an organization with
    several hundred nodes, the amount of memory that is required often
    exceeds 3GB. Default value: `nil`, which is equivalent to 25% of the
    system memory or 1024 (MB, but this setting is specified as an
    integer number of MB in EC11), whichever is smaller.

`opscode_solr4['ip_address']`

:   **Setting EOL in Chef Infra Server 14.**

    The IP address for the machine on which Apache Solr is running.
    Default value: `127.0.0.1`.

`opscode_solr4['java_opts']`

:   **Setting EOL in Chef Infra Server 14.**

    A Hash of `JAVA_OPTS` environment variables to be set.
    (`-XX:NewSize` is configured using the `new_size` setting.) Default
    value: `' '` (empty).

`opscode_solr4['log_directory']`

:   **Setting EOL in Chef Infra Server 14.**

    The directory in which log data is stored. The default value is the
    recommended value. Default value:

    ```ruby
    /var/log/opscode/opscode-solr4
    ```

`opscode_solr4['log_gc']`

:  Enable or disable GC logging. Default is `true`.

`opscode_solr4['log_rotation']`

:   **Setting EOL in Chef Infra Server 14.**

    The log rotation policy for this service. Log files are rotated when
    they exceed `file_maxbytes`. The maximum number of log files in the
    rotation is defined by `num_to_keep`. Default value:

    ```ruby
    { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }
    ```

`opscode_solr4['max_commit_docs']`

:   **Setting EOL in Chef Infra Server 14.**

    The frequency (in documents) at which node objects are added to the
    Apache Solr search index. This value should be tuned carefully. When
    data is committed to the Apache Solr index, all incoming updates are
    blocked. If the duration between updates is too short, it is
    possible for the rate at which updates are asked to occur to be
    faster than the rate at which objects can be actually committed.
    Default value: `1000` (every 1000 documents).

`opscode_solr4['max_field_length']`

:   **Setting EOL in Chef Infra Server 14.**

    The maximum field length (in number of tokens/terms). If a field
    length exceeds this value, Apache Solr may not be able to complete
    building the index. Default value: `100000` (increased from the
    Apache Solr default value of `10000`).

`opscode_solr4['max_merge_docs']`

:   **Setting EOL in Chef Infra Server 14.**

    The maximum number of index segments allowed before they are merged
    into a single index. Default value: `2147483647`.

`opscode_solr4['merge_factor']`

:   **Setting EOL in Chef Infra Server 14.**

    The maximum number of document updates that can be stored in memory
    before being flushed and added to the current index segment. Default
    value: `15`.

`opscode_solr4['new_size']`

:   **Setting EOL in Chef Infra Server 14.**

    Configure the `-XX:NewSize` `JAVA_OPTS` environment variable.
    Default value: `nil`.

`opscode_solr4['poll_seconds']`

:   **Setting EOL in Chef Infra Server 14.**

    The frequency (in seconds) at which the secondary machine polls the
    primary. Default value: `20`.

`opscode_solr4['port']`

:   **Setting EOL in Chef Infra Server 14.**

    The port on which the service is to listen. Default value: `8983`.

`opscode_solr4['ram_buffer_size']`

:   **Setting EOL in Chef Infra Server 14.**

    The size (in megabytes) of the RAM buffer. When document updates
    exceed this amout, pending updates are flushed. Default value:
    `100`.

`opscode_solr4['url']`

:   **Setting EOL in Chef Infra Server 14.**

    Default value: `'http://localhost:8983/solr'`.

`opscode_solr4['vip']`

:   **Setting EOL in Chef Infra Server 14.**

    The virtual IP address. Default value: `127.0.0.1`.

### OpenSearch

You can configure external OpenSearch starting in Chef Infra Server 14.14.

The `chef-server.rb` file has the following settings for OpenSearch:

`opensearch['enable']`

: Enable the service.

  Default value: `true`.

`opensearch['dir']`

: The working directory.  The default value is the recommended value.

  Default value: `/var/opt/opscode/opensearch`

`opensearch['data_dir']`

: The paths used to store data.

  Default value: `/var/opt/opscode/elasticsearch/data`

`opensearch['enable_gc_log']`

: Enable or disable GC logging.

  Default value: `false`

`opensearch['heap_size']`

: The amount of memory (in MBs) available to OpenSearch. If there is not enough memory available, search queries made by nodes to OpenSearch may fail. The amount of memory that must be available also depends on the number of nodes in the organization, the frequency of search queries, and other characteristics that are unique to each organization. In general, as the number of nodes increases, so does the amount of memory. The default value should work for many organizations with fewer than 25 nodes. For an organization with several hundred nodes, the amount of memory that is required often exceeds 3GB.

  Default value is 25% of the system memory or 1024 MB, whichever is greater.

  {{< note >}}

  If `heap_size` is also specified directly in `java_opts`, it will be ignored in favor of the chef-server.rb values or the defaults as calculated here. Only use chef-server.rb to set `heap_size`. It will raise an error if the system memory is less than 4 GB. This value is bounded between 1 GB - 28 GB.

  {{< /note >}}

`opensearch['initial_cluster_join_timeout']`

: Default value: `90`

`opensearch['jvm_opts']`

: Default values are set based on [JVM configuration options](https://github.com/elastic/elasticsearch/blob/6.8/distribution/src/config/jvm.options).

  {{< note >}}

  Each item in this list will be placed as is into the `java_opts` config file. Entries are set in chef-server.rb as:

  ```ruby
  opensearch.jvm_opts = [
  "-xoption1",
  "-xoption2",
  ...
  "optionN"
  ]
  ```

  {{< /note >}}

`opensearch['listen']`

: The IP address for the machine on which Apache Solr is running.

  Default value: `127.0.0.1`

`opensearch['log_directory']`

: The directory in which log data is stored. The default value is the recommended value.

  Default value: `/var/log/opscode/opensearch`

`opensearch['log_rotation']['file_maxbytes']`

: The log rotation policy for this service. Log files are rotated when they exceed `file_maxbytes`.

  Default value: `104857600`.

`opensearch['log_rotation']['num_to_keep']`

: The log rotation policy for this service. `num_to_keep` specifies the maximum number of log files in the rotation.

  Default value: `10`.

`opensearch['new_size']`

: Defaults to the larger of 1/16th of the `heap_size` or 32 MB.

  {{< note >}}

  If `new_size` is also specified directly in `java_opts`, it will be ignored in favor of the chef-server.rb values or the defaults calculated here. Only use chef-server.rb to set `new_size`.

  {{< /note >}}

`opensearch['plugins_directory']`

: The default location of the plugins directory depends on which package you install.

  Default value: `/var/opt/opscode/opensearch/plugins`

`opensearch['port']`

: The port on which the service is listening.

  Default value: `9200`

`opensearch['scripts_directory']`

: The default location of the scripts directory depends on which package you install.

  Default value: `/var/opt/opscode/opensearch/scripts`

`opensearch['temp_directory']`

: By default, OpenSearch uses a private temporary directory that the startup script creates immediately below the system temporary directory.

  Default value: `/var/opt/opscode/opensearch/tmp`


`opensearch['vip']`

: The virtual IP address for the machine on which Apache Solr is running.

  Default value: `127.0.0.1`

### External OpenSearch

`opensearch['external']`

: Enable external `opensearch` service by setting to `true`.

  Default value: `false`.

`opensearch['external_url']`

: The external OpenSearch URL. Example: `http://127.0.0.1:9200`.

  Default value: `nil`

{{< note >}}
Chef Infra Server supports OpenSearch only as an external indexing provider. You must provide values for `external` and `external_url` under this configuration.
{{< /note >}}

### Elasticsearch

This configuration file has the following settings for `elasticsearch`:

`elasticsearch['enable']`

: Enable a service.

  Default value: `true`.

`elasticsearch['dir']`

: The working directory. The default value is the recommended value.

  Default value: `/var/opt/opscode/elasticsearch`

`elasticsearch['data_dir']`

: The paths used to store data.

  Default value: `/var/opt/opscode/elasticsearch/data`

`elasticsearch['plugins_directory']`

: The default location of the plugins directory depends on which package you install.

  Default value: `/var/opt/opscode/elasticsearch/plugins`

`elasticsearch['scripts_directory']`

: The default location of the scripts directory depends on which package you install.

  Default value: `/var/opt/opscode/elasticsearch/scripts`

`elasticsearch['temp_directory']`

: By default, Elasticsearch uses a private temporary directory that the startup script creates immediately below the system temporary directory.

  Default value: `/var/opt/opscode/elasticsearch/tmp`

`elasticsearch['log_directory']`

: The directory in which log data is stored. The default value is the recommended value.

  Default value: `/var/log/opscode/elasticsearch`

`elasticsearch['log_rotation']['file_maxbytes']`

: The log rotation policy for this service. Log files are rotated when they exceed file_maxbytes.

  Default value for 'file_maxbytes': `104857600`

`elasticsearch['log_rotation']['num_to_keep']`

: The log rotation policy for this service. The maximum number of log files in the rotation is defined by num_to_keep.  Default value for 'num_to_keep': => `10`

`elasticsearch['vip']`

: The virtual IP address for the machine on which Apache Solr is running.

  Default value: `127.0.0.1`

`elasticsearch['listen']`

: The IP address for the machine on which Apache Solr is running.

  Default value: `127.0.0.1`

`elasticsearch['port']`

: The port on which the service is to listen.

  Default value: `9200`

`elasticsearch['enable_gc_log']`

: Enable or disable GC logging.

  Default value: `false`

`elasticsearch['initial_cluster_join_timeout']`

: Default value: `90`

`elasticsearch['jvm_opts']`

: Default values are set based on [JVM configuration options](https://github.com/elastic/elasticsearch/blob/6.8/distribution/src/config/jvm.options).

{{< note >}}

Each item in this list will be placed as is into the java_opts config file. Entries are set in chef-server.rb as:

```ruby
 elasticsearch.jvm_opts = [
  "-xoption1",
  "-xoption2",
  ...
  "optionN"
 ]
```

{{< /note >}}

`elasticsearch['heap_size']`

: The amount of memory (in MBs) available to Elasticsearch. If there is not enough memory available, search queries made by nodes to Elasticsearch may fail. The amount of memory that must be available also depends on the number of nodes in the organization, the frequency of search queries, and other characteristics that are unique to each organization. In general, as the number of nodes increases, so does the amount of memory. The default value should work for many organizations with fewer than 25 nodes. For an organization with several hundred nodes, the amount of memory that is required often exceeds 3GB.

  Default value is is equivalent to 25% of the system memory or 1024 MB, whichever is greater.

{{< note >}}

If new_size or heap_size is also specified directly in java_opts, it will be ignored in favor of the chef-server.rb values or the defaults as calculated here. Only use chef-server.rb to set heap and new sizes. Learn more about [Elasticsearch heap-size](https://www.elastic.co/guide/en/elasticsearch/reference/current/heap-size.html). It will error out if the system memory is less than 4 GB. This value is bounded between 1 GB - 28 GB.

{{< /note >}}

`elasticsearch['new_size']`

: Defaults to the larger of 1/16th the heap_size and 32 MB.

{{< note >}}

If new_size or heap_size is also specified directly in java_opts, it will be ignored in favor of the chef-server.rb values or the defaults as calculated here.  Only use chef-server.rb to set heap and new sizes. Learn more about [Elasticsearch heap-size documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/heap-size.html).

{{< /note >}}

### postgresql

{{< readfile file="content/server/reusable/md/server_services_postgresql.md" >}}

This configuration file has the following settings for `postgresql`:

`postgresql['checkpoint_completion_target']`

:   A completion percentage that is used to determine how quickly a
    checkpoint should finish in relation to the completion status of the
    next checkpoint. For example, if the value is `0.5`, then a
    checkpoint attempts to finish before 50% of the next checkpoint is
    done.

    Default value: `0.5`.

`postgresql['checkpoint_segments']`

:   The maximum amount (in megabytes) between checkpoints in log file
    segments.

    Default value: `3`.

`postgresql['checkpoint_timeout']`

:   The amount of time (in minutes) between checkpoints.

    Default value: `5min`.

`postgresql['checkpoint_warning']`

:   The frequency (in seconds) at which messages are sent to the server
    log files if checkpoint segments are being filled faster than their
    currently configured values.

    Default value: `30s`.

`postgresql['data_dir']`

:   The directory in which on-disk data is stored. The default value is
    the recommended value.

    Default value: `/var/opt/opscode/postgresql/#{node['private_chef']['postgresql']['version']}/data`.

`postgresql['db_connection_superuser']`

:   The PostgreSQL superuser name in `'username@hostname'` format (e.g.
    `'opscode_pgsql@my_postgresql.postgres.database.azure.com'`), where
    `username` would normally equal the value of
    `postgresql['db_superuser']` with any dashes replaced by
    underscores. This setting is **required** in an external Azure
    PostgreSQL database-as-a-service configuration. If set to `nil`,
    Chef Infra Server assumes that the database is not on Azure and the
    PostgreSQL connection will be made using the value specified in
    `postgresql['db_superuser']`.

    Default value: `nil`.

`postgresql['db_superuser']`

:   Default value: `opscode-pgsql`. If `username` is set, set
    `db_superuser` to the same value.

`postgresql['db_superuser_password']`

:   Password for the DB superuser.

    Default value: **generated**.

    To override the default value, use the [Secrets
    Management]({{< relref "/server/ctl_chef_server#secrets-management" >}})
    command: `chef-server-ctl set-db-superuser-password`.

`postgresql['dir']`

:   The working directory. The default value is the recommended value.

    Default value: `/var/opt/opscode/postgresql/#{node['private_chef']['postgresql']['version']}`.

`postgresql['effective_cache_size']`

:   The size of the disk cache that is used for data files.

    Default value: 50% of available RAM.

`postgresql['enable']`

:   Enable a service.

    Default value: `true`.

`postgresql['home']`

:   The home directory for PostgreSQL.

    Default value: `/var/opt/opscode/postgresql`.

`postgresql['keepalives_count']`

:   The maximum number of keepalive proves that should be sent before
    dropping a connection.

    Default value: `2`.

`postgresql['keepalives_idle']`

:   The amount of time (in seconds) a connection must remain idle before
    keepalive probes will resume.

    Default value: `60`.

`postgresql['keepalives_interval']`

:   The amount of time (in seconds) between probes.

    Default value: `15`.

`postgresql['listen_address']`

:   The connection source to which PostgreSQL is to respond.

    Default value: `localhost`.

`postgresql['log_directory']`

:   The directory in which log data is stored. The default value is the
    recommended value.

    Default value: `/var/log/opscode/postgresql/#{node['private_chef']['postgresql']['version']}`.

`postgresql['log_min_duration_statement']`

:   When to log a slow PostgreSQL query statement.

    Possible values:

    - `-1` (disabled, do not log any statements)
    - `0` (log every statement)
    - an integer greater than zero

    If set to an integer greater than zero,
    this value is the amount of time (in milliseconds) that a query
    statement must have run before it is logged.

    Default value: `-1`.

`postgresql['log_rotation']`

:   The log rotation policy for this service. Log files are rotated when
    they exceed `file_maxbytes`. The maximum number of log files in the
    rotation is defined by `num_to_keep`.

    Default value: `{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }`

`postgresql['max_connections']`

:   The maximum number of allowed concurrent connections.

    Default value: `350`.

`postgresql['md5_auth_cidr_addresses']`

:   Use instead of `trust_auth_cidr_addresses` to encrypt passwords
    using MD5 hashes.

    Default value: `[ '127.0.0.1/32', '::1/128' ]`.

`postgresql['port']`

:   The port on which the service is to listen.

    Default value: `5432`.

`postgresql['shared_buffers']`

:   The amount of memory that is dedicated to PostgreSQL for data
    caching.

    Default value: `#{(node['memory']['total'].to_i / 4) / (1024)}MB`.

`postgresql['shell']`

:   Default value: `/bin/sh`.

`postgresql['shmall']`

:   The total amount of available shared memory.

    Default value: `4194304`.

`postgresql['shmmax']`

:   The maximum amount of shared memory.

    Default value: `17179869184`.

`postgresql['sslmode']`

:   SSL encryption mode between the Chef Infra Server and PostgreSQL.

    Possible values:

    - `'disable'`
    - `'require'`

    Default value: `'disable'`.

`postgresql['trust_auth_cidr_addresses']`

:   Use for clear-text passwords. See `md5_auth_cidr_addresses`.

    Default value: `'127.0.0.1/32', '::1/128'`.

`postgresql['pg_upgrade_timeout']`

:   The timeout value (in seconds) for PostgreSQL upgrade.

    Default value: `7200`.

`postgresql['user_path']`

:   Default value: `/opt/opscode/embedded/bin:/opt/opscode/bin:$PATH`.

`postgresql['username']`

:   The PostgreSQL account user name.
    If setting this value, you must set `db_superuser` to the same value.

    Default value: `opscode-pgsql`.

`postgresql['version']`

:   The (currently) hardcoded version of PostgreSQL.

    Default value: `'9.2'`.

`postgresql['vip']`

:   The virtual IP address.

    Default value: `127.0.0.1`.

`postgresql['work_mem']`

:   The size (in megabytes) of allowed in-memory sorting.

    Default value: `8MB`.

### rabbitmq

The **rabbitmq** service is used to provide the message queue that is
used by the Chef Infra Server to get search data to Apache Solr so that
it can be indexed for search.

{{< note >}}

rabbitmq settings are EOL in Chef Infra Server 14.

{{< /note >}}

This configuration file has the following settings for `rabbitmq`:

`rabbitmq['actions_exchange']`

:   The name of the exchange to which Chef actions publishes actions
    data. Default value: `'actions'`.

`rabbitmq['actions_password']`

:   Legacy configuration setting for the password of the `actions_user`.
    Default value: **generated**.

    To override the default value, use the [Secrets
    Management]({{< relref "/server/ctl_chef_server#secrets-management" >}})
    command: `chef-server-ctl set-actions-password`.

`rabbitmq['actions_user']`

:   The user with permission to publish actions data. Default value:
    `'actions'`.

`rabbitmq['actions_vhost']`

:   The virtual host to which Chef actions publishes actions data.
    Default value: `'/analytics'`.

`rabbitmq['analytics_max_length']`

:   The maximum number of messages that can be queued before RabbitMQ
    automatically drops messages from the front of the queue to make
    room for new messages. Default value: `10000`.

`rabbitmq['consumer_id']`

:   The identity of the consumer to which messages are published.
    Default value: `'hotsauce'`.

`rabbitmq['data_dir']`

:   The directory in which on-disk data is stored. The default value is
    the recommended value. Default value:
    `'/var/opt/opscode/rabbitmq/db'`.

`rabbitmq['dir']`

:   The working directory. The default value is the recommended value.
    Default value: `'/var/opt/opscode/rabbitmq'`.

`rabbitmq['drop_on_full_capacity']`

:   Specify if messages will stop being sent to the RabbitMQ queue when
    it is at capacity. Default value: `true`.

`rabbitmq['enable']`

:   Enable a service. Default value: `true`.

`rabbitmq['log_directory']`

:   The directory in which log data is stored. The default value is the
    recommended value. Default value: `'/var/log/opscode/rabbitmq'`.

`rabbitmq['log_rotation']`

:   The log rotation policy for this service. Log files are rotated when
    they exceed `file_maxbytes`. The maximum number of log files in the
    rotation is defined by `num_to_keep`. Default value:

    ```ruby
    { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }
    ```

`rabbitmq['management_enabled']`

:   Specify if the rabbitmq-management plugin is enabled. Default value:
    `true`.

`rabbitmq['management_password']`

:   Legacy configuration setting for rabbitmq-management plugin
    password. Default value: **generated**.

    To override the default value, use the [Secrets
    Management]({{< relref "/server/ctl_chef_server#secrets-management" >}})
    command: `chef-server-ctl set-secret rabbitmq management_password`.

`rabbitmq['management_port']`

:   The rabbitmq-management plugin port. Default value: `15672`.

`rabbitmq['management_user']`

:   The rabbitmq-management plugin user. Default value: `'rabbitmgmt'`.

`rabbitmq['node_ip_address']`

:   The bind IP address for RabbitMQ. Default value: `'127.0.0.1'`.

`rabbitmq['node_port']`

:   The port on which the service is to listen. Default value: `'5672'`.

`rabbitmq['nodename']`

:   The unique identifier of the node. Default value: `'rabbit@localhost'`.

`rabbitmq['password']`

:   Legacy configuration setting for the password for the RabbitMQ user.
    Default value: **generated**.

    To override the default value, use the [Secrets
    Management]({{< relref "/server/ctl_chef_server#secrets-management" >}})
    command: `chef-server-ctl set-secret rabbitmq password`.

`rabbitmq['prevent_erchef_startup_on_full_capacity']`

:   Specify if the Chef Infra Server will start when the monitored
    RabbitMQ queue is full. Default value: `false`.

`rabbitmq['queue_at_capacity_affects_overall_status']`

:   Specify if the `_status` endpoint in the Chef Infra Server API will
    fail if the monitored queue is at capacity. Default value: `false`.

`rabbitmq['queue_length_monitor_enabled']`

:   Specify if the queue length monitor is enabled. Default value:
    `true`.

`rabbitmq['queue_length_monitor_millis']`

:   The frequency (in milliseconds) at which the length of the RabbitMQ
    queue is checked. Default value: `30000`.

`rabbitmq['queue_length_monitor_timeout_millis']`

:   The timeout (in milliseconds) at which calls to the queue length
    monitor will stop if the Chef Infra Server is overloaded. Default
    value: `5000`.

`rabbitmq['queue_length_monitor_queue']`

:   The RabbitMQ queue that is observed by queue length monitor. Default
    value: `'alaska'`.

`rabbitmq['queue_length_monitor_vhost']`

:   The virtual host for the RabbitMQ queue that is observed by queue
    length monitor. Default value: `'/analytics'`.

`rabbitmq['rabbit_mgmt_http_cull_interval']`

:   The maximum cull interval (in seconds) for the HTTP connection pool
    that is used by the rabbitmq-management plugin. Default value: `60`.

`rabbitmq['rabbit_mgmt_http_init_count']`

:   The initial worker count for the HTTP connection pool that is used
    by the rabbitmq-management plugin. Default value: `25`.

`rabbitmq['rabbit_mgmt_http_max_age']`

:   The maximum connection worker age (in seconds) for the HTTP
    connection pool that is used by the rabbitmq-management plugin.
    Default value: `70`.

`rabbitmq['rabbit_mgmt_http_max_connection_duration']`

:   The maximum connection duration (in seconds) for the HTTP connection
    pool that is used by the rabbitmq-management plugin. Default value:
    `70`.

`rabbitmq['rabbit_mgmt_http_max_count']`

:   The maximum worker count for the HTTP connection pool that is used
    by the rabbitmq-management plugin. Default value: `100`.

`rabbitmq['rabbit_mgmt_ibrowse_options']`

:   An array of comma-separated key-value pairs of ibrowse options for
    the HTTP connection pool that is used by the rabbitmq-management
    plugin. Default value: `'{connect_timeout, 10000}'`.

`rabbitmq['rabbit_mgmt_timeout']`

:   The timeout for the HTTP connection pool that is used by the
    rabbitmq-management plugin. Default value: `30000`.

`rabbitmq['reindexer_vhost']`

:   Default value: `'/reindexer'`.

`rabbitmq['ssl_versions']`

:   The SSL versions used by the rabbitmq-management plugin. (See
    [RabbitMQ TLS support](https://www.rabbitmq.com/ssl.html) for more
    information.) Default value: `['tlsv1.2', 'tlsv1.1']`.

`rabbitmq['user']`

:   Default value: `'chef'`.

`rabbitmq['vhost']`

:   Default value: `'/chef'`.

`rabbitmq['vip']`

:   The virtual IP address. Default value: `'127.0.0.1'`.

### redis_lb

{{< readfile file="content/server/reusable/md/server_services_redis.md" >}}

This configuration file has the following settings for `redis_lb`:

`redis_lb['activerehashing']`

:   Enable active rehashing.

    Default value: `'no'`.

`redis_lb['aof_rewrite_min_size']`

:   The minimum size of the append-only file. Only files larger than
    this value are rewritten.

    Default value: `'16mb'`.

`redis_lb['aof_rewrite_percent']`

:   The size of the current append-only file, as compared to the base
    size. The append-only file is rewritten when the current file
    exceeds the base size by this value.

    Default value: `'50'`.

`redis_lb['appendfsync']`

:   The frequency at which the operating system writes data on-disk,
    instead of waiting for more data.

    Possible values:

    - `no` (don't fsync, let operating system flush data)
    - `always` (fsync after every write to the append-only log file)
    - `everysec` (fsync only once time per second)

    Default value: `'always'`.

`redis_lb['appendonly']`

:   Dump data asynchronously on-disk or to an append-only log file. Set
    to `yes` to dump data to an append-only log file.

    Default value: `'no'`.

`redis_lb['bind']`

:   Bind Redis to the specified IP address.

    Default value: `'127.0.0.1'`.

`redis_lb['data_dir']`

:   The directory in which on-disk data is stored. The default value is
    the recommended value.

    Default value: `'/var/opt/opscode/redis_lb/data'`.

`redis_lb['databases']`

:   The number of databases.

    Default value: `'16'`.

`redis_lb['dir']`

:   The working directory. The default value is the recommended value.

    Default value: `'/var/opt/opscode/redis_lb'`.

`redis_lb['enable']`

:   Enable a service.

    Default value: `true`.

`redis_lb['ha']`

:   Run the Chef Infra Server in a high availability topology. When
    `topology` is set to `ha`, this setting defaults to `true`.

    Default value: `false`.

`redis_lb['keepalive']`

:   The amount of time (in seconds) to wait for requests on a
    connection.

    Default value: `'60'`.

`redis_lb['log_directory']`

:   The directory in which log data is stored. The default value is the
    recommended value.

    Default value: `'/var/log/opscode/redis_lb'`.

`redis_lb['log_rotation']`

:   The log rotation policy for this service. Log files are rotated when
    they exceed `file_maxbytes`. The maximum number of log files in the
    rotation is defined by `num_to_keep`.

    Default value: `{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }`

`redis_lb['loglevel']`

:   The level of logging to be stored in a log file.

    Possible values:

    - `debug`
    - `notice`
    - `verbose`
    - `warning`.

    Default value: `'notice'`.

`redis_lb['maxmemory']`

:   The maximum amount of memory (in bytes).

    Default value: `'8m'`.

`redis_lb['maxmemory_policy']`

:   The policy applied when the maximum amount of memory is reached.

    Possible values:

    - `allkeys-lru` (remove keys, starting with those used least frequently)
    - `allkeys-random` (remove keys randomly)
    - `noeviction` (don't expire, return an error on write operation)
    - `volatile-lru` (remove expired keys, starting with those used least frequently)
    - `volatile-random` (remove expired keys randomly)
    - `volatile-ttl` (remove keys, starting with nearest expired time)

    Default value: `'noeviction'`.

`redis_lb['port']`

:   The port on which the service is to listen.

    Default value: `'16379'`.

`redis_lb['save_frequency']`

:   Set the save frequency in the following pattern:
    `{ "seconds" => "keys", "seconds" => "keys", "seconds" => "keys" }`.

    Default value: `{ '900' => '1', '300' => '10', '60' => '1000' }`

    The default value saves the database every 15 minutes if at least one key
    changes, every 5 minutes if at least 10 keys change, and every 60
    seconds if 10000 keys change.

`redis_lb['timeout']`

:   The amount of time (in seconds) a client may be idle before timeout.

    Default value: `'300'`.

`redis_lb['vip']`

:   The virtual IP address.

    Default value: `'127.0.0.1'`.

`redis_lb['password']`

:   Legacy configuration setting for the Redis password.

    Default value: **generated**.

    To override the default value, use the [Secrets
    Management]({{< relref "/server/ctl_chef_server#secrets-management" >}})
    command: `chef-server-ctl set-secret redis_lb password`.

### upgrades

This configuration file has the following settings for `upgrades`:

`upgrades['dir']`

:   The working directory. The default value is the recommended value.

    Default value: `'/var/opt/opscode/upgrades'`.

### user

This configuration file has the following settings for `user`:

`user['home']`

:   The home directory for the user under which Chef Infra Server
    services run.

    Default value: `/opt/opscode/embedded`.

`user['shell']`

:   The shell for the user under which Chef Infra Server services run.

    Default value: `/bin/sh`.

`user['username']`

:   The user name under which Chef Infra Server services run.

    Default value: `opscode`.

### required_recipe

`required_recipe` is a feature that allows an administrator to specify a
recipe that will be run by all Chef Infra Clients that connect to it,
regardless of the node's run list. This feature is targeted at expert
level practitioners who are delivering isolated configuration changes to
the target systems, such as self-contained agent software. Further
explanation of the feature can be found in
[Chef Infra Client Development Docs](https://github.com/chef/chef/blob/main/docs/dev/design_documents/server_enforced_recipes.md).

This configuration file has the following settings for
`required_recipe`:

`required_recipe["enable"]`

:   Whether the feature is enabled.

    Default value: `false`.

`required_recipe["path"]`

:   The location of the recipe to serve. The file must be owned by the
    root user and group, and may not be group or world-writeable.

    Default value: `nil`.
