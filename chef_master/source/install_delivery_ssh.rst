=====================================================
Installing |chef delivery|, SSH
=====================================================

.. include:: ../../includes_install/includes_install_delivery.rst

Process Overview
=====================================================
.. include:: ../../includes_install/includes_install_delivery_overview.rst

Prerequisites
=====================================================
.. include:: ../../includes_install/includes_install_delivery_prerequisites.rst

Supported Platforms
-----------------------------------------------------
.. include:: ../../includes_supported_platforms/includes_supported_platforms_delivery_server.rst

Infrastructure
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_delivery_infrastructure.rst

.. note:: If you want to use your existing |chef server| in the |delivery| cluster, the version of the |chef server| must be 12.2 and must have a standalone configuration. In addition, a special entry must be made to the environments configuration file (``/delivery-cluster/environments/ENVIRONMENT_NAME.json``) simillar to:

   .. code-block:: javascript

      "chef-server": {
        "organization": "test",
        "existing": true,
        "host": "chef-server.example.com"
      },

Network and Ports
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_delivery_network_and_ports.rst

Install |delivery|
=====================================================
Begin installing |delivery| by creating a provisioning node to provision and maintain the cluster.

Provisioning Node
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_delivery_provisioning_node.rst

.. include:: ../../includes_install/includes_install_delivery_provisioning_node_steps.rst


SSH Settings
-----------------------------------------------------
The following section details settings for |delivery| with SSH provisioning.

.. list-table::
   :widths: 200 400
   :header-rows: 1

   * - Option
     - Description
   * - **Environment Name**
     - This name becomes the default name for your |delivery| cluster environment, enterprise, and organization. The naming convention prohibits the use of capital letters, but should otherwise be alphanumeric.
   * - **Key File**
     - The path to your ``.ssh`` key file; for example, ``/home/USERNAME/.ssh/USERNAME.pem``. Note, you must set up the public/private SSH key-pair yourself before attempting to install |delivery|.
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
     - The path to your |delivery| license file; the default path is your home directory.
   * - **Enable Supermarket**
     - Enter "yes" if you intend to run cookbooks through your |delivery| pipeline.

SSH Provisioning
-----------------------------------------------------
This section describes setting up a |delivery| cluster to use |ssh| for provisioning. This process creates at least five machines, depending on the selected configuration options. The typical (and recommended) starting setup is five nodes in addition to the provisioning node:

* One to run the |chef server|
* One to run |delivery|
* Three to act as build nodes
* One to run the |supermarket| server; for cookbook dependency resolution, using |supermarket| server is required
* For a test environment, use stand-in infrastructure nodes; we recommend four, one for each environment stage: Acceptance, Union, Rehearsal, and Delivered

.. note:: These machines must be accessible via |ssh| and the user account for the |ssh| logins must be capable of running any command via passwordless |sudo cmd|. Or a password may be specified using the ``prefix`` attribute in the ``environment.json`` file, with a value similar to:

   .. code-block:: javascript

      "ssh": {
        "ssh_username": "ubuntu",
        "prefix": "echo myPassword | sudo -S ",
        "key_file": "~/.ssh/id_rsa.pem",
        ...

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
.. include:: ../../includes_install/includes_install_delivery_provisioning_run.rst

Verify Provisioning
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_delivery_verify_provisioning.rst

Configure Delivery
=====================================================
.. include:: ../../includes_install/includes_install_delivery_configure.rst

Add Users
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_delivery_configure_users.rst

Create Organizations
-----------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_create_org.rst

Setup a Workstation
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_delivery_configure_workstation.rst

.. include:: ../../includes_delivery/includes_delivery_setup_workstation.rst

Install Delivery CLI
-----------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_cli_install.rst

.. note:: .. include:: ../../includes_supported_platforms/includes_supported_platforms_delivery_client.rst

|mac os x|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery/includes_delivery_cli_install_mac.rst

|ubuntu|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery/includes_delivery_cli_install_ubuntu.rst

|redhat enterprise linux| 
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery/includes_delivery_cli_install_rhel.rst

|windows|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery/includes_delivery_cli_install_windows.rst

Configure Delivery CLI
-----------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_cli_configure.rst

Authenticate
-----------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_setup_workstation_authenticate.rst


Validate the Installation
=====================================================
The surest way to validate your |delivery| installation is by creating a cookbook and submitting it to |github|, which will kick off a pipeline and you can see how the process works.

.. include:: ../../includes_delivery/includes_delivery_build_cookbook_create.rst

.. include:: ../../includes_delivery/includes_delivery_projects_add_with_delivery_truck.rst
