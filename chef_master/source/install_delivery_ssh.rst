=====================================================
Installing |chef delivery|, SSH
=====================================================

This topic guides you through setting up |chef delivery| for SSH provisioning with the ``delivery-cluster`` cookbook and Chef Provisioning, and validating the installation, once |chef delivery| is set up. With the ``delivery-cluster`` cookbook, you install the |chef delivery| cluster on your own infrastructure using |chef provisioning| and your license key.

Process Overview
=====================================================
The process for installing |chef delivery| using the ``delivery-cluster`` cookbook involves the following tasks:

* Create and configure a dedicated provisioning node
* Configure the ``delivery-cluster`` cookbook to use SSH provisioning
* Run automation for ``delivery-cluster``, which sets up a full |chef delivery| cluster and gives you login credentials
* Verify the |chef delivery| provisioning
* Set up your workstation to develop projects in |chef delivery|
* Configure |chef delivery|
* Validate the installation by creating a cookbook and kicking off a pipeline

Prerequisites
=====================================================
|chef delivery| requires a license from |company_name| to install.

Supported Platforms
-----------------------------------------------------
|chef delivery| may be run on the following platforms. Do not mix platform versions within the |chef delivery| cluster.

  .. list-table::
     :widths: 250 250
     :header-rows: 1

     * - OS
       - Versions
     * - Ubuntu
       - 12.04, 14.04
     * - Centos
       - 6.5, 6.6, 7
     * - Redhat
       - 6.5, 6.6, 7

Infrastructure
-----------------------------------------------------
|chef delivery| has the following infrastructure requirements:

  .. list-table::
     :widths: 150 100 100 100
     :header-rows: 1

     * - Function
       - vCPU
       - RAM
       - Free disk space (in /var)
     * - Provisioning Node
       - 1 (2.5GHz)
       - 1GB
       - 8GB
     * - Delivery Server
       - 4
       - 8GB
       - 80GB
     * - Chef Server (must be v12). See additional information in note, below.
       - 4
       - 8GB
       - 80GB
     * - Supermarket Server
       - 4
       - 8GB
       - 80GB
     * - Build Nodes (at least 3, one for each Verify phase: Lint, Syntax, and Functional)
       - 2
       - 4GB
       - 60GB
     * - Infrastructure Nodes (at least 4, one for each environment stage: Acceptance, Union, Rehearsal, and Delivered)
       - 2 (for test purposes)
       - 4GB (for test purposes)
       - 60GB (for test purposes)

.. note:: If you want to use your existing |chef server| in the |chef delivery| cluster, the version of the |chef server| must be 12.2, it cannot have a high availability configuration. In addition, a special entry must be made to the environments configuration file (``environments/NAME_OF_ENV.json``) simillar to:

   .. code-block:: javascript

      "chef-server": {
        "organization": "test",
        "existing": true,
        "host": "chef-server.example.com"
      },


Network and Ports
-----------------------------------------------------
|chef delivery| has the following network and port requirements:

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
       - Delivery server
       - LISTEN
     * - 443
       - TCP HTTP Secure
       - Chef server, Delivery server
       - LISTEN
     * - 22
       - TCP SSH
       - All
       - LISTEN
     * - 80
       - TCP HTTP
       - Chef server, Delivery server
       - LISTEN
     * - 5672
       - TCP Analytics MQ
       - n/a
       - n/a
     * - 10012-10013
       - TCP Analytics Messages/Notifier
       - n/a
       - n/a


Install |chef delivery|
=====================================================
Begin installing |chef delivery| by creating a provisioning node to provision and maintain the cluster.

Provisioning Node
-----------------------------------------------------
|chef delivery| uses |chef provisioning| to create, upgrade, and manage the cluster. A dedicated provisioning node ensures a central place from which the |chef delivery| cluster is managed, including managing those allowed to control it. Use your existing means to provision a dedicated provisioning node with a supported platform. This machine does not need to be powerful because it runs only provisioning code.

On the provisioning node:

#. Install a development environment:

   For |debian|-based (apt):

   .. code-block:: bash

      $ sudo apt-get install build-essential

   For |redhat enterprise linux|-based (yum):

   .. code-block:: bash

      $ sudo yum groupinstall "Development Tools"

   For |mac os x|:

   .. code-block:: bash

      $ sudo xcode-select --install

#. Install |git| and configure your |github| username and email, for help see: `Installing Git <http://git-scm.com/book/en/v2/Getting-Started-Installing-Git>`_ and `First-Time Git Setup <https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup>`_.
#. Install the `Chef Development Kit <https://downloads.chef.io/chef-dk/>`_. Be sure to set the system |ruby|; for details, see `Add Ruby to $PATH <https://docs.chef.io/install_dk.html#add-ruby-to-path>`_.

#. Transfer your |chef delivery| license key to ``~/delivery.license``.
#. Clone the |git| repo for the |chef delivery| cluster:

   .. code-block:: bash

      $ git clone https://github.com/opscode-cookbooks/delivery-cluster.git ~/delivery-cluster


SSH Settings
-----------------------------------------------------
The following section details settings for |chef delivery| with SSH provisioning.

.. list-table::
   :widths: 200 400
   :header-rows: 1

   * - Option
     - Description
   * - **Environment Name**
     - This name becomes the default name for your |chef delivery| cluster environment, enterprise, and organization. The naming convention prohibits the use of capital letters, but should otherwise be alphanumeric.
   * - **Key File**
     - The path to your ``.ssh`` key file; for example, ``/home/USERNAME/.ssh/USERNAME.pem``. Note, you must set up the public/private SSH key-pair yourself before attempting to install |chef delivery|.
   * - **SSH Username**
     - Enter the default SSH username for the system on which you are installing ``delivery-cluster``. For example, for an |ubuntu| machine, the default SSH username is ``ubuntu``. You may need to look up what the default is for your system.
   * - **Chef Server Host**, **Delivery Server Host**, and **Build Nodes Host**
     - For SSH, you enter the IP addresses of the nodes that you have already provisioned. This is true also if you choose to enable a |supermarket| server.
   * - **Use existing chef-server**
     - Accept the default, "no", if you want ``delivery-cluster`` to configure a Chef server for you (you will be asked for the IP address of the server). Enter "yes" if you have a configured |chef server| that you want to use and do not need ``delivery-cluster`` to configure one for you. If you do specify ``yes``, please note that the version of the |chef server| must be 12.2, it cannot have a high availability configuration. In addition, a special entry must be made to the environments configuration file (``environments/NAME_OF_ENV.json``) simillar to:

       .. code-block:: javascript

          "chef-server": {
            "organization": "test",
            "existing": true,
            "host": "chef-server.example.com"
          },

   * - **License File**
     - The path to your |chef delivery| license file; the default path is your home directory.
   * - **Enable Supermarket**
     - Enter "yes" if you intend to run cookbooks through your |chef delivery| pipeline.

SSH Provisioning
-----------------------------------------------------
This section describes setting up a |chef delivery| cluster to use |ssh| for provisioning. This process creates at least five machines, depending on the selected configuration options. The typical (and recommended) starting setup is five nodes in addition to the provisioning node:

* One to run the |chef server|
* One to run |chef delivery|
* Three to act as build nodes
* One to run the |supermarket| server; for cookbook dependency resolution, using |supermarket| server is required
* For a test environment, use stand-in infrastructure nodes; we recommend four, one for each environment stage: Acceptance, Union, Rehearsal, and Delivered

These machines must be accessible via |ssh| and commands should be run using ``sudo`` without passwords.

On the provisioning node:

#. Propagate your public key (id_rsa.pub) to your Delivery cluster nodes through a command such as `ssh-copy-id`.

#. Ensure that the appropriate ports are open as described in the **Network and Ports** section.

#. Create a configuration file to drive |chef provisioning|:

   .. code-block:: bash

      $ rake setup:generate_env

   This opens a wizard, the following code block shows the interactions. Variables you must enter are shown in ALL CAPs. Default values are shown in square brackets; pressing ENT sets the default value. This command creates an ``environments/ENV_NAME.json`` file with the specified settings that you can modify if need be.

   .. code-block:: bash

      $ rake setup:generate_env

      Gathering Cluster Information

      Provide the following information to generate your environment.

      Global Attributes
      Environment Name [test]:
      Cluster ID [test]:

      Available Drivers: [ aws | ssh | vagrant ]
      Driver Name [aws]: ssh

      Driver Information [ssh]
      SSH Username: DEFAULT_SSH_USERNAME_FOR_YOUR_SYSTEM
      Key File [/Users/dwrede/.ssh/id_rsa]:
      Would you like to configure Proxy Settings? [no]:

      Chef Server
      Organization Name [test]:
      Use existing chef-server? [no]:
      Host [33.33.33.10]: IP_ADDR_FOR_CHEF_SERVER

      Delivery Server
      Package Version [latest]:
      Enterprise Name [test]:
      License File [/Users/dwrede/delivery.license]: PATH_TO_DELIVERY_LICENSE
      Host [33.33.33.11]: IP_ADDR_FOR_DELIVERY_SERVER

      Analytics Server
      Enable Analytics? [no]:

      Supermarket Server
      Enable Supermarket? [no]: yes
      Host [33.33.33.13]: IP_ADDR_FOR_SUPERMARKET_SERVER

      Build Nodes
      Number of Build Nodes [1]: 3
      Host for Build Node 1 [33.33.33.14]: IP_ADDR_FOR_BUILD_NODE_1
      Host for Build Node 2 [33.33.33.15]: IP_ADDR_FOR_BUILD_NODE_2
      Host for Build Node 3 [33.33.33.16]: IP_ADDR_FOR_BUILD_NODE_3

      Rendering Environment => environments/test.json


#. Export your new environment by executing the following: (example uses ``test`` as the environment name):

   .. code-block:: bash

      $ export CHEF_ENV=test

.. note::

   You can name your environment file anything, but note the name for future reference.

Reset SSH Keys
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery/includes_delivery_ssh_keys_reset.rst

Run Provisioning
-----------------------------------------------------
To run provisioning (from inside the ``delivery-cluster`` directory), run the following command:

.. code-block:: bash

   $ rake setup:cluster

.. note::

   * If the first converge fails on the build nodes, try running the above step again. The |chef delivery| cluster is complicated and sometimes there are timeouts.

Verify Provisioning
-----------------------------------------------------
To verify provisioning (from inside the ``delivery-cluster`` directory), do the following:

#. Run the following command:

   .. code-block:: bash

      $ rake info:list_core_services

#. Navigate to your CHEF_SERVER_URL, and then login with ``delivery:delivery``.
#. Click on **Nodes**. You'll see your |chef delivery| server, your build nodes, and nodes for any other optional features that you installed.
#. Get the credentials and URL with the following command:

   .. code-block:: bash

      $ rake info:delivery_creds

#. Navigate to the **Web Login** and use the ``admin`` credentials to log in.
#. Run the following command:

   .. code-block:: bash

      $ knife node status

   All build nodes should report available.

Configure Delivery
=====================================================
In |chef delivery| there are multiple levels of organization: enterprises, organizations, and projects. The provisioning step created the initial enterprise you specified in your environment file as the first ``name`` option. Enterprises are designed to provide units of multi-tenancy with separate sets of organizations and users. Next, set up |chef delivery| by adding users and organizations.

.. note:: |chef delivery| by default hosts a git server that you interact with through the delivery CLI commands. Additionally, you can integrate GitHub Enterprise or GitHub.com.

Add Users
------------------------------------------------------
The default ``admin`` account should not be used after |chef delivery| is installed. Instead, use the following procedure to create a new user for yourself, then log out as ``admin`` and log back in as the user you created.

Create Organizations
-----------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_create_org.rst

Setup a Workstation
-----------------------------------------------------
After the |chef delivery| cluster has been created, team members need to install the |chef delivery| CLI on their workstations.

.. note:: If you reuse the provisioning node in the previous section of this installation guide as a workstation for using |chef delivery|, you can skip steps 1 through 4 below.

.. include:: ../../includes_delivery/includes_delivery_setup_workstation.rst

Install Delivery CLI
-----------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_cli_install.rst

|mac os x|
++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery/includes_delivery_cli_install_mac.rst

|ubuntu|
++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery/includes_delivery_cli_install_ubuntu.rst

RHEL, SUSE
++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery/includes_delivery_cli_install_rhel.rst

|windows|
++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery/includes_delivery_cli_install_windows.rst

Configure Delivery CLI
-----------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_cli_configure.rst

Authenticate
-----------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_setup_workstation_authenticate.rst


Validate the Installation
=====================================================
The surest way to validate your |chef delivery| installation is by creating a cookbook and submitting it to |github|, which will kick off a pipeline and you can see how the process works.

.. include:: ../../includes_delivery/includes_delivery_build_cookbook_create.rst

.. include:: ../../includes_delivery/includes_delivery_projects_add_with_delivery_truck.rst
