=====================================================
Upgrade to Chef Server 12
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/upgrade_server.rst>`__

The following sections describe the upgrade process for Chef server 12.

.. note:: Be sure to back up the Chef server data before starting the upgrade process.

From Chef Server 12
=====================================================
There are three upgrade scenarios for upgrades from earlier versions of Chef server 12 to a newer version of Chef server 12:

* `Standalone </upgrade_server.html#standalone>`__
* `High availability </upgrade_server.html#high-availability>`__
* `Tiered </upgrade_server.html#tiered>`__

.. note:: As of version 12.14, Chef server will not render passwords outside of the ``/etc/opscode`` directory by default. If you are not using any Chef server add-ons, or you're using the latest add-on versions, you can set ``insecure_addon_compat`` to ``false`` in ``/etc/opscode/chef-server.rb``. With this option set to ``false``, Chef server writes all credentials to a single location. Note that this setting should only be applied after both the Chef server and its add-ons have been upgraded to compatible versions.

        For additional information on this change, including a list of supported add-on versions, see `Chef Server Credentials Management </server_security.html#chef-server-credentials-management>`_.

Standalone
-----------------------------------------------------
This section describes the upgrade process for a standalone configuration. The upgrade process will require downtime equal to the amount of time it takes to stop the server, run dpkg or RPM Package Manager, and then upgrade the server.

To upgrade to Chef server 12 from a standalone Chef server, do the following:

#. Run the following command to make sure all services are in a sane state.

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Download the desired Chef server version from the `Chef Server Downloads <https://downloads.chef.io/chef-server>`__ page.

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

#. Start Chef server 12:

   .. code-block:: bash

      $ chef-server-ctl start

#. `Upgrade <upgrade_server.html#upgrading-add-ons>`__ the Chef server add-ons. 

#. After the upgrade process is complete and everything is tested and verified to be working properly, clean up the server by removing all of the old data:

   .. code-block:: bash

      $ chef-server-ctl cleanup

High Availability
-----------------------------------------------------
This section describes the upgrade process from a high availability configuration. The upgrade process will require downtime equal to the amount of time it takes to stop the server, run dpkg or RPM Package Manager, and then upgrade the server.

To upgrade to Chef server 12 from a high availability Chef server configuration, do the following:

#. Run the following on all servers to make sure all services are in a sane state.

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Download the desired Chef server version from the `Chef Server Downloads <https://downloads.chef.io/chef-server>`__ page, then copy it to each server.

#. Stop all of the front end servers:

   .. code-block:: bash

      $ chef-server-ctl stop

#. Identify the name of the original non-bootstrap backend server. This is the back end server that does **not** have ``:bootstrap => true`` in ``/etc/opscode/private-chef.rb``.

#. Stop Keepalived on the original non-bootstrap backend server. This will ensure that the bootstrap back end server is the active server. This action may trigger a failover.

   .. code-block:: bash

      $ chef-server-ctl stop keepalived

#. Run dpkg or RPM Package Manager on all servers. 

   For dpkg:

   .. code-block:: bash

      $ dpkg -i /path/to/chef-server-core-<version>.deb

   For RPM Package Manager:

   .. code-block:: bash

      $ rpm -Uvh --nopostun /path/to/chef-server-core-<version>.rpm

#. On the primary back end server, stop all services except Keepalived. With Chef server 12, the Keepalived service will not be stopped with the following command:

   .. code-block:: bash

      $ chef-server-ctl stop

   If the upgrade process times out, re-run the command until it finishes successfully.

#. Upgrade the back end primary server with the following command:

   .. code-block:: bash

      $ chef-server-ctl upgrade

   If the upgrade process times out, re-run the command until it finishes successfully.

#. Copy the entire ``/etc/opscode`` directory from the back end primary server to all front and back end nodes. For example, from each server run:

   .. code-block:: bash

      $ scp -r <Bootstrap server IP>:/etc/opscode /etc

   or from the back end primary server:

   .. code-block:: bash

      $ scp -r /etc/opscode <each servers IP>:/etc

#. Upgrade the back end secondary server with the following command:

   .. code-block:: bash

      $ chef-server-ctl upgrade

   In some instances, after the upgrade process is complete, it may be required to stop Keepalived on the back end secondary server, then restart Keepalived on the back end primary server, and then restart Keepalived on the back end secondary server.

#. Upgrade all front end servers with the following commands:

   .. code-block:: bash

      $ chef-server-ctl upgrade

#. Run the following command on all front end servers and the primary back end server:

   .. code-block:: bash

      $ chef-server-ctl start

   .. note:: Do not run this command on the secondary back-end server!

#. `Upgrade <upgrade_server.html#upgrading-add-ons>`__ the Chef server add-ons on each server.

#. After the upgrade process is complete, the state of the system after the upgrade has been tested and verified, and everything looks satisfactory, remove old data, services, and configuration by running the following command on each server:

   .. code-block:: bash

      $ chef-server-ctl cleanup

   .. note:: The message ``[ERROR] opscode-chef-mover is not running`` is expected, does not indicate an actual error, and is safe to ignore.


Tiered
-----------------------------------------------------
This section describes the upgrade process from a tiered server configuration. The upgrade process will require downtime equal to the amount of time it takes to stop the server, run dpkg or RPM Package Manager, and then upgrade the server.

.. note:: These instructions are primarily intended for existing users of the ``tier`` Chef server topology. For the latest information on high availability and how to set up a highly-available server cluster, see :doc:`High Availability: Backend Cluster </install_server_ha>`

To upgrade to Chef server 12 from a tiered Chef server configuration, do the following:

#. Run the following on all servers to make sure all services are in a sane state.

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Download the desired Chef server version from the `Chef Server Downloads <https://downloads.chef.io/chef-server>`__ page, then copy it to each server.

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

#. `Upgrade <upgrade_server.html#upgrading-add-ons>`__ the Chef server add-ons on each server.

#. After the upgrade process is complete, the state of the system after the upgrade has been tested and verified, and everything looks satisfactory, remove old data, services, and configuration by running the following command on each server:

   .. code-block:: bash

      $ chef-server-ctl cleanup


From Enterprise Chef
=====================================================
There are two upgrade scenarios for upgrades from Enterprise Chef 11 to Chef server 12:

* `Standalone </upgrade_server.html#id1>`__
* `High availability </upgrade_server.html#id2>`__

Before upgrading, please :doc:`view the notes </upgrade_server_notes>` for more background on the upgrade process from Enterprise Chef 11 to Chef server 12.

Standalone
-----------------------------------------------------
This section describes the upgrade process from a standalone Enterprise Chef 11 to Chef server 12. The upgrade process will require downtime equal to the amount of time it takes to stop the server, run dpkg or RPM Package Manager, and then upgrade the server. The final step will remove older components (like CouchDB) and will destroy the data after the upgrade process is complete.

To upgrade to Chef server 12 from a standalone Enterprise Chef server, do the following:

#. Run the following command to make sure all services are in a sane state.

   .. code-block:: bash

      $ private-chef-ctl reconfigure

#. Stop the server:

   .. code-block:: bash

      $ private-chef-ctl stop

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

#. Start Chef server 12:

   .. code-block:: bash

      $ chef-server-ctl start

#. `Upgrade <upgrade_server.html#upgrading-add-ons>`__ the Chef server add-ons. 

#. After the upgrade process is complete and everything is tested and verified to be working properly, clean up the server by removing all of the old data:

   .. code-block:: bash

      $ chef-server-ctl cleanup

High Availability
-----------------------------------------------------
This section describes the upgrade process from a high availability Enterprise Chef 11 to Chef server 12. The upgrade process will require downtime equal to the amount of time it takes to stop the server, run dpkg or RPM Package Manager, and then upgrade the server. The final step will remove older components (like CouchDB) and will destroy the data after the upgrade process is complete.

To upgrade to Chef server 12 from a high availability Enterprise Chef server, do the following:

#. Run the following on all servers to make sure all services are in a sane state.

   .. code-block:: bash

      $ private-chef-ctl reconfigure

#. Stop all of the front end servers:

   .. code-block:: bash

      $ private-chef-ctl stop

#. Identify the name of the original non-bootstrap backend server. This is the back end server that does **not** have ``:bootstrap => true`` in ``/etc/opscode/private-chef.rb``.

#. Stop Keepalived on the original non-bootstrap backend server. This will ensure that the bootstrap back end server is the active server. This action may trigger a failover.

   .. code-block:: bash

      $ private-chef-ctl stop keepalived

#. Run dpkg or RPM Package Manager on all servers. 

   For dpkg:

   .. code-block:: bash

      $ dpkg -i /path/to/chef-server-core-<version>.deb

   For RPM Package Manager:

   .. code-block:: bash

      $ rpm -Uvh --nopostun /path/to/chef-server-core-<version>.rpm

#. On the primary back end server, stop all services except Keepalived. With Chef server 12, the Keepalived service will not be stopped with the following command:

   .. code-block:: bash

      $ chef-server-ctl stop

   If the upgrade process times out, re-run the command until it finishes successfully.

#. Upgrade the back end primary server with the following command:

   .. code-block:: bash

      $ chef-server-ctl upgrade

   If the upgrade process times out, re-run the command until it finishes successfully.

#. Copy the entire ``/etc/opscode`` directory from the back end primary server to all front and back end nodes. For example, from each server run:

   .. code-block:: bash

      $ scp -r <Bootstrap server IP>:/etc/opscode /etc

   or from the back end primary server:

   .. code-block:: none

      $ scp -r /etc/opscode <each server's IP>:/etc

#. Upgrade the back end secondary server with the following command:

   .. code-block:: none

      $ chef-server-ctl upgrade

   In some instances, after the upgrade processes is complete, it may be required to stop Keepalived on the back end secondary server, then restart Keepalived on the back end primary server, and then restart Keepalived on the back end secondary server.

#. Upgrade all front end servers with the following commands:

   .. code-block:: bash

      $ chef-server-ctl upgrade

#. Run the following command on all front end servers and the primary back end server:

   .. code-block:: bash

      $ chef-server-ctl start

   .. note:: Do not run this command on the secondary back-end server!

#. `Upgrade <upgrade_server.html#upgrading-add-ons>`__ the Chef server add-ons on each server.

#. After the upgrade process is complete, the state of the system after the upgrade has been tested and verified, and everything looks satisfactory, remove old data, services, and configuration by running the following command on each server:

   .. code-block:: bash

      $ chef-server-ctl cleanup

   .. note:: The message ``[ERROR] opscode-chef-mover is not running`` is expected, does not indicate an actual error, and is safe to ignore.

Upgrading Add-ons
=====================================================
This section details the process for upgrading additional features after the Chef server has been upgraded. 

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

          On the Chef server, run:

          .. code-block:: bash

             $ chef-server-ctl install chef-manage

          then:

          .. code-block:: bash

             $ chef-server-ctl reconfigure

          and then:

          .. code-block:: bash

             $ chef-manage-ctl reconfigure

          .. note:: .. tag chef_license_reconfigure_manage

                    Starting with the Chef management console 2.3.0, the :doc:`Chef MLSA </chef_license>` must be accepted when reconfiguring the product. If the Chef MLSA has not already been accepted, the reconfigure process will prompt for a ``yes`` to accept it. Or run ``chef-manage-ctl reconfigure --accept-license`` to automatically accept the license.

                    .. end_tag

      * - Chef Push Jobs
        - Use Chef push jobs to run jobs---an action or a command to be executed---against nodes independently of a chef-client run.

          On the Chef server, run:

          .. code-block:: bash

             $ chef-server-ctl install opscode-push-jobs-server

          then:

          .. code-block:: bash

             $ chef-server-ctl reconfigure

          and then:

          .. code-block:: bash

             $ opscode-push-jobs-server-ctl reconfigure

      * - Reporting
        - Use Reporting to keep track of what happens during every chef-client runs across all of the infrastructure being managed by Chef. Run Reporting with Chef management console to view reports from a web user interface.

          On the Chef server, run:

          .. code-block:: bash

             $ chef-server-ctl install opscode-reporting

          then:

          .. code-block:: bash

             $ chef-server-ctl reconfigure

          and then:

          .. code-block:: bash

             $ opscode-reporting-ctl reconfigure

   .. end_tag

   **Use Local Packages**

   .. tag ctl_chef_server_install_features_manual

   The ``install`` subcommand downloads packages from https://packages.chef.io/ by default. For systems that are behind a firewall (and may not have connectivity to packages.chef.io), these packages can be downloaded from https://downloads.chef.io/chef-manage/, and then installed manually. First download the package that is appropriate for the platform, save it to a local path, and then run the ``install`` command using the ``--path`` option to specify the directory in which the package is located:

   .. code-block:: bash

      $ chef-server-ctl install PACKAGE_NAME --path /path/to/package/directory

   For example:

   .. code-block:: bash

      $ chef-server-ctl install chef-manage --path /root/packages

   The ``chef-server-ctl`` command will install the first ``chef-manage`` package found in the ``/root/packages`` directory.

   .. end_tag
