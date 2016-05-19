=====================================================
|microsoft| Azure Portal
=====================================================

.. include:: ../../includes_cloud/includes_cloud_azure_portal.rst

.. include:: ../../includes_cloud/includes_cloud_azure_portal_platforms.rst

|azure marketplace|
=====================================================

|chef server_title|
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_azure_portal_server_marketplace.rst

|chef compliance|
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_azure_portal_compliance_marketplace.rst

|chef client_title| Settings
=====================================================
.. include:: ../../includes_cloud/includes_cloud_azure_portal_settings_chef_client.rst

Set up Virtual Machines
=====================================================
.. include:: ../../includes_cloud/includes_cloud_azure_portal_virtual_machines.rst


|azure extension chef|
=====================================================
The |azure extension chef| is an extension for |azure| to enable |chef| on virtual machine instances. The extension makes available two |windows powershell| cmdlets and two |azure| CLI commands.

Azure CLI
-----------------------------------------------------
If the |azure| `cross-platform command line tool (Xplat-CLI) <https://github.com/Azure/azure-xplat-cli>`__ is installed on the workstation, along with the |azure extension chef|, the ``get-chef`` and ``set-chef`` extensions may be used to manage |chef| running on virtual machines in |azure|.

get-chef
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``get-chef`` command to get the details for the |azure extension chef| that is running on the named virtual machine.

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This command has the following syntax:

.. code-block:: bash

   $ azure vm extension get-chef VM_NAME


set-chef
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``set-chef`` command to enable |chef| on any virtual machine running on |azure|.

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This command has the following syntax:

.. code-block:: bash

   $ azure vm extension set-chef VM_NAME (options)

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This command has the following options:

``-a``, ``--auto-update-client``
   |azure autoupdate_client| Default value: ``false``.

``-b``, ``--disable``
   |azure disable_extension|

``-c PATH_TO_CONFIG``, ``--client-config PATH_TO_CONFIG``
   |azure client_rb_path|

``-C CLIENT_PEM``, ``--client-pem CLIENT_PEM``
   |client_key| Default value: ``/etc/chef/client.pem``.

``-D``, ``--delete-chef-config``
   |azure disable_extension|

``-j JSON``, ``--bootstrap-options JSON``
   |json first_run_string| For example:

   .. code-block:: bash

      -j '{"chef_node_name":"test_node"}'

   |azure bootstrap_json|

``-O VALIDATOR_PEM``, ``--validation-pem VALIDATOR_PEM``
   |validation_key| Default value: ``/etc/chef/validation.pem``.

``-R RUN_LIST``, ``--run-list RUN_LIST``
   |run_list|

``-u``, ``--uninstall``
   |azure uninstall|

``-V NUMBER``, ``--version NUMBER``
   |azure version number|


Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The following examples show how to use this |knife| subcommand:

**Create a virtual machine**

.. code-block:: bash

   $ azure vm create your-vm-name MSFT__Windows-Server-2008-R2-SP1.11-29-2011 yourusername yourpassword --location "West US" -r

**Set the Chef extension without a run-list**

.. code-block:: bash

   $ azure vm extension set-chef your-vm-name --validation-pem ~/chef-repo/.chef/testorg-validator.pem --client-config ~/chef-repo/.chef/client.rb --version "1201.12"

**Set the Chef extension with a run-list**

.. code-block:: bash

   $ azure vm extension set-chef your-vm-name --validation-pem ~/chef-repo/.chef/testorg-validator.pem --client-config ~/chef-repo/.chef/client.rb --version "1201.12" -R 'recipe[your_cookbook_name::your_recipe_name]'



PowerShell Cmdlets
-----------------------------------------------------
If |windows powershell| is installed on the workstation, along with the |azure extension chef|, the ``Get-AzureVMChefExtension`` and ``Set-AzureVMChefExtension`` extensions may be used to manage |chef| running on virtual machines in |azure|.

Get-AzureVMChefExtension
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``Get-AzureVMChefExtension`` cmdlet to get the details for the |azure extension chef| that is running on the named virtual machine.

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This cmdlet has the following syntax:

.. code-block:: bash

   Get-AzureVMChefExtension -VM <string>

Example
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The following examples show how to use the ``Get-AzureVMChefExtension`` cmdlet:

**Get details for a virtual machine**

.. code-block:: bash

   $ Get-AzureVM -ServiceName cloudservice1 -Name azurevm1 | Get-AzureVMExtension


Set-AzureVMChefExtension
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``Set-AzureVMChefExtension`` cmdlet to enable |chef| on any virtual machine running on |azure|.

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This cmdlet has the following syntax.

For |windows|:

.. code-block:: bash

   Set-AzureVMChefExtension -ValidationPem <String> -VM <IPersistentVM> -Windows [-ChefServerUrl <String> ] [-ClientRb <String> ] [-OrganizationName <String> ] [-RunList <String> ] [-ValidationClientName <String> ] [-Version <String> ] [ <CommonParameters>]

For |linux|:

.. code-block:: bash

   Set-AzureVMChefExtension -Linux -ValidationPem <String> -VM <IPersistentVM> [-ChefServerUrl <String> ] [-ClientRb <String> ] [-OrganizationName <String> ] [-RunList <String> ] [-ValidationClientName <String> ] [-Version <String> ] [ <CommonParameters>]


Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This cmdlet has the following options:

``-AutoUpdateChefClient``
   |azure autoupdate_client|

``-BootstrapOptions <string>``
   |json first_run_string| For example:

   .. code-block:: bash

      -BootstrapOptions '{"chef_node_name":"test_node"}'

   |azure bootstrap_json|

``-ChefServerUrl <string>``
   |url chef_server|

``-ClientRb <string>``
   |azure client_rb_path|

``-DeleteChefConfig``
   |azure disable_extension|

``-Linux``
   |azure set_linux|

``-OrganizationName <string>``
   |name chef_organization|

``-RunList <string>``
   |run_list|

``-ValidationClientName <string>``
   |validation_client_name|

``-ValidationPem  <string>``
   |validation_key| Default value: ``/etc/chef/validation.pem``.

``-Version <string>``
   |azure version number|

``-Windows``
   |azure set_windows|


Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The following examples show how to use the ``Set-AzureVMChefExtension`` cmdlet:

**Create Windows virtual machine**

.. code-block:: bash

   $vm1 = "azurechefwin"
   $svc = "azurechefwin"
   $username = 'azure'
   $password = 'azure@123'

   $img = "a699494373c04fc0bc8f2bb1389d6106__Windows-Server-2012-R2-201406.01-en.us-127GB.vhd"

   $vmObj1 = New-AzureVMConfig -Name $vm1 -InstanceSize Small -ImageName $img

   $vmObj1 = Add-AzureProvisioningConfig -VM $vmObj1 -Password $password -AdminUsername $username –Windows

   # set azure chef extension
   $vmObj1 = Set-AzureVMChefExtension -VM $vmObj1 -ValidationPem "C:\\users\\azure\\msazurechef-validator.pem" -ClientRb 
   "C:\\users\\azure\\client.rb" -RunList "getting-started" -Windows

   New-AzureVM -Location 'West US' -ServiceName $svc -VM $vmObj1


**Create CentOS virtual machine**

.. code-block:: bash

   $vm1 = "azurecheflnx"
   $svc = "azurecheflnx"
   $username = 'azure'
   $password = 'azure@123'

   # CentOS image id
   $img = "5112500ae3b842c8b9c604889f8753c3__OpenLogic-CentOS-71-20150605"

   $vmObj1 = New-AzureVMConfig -Name $vm1 -InstanceSize Small -ImageName $img

   $vmObj1 = Add-AzureProvisioningConfig -VM $vmObj1 -Password $password -Linux -LinuxUser $username

   # set azure chef extension
   $vmObj1 = Set-AzureVMChefExtension -VM $vmObj1 -ValidationPem "C:\\users\\azure\\msazurechef-validator.pem" -ClientRb 
   "C:\\users\\azure\\client.rb" -RunList "getting-started" -Linux

   New-AzureVM -Location 'West US' -ServiceName $svc -VM $vmObj1


**Create Ubuntu virtual machine**

.. code-block:: bash

   $vm1 = "azurecheflnx"
   $svc = "azurecheflnx"
   $username = 'azure'
   $password = 'azure@123'

   $img = "b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-12_04_5-LTS-amd64-server-20150127-en-us-30GB"

   $vmObj1 = New-AzureVMConfig -Name $vm1 -InstanceSize Small -ImageName $img

   $vmObj1 = Add-AzureProvisioningConfig -VM $vmObj1 -Password $password -Linux -LinuxUser $username

   # set azure chef extension
   $vmObj1 = Set-AzureVMChefExtension -VM $vmObj1 -ValidationPem "C:\\users\\azure\\msazurechef-validator.pem" -ClientRb 
   "C:\\users\\azure\\client.rb" -RunList "getting-started" -Linux

   New-AzureVM -Location 'West US' -ServiceName $svc -VM $vmObj1


knife azure server create
-----------------------------------------------------
If ``knife azure`` plugin is installed on the workstation, along with the |azure extension chef|, the ``server create`` |knife| plugin may be used to manage |chef| running on virtual machines in |azure|.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command has the following syntax:

.. code-block:: bash

   $ knife azure server create (options)

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command has the following options:

``--auto-update-client``
   |azure autoupdate_client|

``--azure-extension-client-config``
   |azure client_rb_path|

``--bootstrap-version``
   |ubuntu| and |centos| only.    |bootstrap version|

``--delete-chef-extension-config``
   |azure disable_extension|

``-j``,  ``--json-attributes``
   |json first_run_string| For example:

   .. code-block:: bash

      -j '{"chef_node_name":"test_node"}'

   Supported options: ``--bootstrap-version``, ``--environment``, ``--[no-]node-verify-api-cert``, ``--node-name``, ``--node-ssl-verify-mode``, ``--secret-file``, and ``--server-url`` (required).

``-r``, ``--run-list``
   |run_list|

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how to use the ``knife azure server create`` command:

**Create Windows virtual machine**

.. code-block:: bash

   $ knife azure server create -I "123abc__Windows-Server-2012-Datacenter-201411.01-en.us-127GB.vhd"\n
                             --azure-vm-size Medium -x 'azureuser' -P 'azure@123' --bootstrap-protocol\n
                             'cloud-api' -c '~/chef-repo/.chef/knife.rb' -r 'recipe[getting-started]'\n
                             --azure-service-location "West US" -VV


**Create Linux virtual machine**

.. code-block:: bash

   $ knife azure server create -I "123abc__Ubuntu_DAILY_BUILD-trusty-14_04_1-LTS-amd64-server-etc"\n
                               --azure-vm-size Medium -x 'azureuser' -P 'azure@123' --bootstrap-protocol 'cloud-api'\n
                               -c '~/chef-repo/.chef/knife.rb' -r 'recipe[getting-started]'\n
                               --azure-service-location "West US" -VV

Azure Resource Manager (ARM) Templates
-----------------------------------------------------
If you are using Azure Resource Manager templates to create your infrastructure you can use the Chef extension to have Azure handle the bootstraping/configuration of your node to your Chef Server.

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The extension has the following options that can be provided in the `settings` hash.

``runlist``
   |run_list|

``client_rb``
   |azure client_rb_content|

``validation_key_format``
   |azure validation_key_format|

..note:: If using the Chef extension in an ARM template, it is recommended that you base64 encode your validation key and set this option to ``base64encoded``

``bootstrap_version``
   |azure bootstrap_version|

..note:: Due to constraints in Azure, the ``bootstrap_version`` option is only available on the ``LinuxChefClient`` extension.

``bootstrap_options``
   |azure bootstrap_options|

..note:: Options that are supplied in the bootstrap items will take presidence over any conflicts found in the client.rb

``chef_node_name``
   |name node_client_rb|

``chef_server_url``
   |chef_server_url|

``environment``
   |azure chef_environment|

``secret``
   |secret|

``validation_client_name``
   |validation_client_name|

``node_ssl_verify_mode``
   |ssl_verify_mode|

``node_verify_api_cert``
   |ssl_verify_mode_verify_api_cert|


Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how the Chef client can be installed and configured from an ARM template.

**Installing the Azure Chef extension on a linux system**

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

**Installing the Azure Chef extension on a linux system with ssl peer verification turned off and given a databag secret**

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
.. include:: ../../includes_cloud/includes_cloud_azure_portal_log_files.rst

From the |azure portal|
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_azure_portal_log_files_azure_portal.rst

From the |chef client_title|
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_azure_portal_log_files_chef_client.rst

Troubleshoot Log Files
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_azure_portal_log_files_troubleshoot.rst

For more information ...
=====================================================
For more information about |azure| and how to use it with |chef|:

* `Microsoft Azure Documentation <http://www.windowsazure.com/en-us/documentation/services/virtual-machines/>`_
* `Chef Documentation <https://docs.chef.io>`_
* `knife azure Plugin <https://docs.chef.io/plugin_knife_azure.html>`_
* `azure-cookbook <https://github.com/chef-partners/azure-cookbook>`_
