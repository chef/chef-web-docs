

=====================================================
Install the Chef Server
=====================================================

There are three configuration scenarios for the Chef server:

* :ref:`Standalone <install_server-standalone>` (everything on a single machine)
* :ref:`High availability <install_server-high-availability>` (machines configured for front-end and back-end, allowing for failover on the back-end and load-balancing on the front-end, as required)
* :ref:`Tiered <install_server-tiered-single-backend>` (machines configured for front-end and back-end, with a single back-end and load-balancing on the front-end, as required)

Prerequisites
=====================================================
The Chef server has the :doc:`following prerequisites </install_server_pre>`:

* An x86_64 compatible system architecture; Red Hat Enterprise Linux and CentOS may require updates prior to installation
* A resolvable hostname that is specified using a FQDN or an IP address
* A connection to Network Time Protocol (NTP) to prevent clock drift
* A local mail transfer agent that allows the Chef server to send email notifications
* Using cron and the ``/etc/cron.d`` directory for periodic maintenance tasks
* Disabling the Apache Qpid daemon on CentOS and Red Hat systems
* Optional. A local user account under which services will run, a local user account for PostgreSQL, and a group account under which services will run. See :ref:`install_server_pre-uids-and-gids` for more information.

.. _install_server-standalone:

Standalone
=====================================================
.. tag install_server_standalone_2

The standalone installation of Chef server creates a working installation on a single server. This installation is also useful when you are installing Chef server in a virtual machine, for proof-of-concept deployments, or as a part of a development or testing loop.

To install Chef server 12:

#. Download the package from http://downloads.chef.io/chef-server/.
#. Upload the package to the machine that will run the Chef server, and then record its location on the file system. The rest of these steps assume this location is in the ``/tmp`` directory.

#. .. tag install_chef_server_install_package

   .. This topic is hooked in globally to install topics for Chef server applications.

   As a root user, install the Chef server package on the server, using the name of the package provided by Chef. For Red Hat and CentOS 6:

   .. code-block:: bash

      $ rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For Ubuntu:

   .. code-block:: bash

      $ dpkg -i /tmp/chef-server-core-<version>.deb

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

   An RSA private key is generated automatically. This is the user's private key and should be saved to a safe location. The ``--filename`` option will save the RSA private key to a specified path.

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

   An RSA private key is generated automatically. This is the chef-validator key and should be saved to a safe location. The ``--filename`` option will save the RSA private key to a specified path.

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

                    Starting with the Chef management console 2.3.0, the Chef MLSA must be accepted when reconfiguring the product. If the Chef MLSA has not already been accepted, the reconfigure process will prompt for a ``yes`` to accept it. Or run ``chef-manage-ctl reconfigure --accept-license`` to automatically accept the license.

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

.. end_tag

.. _install_server-high-availability:

High Availability
=====================================================
The following links describe how to configure the Chef server for high availability:

:doc:`install_server_ha_aws`
:doc:`install_server_ha_drbd`

.. _install_server-tiered-single-backend:

Tiered (Single Backend)
=====================================================
The following link describes how to configure the Chef server with a single backend machine and multiple frontend machines:

:doc:`install_server_tiered`
