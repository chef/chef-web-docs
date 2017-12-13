=====================================================
Install the Chef Server
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_server.rst>`__

There are three configuration scenarios for the Chef server:

* `Standalone <install_server.html#standalone>`__ (everything on a single machine)
* `High availability <install_server.html#high-availability>`__ (machines configured for front-end and back-end, allowing for failover on the back-end and load-balancing on the front-end, as required)
* `Tiered <install_server.html#tiered-single-backend>`__ (machines configured for front-end and back-end, with a single back-end and load-balancing on the front-end, as required)

Prerequisites
=====================================================
The Chef server has the following prerequisites:

* An x86_64 compatible system architecture; Red Hat Enterprise Linux and CentOS may require updates prior to installation
* A resolvable hostname that is specified using a FQDN or an IP address
* A connection to Network Time Protocol (NTP) to prevent clock drift
* If host-based firewalls (iptables, ufw, etc.) are being used, ensure that ports 80 and 443 are open. See the `firewalls </install_server_pre.html#firewalls>`_ section of the install prerequisites for additional details.
* A local mail transfer agent that allows the Chef server to send email notifications
* Using cron and the ``/etc/cron.d`` directory for periodic maintenance tasks
* Disabling the Apache Qpid daemon on CentOS and Red Hat systems. See the `Apache Qpid </install_server_pre.html#apache-qpid>`_ of the prerequisite documentation for detailed steps.
* Optional. A local user account under which services will run, a local user account for PostgreSQL, and a group account under which services will run. See `UIDs and GIDs </install_server_pre.html#uids-and-gids>`__ for more information.

.. note:: See the `expanded list of prerequisites </install_server_pre.html>`__ for a detailed list of software and hardware requirements.

Standalone
=====================================================
The standalone installation of Chef server creates a working installation on a single server. This installation is also useful when you are installing Chef server in a virtual machine, for proof-of-concept deployments, or as a part of a development or testing loop.

To install Chef server 12:

#. Download the package from https://downloads.chef.io/chef-server/.
#. Upload the package to the machine that will run the Chef server, and then record its location on the file system. The rest of these steps assume this location is in the ``/tmp`` directory.

#. .. tag install_chef_server_install_package

   .. This topic is hooked in globally to install topics for Chef server applications.

   As a root user, install the Chef server package on the server, using the name of the package provided by Chef. For Red Hat Enterprise Linux and CentOS:

   .. code-block:: bash

      $ sudo rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For Ubuntu:

   .. code-block:: bash

      $ sudo dpkg -i /tmp/chef-server-core-<version>.deb

   After a few minutes, the Chef server will be installed.

   .. end_tag

#. Run the following to start all of the services:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

   Because the Chef server is composed of many different services that work together to create a functioning system, this step may take a few minutes to complete.

#. .. tag ctl_chef_server_user_create_admin

   Run the following command to create an administrator:

   .. code-block:: bash

      $ chef-server-ctl user-create USER_NAME FIRST_NAME LAST_NAME EMAIL 'PASSWORD' --filename FILE_NAME

   An RSA private key is generated automatically. This is the user's private key and should be saved to a safe location. The ``--filename`` option will save the RSA private key to the specified absolute path.

   For example:

   .. code-block:: bash

      $ chef-server-ctl user-create stevedanno Steve Danno steved@chef.io 'abc123' --filename /path/to/stevedanno.pem

   .. end_tag

#. .. tag ctl_chef_server_org_create_summary

   Run the following command to create an organization:

   .. code-block:: bash

      $ chef-server-ctl org-create short_name 'full_organization_name' --association_user user_name --filename ORGANIZATION-validator.pem

   The name must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``4thcoffee``.

   The full name must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``'Fourth Coffee, Inc.'``.

   The ``--association_user`` option will associate the ``user_name`` with the ``admins`` security group on the Chef server.

   An RSA private key is generated automatically. This is the chef-validator key and should be saved to a safe location. The ``--filename`` option will save the RSA private key to the specified absolute path.

   For example:

   .. code-block:: bash

      $ chef-server-ctl org-create 4thcoffee 'Fourth Coffee, Inc.' --association_user stevedanno --filename /path/to/4thcoffee-validator.pem

   .. end_tag

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

                    Starting with the Chef management console 2.3.0, the `Chef MLSA </chef_license.html>`__ must be accepted when reconfiguring the product. If the Chef MLSA has not already been accepted, the reconfigure process will prompt for a ``yes`` to accept it. Or run ``chef-manage-ctl reconfigure --accept-license`` to automatically accept the license.

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

Update config for purchased nodes
=====================================================
When using more than 25 nodes, a configuration change to your Chef server needs to be made in order for your Chef server to be properly configured and recognize your purchased licenses. You will need to edit your ``/etc/opscode/chef-server.rb`` file by following the process below:

#. On your Chef server, if the ``chef-server.rb`` file does not exist, create it.

   .. code-block:: bash

      sudo mkdir /etc/opscode && sudo touch /etc/opscode/chef-server.rb

#. Open up the newly created ``chef-server.rb`` file in your favorite text editor.

   .. code-block:: bash

      sudo vi /etc/opscode/chef-server.rb

#. Paste or add the following text. Please note the placement of the single quotation (') marks.

   .. code-block:: bash

      license['nodes'] = N where N is the number of licensed nodes you have purchased

#. Save the file. Because we are using the vi editor, you can save your changes in vi with the following command:

.. code-block:: bash

   :wq

#. Run ``chef-server-ctl reconfigure`` for the changes to be picked up by your Chef server.

   .. code-block:: bash

      sudo chef-server-ctl reconfigure

For more information on configuring your Chef server, see `chef-server.rb Settings </config_rb_server.html>`__ and `chef-server.rb Optional Settings </config_rb_server_optional_settings.html>`__.

High Availability
=====================================================
The following links describe how to configure the Chef server for high availability. The **Backend Cluster** setup is strongly recommended for new installations:

* `High Availability using Backend Cluster </install_server_ha.html>`__
* `High Availability using Amazon Web Services (DEPRECATED) </install_server_ha_aws.html>`__
* `High Availability using DRBD (DEPRECATED) </install_server_ha_drbd.html>`__


Tiered (Single Backend)
=====================================================
The following link describes how to configure the Chef server with a single backend machine and multiple frontend machines. Note that this process has been deprecated in favor of a `Backend Cluster </install_server_ha.html>`__ setup:

* `Tiered Installation (DEPRECATED) </install_server_tiered.html>`__
