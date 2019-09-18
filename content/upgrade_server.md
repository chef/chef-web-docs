+++
title = "Upgrade to Chef Server 12"
draft = false

aliases = "/upgrade_server.html"

[menu]
  [menu.docs]
    title = "Upgrades"
    identifier = "chef_infra/managing_chef_infra_server/upgrade_server.md Upgrades"
    parent = "chef_infra/managing_chef_infra_server"
    weight = 120
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/upgrade_server.rst)

The following sections describe the upgrade process for Chef Server 12.

{{< info >}}

Be sure to back up the Chef Infra Server data before starting the
upgrade process.

{{< /info >}}

From Chef Server 12
===================

There are three upgrade scenarios for upgrades from earlier versions of
Chef Server 12 to a newer version of Chef Server 12:

-   [Standalone](/upgrade_server.html#standalone)
-   [High availability](/upgrade_server.html#high-availability)
-   [Tiered](/upgrade_server.html#tiered)

{{< info >}}

As of version 12.14, Chef Server will not render passwords outside of
the `/etc/opscode` directory by default. If you are not using any Chef
Infra Server add-ons, or you're using the latest add-on versions, you
can set `insecure_addon_compat` to `false` in
`/etc/opscode/chef-server.rb`. With this option set to `false`, Chef
Infra Server writes all credentials to a single location. Note that this
setting should only be applied after both the Chef Infra Server and its
add-ons have been upgraded to compatible versions.

For additional information on this change, including a list of supported
add-on versions, see [Chef Infra Server Credentials
Management](/server_security.html#chef-infra-server-credentials-management).

{{< /info >}}

Standalone
----------

This section describes the upgrade process for a standalone
configuration. The upgrade process will require downtime equal to the
amount of time it takes to stop the server, run dpkg or RPM Package
Manager, and then upgrade the server.

To upgrade to Chef Server 12 from a standalone Chef Server, do the
following:

1.  Run the following command to make sure all services are in a sane
    state.

    ``` bash
    $ chef-server-ctl reconfigure
    ```

2.  Download the desired Chef Infra Server version from the [Chef Infra
    Server Downloads](https://downloads.chef.io/chef-server) page.

3.  Stop the server:

    ``` bash
    $ chef-server-ctl stop
    ```

4.  Run dpkg or RPM Package Manager.

    For dpkg:

    ``` bash
    $ dpkg -i /path/to/chef-server-core-<version>.deb
    ```

    For RPM Package Manager:

    ``` bash
    $ rpm -Uvh --nopostun /path/to/chef-server-core-<version>.rpm
    ```

5.  Upgrade the server with the following command:

    ``` bash
    $ chef-server-ctl upgrade
    ```

6.  Start Chef Server 12:

    ``` bash
    $ chef-server-ctl start
    ```

7.  [Upgrade](upgrade_server.html#upgrading-add-ons) the Chef Infra
    Server add-ons.

8.  After the upgrade process is complete and everything is tested and
    verified to be working properly, clean up the server by removing all
    of the old data:

    ``` bash
    $ chef-server-ctl cleanup
    ```

High Availability
-----------------

This section describes the upgrade process from a high availability
configuration. The upgrade process will require downtime equal to the
amount of time it takes to stop the server, run dpkg or RPM Package
Manager, and then upgrade the server.

The DRBD/Keepalived based HA system is no longer supported in Chef Infra
Server 13. If a high availablity system is needed, backup and restore to
a Chef Backend based installation.

Tiered
------

This section describes the upgrade process from a tiered server
configuration. The upgrade process will require downtime equal to the
amount of time it takes to stop the server, run dpkg or RPM Package
Manager, and then upgrade the server.

{{< info >}}

These instructions are primarily intended for existing users of the
`tier` Chef Infra Server topology. For the latest information on high
availability and how to set up a highly-available server cluster, see
[High Availability: Backend Cluster](/install_server_ha.html)

{{< /info >}}

To upgrade to Chef Server 12 from a tiered Chef Infra Server
configuration, do the following:

1.  Run the following on all servers to make sure all services are in a
    sane state.

    ``` bash
    $ chef-server-ctl reconfigure
    ```

2.  Download the desired Chef Infra Server version from the [Chef Infra
    Server Downloads](https://downloads.chef.io/chef-server) page, then
    copy it to each server.

3.  Stop all of the front end servers:

    ``` bash
    $ chef-server-ctl stop
    ```

4.  Run dpkg or RPM Package Manager on all servers.

    For dpkg:

    ``` bash
    $ dpkg -i /path/to/chef-server-core-<version>.deb
    ```

    For RPM Package Manager:

    ``` bash
    $ rpm -Uvh --nopostun /path/to/chef-server-core-<version>.rpm
    ```

5.  Stop the back end server:

    ``` bash
    $ chef-server-ctl stop
    ```

6.  Upgrade the back end server:

    ``` bash
    $ chef-server-ctl upgrade
    ```

7.  Copy the entire `/etc/opscode` directory from the back end server to
    all front end servers:

    ``` none
    $ scp -r /etc/opscode <each server's IP>:/etc
    ```

8.  Upgrade each of the front end servers:

    ``` bash
    $ chef-server-ctl upgrade
    ```

9.  Run the following command on both the front end, and back end
    servers:

    ``` bash
    $ chef-server-ctl start
    ```

10. [Upgrade](upgrade_server.html#upgrading-add-ons) the Chef Infra
    Server add-ons on each server.

11. After the upgrade process is complete, the state of the system after
    the upgrade has been tested and verified, and everything looks
    satisfactory, remove old data, services, and configuration by
    running the following command on each server:

    ``` bash
    $ chef-server-ctl cleanup
    ```

Upgrading Add-ons
=================

This section details the process for upgrading additional features after
the Chef Infra Server has been upgraded.

**Use Downloads**

{{% ctl_chef_server_install_features_download %}}

**Use Local Packages**

{{% ctl_chef_server_install_features_manual %}}
