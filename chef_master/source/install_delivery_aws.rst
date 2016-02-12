=====================================================
Installing |chef delivery|, AWS
=====================================================

This topic guides you through setting up |chef delivery| for AWS provisioning with the ``delivery-cluster`` cookbook and Chef Provisioning, and validating the installation, once |chef delivery| is set up. With the ``delivery-cluster`` cookbook, you install the |chef delivery| cluster on your own infrastructure using |chef provisioning| and your license key.

Process Overview
=====================================================
The process for installing |chef delivery| using the ``delivery-cluster`` cookbook involves the following tasks:

* Create and configure a dedicated provisioning node
* Configure the ``delivery-cluster`` cookbook to use |amazon aws| provisioning
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

.. note:: You cannot use your own |chef server| with this AWS provisioning process. You must use the new one that is created for you.


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
|chef delivery| uses |chef provisioning| to create, upgrade, and manage the cluster. A dedicated provisioning node ensures a central place from which the |chef delivery| cluster is managed, including managing those allowed to control it. Use your existing means to provision a dedicated provisioning node with a supported platform. This machine does not need to be powerful because it runs only provisioning code. Within |amazon aws|, |company_name| generally uses a t2.micro instance, which is a single CPU 2.5GHz, 1 GB of memory, and 8 GB of disk space.

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


AWS Settings
-----------------------------------------------------
The following section details settings for |chef delivery| with |amazon aws| provisioning.

.. list-table::
   :widths: 200 400
   :header-rows: 1

   * - Option
     - Description
   * - **Environment Name**
     - This name becomes the default name for the |chef delivery| cluster environment, enterprise, and organization. The naming convention prohibits the use of capital letters, but should otherwise be alphanumeric.
   * - **Key Name**
     - This is the name of your |amazon aws| ``.pem`` credential file. Enter only the name, without the extension. This file is typically located in the ``~.ssh`` directory, and is associated with the **Key name pair** value in |amazon aws| console: https://console.aws.amazon.com/iam/home.
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
     - The path to your |chef delivery| license file; the default path is your home directory.
   * - **Enable Supermarket**
     - Enter "yes" if you intend to run cookbooks through your |chef delivery| pipeline.

AWS Provisioning
--------------------------------------------------------
This section describes setting up a |chef delivery| cluster to use |amazon aws| for provisioning. This process creates at least five machines, depending on the selected configuration options. The typical (and recommended) starting setup is at least five nodes in addition to the provisioning node:

* One to run the |chef server|
* One to run |chef delivery|
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
To run provisioning (from inside the ``delivery-cluster`` directory), run the following command:

.. code-block:: bash

   $ rake setup:cluster

.. note::

   * If the first converge fails on the build nodes, try running the above step again. The |chef delivery| cluster is complicated and sometimes there are timeouts.
   * Running provisioning creates the instances requrested on |amazon aws|. If there are any failures, check the |amazon aws| console for nodes without names. Nodes without names can be removed.

Verify Provisioning
-----------------------------------------------------
To verify provisioning (from inside the ``delivery-cluster`` directory), do the following:

#. Run the following command:

   .. code-block:: bash

      $ rake info:list_core_services

#. Navigate to your CHEF_SERVER_URL, and then login with ``delivery:delivery``. Use ``rake info:delivery_creds`` to get the password.
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
In |chef delivery| there are multiple levels of organization: enterprises, organizations, and projects, where enterprise contain one (or more) organizations and organizations contain one (or more) projects. The provisioning step created the initial enterprise you specified in your environment file as the first ``name`` option. Enterprises are designed to provide units of multi-tenancy with separate sets of organizations and users. Next, set up |chef delivery| by adding users and organizations.

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
