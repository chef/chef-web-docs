+++
title = "Chef Backend Release Notes"
draft = false
product = []

[menu]
  [menu.release_notes]
    title = "Chef Backend"
    identifier = "release_notes/Chef Backend"
    parent = "release_notes"
    weight = 20
+++

{{< warning >}}

Chef Backend is [deprecated](/versions/#deprecated-products-and-versions) and no longer under active development. Contact your Chef account representative for information about migrating to Chef Automate HA.

{{< /warning >}}

## Chef Backend 3.1.1

### Bug Fixes

- Fixed an issue where new nodes would fail to join a backend cluster installed with Chef Backend 3.0.0 ([#770](https://github.com/chef/chef-backend/pull/770)).

### Security

#### OpenJDK 11.0.14

Updated OpenJDK from 11.0.13 to 11.0.14 to resolve the following CVEs:

- CVE-2022-21248: Enhance cross VM serialization
- CVE-2022-21283: Better String matching
- CVE-2022-21291: Better verification of scan methods
- CVE-2022-21293: Improve String constructions
- CVE-2022-21294: Enhance construction of Identity maps
- CVE-2022-21282: Better resolution of URIs
- CVE-2022-21296: Improve SAX Parser configuration management
- CVE-2022-21299: Improved scanning of XML entities
- CVE-2022-21277: Improve TIFF file handling
- CVE-2022-21305: Better array indexing
- CVE-2022-21340: Verify Jar Verification
- CVE-2022-21341: Improve serial forms for transport
- CVE-2022-21360: Enhance BMP image support
- CVE-2022-21365: Enhanced BMP processing

## Chef Backend 3.0.0

### Enhancements

#### Elasticsearch 6.8.23

Updated Elasticsearch from 5.6.16 to 6.8.23. This new version of Elasticsearch improves performance, reliability, and adds many new capabilities. Additionally, the 5.6.16 release of Elasticsearch is no longer supported by Elastic and does not receive security updates.

Elasticsearch 6.8.23 resolves multiple CVEs and updates Log4j to 2.17.1, which resolves CVE-2021-44832, CVE-2021-45105, CVE-2021-45046, and CVE-2021-44228. While Elastic has stated that Elasticsearch is not vulnerable to these CVEs, we realize many organizations have internal requirements to upgrade legacy Log4j installations.

### Upgrading

You can upgrade to Chef Backend 3.0.0 directly from version 2.1.0 or later using a rolling upgrade where one Chef Backend node is upgraded at a time. It does not require a complete cluster shutdown to perform the upgrade. See the upgrade matrix below and our [Chef Backend upgrade documentation](https://docs.chef.io/server/upgrade_server_ha_v2/) for additional information.

| Upgrade Workflow     | Method                                                                                                                                                                                                                           |
|----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1.x -> 2.x           | [Major version upgrade](https://docs.chef.io/server/upgrade_server_ha_v2/#chef-backend-1x-to-2x-upgrade)                                                                                                                         |
| 2.0.x -> 2.x         | [Rolling upgrade](https://docs.chef.io/server/upgrade_server_ha_v2/#update-chef-backend)                                                                                                                                         |
| 2.1 and later -> 3.0 | [Rolling upgrade](https://docs.chef.io/server/upgrade_server_ha_v2/#update-chef-backend)                                                                                                                                         |
| 2.0 -> 3.0           | Direct upgrades are not supported at this time. You can upgrade to an intermediate version and then to 3.0.0. For example, 2.0.1 -> 2.3.16 -> 3.0.0. Both of these steps would be rolling upgrades that do not require downtime. |

## Chef Backend 2.3.16

### Fixes

- Chef Infra Client, which is used in the `chef-backend-ctl reconfigure` command, has been updated from 15.x to 16.17 to resolve EOL warnings when running.

### Enhancements

- `chef-backend-ctl backup` no longer backs up the Elasticsearch cluster to speed up backup times. Users restoring a backed-up cluster can instead run `chef-server-ctl reindex --all` from a frontend node to generate new data in Elasticsearch.

### Packaging

#### Newly Supported Platforms

We now produce Chef Backend packages for SLES 15, Amazon Linux 2, and Ubuntu 20.04.

#### Deprecated Platforms

Chef Backend packages are no longer produced for RHEL 6, as this platform is now end-of-life.

#### RPM Package Digests

Updated the file digest in Chef Backend RPM packages from MD5 to SHA256 to prevent failures from installing on some FIPS-enabled systems.

### Security

#### Log4j Mitigation

We mitigated the Log4j vulnerability outlined in CVE-2021-44228 by disabling message formatting within logging. Chef Backend is not vulnerable to this CVE in Log4j, but this avoids security concerns with this CVE.

#### Ruby 2.7.5

Updated Ruby from 2.6.5 to 2.7.5 for improved performance and to resolve the following CVEs:

- CVE-2021-41817
- CVE-2021-41819
- CVE-2021-31810
- CVE-2021-32066
- CVE-2021-31799
- CVE-2020-25613
- CVE-2021-28965
- CVE-2020-10663
- CVE-2020-10933

#### OpenSSL 1.0.2zb

Updated OpenSSL from 1.0.2v to 1.0.2zb to resolve issues with Let's Encrypt certificates and to resolve the following CVEs:

- CVE-2021-3712
- CVE-2021-23841
- CVE-2021-23840
- CVE-2021-23839
- CVE-2020-1971
- CVE-2020-1968

#### OpenJDK 11.0.13+8

Updated OpenJDK from 11.0.7+10 to 11.0.13+8 to resolve the following CVEs:

- CVE-2021-35550
- CVE-2021-35565
- CVE-2021-35556
- CVE-2021-35559
- CVE-2021-35561
- CVE-2021-35564
- CVE-2021-35567
- CVE-2021-35578
- CVE-2021-35586
- CVE-2021-35603
- CVE-2021-2341
- CVE-2021-2369
- CVE-2021-2388
- CVE-2021-2163
- CVE-2021-2161
- CVE-2020-14779
- CVE-2020-14781
- CVE-2020-14782
- CVE-2020-14792
- CVE-2020-14796
- CVE-2020-14797
- CVE-2020-14798
- CVE-2020-14803

#### PostgreSQL 9.5.25

Updated PostgreSQL from 9.5.19 to 9.5.25 to resolve the following CVEs:

- CVE-2020-14350
- CVE-2020-25695
- CVE-2020-25694
- CVE-2020-25696

## Chef Backend 2.2.0

### Improvements

#### Improve Health Checker

The health checker has been modified to reduce the number of unnecessary fail-overs. Changes to the health checker include:

- The PostgreSQL health-check makes fewer calls to PostgreSQL
- All PostgreSQL failures are subject to health check retries (bug fix)
- Removed the etcd health-check because the main leader election detects etcd failures first

#### ionice Configuration Options

New `ionice` settings for controlling the disk input/output scheduling `class` and `set` priority for the `etcd` process
have been added. `etcd.ionice.class` and `etcd.ionice.level` settings with the default values of `2` and `0` respectively. The default values mirror the current system defaults on Linux.

#### Leader Endpoint Caching

The `/leader` endpoint now serves a locally cached response. This should reduce the possibility of timeouts returned to clients polling the `/leader` endpoint. The Chef Infra Server polls the `/leader` endpoint, and thus we believe this change will reduce some Chef Backend outages that resulted from `/leader` request timeouts.

### Bug Fixes

- Fixed PostgreSQL validator problem that prevented `join-cluster` from running to completion

### Component Updates

#### Chef Infra Client 15.12.22

The embedded Chef Infra Client used for Chef Backend configuration has been updated from 14.14.25 to 15.12.22

#### Ruby 2.6.5

Ruby has been updated from 2.5.7 to 2.6.5 for improved performance.

## Chef Backend 2.1.0

### Improvements

#### OpenJDK

We have moved from OracleJDK to AdoptOpenJDK. Oracle has changed its license on newer versions of the JDK. The OpenJDK project is delivering security updates in a version with a more open-source-friendly licensing policy.

#### Increased Elasticsearch Memory Allocation

Elasticsearch is now allocated 1/3rd of available memory up to 32GB instead of 1/4th. Elasticsearch recommends using 1/2 of the available system memory, up to 32GB. We slightly reduced the allocated memory to allow room for other Chef Backend services.

### Component Updates

#### Erlang 18.3

The Erlang language used to build Chef Backend has been updated from 18.2 to 18.3 to improve reliability.

#### Etcd 2.3.8

Etcd has been updated from 2.3.7 to 2.3.8 to resolve bugs.

#### Chef Infra Client 14.14.25

The embedded Chef Infra Client that configures Chef Backend has been updated from 14.11.21 to 14.14.25

### Security Fixes

#### Elasticsearch 5.6.16

Elasticsearch has been updated from 5.4.1 to 5.6.16 to resolve a large number of bugs, improve performance, and resolve the following CVEs:

- CVE-2017-8442
- CVE-2019-7611

#### Ruby 2.5.7

Ruby has been updated from 2.4.4 to 2.5.7 for performance improvements, bug fixes, and to resolve the following CVEs:

- CVE-2012-6708
- CVE-2015-9251
- CVE-2018-16395
- CVE-2018-16396
- CVE-2019-15845
- CVE-2019-16201
- CVE-2019-16254
- CVE-2019-16255
- CVE-2019-8320
- CVE-2019-8321
- CVE-2019-8322
- CVE-2019-8323
- CVE-2019-8324
- CVE-2019-8325

#### PostgreSQL 9.5.19

PostgreSQL has been updated from 9.5.6 to 9.5.19 to resolve a large number of bugs and the following CVEs:

- CVE-2017-12172
- CVE-2017-15099
- CVE-2017-7484
- CVE-2017-7485
- CVE-2017-7486
- CVE-2017-7546
- CVE-2017-7547
- CVE-2017-7548
- CVE-2018-1053
- CVE-2018-1058
- CVE-2018-10915
- CVE-2018-10925
- CVE-2019-10130
- CVE-2019-10208

### Packaging

#### New Platforms

- Added support for RHEL 8.

#### Deprecations

- Removed support for Ubuntu 14.04.
- Removed support for SLES 11.

## Chef Backend 2.0.30

### Enhancements

#### Backup Timeout Control

The backup command now includes a new `--timeout` flag that controls the timeout duration in seconds. This defaults to 600 seconds.

#### Cluster Status

The cluster status command now reports leaders that are blocked and leaders that are eligible.

#### Elasticsearch Temporary Files

Elasticsearch temporary files are now stored in `/var/opt/chef-backend/elasticsearch/tmp`. This value can be changed with a new `elasticsearch['temp_directory']` configuration option.

Eleasticsearch tmp directory is not its own tmp directory.

### Component Upgrades

#### Chef Infra Client 13.9.1

The embedded Chef Infra Client that configures Chef Backend has been updated from 13.3.42 to 13.9.1.

### Security

#### SSL Ciphers

Out-of-the-box SSL security has been improved by removing older and less secure SSL ciphers from the list of allowed SSL ciphers.

#### Ruby 2.4.4

Ruby has been updated from 2.3.5 to 2.4.4 to improve performance and to resolve the following CVEs:

- CVE-2017-17405
- CVE-2017-17742
- CVE-2018-6914
- CVE-2018-8777
- CVE-2018-8778
- CVE-2018-8779
- CVE-2018-8780

## Chef Backend 2.0.1

We've bumped the major version because of a breaking change in the upgrade procedure. Upgrading to this version will require full cluster downtime. Before upgrading, please see our guide to [upgrading to Chef Backend 2](https://docs.chef.io/server/upgrade_server_ha_v2/).

### Enhancements

#### Elasticsearch 5

We now ship Elasticsearch 5 by default. This requires a full cluster downtime during the upgrade. Please see the [upgrade instructions](https://docs.chef.io/server/upgrade_server_ha_v2/) for this release for details.

#### Improved Health Checking for demoted leaders

During demotion, the management service leaderl stops PostgreSQL. Previously this would result in all health checks for PostgreSQL failing, meaning the node could not resume leadership. Now, we track whether PostgreSQL is only down because of action taken by leaderl, allowing demoted leades to resume leadership in some cases.

### Bug Fixes

#### EPMD fails on certain IPv6 configurations

This build should fix issues related to the Erlang Port Mapper Daemon (EMPD) failing to start in some EPMD configurations.

### Security Fixes

#### Java 8u144

Updated the version of Java to 8u144 to address CVE-2017-3526.

#### Ruby 2.3.5

Update the version of Ruby to 2.3.5 to address multiple CVEs.

## Chef Backend 1.4.6

### Bug Fix

#### Update minimum_master_nodes on Elasticsearch node removal

This fixes an issue when removing nodes from the cluster would not
adapt the minimum node count required for the Elasticsearch cluster
managed by Chef Backend, leaving the cluster in an unrecoverable
state.

### Enhancements

#### Include disk status in health checks, and status output

When the available disk space for the log and data directories used
by Chef Backend falls below a user-configurable value (default:
250MB). By default disk space failures are considered non-fatal for
the purposes of leaderl health checks. That is, low disk space will
not force a fail over. To make disk space failures fatal, set the
following configuration option:

```
leaderl.health_check.fatal_system_checks true
```

The disk-space-related health status can be queried using:

```
chef-backend-ctl status disk
```

which is exposed via the status endpoint.

#### Improve robustness regarding EPMD

The Erlang Port Mapper Daemon (EMPD) is part of the Erlang runtime
system. Typically, this service is started automatically by the
first Erlang process to start on a machine. By promoting EPMD to a
service under supervision the service will now appear in
`chef-backend-ctl status` and will be restarted on failure.

  Further, leaderl will now periodically attempt to re-register itself
  with EPMD if EPMD has failed.

### Security Updates

Bump zlib to 1.2.11.

## Chef Backend 1.3.2

The release is a bug-fix release.

### Bug Fixes

- Multiple bugs in the backup and restore process have been
fixed.  We recommend all users take a new backup after upgrading.
See [our documentation](https://docs.chef.io/server/server_backup_restore/#backup-and-restore-a-chef-backend-install) for information on how to backup and restore your Chef Infra Server.

- The pgsql-promote function now waits up to 5 minutes for
recovery.done to appear. Previously it would only wait 5 seconds.

### Enhancements

- Reduced flicker on slower terminals when rendering progress indicators.

## Chef Backend 1.2.5

This release fixes a number of stability issues with 1.1.2. We recommend that all users
of Chef Backend 1.1.2 and prior upgrade.

### Enhancements

- Fail follower health check if the node falls too far
behind leader. This is configurable with the
`leaderl.health_check.max_bytes_behind_leader` option.

- The following etcd configuration options are now
available for customization in `/etc/chef-backend/chef-backend.rb`:

  - `etcd.election_timeout`
  - `etcd.heartbeat_interval`
  - `etcd.snapshot_count`

- Bump etcd to 2.3.7

- Upgrade to postgresql 9.5.5

- Health Checks can now fail up to a configurable number
  of times before triggering a failover. Users can configure the
  maximum failures for each service via the following configuration
  settings:

  - `leaderl.health_check.max_elasticsearch_failures`
  - `leaderl.health_check.max_etcd_failures`
  - `leaderl.health_check.max_pgsql_failures`

  If you have manually set these flags in chef-backend.rb, your
  overrides will still be respected. Please remove these options if
  you'd prefer to use the new defaults instead.

- Add a `--force-basebackup` option to the `pgsql-follow`
  command. This allows for a more straightforward recovery procedure
  in cases where human intervention is needed.

- Report 503 from /leaderl if a user-specified number of
  followers haven't initiated replication connections.This is
  tunable with the `leaderl.required_active_followers` configuration
  option (default: 0)

- No longer set shmmax sysctl's as they are no longer
  required by postgresql 9.5. If you are upgrading from a previous
  installation, remember to remove postgresql.shmmax and
  postgresql.shmall from your chef-backend.rb.

- Update configuration defaults based on customer
  feedback. We've changed the following configuration defaults:

  - `leaderl.health_check.interval_seconds` from 2 to 5 seconds.
  - `leaderl.leaderl_ttl_seconds` from 10 to 30.
  - `etcd.heartbeat_interval` from 100 to 500 milliseconds.
  - `etcd.election_timeout` from 1000 to 5000 milliseconds.

  The new defaults have proven to reduce spurious failovers when
  deploying Chef Backend to various cloud providers. If you have
  manually set these flags in chef-backend.rb, your overrides will
  still be respected. Please remove these options if you'd prefer
  to use the new defaults instead.

### Bug Fixes

- `chef-server-ctl cluster-status` shouldn't fail because of
missing leader key.

- Force a checkpoint after promoting the local postgresql
instance, avoiding some cases of postgresql followers failing to
start syncrounous replication after a failover.

- chef-backend-ctl restore shouldn't fail with a
NoMethodError.

- Wait for postgresql to be started via a test connection
rather than a simple process check during the promotion and follow
processes. This fixes a number of cases were postgresql would fail
to promote during a failover event.

- Ensure that the leader key keeps the leader key as long as
it is still in the `promoting` state. This fixes some cases where
the cluster would become leaderless after a failover event because
the elected follower was slow to promote.

- Don't erroneously report etcd as down in `chef-backend-ctl
status` in cases where etcd is up but there is no leaderl leader.

## Chef Backend 1.1.2

### Enhancements

- `cluster-status` now shows which node a follower is following
- It is now possible to clean up a partially added node with `chef-backend-ctl remove-node`.
- Stability improvements in leader election

### Bug Fixes

- Ensure that elasticsearch uses the correct directory
- Do not create recovery.conf on leader
- Gracefully handle failover while syncing.
- Retry etcd connections when chef-backend-ctl is waiting for leader.
- in multi-IP hosts, only test the specified IP and not all.
- Do not overwrite existing configuration
- Other: Misc code cleanups
