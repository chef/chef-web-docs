=====================================================
Upgrade to Chef Server 12
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/upgrade_server.rst>`__

The following sections describe the upgrade process for Chef Server 12.

.. note:: Be sure to back up the Chef Infra Server data before starting the upgrade process.

From Chef Server 12
=====================================================
There are three upgrade scenarios for upgrades from earlier versions of Chef Server 12 to a newer version of Chef Server 12:

* `Standalone </upgrade_server.html#standalone>`__
* `High Availability: Chef Backend </upgrade_server.html#high-availability-chef-backend>`__
* `Tiered </upgrade_server.html#tiered>`__

.. note:: As of version 12.14, Chef Server will not render passwords outside of the ``/etc/opscode`` directory by default. If you are not using any Chef Infra Server add-ons, or you're using the latest add-on versions, you can set ``insecure_addon_compat`` to ``false`` in ``/etc/opscode/chef-server.rb``. With this option set to ``false``, Chef Infra Server writes all credentials to a single location. Note that this setting should only be applied after both the Chef Infra Server and its add-ons have been upgraded to compatible versions.

        For additional information on this change, including a list of supported add-on versions, see `Chef Infra Server Credentials Management </server_security.html#chef-infra-server-credentials-management>`_.

Standalone
-----------------------------------------------------
This section describes the upgrade process for a standalone configuration. The upgrade process will require downtime equal to the amount of time it takes to stop the server, run dpkg or RPM Package Manager, and then upgrade the server.

To upgrade to Chef Server 12 from a standalone Chef Server, do the following:

#. Run the following command to make sure all services are in a sane state.

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Download the desired Chef Infra Server version from the `Chef Infra Server Downloads <https://downloads.chef.io/chef-server>`__ page.

#. Stop the server:

   .. code-block:: bash

      $ chef-server-ctl stop

#. Run dpkg or RPM Package Manager.

   For dpkg:

   .. code-block:: bash

      $ dpkg -i /path/to/chef-server-core-<version>.deb

   For RPM Package Manager:

   .. code-block:: bash

      $ rpm -Uvh --nopostun /path/to/chef-server-core-<version>.rpm

#. Upgrade the server with the following command:

   .. code-block:: bash

      $ chef-server-ctl upgrade

#. Start Chef Server 12:

   .. code-block:: bash

      $ chef-server-ctl start

#. `Upgrade <upgrade_server.html#upgrading-add-ons>`__ the Chef Infra Server add-ons.

#. After the upgrade process is complete and everything is tested and verified to be working properly, clean up the server by removing all of the old data:

   .. code-block:: bash

      $ chef-server-ctl cleanup

High Availability: Chef Backend
-----------------------------------------------------
The Chef Infra Server can operate in a high availability configuration that provides automated load balancing and failover for stateful components in the system architecture.

To upgrade your Chef Backend installation, see `High Availability: Upgrade to Chef Backend 2 </upgrade_server_ha_v2.html>`_.
The upgrade process will require downtime equal to the amount of time it takes to stop the server, run dpkg or RPM Package Manager, and then upgrade the server.

To upgrade Chef Backend from an existing DRBD/keepalived configuration, see the `Best Best Practices for Migrating Your Chef Server <https://blog.chef.io/2018/04/06/best-practices-for-migrating-your-chef-server/>`__ webinar from the `Chef Blog <https://blog.chef.io/>`__

Tiered
-----------------------------------------------------
This section describes the upgrade process from a tiered server configuration. The upgrade process will require downtime equal to the amount of time it takes to stop the server, run dpkg or RPM Package Manager, and then upgrade the server.

.. note:: These instructions are primarily intended for existing users of the ``tier`` Chef Infra Server topology. For the latest information on high availability and how to set up a highly-available server cluster, see `High Availability: Backend Cluster </install_server_ha.html>`__

To upgrade to Chef Server 12 from a tiered Chef Infra Server configuration, do the following:

#. Run the following on all servers to make sure all services are in a sane state.

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Download the desired Chef Infra Server version from the `Chef Infra Server Downloads <https://downloads.chef.io/chef-server>`__ page, then copy it to each server.

#. Stop all of the front end servers:

   .. code-block:: bash

      $ chef-server-ctl stop

#. Run dpkg or RPM Package Manager on all servers.

   For dpkg:

   .. code-block:: bash

      $ dpkg -i /path/to/chef-server-core-<version>.deb

   For RPM Package Manager:

   .. code-block:: bash

      $ rpm -Uvh --nopostun /path/to/chef-server-core-<version>.rpm

#. Stop the back end server:

   .. code-block:: bash

      $ chef-server-ctl stop

#. Upgrade the back end server:

   .. code-block:: bash

      $ chef-server-ctl upgrade

#. Copy the entire ``/etc/opscode`` directory from the back end server to all front end servers:

   .. code-block:: none

      $ scp -r /etc/opscode <each server's IP>:/etc

#. Upgrade each of the front end servers:

   .. code-block:: bash

      $ chef-server-ctl upgrade

#. Run the following command on both the front end, and back end servers:

   .. code-block:: bash

      $ chef-server-ctl start

#. `Upgrade <upgrade_server.html#upgrading-add-ons>`__ the Chef Infra Server add-ons on each server.

#. After the upgrade process is complete, the state of the system after the upgrade has been tested and verified, and everything looks satisfactory, remove old data, services, and configuration by running the following command on each server:

   .. code-block:: bash

      $ chef-server-ctl cleanup

Upgrading Add-ons
=====================================================
This section details the process for upgrading additional features after the Chef Infra Server has been upgraded.

**Use Downloads**

.. tag ctl_chef_server_install_features_download

The ``install`` subcommand downloads packages from https://packages.chef.io/ by default. For systems that are not behind a firewall (and have connectivity to https://packages.chef.io/), these packages can be installed as described below.

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Feature
     - Command
   * - Chef Manage
     - Use Chef management console to manage data bags, attributes, run-lists, roles, environments, and cookbooks from a web user interface.

       On the Chef Infra Server, run:

       .. code-block:: bash

          $ sudo chef-server-ctl install chef-manage

       then:

       .. code-block:: bash

          $ sudo chef-server-ctl reconfigure

       and then:

       .. code-block:: bash

          $ sudo chef-manage-ctl reconfigure

       To accept the `Chef MLSA </chef_license.html>`__:

       .. code-block:: bash

          $ sudo chef-manage-ctl reconfigure --accept-license

.. end_tag

**Use Local Packages**

.. tag ctl_chef_server_install_features_manual

The ``install`` subcommand downloads packages from https://packages.chef.io/ by default. For systems that are behind a firewall (and may not have connectivity to packages.chef.io), these packages can be downloaded from https://downloads.chef.io/chef-manage/, and then installed manually. First download the package that is appropriate for the platform, save it to a local path, and then run the ``install`` command using the ``--path`` option to specify the directory in which the package is located:

.. code-block:: bash

   $ sudo chef-server-ctl install PACKAGE_NAME --path /path/to/package/directory

For example:

.. code-block:: bash

   $ sudo chef-server-ctl install chef-manage --path /root/packages

The ``chef-server-ctl`` command will install the first ``chef-manage`` package found in the ``/root/packages`` directory.

.. end_tag
