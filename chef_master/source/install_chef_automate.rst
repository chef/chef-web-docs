=====================================================
Install Chef Automate
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_chef_automate.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

A Chef Automate installation consists of a minimum of two nodes:

* Chef server with push jobs server installed

  * Contains the cookbooks and data used to build, test, and deploy your components within Chef Automate and your infrastructure.

  * Runs push jobs, which is used in conjunction with a push jobs client on build nodes to coordinate builds across those nodes.

   .. note:: If you have an existing Chef server installation, it's best to
    have a separate Chef organization for managing Chef Automate.
    Instructions for this can be found below under the heading "Create a User and Organization to Manage Your Cluster".
    If you don't, you can install a minimal one for use with Chef Automate. See "Chef Server Installation and Configuration" below for details.

* Chef Automate server

  * Coordinates the process of moving a change through the workflow pipeline as well as providing insights and visualizations about your Chef Automate cluster.

* (Optional) Build nodes used in the push jobs-based job dispatch system, and runners which are used in the new job dispatch system, are optional components that perform the work of running builds, tests, and deployments out of Chef Automate and are only required when using the workflow capabilities of Chef Automate.

* (Optional) Chef Compliance server for use in conjunction with the ``audit cookbook``.

Prerequisites
=====================================================

Chef Automate requires a license from Chef to install. A license key valid for 30 days is included when you download Chef Automate. If you would like to continue using Chef Automate after that period, please contact `awesome@chef.io` for a permanent key.

Platforms
-----------------------------------------

The Chef Automate server may be run on the following platforms. Do not mix platforms or platform versions within the Chef Automate cluster.

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``6.5``, ``6.6``, ``7``
   * - Red Hat Enterprise Linux
     - ``x86_64``
     - ``6.5``, ``6.6``, ``7``
   * - Ubuntu
     - ``x86_64``
     - ``12.04``, ``14.04``, ``16.04``

Infrastructure
------------------------------------------

Chef Automate has the following infrastructure requirements:

  .. list-table::
     :widths: 150 100 100 100
     :header-rows: 1

     * - Function
       - vCPU
       - RAM
       - Free disk space (in /var)
     * - Chef Automate server
       - 4
       - 16GB\*
       - 80GB
     * - Chef server (must be v12). See additional information in note, below.
       - 4
       - 8GB
       - 80GB
     * - Build nodes/Runners (Optional, but required if you use workflow)
       - 2
       - 4GB
       - 60GB

\*If you use your own Elasticsearch cluster instead of the single Elasticsearch instance provided with Chef Automate,
then the Chef Automate server only requires 8 GB of RAM.

.. note:: If you already have a Chef server installation, you can update it with push jobs as detailed in `Push Jobs Server installation <#push_job_installation>`_. If you have both already configured, skip to `Completing Setup <#completing-setup>`_. Also, any build nodes/runners must be accessible from the Chef Automate server over SSH and they must have a user account configured that has sudo privileges.

Node Hostnames and Network Access
-----------------------------------------------------

The automated configuration of Chef Automate and Chef servers use the
``hostname`` command to determine the visible fully-qualified domain name
(FQDN) of the node.  Prior to installation, ensure that ``hostname``
and ``hostname -f`` on each node resolves to a matching, correct FQDN that is visible to the
other nodes in the cluster.   If necessary, update the ``/etc/hosts`` file on
the nodes to ensure that the names resolve.

Disable IPv6 on the host and remove any ip6 settings found in ``/etc/hosts``. The host should also point its name at its own external ip address in ``/etc/hosts``.

The Chef Automate server hostname is also expected to match the hostname
that you will use to work with Chef Automate via its web interface.  It is
not currently possible to use the Chef Automate web interface if the host
name used in the URL does not match the one it is configured with.

Chef Automate has the following network and port requirements. At a minimum the following machines must be able to reach each other:

* Chef Automate server -> Chef server
* Build node/Runner -> Chef Automate server
* Build node/Runner -> Chef server

.. list-table::
   :widths: 100 250 100 100
   :header-rows: 1

   * - Ports
     - Description
     - Server
     - State
   * - 10000-10003
     - TCP Push Jobs
     - Chef server
     - LISTEN
   * - 8989
     - TCP Delivery Git (SCM)
     - Chef Automate server
     - LISTEN
   * - 443
     - TCP HTTP Secure
     - Chef server, Chef Automate server
     - LISTEN
   * - 22
     - TCP SSH
     - All
     - LISTEN
   * - 80
     - TCP HTTP
     - Chef server, Chef Automate server
     - LISTEN

Chef Server Installation and Configuration
=====================================================

Chef Automate requires a Chef server with the push jobs server add-on
installed.  At this time, the Chef server must be installed on a
separate node from Chef Automate server.

If you already have an existing Chef server, you can update it with
the push jobs server add-on and skip to `Completing Setup <#completing-setup>`_ and then `Create a User and Organization <#create-a-user-and-organization>`_.

The steps below will configure a minimal Chef server with push jobs
for use with Chef Automate.  If you already have a Chef server with push jobs,
you can skip to `Create a User and Organization <#create-a-user-and-organization>`_.

Chef Server Installation
------------------------------------------------------

The standalone installation of Chef server creates a working installation on a single server. This installation is also useful when you are installing Chef server in a virtual machine, for proof-of-concept deployments, or as a part of a development or testing loop.

To install Chef server 12:

#. Download the package from https://downloads.chef.io/chef-server/.
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

Push Jobs Server Installation
------------------------------------------------------

Chef Automate can use push jobs to coordinate build jobs across build nodes when using the push jobs-based job dispatch system. This is the default job dispatch system unless you create runners and update your config.json file to use the new job dispatch system.

Push jobs is available as an add-on to Chef server. You can also use runners and the new job dispatch system instead of the previous push jobs-based system.

.. note:: Chef Automate requires Push Jobs Server 1.x and is not compatible with Push Jobs Server 2.x.  If you are installing Chef Automate on Red Hat Enterprise Linux/CentOS 7, use the Red Hat Enterprise Linux/CentOS 6 package for Push Jobs Server 1.x (available at `<https://downloads.chef.io/push-jobs-server/redhat/>`_) and manually install it.  For other platforms, you can use the automated installation method for Push Jobs Server 1.x as described below.

Download the appropriate package for your platform from `<https://downloads.chef.io/push-jobs-server/>`_  and copy it to the Chef server.  The location that it's been saved to is referred to as `PATH_TO_DOWNLOADED_PACKAGE`.

Run the command below on the Chef server:

.. code-block:: bash

   sudo chef-server-ctl install opscode-push-jobs-server --path PATH_TO_DOWNLOADED_PACKAGE

Completing Setup
-----------------------------------------------------

Run the following commands on the Chef server node to complete setup and
configuration of Chef server and push jobs server.

.. code-block:: bash

   sudo chef-server-ctl reconfigure
   sudo opscode-push-jobs-server-ctl reconfigure

Running this reconfigure may trigger a brief restart of Chef
Server.  This will typically fall in the standard retry window for Chef
Clients, so no significant interruption of service is expected.

Create a User and Organization to Manage Your Cluster
========================================================

As part of the setup process, you must create a user and organization that will be used internally by Chef Automate to manage your Chef Automate cluster.

#. From the Chef server, create a user named ``delivery`` specifying first name, last name, email address, and password. Also, as done in the step 5 of the `Chef Server Installation <#chef-server-installation>`_, a private key will be generated for you, so specify where to save that key using the ``--filename`` option with an absolute path to its intended location. The path to the key is referenced below as ``AUTOMATE_CHEF_USER_KEY``:

    .. code-block:: bash

        sudo chef-server-ctl user-create delivery FIRST_NAME LAST_NAME EMAIL_ADDRESS 'PASSWORD' --filename AUTOMATE_CHEF_USER_KEY

#. Create the ``AUTOMATE_CHEF_ORG`` organization and associate the Chef Automate user:

    .. code-block:: bash

        sudo chef-server-ctl org-create AUTOMATE_CHEF_ORG 'org description' --filename ~/AUTOMATE_CHEF_ORG-validator.pem -a delivery

  .. note:: The ``--filename`` option is used so that the validator key for your organization will not be shown on-screen. The key is not required for this process.

Chef Automate Server Installation and Configuration
========================================================

To install Chef Automate:

#. Download and install the latest stable Chef Automate package for your operating system from `<https://downloads.chef.io/automate/>`_ on the Chef Automate server machine.

   For Debian:

   .. code-block:: bash

      dpkg -i PATH_TO_AUTOMATE_SERVER_PACKAGE

   For Red Hat or Centos:

   .. code-block:: bash

      rpm -Uvh PATH_TO_AUTOMATE_SERVER_PACKAGE

#. (Optional) In Chef Automate 0.6.64, you have the option of running the ``preflight-check`` command. This command is optional, but you are encouraged to use it, as it can uncover common environmental problems prior to the actual setup process. For example, there may be required ports that are unavailable, which would have to be rectified prior to setup.

   .. code-block:: bash

      sudo automate-ctl preflight-check

   This triggers a series of validation steps on your system that will be sent to stdout as
   they are run, along with whether they are passing or failing. The end of the
   check will include a report of all failures and remediation steps that you can
   take to fix them.

   .. note:: As shown in the example above, this command requires root user privileges.

   Please refer to the troubleshooting section for more information about the error codes and remediation steps.

#. Ensure that the Chef Automate license file and the user key you created earlier in the Chef Server setup are located on the Chef Automate server.

#. Run the ``setup`` command. This command requires root user privileges. Any unsupplied arguments will be prompted for.

   .. code-block:: bash

      sudo automate-ctl setup --license AUTOMATE_LICENSE \
                              --key AUTOMATE_CHEF_USER_KEY \
                              --server-url https://CHEF_SERVER_FQDN/organizations/AUTOMATE_CHEF_ORG \
                              --fqdn AUTOMATE_SERVER_FQDN \
                              --enterprise ENTERPRISE_NAME

   All paths called for here should be supplied as the absolute path to a file, including the filename.

   ``AUTOMATE_LICENSE`` is the full path and file name of your Chef Automate license file. For example: ``/root/automate.license``.

   .. note:: After your Chef Automate server is successfully setup, this file will be copied into the ``/var/opt/delivery/license`` directory as ``delivery.license``.

   ``AUTOMATE_CHEF_USER_KEY`` is the key that was created in the previous section on your Chef server. For example: ``/root/john_doe.pem``.

   ``AUTOMATE_SERVER_FQDN`` is the external fully-qualified domain name of the Chef Automate server. This is just the name of the system, not a URL. For example: ``host.4thcoffee.co``.

   ``ENTERPRISE_NAME`` is the name of your enterprise. For example: ``4thcoffee_inc``.

#. (Optional) If you are using an internal Supermarket, tell the setup command about it by supplying the ``--supermarket-fqdn`` command line argument:

   .. code-block:: none

      --supermarket-fqdn SUPERMARKET_FQDN

   Because the Supermarket FQDN argument is optional, it will not be prompted for when
   not specified. You must include this option to set up the Chef Automate server
   to interact with an internal Supermarket. The setup command can be re-run
   as often as necessary.

   .. tag automate_supermarket

   .. note:: To enable Chef Automate to upload cookbooks to a private Supermarket, you have to manually log into the Supermarket server with the ``delivery`` user, and when it prompts you to enable the user for Supermarket, enter ``yes``.

   .. end_tag

Once setup of your Chef Automate server completes, you will be prompted to apply the configuration.
This will apply the configuration changes and bring service online, or restart them if you've previously
run setup and applied configuration at that time. You can bypass this prompt by passing in the argument
``--configure`` to the ``setup`` command, which will run it automatically, or pass in ``--no-configure`` to skip it.

If you've applied the configuration, you will also be prompted to
set up a Chef Automate build node.  You can bypass this prompt by passing
in the argument ``--build-node`` to agree to add the build node, or
``--no-build-node`` to skip it.

When opting to install a build node/runner, you will be prompted for additional
required information.  If you choose not to install a build node/runner at this time
you can use the command ``sudo automate-ctl install-build-node`` to install a build node or ``sudo automate-ctl install-runner`` to install a Chef Automate runner
at a later time. This command can be run each time you want to install a
new build node or runner. See the next section for installation instructions.

.. note:: Your Chef Automate server will not be available for use until you either agree to apply the configuration, or manually run ``sudo automate-ctl reconfigure``.

After setup successfully completes, the ``admin`` credentials and ``builder`` password are reported in the completion output; however, they are also saved to ``/etc/delivery/ENTERPRISE_NAME-admin-credentials``.

And if you don't have DNS, define it in ``/etc/hosts``:

   .. code-block:: none

      CHEF_SERVER_IP         CHEF_SERVER_FQDN
      AUTOMATE_SERVER_IP     AUTOMATE_SERVER_FQDN

For more information about ``automate-ctl`` and how to use it, see :doc:`ctl_delivery_server`.

If you plan on using the workflow capabilities of Automate, proceed to the next section to setup your build nodes/runners. After they are set up, you can attempt to run an initial application or cookbook change through your Chef Automate server.

Set up a build node/runner (Optional)
------------------------------------------------------------

Chef Automate's workflow engine automatically creates phase jobs as project code is promoted through the phases of a workflow pipeline. These phase jobs are dispatched to special nodes, called runners and build nodes, that automatically execute each job as it is created. The previous job dispatch system using push jobs is still supported; however the new SSH-based system should be used for any new deployment.

The following steps show how to set up a runner from a Chef Automate server. For instructions on how to set up a push jobs-based build node, see :doc:`setup_build_node`.

#. If you have an on-premises Supermarket installation, copy the Supermarket certificate file to ``/etc/delivery/supermarket.crt``.

#. Run the ``install-runner`` subcommand.

   .. note:: You can optionally download the latest ChefDK from `<https://downloads.chef.io/chef-dk/>`_ to specify a local package via ``--installer``. Doing so is useful if you are in an air-gapped environment. Version 0.15.16 or greater of the ChefDK is required. The download location is referred to below as ``OPTIONAL_CHEF_DK_PACKAGE_PATH``.

   .. code-block:: bash

      automate-ctl install-runner RUNNER_FQDN \
                                  SSH_USERNAME \
                                  [--password OPTIONAL_SSH_OR_SUDO_PASSWORD] \
                                  [--installer OPTIONAL_CHEF_DK_PACKAGE_PATH] \
                                  [--ssh-identity-file OPTIONAL_SSH_IDENTITY_FILE] \
                                  [--port SSH_PORT]

   The ``SSH_USERNAME`` provided must have ``sudo`` access on the intended runner, and at least one of ``--password PASSWORD`` or ``--ssh-identity-file FILE`` is required by Chef Automate in order to communicate with it.

   For more ``install-runner`` usage examples, see :ref:`install-runner`, and for more information on the SSH-based job dispatch system, see :doc:`job_dispatch`.

   .. tag chef_automate_build_nodes

   .. note:: Legacy build nodes created by ``delivery-cluster`` can be used with a Chef Automate server.  Some visibility features are designed to only work with new build nodes and runners installed through the command line process, but the workflow feature in Chef Automate can use legacy, new, or mixed node pools; however, you cannot upgrade a legacy build node to the new build node or runner models.  If you would like to use new build nodes/runners, please use fresh hosts or completely wipe your legacy build nodes before attempting to run ``automate-ctl install-build-node`` or ``automate-ctl install-runner``.

   .. end_tag

   You can view the logs at ``/var/log/automate-ctl/build-node-install_$BUILD_NODE_FDQN.log``.

   Any existing nodes with the same name as your runner's FQDN will be overwritten on the Chef server. This will remove any previous run lists or Chef Server configuration on this node. This is done in case the hostname was previously being used for something else. When calling ``install-runner``, it will give you a warning if you will overwrite a node before installation begins, which you can bypass by passing ``--yes``.

.. note:: Certain sensitive files are copied over to a temporary directory on the build node/runner. In the event of failure after these files have been copied, the installer will attempt to remove them. If it is unable to do so, it will provide you with instructions for doing so manually.

.. note:: Setting up a build node or a runner involves a Chef client run on the target node. This requires the target node to be able to reach your installation's Chef server. Especially in setups that involve proxies, connectivity issues abound and lead to hard-to-spot errors. One indicator of not having interacted with the Chef server is this output in your Chef client run (note the "Server Response" section):

   .. code-block:: none

      ================================================================================
      Chef encountered an error attempting to load the node data for "bldr-1.example"
      ================================================================================

      Authorization Error
      -------------------
      Your client is not authorized to load the node data (HTTP 403).

      Server Response:
      ----------------
      Cannot fetch the contents of the response.

About Proxies
--------------------------------------------------

If the Chef Automate setup process is happening in an environment that is configured to only allow http/https traffic to go
through a proxy server, then some additional steps need to be taken.

The ``http_proxy``, ``https_proxy`` and ``no_proxy`` environment variables will need to be set appropriately for the setup process
to complete successfully. These can be set in the environment directly, or added to a knife.rb file (for example, in ``/root/.chef/knife.rb``).
Any host that needs to make outgoing http or https connections will require these settings. For example, the Chef Automate Server
(which makes knife calls to Chef Server) and Chef Server (for push jobs) should have these configured.

For more details on the proxy setup, please see `About Proxies <https://docs.chef.io/proxies.html>`__.

Compliance
===================================================================

.. _profiles:

Profiles
------------------------------------------------------------

Starting with Chef Automate version 0.6, the Chef Automate server contains a compliance profiles asset store. Enable the service by adding this line:

.. code-block:: bash

   compliance_profiles['enable'] = true

into ``/etc/delivery/delivery.rb`` and running ``automate-ctl reconfigure``. The ``automate-ctl status`` subcommand should now list the status of the ``compliance_profiles`` service.

Manage the profiles in this asset store using the :doc:`api_delivery`.

Scanning
------------------------------------------------------------

Allows nodes to execute infrastructure tests or compliance profiles as part of the chef-client runs. For more details, see :doc:`Compliance scanning w/ Chef Automate guide </integrate_compliance_chef_automate>`.

Troubleshooting
===================================================================

If you run into issues during during setup or in the use of Chef Automate, see :doc:`Troubleshooting Chef Automate </troubleshooting_chef_automate>` for debugging tips and remediations.

Delivery-truck setup
====================================================================

Delivery-truck is Chef Automate's recommended way of setting up build cookbooks.  See :doc:`About the delivery-truck Cookbook </delivery_truck>` for directions on how to get started.

Next steps
=====================================================

After you have setup your Chef Server, Chef Automate, and any build nodes, you must also perform additional configuration steps on nodes to visualize their data in Chef Automate. See :doc:`Configure Data Collection </setup_visibility_chef_automate>` for more information.
