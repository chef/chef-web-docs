=====================================================
Installing |chef delivery|, AWS
=====================================================

.. include:: ../../includes_install/includes_install_delivery.rst

Process Overview
=====================================================
.. include:: ../../includes_install/includes_install_delivery_overview.rst

Prerequisites
=====================================================
.. include:: ../../includes_install/includes_install_delivery_prerequisites.rst

Platforms
-----------------------------------------------------
.. include:: ../../includes_adopted_platforms/includes_adopted_platforms_delivery_server.rst

Infrastructure
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_delivery_infrastructure.rst

.. note:: You cannot use your own |chef server| with this AWS provisioning process. You must use the new one that is created for you.

Network and Ports
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_delivery_network_and_ports.rst

Install |delivery|
=====================================================
Begin installing |delivery| by creating a provisioning node to provision and maintain the cluster.

Provisioning Node
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_delivery_provisioning_node.rst

Within |amazon aws|, |company_name| generally uses a t2.micro instance, which is a single CPU 2.5GHz, 1 GB of memory, and 8 GB of disk space.

.. include:: ../../includes_install/includes_install_delivery_provisioning_node_steps.rst

AWS Settings
-----------------------------------------------------
The following section details settings for |delivery| with |amazon aws| provisioning.

.. list-table::
   :widths: 200 400
   :header-rows: 1

   * - Option
     - Description
   * - **Environment Name**
     - This name becomes the default name for the |delivery| cluster environment, enterprise, and organization. The naming convention prohibits the use of capital letters, but should otherwise be alphanumeric.
   * - **Key Name**
     - This is the name of your |amazon aws| ``.pem`` credential file. Enter only the name, without the extension. This file is typically located in the ``~.ssh`` directory, and is associated with the **Key name pair** value in |amazon aws| console: https://console.aws.amazon.com/.
   * - **Image ID**, **Subnet ID**, and **Security Group ID**
     - This is the information that |amazon aws| needs to provision the nodes. It is wise to verify that the given defaults are actually the ones that you want by opening your |amazon aws| console and verifying.
   * - **Use existing chef-server**
     - Accept the default: ``no``. If you want ``delivery-cluster`` to configure a |chef server| for you (you will be asked for the IP address of the server). Enter ``yes`` if you have a configured |chef server| that you want to use and do not need ``delivery-cluster`` to configure one for you. If you do specify ``yes``, please note that the version of the |chef server| must be 12.2, it cannot have a high availability configuration. In addition, a special entry must be made to the environments configuration file (``environments/NAME_OF_ENV.json``) simillar to:

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

AWS Provisioning
-----------------------------------------------------
This section describes setting up a |delivery| cluster to use |amazon aws| for provisioning. This process creates at least five machines, depending on the selected configuration options. The typical (and recommended) starting setup is at least five nodes in addition to the provisioning node:

* One to run the |chef server|
* One to run |delivery|
* Three to act as build nodes
* One to run the |supermarket| server; for cookbook dependency resolution, using |supermarket| server is required
* For a test environment, use stand-in infrastructure nodes; we recommend four, one for each environment stage: Acceptance, Union, Rehearsal, and Delivered

On the provisioning node:

#. Configure your |amazon aws| key credentials in two files, ``~/.aws/config`` and ``~/.aws/credentials`` as shown, with the text editor of your choice:

   For ``~/.aws/config``:

   .. code-block:: bash

      [default]
      region = us-west-2
      output = text
      aws_access_key_id = YOUR_ACCESS_KEY_ID
      aws_secret_access_key = YOUR_SECRET_KEY

   For ``~/.aws/credentials``:

   .. code-block:: bash

      [default]
      aws_access_key_id = YOUR_ACCESS_KEY_ID
      aws_secret_access_key = YOUR_SECRET_KEY

#. Transfer the private key of the key pair (private-key) that you will use to create the servers in |amazon aws|, to ``~/.ssh`` on the provisioning node. If you do not have one already, use this link and create one: `Amazon EC2 Key Pairs <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html>`_.

#. Ensure that an |amazon aws| security group is available, with the appropriate ports open. See "Network and Ports" for details.

#. Move to the ``delivery-cluster`` directory:  ``cd ~/delivery-cluster``.

#. Create a configuration file to drive |chef provisioning|:

   .. code-block:: bash

      $ rake setup:generate_env

   This opens a wizard, the following code block shows the interactions. Variables you must enter are shown in ALL CAPs. Default values are shown in square brackets; pressing ENT sets the default value. This command creates a ``environments/ENV_NAME.json`` file with the specified settings that you can modify if need be.

   .. code-block:: bash

      $ rake setup:generate_env

      Gathering Cluster Information

      Provide the following information to generate your environment.

      Global Attributes
      Environment Name [test]:
      Cluster ID [test]:

      Available Drivers: [ aws | ssh | vagrant ]
      Driver Name [vagrant]: aws

      Driver Information [aws]
      Key Name: MY-KEY-NAME
      SSH Username [ubuntu]:
      Image ID [ami-3d50120d]:
      Subnet ID [subnet-19ac017c]:
      Security Group ID [sg-cbacf8ae]:
      Use private ip for ssh? [yes]:
      Would you like to configure Proxy Settings? [no]:

      Chef Server
      Organization Name [test]:
      Use existing chef-server? [no]:
      Flavor [c3.xlarge]:

      Delivery Server
      Package Version [latest]:
      Enterprise Name [test]:
      License File [/Users/YOUR-NAME/delivery.license]:
      Flavor [c3.xlarge]:

      Analytics Server
      Enable Analytics? [no]:

      Supermarket Server
      Enable Supermarket? [no]: yes
      Flavor [c3.xlarge]:

      Build Nodes
      Number of Build Nodes [1]: 3
      Flavor [c3.large]:
      Specify a delivery-cli artifact? [no]:

      Rendering Environment => environments/test.json

#. Export the environment by executing the following:

   .. code-block:: bash

      $ export CHEF_ENV=test

   where ``test`` is the name of the environment.

   .. note:: Name the environment file anything, but keep the name close by for future reference.

Run Provisioning
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_delivery_provisioning_run.rst

Running provisioning creates the instances requrested on |amazon aws|. If there are any failures, check the |amazon aws| console for nodes without names. Nodes without names can be removed.

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
