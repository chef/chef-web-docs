+++
title = "chef-backend.rb Settings"
draft = false

aliases = ["/config_rb_backend.html"]

[menu]
  [menu.infra]
    title = "chef-backend.rb"
    identifier = "chef_infra/managing_chef_infra_server/config_rb_backend.md chef-backend.rb"
    parent = "chef_infra/managing_chef_infra_server"
    weight = 185
+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/config_rb_backend.md)


## chef-backend.rb Options

{{% config_rb_backend_summary %}}

### Common 'Runit' flags for any backend service

See <https://github.com/chef-cookbooks/runit> for details. Many of the
flags are repeated across the various backend services - they are only
documented once at the top here. The same defaults are used unless
specified below.

-   `postgresql.enable` Sets up and runs this service. `true` by
    default.
-   `postgresql.environment` A hash of environment variables with their
    values as content used in the service's env directory.
-   `postgresql.log_directory` The directory where the svlogd log
    service will run. `'/var/log/chef-backend/postgresql/<version>'` by
    default.
-   `postgresql.log_rotation.file_maxbytes` The maximum size a log file
    can grow to before it is automatically rotated. `104857600` by
    default (100MB).
-   `postgresql.log_rotation.num_to_keep` The maximum number of log
    files that will be retained after rotation. `10` by default.
-   `etcd.enable`
-   `etcd.log_directory` `'/var/log/chef-backend/etcd'` by default
-   `etcd.log_rotation.file_maxbytes`
-   `etcd.log_rotation.num_to_keep`
-   `elasticsearch.enable`
-   `elasticsearch.log_directory`
    `'/var/log/chef-backend/elasticsearch'` by default. Also affects
    `path.logs` in the Elasticsearch configuration yml.
-   `elasticsearch.log_rotation.file_maxbytes`
-   `elasticsearch.log_rotation.num_to_keep`
-   `leaderl.enable`
-   `leaderl.log_directory` `'/var/log/chef-backend/leaderl'` by
    default.
-   `leaderl.start_down` Set the default state of the runit service to
    'down' by creating \<sv_dir\>/down file. `true` by default.
-   `leaderl.log_rotation.file_maxbytes`
-   `leaderl.log_rotation.num_to_keep`

### PostgreSQL settings

-   `postgresql.db_superuser` Super user account to create. Password is
    in chef-backend-secrets.json. `'chef_pgsql'` by default.
-   `postgresql.md5_auth_cidr_addresses` A list of authorized addresses
    from which other backend nodes can connect to perform streaming
    replication. `samehost` and `samenet` are special symbols to allow
    connections from the this node's IP address and its subnet. You may
    also use `all` to match any IP address. You may specify a hostname
    or IP address in CIDR format (`172.20.143.89/32` for a single host,
    or `172.20.143.0/24` for a small network. See
    <https://www.postgresql.org/docs/9.5/static/auth-pg-hba-conf.html>
    for alternative formats. `["samehost", "samenet"]` by default.
-   `postgresql.replication_user` Username used by postgres streaming
    replicator when accessing this node. `'replicator'` by default.
-   `postgresql.username` `'chef_pgsql'` by default.

### PostgreSQL settings given to `postgresql.conf`

See <https://www.postgresql.org/docs/9.5/static/runtime-config.html> for
details. Some defaults are provided:

-   `postgresql.archive_command ''`
-   `postgresql.archive_mode 'off'`
-   `postgresql.archive_timeout 0`
-   `postgresql.checkpoint_completion_target 0.5`
-   `postgresql.checkpoint_timeout '5min'`
-   `postgresql.checkpoint_warning '30s'`
-   `postgresql.effective_cache_size` Automatically calculated based on
    available memory.
-   `postgresql.hot_standby 'on'`
-   `postgresql.keepalives_count 2` Sets `tcp_keepalives_count`
-   `postgresql.keepalives_idle 60` Sets `tcp_keepalives_idle`
-   `postgresql.keepalives_interval 15` Sets `tcp_keepalives_interval`
-   `postgresql.log_checkpoints true`
-   `postgresql.log_min_duration_statement -1`
-   `postgresql.max_connections 350`
-   `postgresql.max_replication_slots 12`
-   `postgresql.max_wal_senders 12`
-   `postgresql.max_wal_size 64`
-   `postgresql.min_wal_size 5`
-   `postgresql.port 5432`
-   `postgresql.shared_buffers` Automatically calculated based on
    available memory.
-   `postgresql.wal_keep_segments 32`
-   `postgresql.wal_level 'hot_standby'`
-   `postgresql.wal_log_hints on`
-   `postgresql.work_mem '8MB'`

### etcd settings

-   `etcd.client_port 2379` Port to use for ETCD_LISTEN_CLIENT_URLS
    and ETCD_ADVERTISE_CLIENT_URLS.
-   `etcd.peer_port 2380` Port to use for ETCD_LISTEN_PEER_URLS and
    ETCD_ADVERTISE_PEER_URLS.

The following settings relate to etcd's consensus protocol. Chef Backend
builds its own leader election on top of etcd's consensus protocol.
Updating these settings may be advisable if you are seeing frequent
failover events as a result of spurious etcd connection timeouts. The
current defaults assume a high-latency environment, such those you might
find if deploying Chef Backend to various cloud providers.

-   `etcd.heartbeat_interval 500` ETCD_HEARTBEAT_INTERVAL in
    milliseconds. This is the frequency at which the leader will send
    heartbeats to followers. Etcd's documentation recommends that this
    is set roughly to the round-trip times between members. (The default
    before 1.2 was 100)
-   `etcd.election_timeout 5000` ETCD_ELECTION_TIMEOUT in
    milliseconds. This controls how long an etcd node will wait for
    heartbeat before triggering an election. Per Etcd's documentation,
    this should be 5 to 10 times larger than the
    `etcd.heartbeat_interval`. Increasing `etcd.election_timeout`
    increases the time it will take for `etcd` to detect a failure. (The
    default value before 1.2 was 1000)
-   `etcd.snapshot_count 5000` ETCD_SNAPSHOT_COUNT which is the number
    of committed transactions to trigger a snapshot to disk.
-   `etcd.ionice.class 2` etcd must be able to write to disk with minimal
    latency. If your cluster does not meet the
    [disk requirements](/install_server_ha/#hardware-requirements), e.g. you
    are running Chef Backend on virtual machines with shared disks, this
    settings should be changed to '1' (real-time scheduling) to mitigate
    unnecessary failovers under high latency conditions.
    (New in Chef Backend 2.2)
-   `etcd.ionice.level 0` if `etcd.ionice.class` is changed, this may be
    changed for further tuning to specific environments, but in almost all
    cases should not be modified.
    (New in Chef Backend 2.2)

{{< note >}}

Even though the defaults assume a high-latency environment, cloud
deployments should be restricted to the same datacenter, or in AWS, in
the same region. This means that geographically-dispersed cluster
deployments are not supported. Multiple Availability Zones *are*
supported as long as they are in the same region.

{{< /note >}}

For additional information on the etcd tunables, see
<https://coreos.com/etcd/docs/latest/tuning.html>.

### Elasticsearch JVM settings

-   `elasticsearch.heap_size` Automatically computed by Elasticsearch
    based on available memory. Specify in MB if you wish to override.
-   `elasticsearch.java_opts` Flags to directly pass to the JVM when
    launching Elasticsearch. If you override a heap flag here, the
    setting here takes precedence.
-   `elasticsearch.new_size` Java heap's new generation size.

### Elasticsearch configuration

See
<https://www.elastic.co/guide/en/elasticsearch/reference/current/settings.html>
for details.

-   `elasticsearch.plugins_directory '/var/opt/chef-backend/elasticsearch/plugins'`
    Sets `path.plugins`.
-   `elasticsearch.port 9200` Sets `http.port`.
-   `elasticsearch.scripts_directory '/var/opt/chef-backend/elasticsearch/scripts'`
    Sets `path.scripts`.

### Chef HA backend leader management service settings

-   `leaderl.db_timeout` Socket timeout when connecting to PostgreSQL in
    milliseconds. `2000` by default.
-   `leaderl.http_acceptors` Http threads that responds to monitoring
    and leadership status requests from HAProxy. `10` by default.
-   `leaderl.http_address` The address that leaderl listens on. This
    address should not be `127.0.0.1`. It should be reachable from any
    front-end node. `'0.0.0.0'` by default.
-   `leaderl.http_port` `7331` by default.
-   `leaderl.leader_ttl_seconds` The number of seconds it takes the
    leader key to expire. Increasing this value will increase the amount
    of time the cluster will take to recognize a failed leader. Lowering
    this value may lead to frequent leadership changes and thrashing.
    `30` by default (`10` by default before 1.2).
-   `leaderl.required_active_followers` The number of followers that
    must be syncing via a PostgreSQL replication slot before a new
    leader will return 200 to /leader HTTP requests. If an existing
    leader fails to maintain this quorum of followers, the /leader
    endpoint will return 503 but active connections will still be able
    to complete their writes to the database. 0 by default.
-   `leaderl.runsv_group` The group that sensitive password files will
    belong to. This is used internally for test purposes and should
    never be modified otherwise. `'chef_pgsql'` by default.
-   `leaderl.status_internal_update_interval_seconds` How often we check
    for a change in the leader service's status. 5 seconds by default.
-   `leaderl.status_post_update_interval_seconds` How often etcd is
    updated with the leader service's current status. 10 seconds by
    default.
-   `leaderl.username 'chef_pgsql'`
-   `leaderl.log_rotation.max_messages_per_second` Rate limit for the
    number of messages that the Erlang error_logger will output. `1000`
    by default.
-   `leaderl.etcd_pool.ibrowse_options` Internal options to affect how
    requests to etcd are made (see
    <https://github.com/cmullaparthi/ibrowse/blob/master/doc/ibrowse.html>).
-   `leaderl.epmd_monitor.check_interval` How often (in milliseconds) to
    check that leaderl is registered with the Erlang Port Mapping Daemon
    (epmd). `60000` by default.

### Chef HA backend leader health status settings

-   `leaderl.health_check.interval_seconds` How frequently, in seconds,
    to poll the service for health status. We recommend setting this to
    at least 5 times the value of `leaderl.leader_ttl_seconds`. 5 by
    default (2 by default before version 1.2)
-   `leaderl.health_check.max_bytes_behind_leader` Limit on maximum
    different between elected leader and current node in bytes.
    `52428800` (50MB) by default.
-   `leaderl.health_check.max_elasticsearch_failures` Number of Elasticsearch
    API failures allowed before health check fails. 5 by default.
-   `leaderl.health_check.max_etcd_failures` Number of etcd failures
    allowed before health check fails. 5 by default.
-   `leaderl.health_check.max_pgsql_failures` Number of PostgreSQL
    connection failures allowed before health check fails. 5 by default.
-   `leaderl.health_check.fatal_system_checks` Whether or not system
    check failures (such as disk space failures) will result in the node
    being marked ineligible for leadership. `false` by default. **Added
    in Chef Backend 1.4.**
-   `leaderl.health_check.disk_paths` An array containing the paths to
    check for sufficient disk space.
    `[/var/log/chef-backend, /var/opt/chef-backend]` by default. **Added
    in Chef Backend 1.4.**
-   `leaderl.health_check.disk_min_space_mb` The minimum amount of disk
    space (in megabytes) required for a disk health check to pass. `250`
    by default. **Added in Chef Backend 1.4.**

### Chef HA backend leader connection pool settings

See <https://github.com/seth/pooler/blob/master/README.org> for details.
These are internal settings that affect the responsiveness, uptime and
reliability of the backend cluster. They should not be modified unless
you are advised to do so by Support.

-   `leaderl.etcd_pool.cull_interval_seconds 60`
-   `leaderl.etcd_pool.http_timeout_ms 5000`
-   `leaderl.etcd_pool.init_count 10`
-   `leaderl.etcd_pool.max_age_seconds 60`
-   `leaderl.etcd_pool.max_connection_duration_seconds 300`
-   `leaderl.etcd_pool.max_count 10`

### SSL settings

If `certificate` and `certificate_key` are nil, the SSL Certificate will
be auto-generated using the other parameters provided. Otherwise, they
are on-disk locations to user-provided certificate.

-   `ssl.certificate` Provide this path if you have a pre-generated SSL
    cert.
-   `ssl.certificate_key` Provide this path if you have a pre-generated
    SSL cert.
-   `ssl.ciphers` Ordered list of allowed SSL ciphers. This will be
    updated based on security considerations and the version of OpenSSL
    being shipped.
-   `ssl.company_name`
-   `ssl.country_name`
-   `ssl.data_dir` Where certificates will be stored.
    `'/var/opt/chef-backend/ssl/'` by default
-   `ssl.duration` 3650 days by default (10 years).
-   `ssl.key_length` 2048 by default.
-   `ssl.organizational_unit_name`

## chef-backend-ctl

The Chef Infra Server backend HA cluster includes a command-line utility
named chef-backend-ctl. This command-line tool is used to manage the
Chef Infra Server backend HA cluster, start and stop individual
services, and tail Chef Infra Server log files. For more information,
see the [chef-backend-ctl documentation](/ctl_chef_backend/).
