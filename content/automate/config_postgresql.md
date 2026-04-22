+++
title = "HA PostgreSQL Node Config"
draft = false

[menu]
  [menu.automate]
    title = "HA PostgreSQL Node Config"
    parent = "automate/deploy_high_availability/configuration"
    identifier = "automate/deploy_high_availability/configuration/config_postgresql.md HA PostgreSQL Node Config"
    weight = 220
+++

## Configurations

The PostgreSQL node in Chef Automate HA provides configuration options you can use to customize its behavior and meet specific requirements. This guide documents all settings you can patch.

The detailed document about how these individual properties affect the system is at [Official PostgreSQL docs](https://www.postgresql.org/docs/13/)

Patch the below configuration to PostgreSQL nodes. Please add the values you want to patch to a `config.toml` file and run the `chef-automate config patch config.toml --pg` from the bastion.

### Logging

```bash
log_level = "ERROR"
log_line_prefix = "%t [%p]: [%l-1] user=%u,db=%d,client=%h %r (%x:%e)"
logging_collector = "on"
```

In the above snippet:

- `log_level` controls which message levels the server log records. Valid values are DEBUG5, DEBUG4, DEBUG3, DEBUG2, DEBUG1, INFO, NOTICE, WARNING, ERROR, LOG, FATAL, and PANIC. The default value is WARNING.
- `log_line_prefix` is a printf-style string output at the beginning of each log line.
- `logging_collector` enables the logging collector, which is a background process that captures log messages sent to stderr and redirects them into log files

### Checkpoints

```bash
checkpoint_timeout = "5min"
max_wal_size = "1GB"
min_wal_size = "80MB"
```

In the above snippet:

- `checkpoint_timeout` sets the longest time between automatic WAL checkpoints. The valid range is between 30 seconds and one day. The default is five minutes (5min). Increasing this parameter can increase the amount of time needed for crash recovery.
- `max_wal_size` sets the largest size that WAL can grow to during automatic checkpoints. The default is 1 GB. Increasing this parameter can increase the amount of time needed for crash recovery. Set this parameter in the PostgreSQL.conf file or on the server command line.
- `min_wal_size` helps reserve enough WAL space to handle spikes in WAL usage, for example, when running large batch jobs. If you specify this value without units, PostgreSQL treats it as megabytes. The default is 80 MB.

### Write-ahead log keep size

```bash
wal_keep_size = 1600
```

`wal_keep_size` specifies the smallest size of past log file segments kept in the pg_wal directory if a standby server needs to fetch them for streaming replication. If wal_keep_size is zero (the default), the system doesn't keep extra segments for standby purposes. As a result, the number of old WAL segments available to standby servers depends on the location of the previous checkpoint and the status of WAL archiving.

### Lock Management

```bash
max_locks_per_transaction = 64
```

The shared lock table tracks locks on `max_locks_per_transaction` * (max_connections + max_prepared_transactions) objects (for example, tables). This means the system can lock at most that number of distinct objects at a time. This parameter controls the average number of object locks allocated for each transaction. Individual transactions can lock more objects as long as all transaction locks fit in the lock table. This doesn't limit the number of rows that a transaction can lock. The default is 64.

When running a standby server, you must set this parameter to the same or higher value than on the primary server. Otherwise, the standby server won't allow queries.

### Max connections

```bash
max_connections = 350
```

The highest number of concurrent connections to the database server. The default for Chef Automate is 350 connections.

When running a standby server, set this parameter to the same or higher value than on the primary server. Otherwise, the standby server won't allow queries.

**Note:** Modifications to `max_connections` require a reboot of the leader, and the cluster elects a new leader during that reboot. The configuration reflects the updated `max_connections` value after the reboot, as described in the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-connection.html#GUC-MAX-CONNECTIONS).

### Pg Dump

```bash
[pg_dump]
enable = true
path = "/mnt/automate_backups/postgresql/pg_dump"
```

This section configures pg_dump, a PostgreSQL utility for performing database backups. It enables pg_dump and specifies the path where pg_dump stores backups.

### Replication

```bash
[replication]
name = 'replication'
password = 'replication'
# note: lag_health_threshold is in bytes - default to 300KB
# this is just greater than 1 WAL segment
lag_health_threshold = 307200
# largest lag time in seconds since log was last replayed before replica is eligible for a restart
max_replay_lag_before_restart_s = 180
max_wal_senders = 10
max_replication_slots = 5
wal_sender_timeout = 60
wal_receiver_timeout = 60
wal_compression = "off"
```

This section configures replication settings:

- `name`: replication name
- `password`: replication password.
- `lag_health_threshold`: Sets the lag health threshold to 307200 bytes (300 KB), the highest allowed replication lag.
- `max_replay_lag_before_restart_s`: Custom setting; largest lag time in seconds since log was last replayed before replica is eligible for a restart.
- `max_wal_senders`: Limits the number of standbys that can connect for replication (default: 10).
- `max_replication_slots`: Sets the number of allowed replication slots (default: 5).
- `wal_sender_timeout`: Primary waits 60 seconds for standby response before disconnecting.
- `wal_receiver_timeout`: Standby waits 60 seconds for data from primary before timing out.
- `wal_compression`: Controls compression of WAL data; "off" disables it, "on" enables it.

### Transport security settings

```bash
[ssl]
enable = true
issuer_cert = "----Enter Root CA----"
ssl_cert = "----Enter Public Key----"
ssl_key = "----Enter Private Key----"
tls_ciphers = "ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256"
```

This section configures SSL/TLS settings. It turns on SSL and specifies the root CA (issuer) certificate, the public key certificate, the private key, and the allowed TLS ciphers.

### User

```bash
[superuser]
name = "admin"
password = "admin"
```

This section specifies the username and password for the superuser (administrator) account.

### Write-ahead log archive

```bash
[wal_archive]
enable = false
path = "/mnt/automate_backups/postgresql/archive"
```

This section configures WAL archiving. It specifies whether WAL archiving is on (false in this case) and the path where the system stores archived WAL files.

### Full config for PostgreSQL node

```bash
checkpoint_timeout = "5min"
host = "0.0.0.0"
log_level = "ERROR"
log_line_prefix = "%t [%p]: [%l-1] user=%u,db=%d,client=%h %r (%x:%e)"
logging_collector = "on"
max_connections = 350
max_locks_per_transaction = 64
max_wal_size = "1GB"
min_wal_size = "80MB"
port = 5432
print_db_statistics = true
wal_keep_size = 1600
[pg_dump]
enable = true
path = "/mnt/automate_backups/postgresql/pg_dump"
[replication]
lag_health_threshold = 20480
max_replay_lag_before_restart_s = 180
name = "replication"
password = "replication"
[ssl]
enable = true
issuer_cert = "----Enter Root CA----"
ssl_cert = "----Enter Public Key----"
ssl_key = "----Enter Private Key----"
tls_ciphers = "ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256"
[superuser]
name = "admin"
password = "admin"
[wal_archive]
enable = false
path = "/mnt/automate_backups/postgresql/archive"
```

#### Example

To increase the log level to DEBUG1:

- Create a log.toml file with the below contents on bastion:

```toml
log_level = "DEBUG"
```

- Run the patch command `chef-automate config patch log.toml --pg` to apply the patch.

### Centralized logs

Take a tour of the main page to know about [Centralized logs](/automate/centralize_logs/).
