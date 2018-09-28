=====================================================
Microsoft Azure Portal
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/azure_portal.rst>`__

.. tag cloud_azure_portal

Microsoft Azure is a cloud hosting platform from Microsoft that provides virtual machines and integrated services for you to use with your cloud and hybrid applications. Through the Azure Marketplace and the `Azure portal <https://portal.azure.com/>`_, virtual machines can be bootstrapped and ready to run Chef Automate, Chef Compliance and Chef client.

.. end_tag

Virtual Machines running Chef client
=====================================================

.. tag cloud_azure_portal_platforms

Through the Azure portal, you can provision a virtual machine with chef-client running as a background service. Once provisioned, these virtual machines are ready to be managed by a Chef server.

.. note:: Virtual machines running on Microsoft Azure can also be provisioned from the command-line using the ``knife azure`` plugin for knife. This approach is ideal for cases that require automation or for users who are more suited to command-line interfaces.

.. end_tag

.. tag cloud_azure_portal_settings_chef_client

Before virtual machines can be created using the Azure portal, some chef-client-specific settings will need to be identified so they can be provided to the Azure portal during the virtual machine creation workflow. These settings are available from the chef-client configuration settings:

* The ``chef_server_url`` and ``validation_client_name``. These are settings in the `client.rb file </config_rb_client.html>`__.

* The file for the `validator key </chef_private_keys.html>`__.

.. end_tag

.. tag cloud_azure_portal_virtual_machines

Once this information has been identified, launch the Azure portal, start the virtual machine creation workflow, and then bootstrap virtual machines with Chef using the following steps:

#. Sign in to the `Azure portal <https://portal.azure.com/>`_ and authenticate using your Microsoft Azure account credentials.

#. Choose **Virtual Machines** in the left pane of the portal.

#. Click the **Add** option at the top of the blade.

#. Select either **Windows Server** or **Ubuntu Server** in the **Recommended** category.

   .. note:: The Chef extension on the Azure portal may be used on the following platforms:

      * Windows Server 2008 R2 SP1, 2012, 2012 R2, 2016
      * Ubuntu 12.04 LTS, 14.04 LTS, 16.04 LTS, 16.10
      * CentOS 6.5+
      * RHEL 6+
      * Debian 7, 8

#. In the next blade, select the sku/version of the OS that you would like to use on your VM and click **Create**.

#. Fill in the virtual machine configuration information, such as machine name, credentials, VM size, and so on.

   .. note:: It's best to use a new computer name each time through this workflow. This will help to avoid conflicts with virtual machine names that may have been previously registered on the Chef server.

#. In Step 3 on the portal UI, open the **Extensions** blade and click ``Add extension``.

#. Depending on the OS you selected earlier, select either **Windows Chef Extension** or **Linux Chef Extension** and then **Create**.

#. Using the ``chef-repo/.chef/config.rb`` file you downloaded during your Chef server setup, enter values for the Chef server URL and the validation client name. You can also use this file to help you find the location of your validation key.

#. Browse on your local machine and find your validation key (``chef-repo/.chef/<orgname>-validator.pem``).

#. Upload it through the portal in the **Validation Key** field.

   .. note:: Because the ``.chef`` directory is considered a hidden directory, you may have to copy this file out to a non-hidden directory on disk before you can upload it through the open file dialog box.

#. For **Client Configuration File**, browse to the ``chef-repo/.chef/config.rb`` file and upload it through your web browser.

   .. note:: Same directory issue from previous step applies here as well. Also, the ``config.rb`` file must be correctly configured to communicate to the Chef server. Specifically, it must have valid values for the following two settings: ``chef_server_url`` and ``validation_client_name``.

#. Optional. `Use a run-list </run_lists.html>`__ to specify what should be run when the virtual machine is provisioned, such as using the run-list to provision a virtual machine with Internet Information Services (IIS). Use the ``iis`` cookbook and the default recipe to build a run-list. For example:

   .. code-block:: ruby

      iis

   or:

   .. code-block:: ruby

      iis::default

   or:

   .. code-block:: ruby

      recipe['iis']

   A run-list can also be built using a role. For example, if a role named ``backend_server`` is defined on the Chef server, the run-list would look like:

   .. code-block:: ruby

      role['backend_server']

   Even without a run-list, the virtual machine will periodically check with the Chef server to see if the configuration requirements change. This means that the run-list can be updated later, by editing the run-list to add the desired run-list items by using the Chef server web user interface or by using the knife command line tool.

   .. note:: A run-list may only refer to roles and/or recipes that have already been uploaded to the Chef server.

#. Click **OK** to complete the page. Click **OK** in the Extensions blade and the rest of the setup blades. Provisioning will begin and the portal will the blade for your new VM.

After the process is complete, the virtual machine will be registered with the Chef server and it will have been provisioned with the configuration (applications, services, etc.) from the specified run-list. The Chef server can now be used to perform all ongoing management of the virtual machine node.

.. end_tag

Azure Chef Extension
=====================================================
The Azure Chef Extension is an extension for Microsoft Azure to enable Chef on virtual machine instances. The extension makes available two Windows PowerShell cmdlets and two Microsoft Azure CLI commands.

Azure CLI
-----------------------------------------------------
If the Microsoft Azure `cross-platform command line tool (Xplat-CLI) <https://github.com/Azure/azure-xplat-cli>`__ is installed on the workstation, along with the Azure Chef Extension, the ``get-chef`` and ``set-chef`` extensions may be used to manage Chef running on virtual machines in Microsoft Azure.

get-chef
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``get-chef`` command to get the details for the Azure Chef Extension that is running on the named virtual machine.

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This command has the following syntax:

.. code-block:: bash

   $ azure vm extension get-chef VM_NAME

set-chef
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``set-chef`` command to enable Chef on any virtual machine running on Microsoft Azure.

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This command has the following syntax:

.. code-block:: bash

   $ azure vm extension set-chef VM_NAME (options)

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This command has the following options:

``-a``, ``--auto-update-client``
   Auto-update the chef-client. Set to ``true`` to auto update the version of the Azure Chef Extension when the virtual machine is restarted. For example, if this option is enabled, a virtual machine that has version ``1205.12.2.0`` will be updated automatically to ``1205.12.2.1`` when it is published. Default value: ``false``.

``-b``, ``--disable``
   Disable the Azure Chef Extension extension.

``-c PATH_TO_CONFIG``, ``--client-config PATH_TO_CONFIG``
   The path to the ``client.rb`` file.

``-C CLIENT_PEM``, ``--client-pem CLIENT_PEM``
   The location of the file that contains the client key. Default value: ``/etc/chef/client.pem``.

``-D``, ``--delete-chef-config``
   Disable the Azure Chef Extension extension.

``-j JSON``, ``--bootstrap-options JSON``
   A JSON string that is added to the first run of a chef-client. For example:

   .. code-block:: bash

      -j '{"chef_node_name":"test_node"}'

   Supported options: ``"chef_node_name"``, ``"chef_server_url"`` (required), ``"environment"``, ``"secret"``, and ``"validation_client_name"`` (required).

``-O VALIDATOR_PEM``, ``--validation-pem VALIDATOR_PEM``
   The location of the file that contains the key used when a chef-client is registered with a Chef server. A validation key is signed using the ``validation_client_name`` for authentication. Default value: ``/etc/chef/validation.pem``.

``-R RUN_LIST``, ``--run-list RUN_LIST``
   A comma-separated list of roles and/or recipes to be applied.

``-u``, ``--uninstall``
   Uninstall the Azure Chef Extension.

``-V NUMBER``, ``--version NUMBER``
   Specify the version number for the Azure Chef Extension extension. Default is to use the latest extension's version number.

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The following examples show how to use this knife subcommand:

**Create a virtual machine**

.. code-block:: bash

   $ azure vm create your-vm-name MSFT__Windows-Server-2008-R2-SP1.11-29-2011 yourusername yourpassword --location "West US" -r

**Set the Chef extension without a run-list**

.. code-block:: bash

   $ azure vm extension set-chef your-vm-name --validation-pem ~/chef-repo/.chef/testorg-validator.pem --client-config ~/chef-repo/.chef/client.rb --version "1201.12"

**Set the Chef extension with a run-list**

.. code-block:: bash

   $ azure vm extension set-chef your-vm-name --validation-pem ~/chef-repo/.chef/testorg-validator.pem --client-config ~/chef-repo/.chef/client.rb --version "1201.12" -R 'recipe[your_cookbook_name::your_recipe_name]'


Azure Resource Manager (ARM) Templates
-----------------------------------------------------
If you are using Azure Resource Manager templates to create your infrastructure you can use the Chef extension to have Azure handle the bootstrapping/configuration of your node to your Chef Server.

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The extension has the following options that can be provided in the `settings` hash.

``runlist``
   A comma-separated list of roles and/or recipes to be applied.

``client_rb``
   A JSON escaped string containing the content of your ``client.rb`` file.

``validation_key_format``
   Tells the extension whether the supplied validation key is ``plaintext`` or ``base64encoded``.

   .. note:: If using the Chef extension in an ARM template, it is recommended that you base64 encode your validation key and set this option to ``base64encoded``

``bootstrap_version``
   The version of chef-client that will be installed on the system. **linux only**

   .. note:: Due to constraints in Azure, the ``bootstrap_version`` option is only available on the ``LinuxChefClient`` extension.

``bootstrap_options``
   A hash of the following options: ``chef_node_name``, ``chef_server_url``, ``environment``, ``secret``, and ``validation_client_name``.

   .. note:: Options that are supplied in the bootstrap items will take precedence over any conflicts found in the ``client.rb`` file.

``chef_node_name``
   Determines which configuration should be applied and sets the ``client_name``, which is the name used when authenticating to a Chef server. The default value is the FQDN of the chef-client, as detected by Ohai. In general, Chef recommends that you leave this setting blank and let Ohai assign the FQDN of the node as the ``node_name`` during each chef-client run.

``chef_server_url``
   The URL for the Chef server.

``environment``
   The environment this machine will be placed in on your Chef server.

``secret``
   The encryption key that is used for values contained within a data bag item.

``validation_client_name``
   The name of the chef-validator key that is used by the chef-client to access the Chef server during the initial chef-client run.

``node_ssl_verify_mode``
   Set the verify mode for HTTPS requests.

``node_verify_api_cert``
   Verify the SSL certificate on the Chef server. When ``true``, the chef-client always verifies the SSL certificate. When ``false``, the chef-client uses the value of ``ssl_verify_mode`` to determine if the SSL certificate requires verification.

**Protected Settings**

The following options can be provided to the extension through the ``protectedSettings`` hash:

``validation_key``
   The contents of your organization validator key, the format is dependent on ``validation_key_format``.

``chef_server_crt``
   The SSL certificate of your Chef server that will be added to the trusted certificates.

``client_pem``
   A client key that will be used to communication with the Chef server.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how the chef-client can be installed and configured from an ARM template.

**Installing the Azure Chef extension on a Linux system**

.. code-block:: javascript

   {
      "type": "Microsoft.Compute/virtualMachines/extensions",
      "name": "myVirtualMachine/LinuxChefClient",
      "apiVersion": "2015-05-01-preview",
      "location": "westus",
      "properties": {
        "publisher": "Chef.Bootstrap.WindowsAzure",
        "type": "LinuxChefClient",
        "typeHandlerVersion": "1210.12",
        "settings": {
          "bootstrap_options": {
            "chef_node_name": "node1",
            "chef_server_url": "https://api.chef.io/organizations/my-chef-organization",
            "validation_client_name": "my-chef-organization-validator"
          },
          "runlist": "recipe[awesome_customers_rhel],recipe[yum],role[base]",
          "validation_key_format": "plaintext"
        },
        "protectedSettings": {
          "validation_key": "-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIB..\n67VT3Dg=\n-----END RSA PRIVATE KEY-----"
        }
      }
    }

**Installing the Azure Chef extension on a Windows system**

.. code-block:: javascript

   {
     "type": "Microsoft.Compute/virtualMachines/extensions",
     "name": "myVirtualMachine/ChefClient",
     "apiVersion": "2015-05-01-preview",
     "location": "westus",
     "properties": {
       "publisher": "Chef.Bootstrap.WindowsAzure",
       "type": "ChefClient",
       "typeHandlerVersion": "1210.12",
       "settings": {
         "bootstrap_options": {
           "chef_node_name": "node12",
           "chef_server_url": "https://api.chef.io/organizations/my-chef-organization",
           "validation_client_name": "my-chef-organization-validator"
         },
         "runlist": "recipe[awesome_customers_windows],recipe[iis],role[windows_base]",
         "validation_key_format": "plaintext"
       },
       "protectedSettings": {
         "validation_key": "-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIB..\n67VT3Dg=\n-----END RSA PRIVATE KEY-----"
       }
     }
   }

**Installing the Azure Chef extension on a Linux system with SSL peer verification turned off and given a data bag secret**

.. code-block:: javascript

   {
      "type": "Microsoft.Compute/virtualMachines/extensions",
      "name": "myVirtualMachine/LinuxChefClient",
      "apiVersion": "2015-05-01-preview",
      "location": "westus",
      "properties": {
        "publisher": "Chef.Bootstrap.WindowsAzure",
        "type": "LinuxChefClient",
        "typeHandlerVersion": "1210.12",
        "settings": {
          "bootstrap_options": {
            "chef_node_name": "node1",
            "chef_server_url": "https://api.chef.io/organizations/my-chef-organization",
            "validation_client_name": "my-chef-organization-validator",
            "node_ssl_verify_mode": "none",
            "secret": "KCYWGXxSrkgR..."
          },
          "runlist": "recipe[awesome_customers_rhel],recipe[yum],role[base]",
          "validation_key_format": "base64encoded"
        },
        "protectedSettings": {
          "validation_key": "LS0tLS1CRUdJTiBSU0EgUFJ...FIEtFWS0tLS0t"
        }
      }
    }

.. note:: Here we're also base64 encoding our validator key which is a recommended approach when using the Azure Chef extension in an ARM template

Log Files
=====================================================
.. tag cloud_azure_portal_log_files

If the Azure portal displays an error in dashboard, check the log files. The log files are created by the chef-client. The log files can be accessed from within the Azure portal or by running the chef-client on the node itself and then reproducing the issue interactively.

.. end_tag

From the Azure portal
-----------------------------------------------------
.. tag cloud_azure_portal_log_files_azure_portal

Log files are available from within the Azure portal:

#. Select **Virtual Machines** in the left pane of the Azure portal.

#. Select the virtual machine that has the error status.

#. Click the **Connect** button at the bottom of the portal to launch a Windows Remote Desktop session, and then log in to the virtual machine.

#. Start up a Windows PowerShell command shell.

   .. code-block:: bash

      $ cd c:\windowsazure\logs
        ls –r chef*.log

#. This should display the log files, including the chef-client log file.

.. end_tag

From the chef-client
-----------------------------------------------------
.. tag cloud_azure_portal_log_files_chef_client

The chef-client can be run interactively by using Windows Remote Desktop to connect to the virtual machine, and then running the chef-client:

#. Log into the virtual machine.

#. Start up a Windows PowerShell command shell.

#. Run the following command:

   .. code-block:: bash

      $ chef-client -l debug

#. View the logs. On a linux system, the Chef client logs are saved to ``/var/log/azure/Chef.Bootstrap.WindowsAzure.LinuxChefClient/<extension-version-number>/chef-client.log`` and can be viewed using the following command:

   .. code-block:: bash

      $ tail -f /var/log/azure/Chef.Bootstrap.WindowsAzure.LinuxChefClient/1210.12.102.1000/chef-client.log

.. end_tag

Troubleshoot Log Files
-----------------------------------------------------
.. tag cloud_azure_portal_log_files_troubleshoot

After the log files have been located, open them using a text editor to view the log file. The most common problem are below:

* Connectivity errors with the Chef server caused by incorrect settings in the client.rb file. Ensure that the ``chef_server_url`` value in the client.rb file is the correct value and that it can be resolved.
* An invalid validator key has been specified. This will prevent the chef-client from authenticating to the Chef server. Ensure that the ``validation_client_name`` value in the client.rb file is the correct value
* The name of the node is the same as an existing node. Node names must be unique. Ensure that the name of the virtual machine in Microsoft Azure has a unique name.
* An error in one the run-list. The log file will specify the details about errors related to the run-list.

.. end_tag

For more information ...
=====================================================
For more information about Microsoft Azure and how to use it with Chef:

* `Microsoft Azure Documentation <https://azure.microsoft.com/en-us/documentation/services/virtual-machines/>`_
* `knife azure Plugin <https://github.com/chef/knife-azure>`_
* `azure-cookbook <https://github.com/chef-partners/azure-cookbook>`_
