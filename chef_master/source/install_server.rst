=====================================================
Install the Chef Server
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_server.rst>`__

There are three configuration scenarios for the Chef Infra Server:

* `Standalone <install_server.html#standalone>`__ (everything on a single machine)
* `High availability <install_server.html#high-availability>`__ (machines configured for front-end and back-end, allowing for failover on the back-end and load-balancing on the front-end, as required)
* `Tiered <install_server.html#tiered-single-backend>`__ (machines configured for front-end and back-end, with a single back-end and load-balancing on the front-end, as required)

Supported Platforms
=====================================================
.. tag adopted_platforms_server

The following table lists the commercially-supported platforms and versions for the Chef Infra Server:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - Oracle Enterprise Linux
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - Red Hat Enterprise Linux
     - ``x86_64``, ``ppc64le`` (7.x only), ``ppc64`` (7.x only)
     - ``6.x``, ``7.x``
   * - SUSE Enterprise Linux Server
     - ``x86_64``
     - ``11 SP4``, ``12 SP1+``
   * - Ubuntu
     - ``x86_64``
     - ``16.04``, ``18.04``

.. end_tag

Prerequisites
=====================================================
The Chef Infra Server has the following prerequisites:

* An x86_64 compatible system architecture; Red Hat Enterprise Linux and CentOS may require updates prior to installation
* A resolvable hostname that is specified using a FQDN or an IP address
* A connection to Network Time Protocol (NTP) to prevent clock drift
* If host-based firewalls (iptables, ufw, etc.) are being used, ensure that ports 80 and 443 are open. See the `firewalls </install_server_pre.html#firewalls>`_ section of the install prerequisites for additional details.
* A local mail transfer agent that allows the Chef Infra Server to send email notifications
* Using cron and the ``/etc/cron.d`` directory for periodic maintenance tasks
* Disabling the Apache Qpid daemon on CentOS and Red Hat systems. See the `Apache Qpid </install_server_pre.html#apache-qpid>`_ of the prerequisite documentation for detailed steps.
* Optional. A local user account under which services will run, a local user account for PostgreSQL, and a group account under which services will run. See `UIDs and GIDs </install_server_pre.html#uids-and-gids>`__ for more information.

.. note:: See the `expanded list of prerequisites </install_server_pre.html>`__ for a detailed list of software and hardware requirements.

Standalone
=====================================================
The standalone installation of Chef Infra Server creates a working installation on a single server. This installation is also useful when you are installing Chef Infra Server in a virtual machine, for proof-of-concept deployments, or as a part of a development or testing loop.

To install Chef Server:

#. Download the package from https://downloads.chef.io/chef-server/.
#. Upload the package to the machine that will run the Chef Infra Server, and then record its location on the file system. The rest of these steps assume this location is in the ``/tmp`` directory.

#. .. tag install_chef_server_install_package

   .. This topic is hooked in globally to install topics for Chef Infra Server applications.

   As a root user, install the Chef Infra Server package on the server, using the name of the package provided by Chef. For Red Hat Enterprise Linux and CentOS:

   .. code-block:: bash

      $ sudo rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For Ubuntu:

   .. code-block:: bash

      $ sudo dpkg -i /tmp/chef-server-core-<version>.deb

   After a few minutes, the Chef Infra Server will be installed.

   .. end_tag

#. Run the following to start all of the services:

   .. code-block:: bash

      $ sudo chef-server-ctl reconfigure

   Because the Chef Infra Server is composed of many different services that work together to create a functioning system, this step may take a few minutes to complete.

#. .. tag ctl_chef_server_user_create_admin

   Run the following command to create an administrator:

   .. code-block:: bash

      $ sudo chef-server-ctl user-create USER_NAME FIRST_NAME LAST_NAME EMAIL 'PASSWORD' --filename FILE_NAME

   An RSA private key is generated automatically. This is the user's private key and should be saved to a safe location. The ``--filename`` option will save the RSA private key to the specified absolute path.

   For example:

   .. code-block:: bash

      $ sudo chef-server-ctl user-create janedoe Jane Doe janed@example.com 'abc123' --filename /path/to/janedoe.pem

   .. end_tag

#. .. tag ctl_chef_server_org_create_summary

   Run the following command to create an organization:

   .. code-block:: bash

      $ sudo chef-server-ctl org-create short_name 'full_organization_name' --association_user user_name --filename ORGANIZATION-validator.pem

   For example:

   .. code-block:: bash

      $ sudo chef-server-ctl org-create 4thcoffee 'Fourth Coffee, Inc.' --association_user janedoe --filename /path/to/4thcoffee-validator.pem

   The name must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``4thcoffee``.

   The full name must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``'Fourth Coffee, Inc.'``.

   The ``--association_user`` option will associate the ``user_name`` with the ``admins`` security group on the Chef Infra Server.

   An RSA private key is generated automatically. This is the chef-validator key and should be saved to a safe location. The ``--filename`` option will save the RSA private key to the specified absolute path.

   .. end_tag

Update Configuration for Purchased Nodes
=====================================================

To use more than 25 nodes, you'll need to change Chef Infra Server configuration for the server to recognize your purchased licenses. Edit your ``/etc/opscode/chef-server.rb`` file by following the process below:

#. On your Chef Infra Server, if the ``chef-server.rb`` file does not exist, create it.

   .. code-block:: bash

      sudo mkdir /etc/opscode && sudo touch /etc/opscode/chef-server.rb

#. Open up the newly created ``chef-server.rb`` file in your favorite text editor, for example:

   .. code-block:: bash

      sudo vi /etc/opscode/chef-server.rb

#. Paste or add the following text. Please note the placement of the single quotation (') marks. If you're using the vi text editor, you'll need to use the `i` key to insert the text.

   .. code-block:: bash

      license['nodes'] = N where N is the number of licensed nodes you have purchased

#. Save the file. If you're using vi, from the example above, use the `esc` key and then :

.. code-block:: bash

   :wq

#. Run ``chef-server-ctl reconfigure`` for the changes to be picked up by your Chef Infra Server.

   .. code-block:: bash

      sudo chef-server-ctl reconfigure

For more information on configuring your Chef Infra Server, see `chef-server.rb Settings </config_rb_server.html>`__ and `chef-server.rb Optional Settings </config_rb_server_optional_settings.html>`__.

High Availability
=====================================================
The following links describe how to configure the Chef Infra Server for high availability. The **Backend Cluster** setup is strongly recommended for new installations:

* `High Availability using Backend Cluster </install_server_ha.html>`__

Tiered (Single Backend)
=====================================================
The following link describes how to configure the Chef Infra Server with a single backend machine and multiple frontend machines. Note that this process has been deprecated in favor of a `Backend Cluster </install_server_ha.html>`__ setup:

* `Tiered Installation </install_server_tiered.html>`__
