=====================================================
Knife Azure
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/knife_azure.rst>`__


Knife Azure Overview
=====================================================

.. tag knife_azure

Microsoft Azure is a cloud hosting platform from Microsoft that provides virtual machines for Linux and Windows Server, cloud and database services, and more. Use the ``knife azure`` subcommand to manage API-driven cloud servers hosted by Microsoft Azure.

.. end_tag

.. note:: Review the list of `common options </knife_options.html>`__ available to this (and all) knife subcommands and plugins.

``knife-azure`` version 1.6.0 and later supports Azure Resource Manager. Commands starting with ``knife azurerm`` use the Azure Resource Manager API. Commands starting with ``knife azure`` use the Azure Service Management API. While you can switch between the two command sets, they are not designed to work together.


Install Chef Workstation
------------------------------------------------------

Install the latest version of Chef Workstation from `Chef Downloads <https://downloads.chef.io/chef-workstation>`__

For Windows versions older than 2012r2, download the `ChefDK <https://downloads.chef.io/chefdk/>`__.

Install Knife Azure 
------------------------------------------------------

If Chef Client was installed using RubyGems, install the ``knife azure`` with the following command:

.. code-block:: bash

   $ gem install knife-azure

If the Chef Client was installed from the `Chef Client <https://downloads.chef.io/chef>`__ downloads page or any other method, run:

.. code-block:: bash

   $ /opt/chef/embedded/bin/gem install knife-azure

where ``/opt/chef/embedded/bin/`` is the path to the location where the chef-client expects knife plugins to be located.

Configuration
------------------------------------------------------

ASM Mode
+++++++++++++++++++++++++++++++++++++++++++++++++++++

The ``knife azure`` (ASM mode) subcommand uses a management certificate for secure communication with Microsoft Azure. The management certificate is required for secure communication with the Microsoft Azure platform via the REST APIs. To generate the management certificate (.pem file):

#. Download the settings file: http://go.microsoft.com/fwlink/?LinkId=254432.
#. Extract the data from the ``ManagementCertificate`` field into a separate file named ``cert.pfx``.
#. Decode the certificate file with the following command:

   .. code-block:: bash

      $ base64 -d cert.pfx > cert_decoded.pfx
#. Convert the decoded PFX file to a PEM file with the following command:

   .. code-block:: bash

      $ openssl pkcs12 -in cert_decoded.pfx -out managementCertificate.pem -nodes

.. note:: It is possible to generate certificates, and then upload them. See the following link for more information: www.windowsazure.com/en-us/manage/linux/common-tasks/manage-certificates/.

Knife Azure Commands
------------------------------------------------------

ag create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``ag create`` argument to create an affinity group.

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following syntax:

.. code-block:: bash

   $ knife azure ag create (options)

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following options:

``-a``, ``--azure-affinity-group GROUP``
   The affinity group to which the virtual machine belongs. Required when not using a service location. Required when not using ``--azure-service-location``.

``--azure-ag-desc DESCRIPTION``
   The description of the Microsoft Azure affinity group.

``--azure-publish-settings-file FILE_NAME``
   The name of the Azure Publish Settings file, including the path. For example: ``"/path/to/your.publishsettings"``.

``-H HOST_NAME``, ``--azure_host_name HOST_NAME``
   The host name for the Microsoft Azure environment.

``-m LOCATION``, ``--azure-service-location LOCATION``
   The geographic location for a virtual machine and its services. Required when not using ``--azure-affinity-group``.

``-p FILE_NAME``, ``--azure-mgmt-cert FILE_NAME``
   The name of the file that contains the SSH public key that is used when authenticating to Microsoft Azure.

``-S ID``, ``--azure-subscription-id ID``
   The subscription identifier for the Microsoft Azure portal.

``--verify-ssl-cert``
   The SSL certificate used to verify communication over HTTPS.

ag list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``ag list`` argument to get a list of affinity groups.

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following syntax:

.. code-block:: bash

   $ knife azure ag list (options)

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following options:

``--azure-publish-settings-file FILE_NAME``
   The name of the Azure Publish Settings file, including the path. For example: ``"/path/to/your.publishsettings"``.

``-H HOST_NAME``, ``--azure_host_name HOST_NAME``
   The host name for the Microsoft Azure environment.

``-p FILE_NAME``, ``--azure-mgmt-cert FILE_NAME``
   The name of the file that contains the SSH public key that is used when authenticating to Microsoft Azure.

``-S ID``, ``--azure-subscription-id ID``
   The subscription identifier for the Microsoft Azure portal.

``--verify-ssl-cert``
   The SSL certificate used to verify communication over HTTPS.

image list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``image list`` argument to get a list of images that exist in a Microsoft Azure environment. Any image in this list may be used for provisioning.

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following syntax:

.. code-block:: bash

   $ knife azure image list (options)

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following options:

``--azure-publish-settings-file FILE_NAME``
   The name of the Azure Publish Settings file, including the path. For example: ``"/path/to/your.publishsettings"``.

``--full``
   Show all fields for all images.

``-H HOST_NAME``, ``--azure_host_name HOST_NAME``
   The host name for the Microsoft Azure environment.

``-p FILE_NAME``, ``--azure-mgmt-cert FILE_NAME``
   The name of the file that contains the SSH public key that is used when authenticating to Microsoft Azure.

``-S ID``, ``--azure-subscription-id ID``
   The subscription identifier for the Microsoft Azure portal.

``--verify-ssl-cert``
   The SSL certificate used to verify communication over HTTPS.

server create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``server create`` argument to create a new Microsoft Azure cloud instance. This will provision a new image in Microsoft Azure, perform a bootstrap (using the SSH protocol), and then install the chef-client on the target system so that it can be used to configure the node and to communicate with a Chef server.

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following syntax:

.. code-block:: bash

   $ knife azure server create (options)

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following options:

``-a``, ``--azure-affinity-group GROUP``
   The affinity group to which the virtual machine belongs. Required when not using a service location. Required when not using ``--azure-service-location``.

``--auto-update-client``
   Enable automatic updates for the chef-client in Microsoft Azure. This option may only be used when ``--bootstrap-protocol`` is set to ``cloud-api``. Default value: ``false``.

``--azure-availability-set NAME``
   The name of the availability set for the virtual machine.

``--azure-dns-name DNS_NAME``
   Required. The name of the DNS prefix that is used to access the cloud service. This name must be unique within Microsoft Azure. Use with ``--azure-connect-to-existing-dns`` to use an existing DNS prefix.

``--azure-network-name NETWORK_NAME``
   The network for the virtual machine.

``--azure-publish-settings-file FILE_NAME``
   The name of the Azure Publish Settings file, including the path. For example: ``"/path/to/your.publishsettings"``.

``--azure-storage-account STORAGE_ACCOUNT_NAME``
   The name of the storage account used with the hosted service. A storage account name may be between 3 and 24 characters (lower-case letters and numbers only) and must be unique within Microsoft Azure.

``--azure-subnet-name SUBNET_NAME``
   The subnet for the virtual machine.

``--azure-vm-name NAME``
   The name of the virtual machine. Must be unique within Microsoft Azure. Required for advanced server creation options.

``--azure-vm-ready-timeout TIMEOUT``
   A number (in minutes) to wait for a virtual machine to reach the ``provisioning`` state. Default value: ``10``.

``--azure-vm-startup-timeout TIMEOUT``
   A number (in minutes) to wait for a virtual machine to transition from the ``provisioning`` state to the ``ready`` state. Default value: ``15``.

``--bootstrap-protocol PROTOCOL``
   The protocol used to bootstrap on a machine that is running Windows Server: ``cloud-api``, ``ssh``, or ``winrm``. Default value: ``winrm``.

   Use the ``cloud-api`` option to bootstrap a machine in Microsoft Azure. The bootstrap operation will enable the guest agent to install, configure, and run the chef-client on a node, after which the chef-client is configured to run as a daemon/service. (This is a similar process to using the Azure portal.)

   Microsoft Azure maintains images of the chef-client on the guest, so connectivity between the guest and the workstation from which the bootstrap operation was initiated is not required, after a ``cloud-api`` bootstrap is started.

   During the ``cloud-api`` bootstrap operation, knife does not print the output of the chef-client run like it does when the ``winrm`` and ``ssh`` options are used. knife reports only on the status of the bootstrap process: ``provisioning``, ``installing``, ``ready``, and so on, along with reporting errors.

``--bootstrap-version VERSION``
   The version of the chef-client to install.

``-c``, ``--azure-connect-to-existing-dns``
   Add a new virtual machine to the existing deployment and/or service. Use with ``--azure-dns-name`` to ensure the correct DNS is used.

``--cert-passphrase PASSWORD``
   The password for the SSL certificate.

``--cert-path PATH``
   The path to the location of the SSL certificate.

``-H HOST_NAME``, ``--azure_host_name HOST_NAME``
   The host name for the virtual machine.

``--hint HINT_NAME[=HINT_FILE]``
   An Ohai hint to be set on the target node.

   .. tag ohai_hints

   Ohai hints are used to tell Ohai something about the system that it is running on that it would not be able to discover itself. An Ohai hint exists if a JSON file exists in the hint directory with the same name as the hint. For example, calling ``hint?('antarctica')`` in an Ohai plugin would return an empty hash if the file ``antarctica.json`` existed in the hints directory, and return nil if the file does not exist.

   .. end_tag

   .. tag ohai_hints_json

   If the hint file contains JSON content, it will be returned as a hash from the call to ``hint?``.

   .. code-block:: javascript

      {
        "snow": true,
        "penguins": "many"
      }

   .. code-block:: ruby

      antarctica_hint = hint?('antarctica')
      if antarctica_hint['snow']
        "There are #{antarctica_hint['penguins']} penguins here."
      else
        'There is no snow here, and penguins like snow.'
      end

   Hint files are located in the ``/etc/chef/ohai/hints/`` directory by default. Use the ``Ohai.config[:hints_path]`` setting in the ``client.rb`` file to customize this location.

   .. end_tag

   ``HINT_FILE`` is the name of the JSON file. ``HINT_NAME`` is the name of a hint in a JSON file. Use multiple ``--hint`` options to specify multiple hints.

``--host-name HOST_NAME``
   The host name for the Microsoft Azure environment.

``-I IMAGE``, ``--azure-source-image IMAGE``
   The name of the disk image to be used to create the virtual machine.

``--identity-file IDENTITY_FILE``
   The SSH identity file used for authentication. Key-based authentication is recommended.

``--identity-file_passphrase PASSWORD``
   The passphrase for the SSH key. Use only with ``--identity-file``.

``-j JSON_ATTRIBS``, ``--json-attributes JSON_ATTRIBS``
   A JSON string that is added to the first run of a chef-client.

``-m LOCATION``, ``--azure-service-location LOCATION``
   The geographic location for a virtual machine and its services. Required when not using ``--azure-affinity-group``.

``-N NAME``, ``--node-name NAME``
   The name of the node. Node names, when used with Microsoft Azure, must be 91 characters or shorter.

``--[no-]host-key-verify``
   Use ``--no-host-key-verify`` to disable host key verification. Default setting: ``--host-key-verify``.

``-o DISK_NAME``, ``--azure-os-disk-name DISK_NAME``
   The operating system type of the Microsoft Azure OS image: ``Linux`` or ``Windows``.

``-p FILE_NAME``, ``--azure-mgmt-cert FILE_NAME``
   The name of the file that contains the SSH public key that is used when authenticating to Microsoft Azure.

``-P PASSWORD``, ``--ssh-password PASSWORD``
   The SSH password. This can be used to pass the password directly on the command line. If this option is not specified (and a password is required) knife prompts for the password.

``--prerelease``
   Install pre-release gems.

``-r RUN_LIST``, ``--run-list RUN_LIST``
   A comma-separated list of roles and/or recipes to be applied.

``-R ROLE_NAME``, ``--role-name ROLE_NAME``
   The name of the virtual machine.

``--ssh-port PORT``
   The SSH port. Default value: ``22``.

``-t PORT_LIST``, ``--tcp-endpoints PORT_LIST``
   A comma-separated list of local and public TCP ports that are to be opened. For example: ``80:80,433:5000``.

``--template-file TEMPLATE``
   The path to a template file to be used during a bootstrap operation.

   Deprecated in Chef Client 12.0.

``--thumbprint THUMBPRINT``
   The thumbprint of the SSL certificate.

``-u PORT_LIST``, ``---udp-endpoints PORT_LIST``
   A comma-separated list of local and public UDP ports that are to be opened. For example: ``80:80,433:5000``.

``--verify-ssl-cert``
   The SSL certificate used to verify communication over HTTPS.

``--windows-auth-timeout MINUTES``
   The amount of time (in minutes) to wait for authentication to succeed. Default value: ``25``.

``-x USER_NAME``, ``--ssh-user USER_NAME``
   The SSH user name.

``-z SIZE``, ``--azure-vm-size SIZE``
   The size of the virtual machine: ``ExtraSmall``, ``Small``, ``Medium``, ``Large``, or ``ExtraLarge``. Default value: ``Small``.

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
**Provision an instance using new hosted service and storage accounts**

To provision a medium-sized CentOS machine configured as a web server in the ``West US`` data center, while reusing existing hosted service and storage accounts, enter something like:

.. code-block:: bash

   $ knife azure server create -r "role[webserver]" --service-location "West US"
     --hosted-service-name webservers --storage-account webservers-storage --ssh-user foo
     --ssh--password password --role-name web-apache-0001 --host-name web-apache
     --tcp-endpoints 80:80,8080:8080 --source-image name_of_source_image --role-size Medium

**Provision an instance using new hosted service and storage accounts**

To provision a medium-sized CentOS machine configured as a web server in the ``West US`` data center, while also creating new hosted service and storage accounts, enter something like:

.. code-block:: bash

   $ knife azure server create -r "role[webserver]" --service-location "West US" --ssh-user foo
     --ssh--password password --role-name web-apache-0001 --host-name web-apache
     --tcp-endpoints 80:80,8080:8080 --source-image name_of_source_image --role-size Medium

server delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``server delete`` argument to delete one or more instances that are running in the Microsoft Azure cloud. To find a specific cloud instance, use ``knife azure server list``. Use the ``--purge`` option to delete all associated node and client objects from the Chef server or use the ``knife node delete`` and ``knife client delete`` subcommands to delete specific node and client objects.

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following syntax:

.. code-block:: bash

   $ knife azure server delete [SERVER...] (options)

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following options:

``--azure-dns-name NAME``
   The name of the DNS server (also known as the Hosted Service Name).

``--azure-publish-settings-file FILE_NAME``
   The name of the Azure Publish Settings file, including the path. For example: ``"/path/to/your.publishsettings"``.

``--delete-azure-storage-account``
   Delete any corresponding storage account. When this option is ``true``, any storage account not used by any virtual machine is deleted.

``-H HOST_NAME``, ``--azure_host_name HOST_NAME``
   The host name for the Microsoft Azure environment.

``-N NODE_NAME``, ``--node-name NODE_NAME``
   The name of the node to be deleted, if different from the server name. This must be used with the ``-p`` (purge) option.

``-p FILE_NAME``, ``--azure-mgmt-cert FILE_NAME``
   The name of the file that contains the SSH public key that is used when authenticating to Microsoft Azure.

``-P``, ``--purge``
   Destroy all corresponding nodes and clients on the Chef server, in addition to the Microsoft Azure node itself. This action (by itself) assumes that the node and client have the same name as the server; if they do not have the same names, then the ``--node-name`` option must be used to specify the name of the node.

``--preserve-azure-dns-name``
   Preserve the DNS entries for the corresponding cloud services. If this option is ``false``, any service not used by any virtual machine is deleted.

``--preserve-azure-os-disk``
   Preserve the corresponding operating system disk.

``--preserve-azure-vhd``
   Preserve the underlying virtual hard disk (VHD).

``-S ID``, ``--azure-subscription-id ID``
   The subscription identifier for the Microsoft Azure portal.

``--verify-ssl-cert``
   The SSL certificate used to verify communication over HTTPS.

``--wait``
   Pause the console until the server has finished processing the request.

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
**Delete an instance**

To delete an instance named ``devops12``, enter:

.. code-block:: bash

   $ knife azure server delete devops12

server list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``server list`` argument to find instances that are associated with a Microsoft Azure account. The results may show instances that are not currently managed by the Chef server.

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following syntax:

.. code-block:: bash

   $ knife azure server list (options)

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following options:

``--azure-publish-settings-file FILE_NAME``
   The name of the Azure Publish Settings file, including the path. For example: ``"/path/to/your.publishsettings"``.

``-H HOST_NAME``, ``--azure_host_name HOST_NAME``
   The host name for the Microsoft Azure environment.

``-p FILE_NAME``, ``--azure-mgmt-cert FILE_NAME``
   The name of the file that contains the SSH public key that is used when authenticating to Microsoft Azure.

``-S ID``, ``--azure-subscription-id ID``
   The subscription identifier for the Microsoft Azure portal.

``--verify-ssl-cert``
   The SSL certificate used to verify communication over HTTPS.

server show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``server show`` argument to show the details for the named server (or servers).

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following syntax:

.. code-block:: bash

   $ knife azure server show SERVER [SERVER...] (options)

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following options:

``--azure-publish-settings-file FILE_NAME``
   The name of the Azure Publish Settings file, including the path. For example: ``"/path/to/your.publishsettings"``.

``-H HOST_NAME``, ``--azure_host_name HOST_NAME``
   The host name for the Microsoft Azure environment.

``-p FILE_NAME``, ``--azure-mgmt-cert FILE_NAME``
   The name of the file that contains the SSH public key that is used when authenticating to Microsoft Azure.

``-S ID``, ``--azure-subscription-id ID``
   The subscription identifier for the Microsoft Azure portal.

``--verify-ssl-cert``
   The SSL certificate used to verify communication over HTTPS.

vnet create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``vnet create`` argument to create a virtual network.

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following syntax:

.. code-block:: bash

   $ knife azure vnet create (options)

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following options:

``-a``, ``--azure-affinity-group GROUP``
   The affinity group to which the virtual machine belongs. Required when not using a service location.

``--azure-address-space CIDR``
   The address space of the virtual network. Use with classless inter-domain routing (CIDR) notation.

``--azure-publish-settings-file FILE_NAME``
   The name of the Azure Publish Settings file, including the path. For example: ``"/path/to/your.publishsettings"``.

``--azure-subnet-name CIDR``
   The subnet for the virtual machine. Use with classless inter-domain routing (CIDR) notation.

``-H HOST_NAME``, ``--azure_host_name HOST_NAME``
   The host name for the Microsoft Azure environment.

``-n``, ``--azure-network-name NETWORK_NAME``
   The network for the virtual machine.

``-p FILE_NAME``, ``--azure-mgmt-cert FILE_NAME``
   The name of the file that contains the SSH public key that is used when authenticating to Microsoft Azure.

``-S ID``, ``--azure-subscription-id ID``
   The subscription identifier for the Microsoft Azure portal.

``--verify-ssl-cert``
   The SSL certificate used to verify communication over HTTPS.

vnet list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``vnet list`` argument to get a list of virtual networks.

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following syntax:

.. code-block:: bash

   $ knife azure vnet list (options)

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This argument has the following options:

``--azure-publish-settings-file FILE_NAME``
   The name of the Azure Publish Settings file, including the path. For example: ``"/path/to/your.publishsettings"``.

``-H HOST_NAME``, ``--azure_host_name HOST_NAME``
   The host name for the Microsoft Azure environment.

``-p FILE_NAME``, ``--azure-mgmt-cert FILE_NAME``
   The name of the file that contains the SSH public key that is used when authenticating to Microsoft Azure.

``-S ID``, ``--azure-subscription-id ID``
   The subscription identifier for the Microsoft Azure portal.

``--verify-ssl-cert``
   The SSL certificate used to verify communication over HTTPS.

