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

* Chef server

  Contains the cookbooks and data used to build, test, and deploy your components within Chef Automate and your infrastructure

* Chef Automate server

  Coordinates the process of moving a change through the workflow pipeline as well as providing insights and visualizations about your Chef Automate cluster

Optional components include:

* Push jobs server

  Runs push jobs, which is used to create infrastructure nodes for deployment testing and is also needed if you use push jobs-based build nodes as part of your testing and deployment process

* Runners/build nodes

  Perform the work of running builds, tests, and deployments out of Chef Automate and are only required when using the workflow capabilities of Chef Automate

* Chef Compliance server 

  Used in conjunction with the ``audit cookbook`` to run InSpec profiles as part of a Chef client run

Prerequisites
=====================================================

Chef Automate requires a license from Chef to install. You will receive an email with a license key valid for 30 days after you complete the Chef Automate registration. If you would like to continue using Chef Automate after that period, please contact `awesome@chef.io` for a permanent key.

Platform Support
-----------------------------------------
Please see the `platforms topic </platforms.html#chef-automate>`_ for details on supported platforms, architectures, and versions for both Chef Automate servers and runners.


Hardware Requirements
------------------------------------------

Chef Automate deployments have the following hardware requirements:

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

Node Hostnames and Network Access
-----------------------------------------------------

The automated configuration of Chef Automate and Chef servers use the
``hostname`` command to determine the visible fully-qualified domain name
(FQDN) of the node.  Prior to installation, ensure that ``hostname``
and ``hostname -f`` on each node resolves to a matching, correct FQDN that is visible to the
other nodes in the cluster. If necessary, update the ``/etc/hosts`` file on
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

.. note:: Any build nodes/runners must be accessible from the Chef Automate server over SSH and they must have a user account configured that has sudo privileges.

Chef Server Installation and Configuration
=====================================================

Chef Automate associates with a Chef server for application/cookbook building and testing as well as proxying cluster data from nodes for visualization purposes. Because of hardware requirements for both Chef server and Chef Automate, it is recommended that Chef server is installed on a separate node from Chef Automate server.

Also, if you have an existing Chef server installation, it is recommended that you have a separate organization for use with Chef Automate. This keeps any existing production organizations separate from the organization used by runners and infrastructure nodes in your Chef Automate cluster. 

Instructions for creating a new organization can be found below under the subheading `Create a User and Organization to Manage Your Cluster </install_chef_automate.html#create-a-user-and-organization-to-manage-your-cluster>`_.

If you already have an existing Chef server and wish to manage infrastructure nodes for deployment testing (or want to use push jobs-based build nodes), update it with
the `push jobs server add-on </install_chef_automate.html#push-jobs-server-installation>`_.

If you don't have an existing Chef server installed and configured, the steps below will configure a minimal Chef server for use with Chef Automate.

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

Create a User and Organization to Manage Your Cluster
-------------------------------------------------------

As noted above, it's a best practice to use a separate organization when managing nodes in a Chef Automate cluster. Perform the following steps to create a new administrator user and a new organization for your Chef Automate cluster:

#. Create a user named ``delivery``, and specify a first name, last name, email address, and password. A private key will be generated for you, so specify where to save that key using the ``--filename`` option with an absolute path to its intended location. 

    .. code-block:: bash

        sudo chef-server-ctl user-create delivery FIRST_NAME LAST_NAME EMAIL_ADDRESS 'PASSWORD' --filename AUTOMATE_CHEF_USER_KEY

    The path to the key is referenced as ``AUTOMATE_CHEF_USER_KEY`` in step 4 of `Chef Automate Server Installation and Configuration </install_chef_automate.html#chef-automate-server-installation-and-configuration>`_.

#. Create an organization for managing your Chef Automate cluster and associate the Chef Automate ``delivery`` user with it.

    .. code-block:: bash

        sudo chef-server-ctl org-create AUTOMATE_CHEF_ORG 'org description' --filename ~/AUTOMATE_CHEF_ORG-validator.pem -a delivery

   The organization name (denoted by the placeholder ``AUTOMATE_CHEF_ORG`` above) must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``4thcoffee``.

   The full name must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``'Fourth Coffee, Inc.'``.

   The ``--association_user`` (``-a``) option will associate the ``delivery`` user with the ``admins`` security group on the Chef server. 

   An RSA private key is generated automatically. This is the chef-validator key and should be saved to a safe location. The ``--filename`` option will save the RSA private key to the specified absolute path.

  .. note:: The ``--filename`` option is used so that the validator key for your organization will not be shown on-screen. The key is not required for this process.

Push Jobs Server Installation (Optional)
------------------------------------------------------

Chef Automate, through the delivery-truck cookbook, can use push jobs to spin up infrastructure environments for deployment testing and can also be used to coordinate build jobs across build nodes when using the push jobs-based job dispatch system.

Push jobs server is available as an add-on to Chef server. If you only wish to use push jobs for deployment testing, you can use runners and the new job dispatch system in conjunction with Push jobs server.

.. note:: Chef Automate is fully compatible with Push jobs server 1.x and 2.x. Please use 2.x for new installations. Information about upgrading from Push jobs server version 1.x to 2.x can be be found `here </release_notes_push_jobs.html#upgrading-chef-automate-installation-to-use-push-jobs-server-2-1>`_.

Download the appropriate package for your platform from `<https://downloads.chef.io/push-jobs-server/>`_  and copy it to the Chef server.  The location that it's been saved to is referred to as `PATH_TO_DOWNLOADED_PACKAGE`.

Run the command below on the Chef server:

.. code-block:: bash

   sudo chef-server-ctl install opscode-push-jobs-server --path PATH_TO_DOWNLOADED_PACKAGE

After it has been installed, you must reconfigure it to complete your setup of Push jobs server.

.. code-block:: bash

   sudo opscode-push-jobs-server-ctl reconfigure

Completing Setup
-----------------------------------------------------

Run the following command on the Chef server node to complete setup and
configuration of Chef server.

.. code-block:: bash

   sudo chef-server-ctl reconfigure

Running this ``reconfigure`` command may trigger a brief restart of your Chef server.  This will typically fall within the standard retry window for Chef clients, so no significant interruption of service is expected.

Chef Automate Server Installation and Configuration
========================================================

Now that you have your Chef server set up, install and configure Chef Automate by doing the following: 

.. note:: If you plan to use a private Supermarket with your Chef Automate server, please make sure it is set up correctly by following the steps in :doc:`install_supermarket`. 

#. Download and install the latest stable Chef Automate package for your operating system from `<https://downloads.chef.io/automate/>`_ on the Chef Automate server machine.

   For Debian:

   .. code-block:: bash

      dpkg -i PATH_TO_AUTOMATE_SERVER_PACKAGE

   For Red Hat or Centos:

   .. code-block:: bash

      rpm -Uvh PATH_TO_AUTOMATE_SERVER_PACKAGE

#. In Chef Automate 0.6.64, you have the option of running the ``preflight-check`` command. This command is optional, but you are encouraged to use it, as it can uncover common environmental problems prior to the actual setup process. For example, there may be required ports that are unavailable, which would have to be rectified prior to setup.

   .. code-block:: bash

      sudo automate-ctl preflight-check

   This triggers a series of validation steps on your system that will be sent to stdout as
   they are run, along with whether they are passing or failing. The end of the
   check will include a report of all failures and remediation steps that you can
   take to fix them.

   .. note:: As shown in the example above, this command requires root user privileges.

   Please refer to the troubleshooting section for more information about the error codes and remediation steps.

#. Ensure that the Chef Automate license file and the ``delivery`` user key you created earlier in the Chef Server setup are located on the Chef Automate server.

#. Run the ``setup`` command. This command requires root user privileges. Any unsupplied arguments will be prompted for.

   .. code-block:: bash

      sudo automate-ctl setup --license AUTOMATE_LICENSE \
                              --key AUTOMATE_CHEF_USER_KEY \
                              --server-url https://CHEF_SERVER_FQDN/organizations/AUTOMATE_CHEF_ORG \
                              --fqdn AUTOMATE_SERVER_FQDN \
                              --enterprise ENTERPRISE_NAME \
                              --supermarket-fqdn SUPERMARKET_FQDN (Optional)

   All paths called for here should be supplied as the absolute path to a file, including the filename.

   ``AUTOMATE_LICENSE`` is the full path and file name of your Chef Automate license file. For example: ``/root/automate.license``.

   .. note:: After your Chef Automate server is successfully setup, this file will be copied into the ``/var/opt/delivery/license`` directory as ``delivery.license``.

   ``AUTOMATE_CHEF_USER_KEY`` is the ``delivery`` user key that you created on your Chef server. For example: ``/root/delivery.pem``.

   The ``--server-url`` is the URL of your Chef server, which contains the fully-qualified domain name of the Chef server and the name of the organization you created when you created the ``delivery`` user. 

   ``AUTOMATE_SERVER_FQDN`` is the external fully-qualified domain name of the Chef Automate server. This is just the name of the system, not a URL. For example: ``host.4thcoffee.co``.

   ``ENTERPRISE_NAME`` is the name of your enterprise. For example: ``4thcoffee_inc``.

   If you are using a private Supermarket, tell the setup command about it by supplying the ``--supermarket-fqdn`` command line argument:

   .. code-block:: none

      --supermarket-fqdn SUPERMARKET_FQDN

   Because the Supermarket FQDN argument is optional, it will not be prompted for when
   not specified. You must include this option to set up the Chef Automate server
   to interact with a private Supermarket. The setup command can be re-run
   as often as necessary.

   .. tag automate_supermarket

   .. note:: To enable Chef Automate to upload cookbooks to a private Supermarket, you have to manually log into the Supermarket server with the ``delivery`` user, and when it prompts you to enable the user for Supermarket, enter ``yes``. Also, you must copy the Supermarket certificate file to ``/etc/delivery/supermarket.crt`` on the Chef Automate server.

   .. end_tag

Once setup of your Chef Automate server completes, you will be prompted to apply the configuration.
This will apply the configuration changes and bring services online, or restart them if you've previously
run setup and applied configuration at that time. You can bypass this prompt by passing in the argument
``--configure`` to the ``setup`` command, which will run it automatically, or pass in ``--no-configure`` to skip it.

.. note:: Your Chef Automate server will not be available for use until you either agree to apply the configuration, or manually run ``sudo automate-ctl reconfigure``.

If you've applied the configuration, you will also be prompted to set up a Chef Automate runner and submit additional information. In addition to installing runners during setup, you can also install push jobs-based build nodes after your Chef Automate setup completes using the command ``sudo automate-ctl install-build-node``. If you need to install additional runners, run ``sudo automate-ctl install-runner``. These commands can be run each time you want to install a new build node or runner. See the next section for installation instructions.

After setup successfully completes and a configuration has been applied, login credentials are reported in the completion output; however, they are also saved to ``/etc/delivery/ENTERPRISE_NAME-admin-credentials``.

And if you don't have DNS, specify the fully-qualified domain names for your Chef server and Chef Automate server in ``/etc/hosts``:

   .. code-block:: none

      CHEF_SERVER_IP         CHEF_SERVER_FQDN
      AUTOMATE_SERVER_IP     AUTOMATE_SERVER_FQDN

.. note:: If your environment requires going through a proxy server, please see `About Proxies </install_chef_automate.html#about-proxies>`_ for information on how to configure proxy settings.

If you plan on using the workflow capabilities of Automate, proceed to the next section to setup your build nodes/runners. After they are set up, you can attempt to run an initial application or cookbook change through your Chef Automate server.

For more information about ``automate-ctl`` and how to use it, see :doc:`ctl_delivery_server`.

Set up a build node/runner (Optional)
------------------------------------------------------------

Chef Automate's workflow engine automatically creates phase jobs as project code is promoted through the phases of a workflow pipeline. These phase jobs are dispatched to special nodes, called runners and build nodes, that automatically execute each job as it is created. The previous job dispatch system using push jobs-based build nodes is still supported; however the new SSH-based system using runners is the default job dispatch system and should be used for any new deployment.

The following steps show how to set up a runner from a Chef Automate server. For instructions on how to set up a push jobs-based build node, see :doc:`setup_build_node`.

#. If you have an on-premises Supermarket installation, copy the Supermarket certificate file to ``/etc/delivery/supermarket.crt``.

#. Run the ``install-runner`` subcommand.

   .. note:: You can optionally download the latest ChefDK from `<https://downloads.chef.io/chefdk/>`_ to specify a local package via ``--installer``. Doing so is useful if you are in an air-gapped environment. Version 0.15.16 or greater of the ChefDK is required. The download location is referred to below as ``OPTIONAL_CHEF_DK_PACKAGE_PATH``.

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

Any host that needs to make outgoing http or https connections will require these settings as well. For example, the Chef Automate server
(which makes knife calls to Chef server) and Chef server (for push jobs) should have these configured. To update the Chef Automate server, update ``/etc/delivery/delivery.rb`` on your Chef Automate server with the values specified in `Proxy Settings </config_rb_delivery.html#proxy-settings>`_. After you have configured your settings, run ``sudo automate-ctl reconfigure``.

For general information on proxy settings, please see :doc:`About Proxies </proxies>`.

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

After you have setup your Chef Server, Chef Automate, and any build nodes, you must perform some simple configuration steps to visualize node data in Chef Automate. This, as well as more advanced data configuration scenarios are covered in See :doc:`Configure Data Collection </setup_visibility_chef_automate>`.
