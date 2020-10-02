+++
title = "Upgrade Chef Infra Server"
draft = false

aliases = ["/upgrade_server.html"]

[menu]
  [menu.infra]
    title = "Upgrades"
    identifier = "chef_infra/managing_chef_infra_server/upgrade_server.md Upgrades"
    parent = "chef_infra/managing_chef_infra_server"
    weight = 120
+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/upgrade_server.md)

## Chef Infra Server Upgrade Matrix

| Installed Version | Upgrade Version | EULA | Upgrade Supported |
|---------|---------|------|-----------|
| 13 | 14 | Yes | Yes |
| 12.17.15 | 14 | Yes | Yes |
| 12.3.0 | 12.17.15 | No | No |
| 11 | 12.3.0 | No | No |

EULA
: Chef Infra Server 13 and 14 are governed by the [EULA License Agreement](https://docs.chef.io/chef_license_accept/#chef-infra-server). You will be required to accept these terms when using Chef Infra Server 13 for the first time.

Upgrade Supported
: Chef Infra Server 13 and 14 are supported Chef Software distributions and all earlier versions are no longer supported. For more information about supported Chef Software see the [Supported Versions](https://docs.chef.io/versions/#supported-commercial-distributions) documentation.

## Upgrading to Chef Infra Server

Three upgrade scenarios exist for upgrades from Chef Infra Server 12.17.15 to Chef Infra Server 13 or 14:

- [Standalone](/upgrade_server/#standalone-upgrade)
- [High Availability: Chef Backend](/upgrade_server/#chef-backend-upgrade)
- [Tiered](/upgrade_server/#tiered-upgrade)

### Chef Infra Server 14

{{< warning >}}

Do not upgrade your production server. First, upgrade in your test server, and then upgrade your production server.

{{< /warning >}}

Chef Infra Server 14 uses Elasticsearch as its search index.
Upgrading to Chef Infra Server 14 requires a reindexing operation for internal Solr users, which automatically happens.
This reindexing operation is estimated to take 2 minutes per 1000 nodes.
This estimate can be substantially impacted by your server hardware and the complexity of your Chef data.

No reindexing will occur for existing external Elasticsearch users upgrading to Chef Infra Server 14.

### Chef Infra Server 12.17.15 or Later

As of version 12.14, Chef Infra Server will not render passwords outside of the `/etc/opscode` directory by default.
If you are not using any Chef Infra Server add-ons, or you're using the latest add-on versions, you
can set `insecure_addon_compat` to `false` in `/etc/opscode/chef-server.rb`.
With this option set to `false`, Chef Infra Server writes all credentials to a single location.
Note that this setting should only be applied after both the Chef Infra Server and its add-ons have been upgraded to compatible versions.

For additional information on this change, including a list of supported add-on versions, see [Chef Infra Server Credentials Management](/server_security/#chef-infra-server-credentials-management).

## Standalone Upgrade

This section describes the upgrade process for a standalone configuration. The upgrade process will require downtime equal to the amount of time it takes to stop the server, run dpkg or RPM Package
Manager, and then upgrade the server.

To upgrade to Chef Infra Server 14 from a standalone Chef Infra Server, do the following:

1. Back up the Chef Infra Server data before starting the upgrade process using [knife-ec-backup](https://github.com/chef/knife-ec-backup).

1. Run the following command to make sure all services are in a sane
    state.

    ``` bash
    chef-server-ctl reconfigure
    ```

1. Download the desired Chef Infra Server version from the [Chef Infra
    Server Downloads](https://downloads.chef.io/chef-server) page.

1. Stop the server:

    ``` bash
    chef-server-ctl stop
    ```

1. Run dpkg or RPM Package Manager.

    For dpkg:

    ``` bash
    dpkg -i /path/to/chef-server-core-<version>.deb
    ```

    For RPM Package Manager:

    ``` bash
    rpm -Uvh --nopostun /path/to/chef-server-core-<version>.rpm
    ```

1. Upgrade the server with the following command. You will
    need to type `Yes` to accept the Chef License for version 13.

    ``` bash
    chef-server-ctl upgrade
    ```

    To accept the license and upgrade to version 14 in one command:

    ```bash
    CHEF_LICENSE='accept' chef-server-ctl upgrade
    ```

1. Start Chef Infra Server 14:

    ``` bash
    chef-server-ctl start
    ```

1. [Upgrade](#upgrading-add-ons) the Chef Infra
    Server add-ons.

1. After the upgrade process is complete and everything is tested and
    verified to be working properly, clean up the server by removing all
    of the old data:

    ``` bash
    chef-server-ctl cleanup
    ```

## Chef Backend Upgrade

The Chef Infra Server can operate in a high availability configuration that provides automated load balancing and failover for stateful components in the system architecture.

To upgrade your Chef Backend installation, see [High Availability: Upgrade to Chef Backend 2](/upgrade_server_ha_v2/).
The upgrade process will require downtime equal to the amount of time it takes to stop the server, run dpkg or RPM Package Manager, and then upgrade the server.

To upgrade Chef Backend from an existing DRBD/keepalived configuration, see the [Best Best Practices for Migrating Your Chef Server](https://blog.chef.io/2018/04/06/best-practices-for-migrating-your-chef-server/) webinar from the [Chef Blog](https://blog.chef.io/).

## Tiered Upgrade

This section describes the upgrade process from a tiered server configuration.
The upgrade process will require downtime equal to the amount of time it takes to stop the server, run dpkg or RPM Package Manager, and then upgrade the server.

{{< note >}}

These instructions are primarily intended for existing users of the `tier` Chef Infra Server topology.
For the latest information on high availability and how to set up a highly-available server cluster, see [High Availability: Backend Cluster](/install_server_ha/).

{{< /note >}}

To upgrade to Chef Infra Server 14 from a tiered Chef Infra Server configuration, do the following:

1. Back up the Chef Infra Server data before starting the upgrade process using [knife-ec-backup](https://github.com/chef/knife-ec-backup).

1. Run the following on all servers to make sure all services are in a sane state.

    ``` bash
    chef-server-ctl reconfigure
    ```

1. Download the desired Chef Infra Server version from the [Chef Infra Server Downloads](https://downloads.chef.io/chef-server) page, then copy it to each server.

1. Stop all of the front end servers:

    ``` bash
    chef-server-ctl stop
    ```

1. Run dpkg or RPM Package Manager on all servers.

    For dpkg:

    ``` bash
    dpkg -i /path/to/chef-server-core-<version>.deb
    ```

    For RPM Package Manager:

    ``` bash
    rpm -Uvh --nopostun /path/to/chef-server-core-<version>.rpm
    ```

1. Stop the back end server:

    ``` bash
    chef-server-ctl stop
    ```

1. Upgrade the backend server with the following command. You will need to type `Yes` to accept Chef License for version 13.

    ``` bash
    chef-server-ctl upgrade
    ```

    To accept the license and upgrade to version 14 in one command:

    ```bash
    CHEF_LICENSE='accept' chef-server-ctl upgrade
    ```

1. Copy the entire `/etc/opscode` directory from the back end server to all front end servers:

    ``` none
    scp -r /etc/opscode <each server's IP>:/etc
    ```

1. Upgrade each of the front end servers:

    ``` bash
    chef-server-ctl upgrade
    ```

1. Run the following command on both the front end, and back end servers:

    ``` bash
    chef-server-ctl start
    ```

1. [Upgrade](#upgrading-add-ons) the Chef Infra Server add-ons on each server.

1. After the upgrade process is complete, the state of the system after the upgrade has been tested and verified, and everything looks satisfactory, remove old data, services, and configuration by running the following command on each server:

    ``` bash
    chef-server-ctl cleanup
    ```

## Upgrading Add-ons

This section details the process for upgrading additional features after the Chef Infra Server has been upgraded.

**Use Downloads**

{{% ctl_chef_server_install_features_download %}}

**Use Local Packages**

{{% ctl_chef_server_install_features_manual %}}
