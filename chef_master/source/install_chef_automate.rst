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

  * Runs push jobs, which is used in conjunction with a push jobs client on build nodes to coordinate builds across those build nodes.

   .. note:: if you have an existing Chef server installation, it's best to
    have a separate Chef organization for managing Chef Automate.
    Instructions for this can be found below under the heading "Creating a
    User and Organization".

* Chef Automate server

  * Coordinates the process of moving a change through the workflow pipeline as well as providing insights and visualizations about your Chef Automate cluster.

* (Optional) Build nodes are optional components that perform the work of running builds, tests, and deployments out of Chef Automate and are only required when using the workflow capabilities of Chef Automate.

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
     - ``12.04``, ``14.04``

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
     * - Chef Automate Server
       - 4
       - 16GB\*
       - 80GB
     * - Chef Server (must be v12). See additional information in note, below.
       - 4
       - 8GB
       - 80GB
     * - Build Nodes (Optional, but required if you use workflow)
       - 2
       - 4GB
       - 60GB

\*If you use your own Elasticsearch cluster instead of the single Elasticsearch instance provided with Chef Automate, 
then the Chef Automate server only requires 8 GB of RAM.

.. note:: If you already have a Chef server installation, you can update it with push jobs as detailed in `Push Jobs Server installation <#push_job_installation>`_. If you have both already configured, skip to `Completing Setup <#completing-setup>`_. Also, any build nodes must be accessible from the Chef Automate server over SSH and they must have a user account configured that has sudo privileges.

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
* Build node -> Chef Automate server
* Build node -> Chef server

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

Push Jobs Server Installation
------------------------------------------------------

Chef Automate uses push jobs to coordinate builds jobs across build nodes.
This is available as an add-on to Chef server.

.. note:: Chef Automate requires Push Jobs Server 1.x and is not compatible with Push Jobs Server 2.x.  If you are installing Chef Automate on Red Hat Enterprise Linux/CentOS 7, use the Red Hat Enterprise Linux/CentOS 6 package for Push Jobs Server 1.x (available at `<https://downloads.chef.io/push-jobs-server/redhat/>`_) and manually install it.  For other platforms, you can use the automated installation method for Push Jobs Server 1.x as described below.

Download the appropriate package for your platform from `<https://downloads.chef.io/push-jobs-server/>`_  and copy it to the Chef server.  The location that it's been saved to is referred to as `$PATH_TO_DOWNLOADED_PACKAGE`.

Run the command below on the Chef server:

.. code-block:: bash

   sudo chef-server-ctl install opscode-push-jobs-server --path $PATH_TO_DOWNLOADED_PACKAGE

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

#. From the Chef server, create a ``delivery`` user specifying first name, last name, email address, and password. Also, as done in the step 5 of the `Chef Server Installation <#chef-server-installation>`_, a private key will be generated for you, so specify where to save the user key using the ``--filename`` option. The key will be referenced this later as ``$AUTOMATE_CHEF_USER_KEY``:

    .. code-block:: bash

        sudo chef-server-ctl user-create delivery $FIRST_NAME $LAST_NAME $EMAIL_ADDRESS '$PASSWORD' --filename $AUTOMATE_CHEF_USER_KEY

#. Create the ``$AUTOMATE_CHEF_ORG`` organization and associate the Chef Automate user:

    .. code-block:: bash

        sudo chef-server-ctl org-create $AUTOMATE_CHEF_ORG 'org description'  --filename ~/$AUTOMATE_CHEF_ORG-validator.pem -a delivery

  .. note:: The ``--filename`` option is used so that the validator key for your organization will not be shown on-screen. The key is not required for this process.

Chef Automate Server Installation and Configuration
========================================================

To install Chef Automate:

#. Download and install the latest stable Chef Automate package for your operating system from `<https://downloads.chef.io/automate/>`_ on the Chef Automate server machine.

   For Debian:

   .. code-block:: bash

      dpkg -i $PATH_TO_AUTOMATE_SERVER_PACKAGE

   For Red Hat or Centos:

   .. code-block:: bash

      rpm -Uvh $PATH_TO_AUTOMATE_SERVER_PACKAGE

#. Ensure that the Chef Automate license file is located on the Chef Automate server.

#. Run the ``setup`` command. This command requires root user privileges. Any unsupplied arguments will be prompted for.

   .. code-block:: bash

      sudo delivery-ctl setup --license $AUTOMATE_LICENSE \
                             --key $AUTOMATE_CHEF_USER_KEY \
                             --server-url https://$CHEF_SERVER_FQDN/organizations/$AUTOMATE_CHEF_ORG \
                             --fqdn $AUTOMATE_SERVER_FQDN

   All paths called for here should be supplied as the absolute path to a file, including the filename.

   ``$AUTOMATE_LICENSE`` is the full path and file name of your Chef Automate license file.

   ``$AUTOMATE_CHEF_USER_KEY`` is the key that was created in the previous section on your Chef server.
   Copy it from the Chef server to the Chef Automate server and then provide the path for the ``--key`` argument.

   ``$AUTOMATE_SERVER_FQDN`` is the external fully-qualified domain name of the Chef Automate server. This is just the name of the system, not a URL.

#. (Optional) If you are using an internal Supermarket, tell the setup command about it by supplying the ``--supermarket-fqdn`` command line argument:

   .. code-block:: none

      --supermarket-fqdn SUPERMARKET_FQDN

   Because the Supermarket FQDN argument is optional, it will not be prompted for when
   not specified. You must include this option to set up the Chef Automate server
   to interact with an internal Supermarket. The setup command can be re-run
   as often as necessary.

Once setup of your Chef Automate server completes, you will be prompted to apply the configuration. 
This will apply the configuration changes and bring service online, or restart them if you've previously 
run setup and applied configuration at that time. You can bypass this prompt by passing in the argument 
``--configure`` to the ``setup`` command, which will run it automatically, or pass in ``--no-configure`` to skip it.

If you've applied the configuration, you will also be prompted to
set up a Chef Automate build node.  You can bypass this prompt by passing
in the argument ``--build-node`` to agree to add the build node, or
``--no-build-node`` to skip it.

When opting to install a build node, you will be prompted for additional
required information.  If you choose not to install a build node at this time
you can use the command ``sudo delivery-ctl install-build-node`` to install a Chef Automate build node
at a later time. This command can be run each time you want to install a
new Chef Automate build node. See the next section for build node installation instructions.

.. note:: Your Chef Automate server will not be available for use until you either agree to apply the configuration, or manually run ``sudo delivery-ctl reconfigure``.

Finally, you must create an Enterprise on the Chef Automate server using the builder's SSH key generated by the ``delivery-ctl setup`` command:

   .. code-block:: bash

      delivery-ctl create-enterprise $ENTERPRISE_NAME --ssh-pub-key-file=/etc/delivery/builder_key.pub

Copy the credentials somewhere safe. And in the ``$AUTOMATE\_SERVER``, if you don't have DNS, define it in ``/etc/hosts``:

   .. code-block:: none

      $CHEF_SERVER_IP         $CHEF_SERVER_FQDN
      $AUTOMATE_SERVER_IP     $AUTOMATE_SERVER_FQDN

If you plan on using the workflow capabilities of Automate, proceed to the next section to setup your build nodes. After they are setup, you can attempt to run an initial application or cookbook change through your Chef Automate server.

Set up a Build node (Optional)
------------------------------------------------------------

The following steps are performed on the Chef Automate server:

#. Download the latest ChefDK from either `<https://downloads.chef.io/chef-dk/>`_. Version 0.15.16 or greater is required. The download location is referred to below as ``$CHEF_DK_PACKAGE_PATH``.

#. If you have an on-premises Supermarket installation, copy the Supermarket certificate file to ``/etc/delivery/supermarket.crt``.

#. Run the following commands. Note that the username provided must be a user who has
   sudo access on the target node.

   .. code-block:: bash

      sudo delivery-ctl install-build-node

   .. tag chef_automate_build_nodes

   .. note:: Legacy build nodes created by ``delivery-cluster`` can be used with a Chef Automate server.  Some visibility features are designed to only work with new build nodes installed through the command line process, but the workflow feature in Chef Automate can use legacy, new, or mixed build node pools; however, you cannot upgrade a legacy build node to the new build node model.  If you would like new build nodes, please use fresh hosts or completely wipe your legacy build nodes before attempting to run ``delivery-ctl install-build-node``.

   .. end_tag

   You will be prompted for the information required to continue.  Alternatively, you can provide some or all
   of the information as arguments to the command:

   .. code-block:: bash

      delivery-ctl install-build-node --fqdn $BUILD_NODE_FQDN \
                                   --username $SSH_USERNAME \
                                   --password $SSH_PASSWORD \
                                   --installer $CHEF_DK_PACKAGE_PATH \
                                   --ssh-identity-file $SSH_IDENTITY_FILE \
                                   --port $SSH_PORT

   You can view the logs at ``/var/log/delivery-ctl/build-node-install_$BUILD_NODE_FDQN.log``.

   You maybe be asked about overwriting your build node's registration in Chef Server.  This will remove any previous run lists or Chef Server configuration on this node.  This is done in case this hostname was previously being used for something else.  Setting the ``--[no]-overwrite-registration`` flag will allow you to avoid that prompt.

.. note:: Certain sensitive files are copied over to a temporary directory on the build node. In the event of failure after these files have been copied, the installer will attempt to remove them. If it is unable to do so, it will provide you with instructions for doing so manually.

About Proxies
--------------------------------------------------

If the Chef Automate setup process is happening in an environment that is configured to only allow http/https traffic to go 
through a proxy server, then some additional steps need to be taken.

The ``http_proxy``, ``https_proxy`` and ``no_proxy`` environment variables will need to be set appropriately for the setup process 
to complete successfully. These can be set in the environment directly, or added to a knife.rb file (for example, in ``/root/.chef/knife.rb``). 
Any host that needs to make outgoing http or https connections will require these settings. For example, the Chef Automate Server 
(which makes knife calls to Chef Server) and Chef Server (for push jobs) should have these configured.

For more details on the proxy setup, please see `About Proxies <https://docs.chef.io/proxies.html>`__.

Compliance scanning
===================================================================

Allows nodes to execute infrastructure tests or compliance profiles as part of the chef-client runs. For more details see the `Compliance scanning w/ Chef Automate guide </integrate_compliance_chef_automate>`_.

Troubleshooting
===================================================================

Once you have setup completed, you should be able to submit a change request for review through the workflow pipeline 
and Chef Automate will run it through the complete process. If there are problems, see :doc:`Troubleshooting Chef Automate Deployments </troubleshooting_chef_automate>` for debugging tips.

Delivery-truck setup
====================================================================

Delivery-truck is Chef Automate's recommended way of setting up build cookbooks.  See :doc:`About the delivery-truck Cookbook </delivery_truck>` for directions on how to get started.

Next steps
=====================================================

After you have setup your Chef Server, Chef Automate, and any build nodes, you must also perform additional configuration steps on nodes to visualize their data in Chef Automate. See :doc:`Configure Data Collection </setup_visibility_chef_automate>` for more information.
