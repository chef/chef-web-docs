=====================================================
Upgrade to Chef Server 12
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/upgrade_server.rst>`__

The following sections describe the upgrade process for Chef server 12.

.. note:: Be sure to back up the Chef server data before starting the upgrade process.

From Chef Server 12
=====================================================
There are two upgrade scenarios for upgrades from earlier versions of Chef server 12 to a newer version of Chef server 12:

* `Standalone </upgrade_server.html#standalone>`__
* `High availability </upgrade_server.html#high-availability>`__

.. note:: As of version 12.14, Chef server will not render passwords outside of the ``/etc/opscode`` directory by default. If you are not using any Chef server add-ons, or you're using the latest add-on versions, you can set ``insecure_addon_compat`` to ``false`` in ``/etc/opscode/chef-server.rb``. With this option set to ``false``, Chef server writes all credentials to a single location. Note that this setting should only be applied after both the Chef server and its add-ons have been upgraded to compatible versions.

        For additional information on this change, including a list of supported add-on versions, see `Chef Server Credentials Management </server_security.html#chef-server-credentials-management>`_.

Standalone
-----------------------------------------------------
This section describes the upgrade process for a standalone configuration. The upgrade process will require downtime equal to the amount of time it takes to stop the server, run dpkg or RPM Package Manager, and then upgrade the server.

To upgrade to Chef server 12 from a standalone Chef server server, do the following:

#. Verify that the ``make`` command is available on the Chef server server. If it is not available, install the ``make`` command.

#. Run the following command to make sure all services are in a sane state.

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Download the desired Chef server version from the `Chef Server Downloads <https://downloads.chef.io/chef-server>`__ page.

#. Stop the server:

   .. code-block:: bash

      $ chef-server-ctl stop

#. Run dpkg or RPM Package Manager. For dpkg:

   .. code-block:: bash

      $ dpkg -D10 -i /path/to/chef-server-core-<version>.deb

   where ``-D`` enables debugging and ``10`` creates output for each file that is processed during the upgrade. See the man pages for dpkg for more information about this option.

   For RPM Package Manager:

   .. code-block:: bash

      $ rpm -Uvh --nopostun /path/to/chef-server-core-<version>.rpm

#. Upgrade the server with the following command:

   .. code-block:: bash

      $ chef-server-ctl upgrade

#. Start Chef server 12:

   .. code-block:: bash

      $ chef-server-ctl start

#. After the upgrade process is complete and everything is tested and verified to be working properly, clean up the server by removing all of the old data:

   .. code-block:: bash

      $ chef-server-ctl cleanup

#. .. tag ctl_chef_server_install_features

   Enable additional features of the Chef server! The packages may be downloaded directly as part of the installation process or they may be first downloaded to a local directory, and then installed.

   .. end_tag

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

High Availability
-----------------------------------------------------
This section describes the upgrade process from a high availability configuration. The upgrade process will require downtime equal to the amount of time it takes to stop the server, run dpkg or RPM Package Manager, and then upgrade the server.

To upgrade to Chef server 12 from a high availability Chef server server, do the following:

#. Verify that the ``make`` command is available on the primary backend Chef server server. If it is not available, install the ``make`` command.

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

#. Run dpkg or RPM Package Manager on all servers. For dpkg:

   .. code-block:: bash

      $ dpkg -D10 -i /path/to/chef-server-core-<version>.deb

   where ``-D`` enables debugging and ``10`` creates output for each file that is processed during the upgrade. See the man pages for dpkg for more information about this option.

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

   In some instances, after the upgrade processes is complete, it may be required to stop Keepalived on the back end secondary server, then restart Keepalived on the back end primary server, and then restart Keepalived on the back end secondary server.

#. Upgrade all front end servers with the following commands:

   .. code-block:: bash

      $ chef-server-ctl upgrade

#. Run the following command on all front end servers and the primary back end server:

   .. code-block:: bash

      $ chef-server-ctl start

   .. note:: Do not run this command on the secondary back-end server!

#. After the upgrade process is complete, the state of the system after the upgrade has been tested and verified, and everything looks satisfactory, remove old data, services, and configuration by running the following command on each server:

   .. code-block:: bash

      $ chef-server-ctl cleanup

   .. note:: The message ``[ERROR] opscode-chef-mover is not running`` is expected, does not indicate an actual error, and is safe to ignore.

#. .. tag ctl_chef_server_install_features

   Enable additional features of the Chef server! The packages may be downloaded directly as part of the installation process or they may be first downloaded to a local directory, and then installed.

   .. end_tag

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

#. Verify that the ``make`` command is available on the Enterprise Chef server. If it is not available, install the ``make`` command.

#. Run the following command to make sure all services are in a sane state.

   .. code-block:: bash

      $ private-chef-ctl reconfigure

#. Stop the server:

   .. code-block:: bash

      $ private-chef-ctl stop

#. Run dpkg or RPM Package Manager. For dpkg:

   .. code-block:: bash

      $ dpkg -D10 -i /path/to/chef-server-core-<version>.deb

   where ``-D`` enables debugging and ``10`` creates output for each file that is processed during the upgrade. See the man pages for dpkg for more information about this option.

   For RPM Package Manager:

   .. code-block:: bash

      $ rpm -Uvh --nopostun /path/to/chef-server-core-<version>.rpm

#. Upgrade the server with the following command:

   .. code-block:: bash

      $ chef-server-ctl upgrade

#. Start Chef server 12:

   .. code-block:: bash

      $ chef-server-ctl start

#. After the upgrade process is complete and everything is tested and verified to be working properly, clean up the server by removing all of the old data:

   .. code-block:: bash

      $ chef-server-ctl cleanup

#. .. tag ctl_chef_server_install_features

   Enable additional features of the Chef server! The packages may be downloaded directly as part of the installation process or they may be first downloaded to a local directory, and then installed.

   .. end_tag

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

High Availability
-----------------------------------------------------
This section describes the upgrade process from a high availability Enterprise Chef 11 to Chef server 12. The upgrade process will require downtime equal to the amount of time it takes to stop the server, run dpkg or RPM Package Manager, and then upgrade the server. The final step will remove older components (like CouchDB) and will destroy the data after the upgrade process is complete.

To upgrade to Chef server 12 from a high availability Enterprise Chef server, do the following:

#. Verify that the ``make`` command is available on the primary backend Enterprise Chef server. If it is not available, install the ``make`` command.

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

#. Run dpkg or RPM Package Manager on all servers. For dpkg:

   .. code-block:: bash

      $ dpkg -D10 -i /path/to/chef-server-core-<version>.deb

   where ``-D`` enables debugging and ``10`` creates output for each file that is processed during the upgrade. See the man pages for dpkg for more information about this option.

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

   In some instances, after the upgrade processes is complete, it may be required to stop Keepalived on the back end secondary server, then restart Keepalived on the back end primary server, and then restart Keepalived on the back end secondary server.

#. Upgrade all front end servers with the following commands:

   .. code-block:: bash

      $ chef-server-ctl upgrade

#. Run the following command on all front end servers and the primary back end server:

   .. code-block:: bash

      $ chef-server-ctl start

   .. note:: Do not run this command on the secondary back-end server!

#. After the upgrade process is complete, the state of the system after the upgrade has been tested and verified, and everything looks satisfactory, remove old data, services, and configuration by running the following command on each server:

   .. code-block:: bash

      $ chef-server-ctl cleanup

   .. note:: The message ``[ERROR] opscode-chef-mover is not running`` is expected, does not indicate an actual error, and is safe to ignore.

#. .. tag ctl_chef_server_install_features

   Enable additional features of the Chef server! The packages may be downloaded directly as part of the installation process or they may be first downloaded to a local directory, and then installed.

   .. end_tag

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

From Open Source Chef
=====================================================
This section describes the upgrade process from a standalone configuration of Open Source Chef 11.1.0 (or higher) to a standalone configuration of Chef server 12. The upgrade process will require downtime equal to the amount of time it takes to stop the server, run dpkg or RPM Package Manager, and then upgrade the server.

Please :doc:`view the notes </upgrade_server_open_source_notes>` for more background on the upgrade process from Open Source Chef 11 to Chef server 12.

To upgrade to Chef server 12 from the Open Source Chef server, do the following:

#. Run the following to make sure all services are in a sane state.

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Stop the Open Source Chef server:

   .. code-block:: bash

      $ chef-server-ctl stop

#. Run dpkg or RPM Package Manager on the server to install Chef server 12. For dpkg:

   .. code-block:: bash

      $ dpkg -D10 -i /path/to/chef-server-core-<version>.deb

   where ``-D`` enables debugging and ``10`` creates output for each file that is processed during the upgrade. See the man pages for dpkg for more information about this option.

   For RPM Package Manager:

   .. code-block:: bash

      $ rpm -Uvh /path/to/chef-server-core-<version>.rpm

   Chef server 12 is installed to ``/opt/opscode``. (The existing Open Source Chef remains at ``/opt/chef-server``.) From this point, the ``chef-server-ctl`` commands are running against the ``/opt/opscode`` location.

#. Upgrade the server with the following command:

   .. code-block:: bash

      $ chef-server-ctl upgrade

   The upgrade process will automatically detect the presence of Open Source Chef 11, and will step through the migration process, prompting for organization name details along the way.

   The migration process will first download the existing data from the Open Source Chef server, transform that data into the format required for Chef server 12, and then upload that data to the server.

#. Before data can be uploaded, an organization must be created. When prompted, enter the organization name, and then a full organization name.

   The name must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``chef``.

   The full name must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``"Chef Software, Inc."``.

   .. note:: The upgrade process will automatically assign the organization name to the ``default_orgname`` setting in the chef-server.rb file. This setting ensures the new organization name is available for Chef server API requests, such as those made by the chef-client and by knife.

   .. warning:: If you receive a ``missing read permission`` error when running the ``knife user list`` subcommand after the upgrade process is finished, you will need to update the value for the ``chef_server_url`` setting in the knife.rb file. The default value for that setting is:

      .. code-block:: ruby

         chef_server_url 'https://CHEF_SERVER_NAME:443/'

      and should be updated to add ``organizations/ORG_NAME``:

      .. code-block:: ruby

         chef_server_url 'https://CHEF_SERVER_NAME:443/organizations/ORG_NAME'

#. The Chef server is automatically restarted. A prompt is displayed that contains details about how to remove any temporary data that was created during the upgrade process.

#. .. tag ctl_chef_server_install_features

   Enable additional features of the Chef server! The packages may be downloaded directly as part of the installation process or they may be first downloaded to a local directory, and then installed.

   .. end_tag

   **Update the Chef server URL**

   The URL for the Chef server needs to be updated on all nodes and workstations. In the client.rb file on each node and in the knife.rb file on each workstation, update the following setting:

   .. code-block:: ruby

      chef_server_url "https://url.for.server"

   .. note:: Any node that is bootstrapped from a workstation with the updated URL will automatically be assigned the new URL for the Chef server. Only existing nodes prior to the upgrade require the URL update.

   .. note:: Any chef-client or knife user that tries to access the Chef server after the upgrade will be able to do so as long as the ``default_orgname`` is set and is part of the default organization on the upgraded Chef server.

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

Chef Manage
=====================================================
Chef management console can be upgraded as part of a standalone or high availability configuration:

#. After upgrading the Chef server, upgrade each of the front end servers. For Red Hat and CentOS 6:

   .. code-block:: bash

      $ chef-server-ctl install opscode-manage

   For Ubuntu, for the Chef management console 1.x to 2.x:

   .. code-block:: bash

      $ apt-get install chef-manage

#. Reconfigure each of the front end servers:

   .. code-block:: bash

      $ chef-manage-ctl reconfigure

Chef Push Jobs
=====================================================
Chef push jobs can be upgraded as part of a standalone or high availability configuration:

#. After upgrading the Chef server, run the following command on all front and back end servers:

   .. code-block:: bash

      $ chef-server-ctl install opscode-push-jobs-server

#. TCP protocol ports 10000-10003 must be open. This allows the Chef push jobs clients to communicate with the Chef push jobs server. In a configuration with both front and back ends, these ports only need to be open on the back end servers. The Chef push jobs server waits for connections from the Chef push jobs client (and never makes a connection to a Chef push jobs client).

#. Reconfigure the Chef push jobs servers:

   .. code-block:: bash

      $ opscode-push-jobs-server-ctl reconfigure

#. Run the following command on each of the back end servers:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

   This ensures that the Keepalived scripts are regenerated so they are aware of Chef push jobs.

#. Restart the Chef push jobs components:

   .. code-block:: bash

      $ chef-server-ctl restart opscode-pushy-server

#. Verify the installation:

   .. code-block:: bash

      $ opscode-push-jobs-server-ctl test

#. Install the Chef push jobs client on all nodes using the **push-jobs** cookbook, as needed.
