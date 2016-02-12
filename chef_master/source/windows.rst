=====================================================
|windows chef|
=====================================================

.. note:: This page collects information about |chef| that is specific to using |chef| with |windows|.

The |chef client| has specific components that are designed to support unique aspects of the |windows| platform, including |windows powershell|, |microsoft iis|, and |microsoft sqlserver|.

* The |chef client| is `installed on a machine <https://downloads.chef.io/chef-client/windows/#/>`_ running |windows| by using a |microsoft installer package|
* Six resources dedicated to the |windows| platform are built into the |chef client|: |resource batch|, |resource dsc_script|, |resource env|, |resource powershell_script|, |resource registry_key|, and |resource package_windows|
* Use the |resource dsc_resource| to use Powershell DSC resources in |chef|!
* Two |knife| plugins dedicated to the |windows| platform are available: |subcommand knife azure| is used to manage virtual instances in |azure|; |subcommand knife windows| is used to interact with and manage physical nodes that are running |windows|, such as desktops and servers
* Four cookbooks provide application-specific support. For `PowerShell 4.0 <https://github.com/chef-cookbooks/powershell>`_. For `IIS 7.0/7.5/8.0 <https://github.com/chef-cookbooks/iis>`_. For `SQL Server <https://github.com/chef-cookbooks/database>`_. And for configuring various settings and behaviors on a machine that is running `Windows <https://github.com/chef-cookbooks/windows>`_ 
* Support for both :i386 and :x86_64 architectures
* .. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_windows_helpers.rst
* Two community provisioners for |kitchen|: `kitchen-dsc <https://github.com/smurawski/kitchen-dsc>`_ and `kitchen-pester <https://github.com/smurawski/kitchen-pester>`_

The most popular core resources in the |chef client|---:doc:`cookbook_file </resource_cookbook_file>`, :doc:`directory </resource_directory>`, :doc:`env </resource_env>`, :doc:`execute </resource_execute>`, :doc:`file </resource_file>`, :doc:`group </resource_group>`, :doc:`http_request </resource_http_request>`, :doc:`link </resource_link>`, :doc:`mount </resource_mount>`, :doc:`package </resource_package>`, :doc:`remote_directory </resource_remote_directory>`, :doc:`remote_file </resource_remote_file>`, :doc:`ruby_block </resource_ruby_block>`, :doc:`service </resource_service>`, :doc:`template </resource_template>`, and :doc:`user </resource_user>`---work the same way in |windows| as they do on any |unix|- or |linux|-based platform.

The file-based resources---|resource cookbook_file|, |resource file|, |resource remote_file|, and |resource template|---have attributes that support unique requirements within the |windows| platform, including ``inherits`` (for file inheritence), ``mode`` (for octal modes), and ``rights`` (for access control lists, or ACLs).

.. note:: The |windows| platform does not support running as an alternate user unless full credentials (a username and password or equivalent) are specified.

The following sections are pulled in from the larger |url docs| site and represents the documentation that is specific to the |windows| platform, compiled here into a single-page reference.

Install the |chef client_title| on Windows
=====================================================
.. include:: ../../includes_windows/includes_windows_install_overview.rst

The |chef client| can be used to manage machines that run on the following versions of |windows|:

.. list-table::
   :widths: 200 200 200
   :header-rows: 1

   * - Operating System
     - Version
     - Architecture
   * - Windows
     - 2003 R2, 2008
     - i686, x86_64
   * - 
     - 2008 R2, 2012
     - x86_64

(The recommended amount of RAM available to the |chef client| during a |chef client| run is 512MB. Each node and workstation must have access to the |chef server| via HTTPS. |ruby| version 1.9.1 or |ruby| version 1.9.2 with |ssl| bindings is required.)

The |microsoft installer package| for |windows| is available at http://www.chef.io/chef/install/. From the drop-downs, select the operating system (``Windows``), then the version, and then the architecture.

After the |chef client| is installed, it is located at ``C:\chef``. The main configuration file for the |chef client| is located at ``C:\chef\client.rb``.

Set the System |ruby|
-----------------------------------------------------
.. include:: ../../includes_windows/includes_windows_set_system_ruby.rst

Spaces and Directories
-----------------------------------------------------
.. include:: ../../includes_windows/includes_windows_spaces_and_directories.rst

Top-level Directory Names
-----------------------------------------------------
.. include:: ../../includes_windows/includes_windows_top_level_directory_names.rst

Use knife-windows
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows.rst

For more information about the |subcommand knife windows| plugin, see :doc:`windows </plugin_knife_windows>`.

Ports
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_winrm_ports.rst

|microsoft msiexec|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_windows/includes_windows_msiexec.rst

ADDLOCAL Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_windows/includes_windows_msiexec_addlocal.rst

Use MSI Installer
-----------------------------------------------------
A |microsoft installer package| is available for installing the |chef client| on a |windows| machine.

.. include:: ../../includes_install/includes_install_chef_client_windows.rst

Enable as a Service
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_install/includes_install_chef_client_windows_as_service.rst

Use an Existing Process
-----------------------------------------------------
.. include:: ../../includes_windows/includes_windows_install_system_center.rst

PATH System Variable
-----------------------------------------------------
.. include:: ../../includes_windows/includes_windows_environment_variable_path.rst

Proxy Settings
=====================================================
.. include:: ../../includes_proxy/includes_proxy_windows.rst

|microsoft| |azure portal|
=====================================================

.. include:: ../../includes_cloud/includes_cloud_azure_portal.rst

.. include:: ../../includes_cloud/includes_cloud_azure_portal_platforms.rst

|azure marketplace|
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_azure_portal_server_marketplace.rst

|chef client_title| Settings
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_azure_portal_settings_chef_client.rst

Set up Virtual Machines
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_azure_portal_virtual_machines.rst

Log Files
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_azure_portal_log_files.rst

From the |azure portal|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cloud/includes_cloud_azure_portal_log_files_azure_portal.rst

From the |chef client_title|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cloud/includes_cloud_azure_portal_log_files_chef_client.rst

Troubleshoot Log Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cloud/includes_cloud_azure_portal_log_files_troubleshoot.rst

For more information ...
-----------------------------------------------------
For more information about |azure| and how to use it with |chef|:

* `Microsoft Azure Documentation <http://www.windowsazure.com/en-us/documentation/services/virtual-machines/>`_
* `azure-cookbook <https://github.com/chef-partners/azure-cookbook>`_


|knife_title|
=====================================================
.. include:: ../../includes_knife/includes_knife.rst

Set the Text Editor
-----------------------------------------------------
.. include:: ../../step_knife/step_knife_common_set_editor.rst

Quotes, Windows
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_common_windows_quotes.rst

``Import-Module chef``
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_common_windows_quotes_module.rst

Ampersands, Windows
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_common_windows_ampersand.rst

knife bootstrap
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_bootstrap_node.rst

.. include:: ../../includes_knife/includes_knife_bootstrap.rst

.. note:: To bootstrap the |chef client| on |windows| machines, the `knife-windows <https://docs.chef.io/plugin_knife_windows.html>`_ plugins is required, which includes the necessary bootstrap scripts that are used to do the actual installation.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_bootstrap_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. note:: Review the list of `common options <https://docs.chef.io/knife_common_options.html>`__ available to this (and all) |knife| subcommands and plugins.

.. include:: ../../includes_knife/includes_knife_bootstrap_options.rst

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Custom Templates
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_bootstrap_template.rst

Microsoft Windows
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_bootstrap_example_windows.rst


knife azure
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure.rst

.. note:: Review the list of `common options <https://docs.chef.io/knife_common_options.html>`__ available to this (and all) |knife| subcommands and plugins.

Install this plugin
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../step_plugin_knife/step_plugin_knife_azure_install_rubygem.rst

Generate Certificates
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_certificate.rst


ag create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_ag_create.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_ag_create_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_ag_create_options.rst

ag list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_ag_list.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_ag_list_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_ag_list_options.rst

image list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_image_list.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_image_list_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_image_list_options.rst

server create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_server_create.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_server_create_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_server_create_options.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
**Provision an instance using new hosted service and storage accounts**

.. include:: ../../step_plugin_knife/step_plugin_knife_azure_server_create_use_existing_hosted_service.rst

**Provision an instance using new hosted service and storage accounts**

.. include:: ../../step_plugin_knife/step_plugin_knife_azure_server_create_use_new_hosted_service.rst

server delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_server_delete.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_server_delete_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_server_delete_options.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
**Delete an instance**

.. include:: ../../step_plugin_knife/step_plugin_knife_azure_server_delete.rst

server describe
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_server_describe.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_server_describe_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_server_describe_options.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
**View role details**

.. include:: ../../step_plugin_knife/step_plugin_knife_azure_server_describe.rst

server list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_server_list.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_server_list_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_server_list_options.rst

server show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_server_show.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_server_show_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_server_show_options.rst


vnet create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_vnet_create.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_vnet_create_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_vnet_create_options.rst

vnet list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_vnet_list.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_vnet_list_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_vnet_list_options.rst




knife windows
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows.rst

.. note:: Review the list of `common options <https://docs.chef.io/knife_common_options.html>`__ available to this (and all) |knife| subcommands and plugins.

Install this plugin
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../step_plugin_knife/step_plugin_knife_windows_install_rubygem.rst

Requirements
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_winrm_requirements.rst

|microsoft negotiate|, |ntlm|
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_winrm_requirements_nltm.rst

Domain Authentication
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_winrm_domain_authentication.rst

bootstrap windows ssh
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_bootstrap_windows_ssh.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_bootstrap_windows_ssh_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_bootstrap_windows_ssh_options.rst

winrm
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_winrm.rst

.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_winrm_ports.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_winrm_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_winrm_options.rst


Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Find Uptime for Web Servers**

.. include:: ../../step_plugin_knife/step_plugin_knife_windows_winrm_find_uptime.rst

**Force a chef-client run**

.. include:: ../../step_plugin_knife/step_plugin_knife_windows_winrm_force_chef_run.rst

**Bootstrap a Windows machine using SSH**

.. include:: ../../step_plugin_knife/step_plugin_knife_windows_bootstrap_ssh.rst

**Bootstrap a Windows machine using Windows Remote Management**

.. include:: ../../step_plugin_knife/step_plugin_knife_windows_bootstrap_winrm.rst



Resources
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common.rst

Common Functionality 
-----------------------------------------------------
The following sections describe |windows|-specific functionality that applies generally to all resources:

Relative Paths
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_relative_paths.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../step_resource/step_resource_template_use_relative_paths.rst

Windows File Security
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_windows_security.rst

.. note:: Windows File Security applies to the |resource cookbook_file|, |resource directory|, |resource file|, |resource remote_directory|, |resource remote_file|, and |resource template| resources.

ACLs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources_common/includes_resources_common_windows_security_acl.rst

Inheritance
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources_common/includes_resources_common_windows_security_inherits.rst

Attributes for File-based Resources
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following attributes:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``group``
     - |windows group_identifier|
   * - ``inherits``
     - |windows| only. |inherits windows security| Default value: ``true``.
   * - ``mode``
     - |mode resource_file|
       
       |windows|: |mode windows security|
   * - ``owner``
     - |owner windows security|	
   * - ``path``
     - |path full_path_to_file|

       |windows|: A path that begins with a forward slash (``/``) will point to the root of the current working directory of the |chef client| process. This path can vary from system to system. Therefore, using a path that begins with a forward slash (``/``) is not recommended.
   * - ``rights``
     - |windows| only. |rights windows security|

.. note:: Use the ``owner`` and ``right`` attributes and avoid the ``group`` and ``mode`` attributes whenever possible. The ``group`` and ``mode`` attributes are not true |windows| concepts and are provided more for backward compatibility than for best practice.

Atomic File Updates
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_atomic_update.rst

.. note:: Atomic File Updates applies to the |resource template| resource.


batch
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_batch.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_batch_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_batch_actions.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_batch_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Unzip a file, and then move it**

.. include:: ../../step_resource/step_resource_batch_unzip_file_and_move.rst






dsc_resource
-----------------------------------------------------

.. include:: ../../includes_resources_common/includes_resources_common_generic.rst

.. include:: ../../includes_resources_common/includes_resources_common_powershell.rst

.. include:: ../../includes_resources_common/includes_resources_common_powershell_dsc.rst

.. include:: ../../includes_resources/includes_resource_dsc_resource.rst

.. warning:: .. include:: ../../includes_resources/includes_resource_dsc_resource_requirements.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_resource_syntax.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_resource_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Open a Zip file**

.. include:: ../../step_resource/step_resource_dsc_resource_zip_file.rst

**Manage users and groups**

.. include:: ../../step_resource/step_resource_dsc_resource_manage_users.rst

**Create a test message queue**

.. include:: ../../step_resource/step_resource_dsc_resource_manage_msmq.rst





dsc_script
-----------------------------------------------------

.. include:: ../../includes_resources_common/includes_resources_common_generic.rst

.. include:: ../../includes_resources_common/includes_resources_common_powershell.rst

.. include:: ../../includes_resources_common/includes_resources_common_powershell_dsc.rst

.. include:: ../../includes_resources/includes_resource_dsc_script.rst

.. note:: |windows powershell| 4.0 is required for using the |resource dsc_script| resource with |chef|.

.. note:: The |windows remote management| service must be enabled. (Use ``winrm quickconfig`` to enable the service.)

.. warning:: The |resource dsc_script| resource  may not be used in the same run-list with the |resource dsc_resource|. This is because the |resource dsc_script| resource requires that ``RefreshMode`` in the Local Configuration Manager be set to ``Push``, whereas the |resource dsc_resource| resource requires it to be set to ``Disabled``.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_script_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_script_actions.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_script_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Specify DSC code directly**

.. include:: ../../step_resource/step_resource_dsc_script_code.rst

**Specify DSC code using a Windows Powershell data file**

.. include:: ../../step_resource/step_resource_dsc_script_command.rst

**Pass parameters to DSC configurations**

.. include:: ../../step_resource/step_resource_dsc_script_flags.rst

**Use custom configuration data**

.. include:: ../../includes_resources/includes_resource_dsc_script_custom_config_data.rst

.. include:: ../../step_resource/step_resource_dsc_script_configuration_data.rst

.. include:: ../../step_resource/step_resource_dsc_script_configuration_name.rst

**Using DSC with other Chef resources**

.. include:: ../../step_resource/step_resource_dsc_script_remote_files.rst



env
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_env.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_env_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_env_actions.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_env_attributes.rst


Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Set an environment variable**

.. include:: ../../step_resource/step_resource_environment_set_variable.rst

powershell_script
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_powershell_script.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_powershell_script_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_powershell_script_actions.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_powershell_script_attributes.rst


Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Write to an interpolated path**

.. include:: ../../step_resource/step_resource_powershell_write_to_interpolated_path.rst

**Change the working directory**

.. include:: ../../step_resource/step_resource_powershell_cwd.rst

**Change the working directory in Microsoft Windows**

.. include:: ../../step_resource/step_resource_powershell_cwd_microsoft_env.rst

**Pass an environment variable to a script**

.. include:: ../../step_resource/step_resource_powershell_pass_env_to_script.rst

registry_key
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_registry_key.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_registry_key_syntax.rst

Path Separators
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_windows/includes_windows_registry_key_backslashes.rst

Recipe DSL Methods
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_windows_methods.rst

.. note:: .. include:: ../../includes_notes/includes_notes_dsl_recipe_order_for_windows_methods.rst

registry_data_exists?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_data_exists.rst

registry_get_subkeys
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_get_subkeys.rst

registry_get_values
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_get_values.rst

registry_has_subkeys?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_has_subkeys.rst

registry_key_exists?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_key_exists.rst

registry_value_exists?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_value_exists.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_registry_key_actions.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_registry_key_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Create a registry key**

.. include:: ../../step_resource/step_resource_registry_key_create.rst

**Delete a registry key value**

.. include:: ../../step_resource/step_resource_registry_key_delete_value.rst

**Delete a registry key and its subkeys, recursively**

remote_file
-----------------------------------------------------

**Specify local Windows file path as a valid URI**

.. include:: ../../step_resource/step_resource_remote_file_local_windows_path.rst

windows_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_windows.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_windows_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_windows_actions.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_windows_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_windows_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Install a package**

.. include:: ../../step_resource/step_resource_windows_package_install.rst

**Specify a URL for the source attribute**

.. include:: ../../step_resource/step_resource_package_windows_source_url.rst

**Specify path and checksum**

.. include:: ../../step_resource/step_resource_package_windows_source_url_checksum.rst

**Modify remote_file resource attributes**

.. include:: ../../step_resource/step_resource_package_windows_source_remote_file_attributes.rst

**Download a nsis (Nullsoft) package resource**

.. include:: ../../step_resource/step_resource_package_windows_download_nsis_package.rst

**Download a custom package**

.. include:: ../../step_resource/step_resource_package_windows_download_custom_package.rst


windows_service
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_service_windows.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_windows_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_windows_actions.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_windows_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Start a service manually**

.. include:: ../../step_resource/step_resource_service_windows_manual_start.rst




Cookbook Resources
=====================================================
Some of the most popular |company_name|-maintained cookbooks that contain lightweight resources useful when configuring machines running |windows| are listed below:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Cookbook
     - Description
   * - `iis <https://github.com/chef-cookbooks/iis>`_
     - The ``iis`` cookbook is used to install and configure |microsoft iis|.
   * - `webpi <https://github.com/chef-cookbooks/webpi>`_
     - The ``webpi`` cookbook is used to run the |microsoft webpi|.
   * - `windows <https://github.com/chef-cookbooks/windows>`_
     - The ``windows`` cookbook is used to configure auto run, batch, reboot, enable built-in operating system packages, configure |windows| packages, reboot machines, and more.

|dsl recipe| Methods
=====================================================
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_windows_methods.rst

.. note:: .. include:: ../../includes_notes/includes_notes_dsl_recipe_order_for_windows_methods.rst

registry_data_exists?
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_data_exists.rst

registry_get_subkeys 
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_get_subkeys.rst

registry_get_values
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_get_values.rst

registry_has_subkeys?
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_has_subkeys.rst

registry_key_exists?
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_key_exists.rst

registry_value_exists?
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_registry_value_exists.rst

Helpers
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_helper_windows_platform.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_helper_windows_platform_helpers.rst

.. include:: ../../step_dsl_recipe/step_dsl_recipe_helper_windows_platform.rst


|chef client_title|
=====================================================
.. include:: ../../includes_chef_client/includes_chef_client.rst

.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_options_windows.rst

.. note:: |chef solo| also uses the ``--daemonize`` setting for |windows|.

Run w/Elevated Privileges
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_elevated_privileges.rst

.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_elevated_privileges_windows.rst

|knife rb|
=====================================================
.. include:: ../../includes_notes/includes_notes_knife_rb_windows_path.rst
