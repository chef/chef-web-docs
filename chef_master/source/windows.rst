=====================================================
Chef for Microsoft Windows
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/windows.rst>`__

Overview
=======================================================
The Chef Infra Client has specific components that are designed to support unique aspects of the Microsoft Windows platform, including Windows PowerShell, Internet Information Services (IIS), and SQL Server.

.. tag windows_install_overview

Chef Infra Client can be installed on machines running Microsoft Windows in the following ways:

* By bootstraping Chef Infra Client using `knife bootstrap </knife_bootstrap.html>`__ from a local workstation using WinRM
* By downloading Chef Infra Client to the target node, and then running the Microsoft Installer Package (MSI) locally
* By using an existing process already in place for managing Microsoft Windows machines, such as System Center

.. end_tag

Setting up Windows Workstations
=======================================================
To set up your Windows workstation follow the steps on `Chef for Microsoft Windows </dk_windows.html>`__

Install Chef Infra Client on Windows Nodes
=======================================================

.. tag chef_client_summary

Chef Infra Client is an agent that runs locally on every node that is under management by Chef Infra Server. When Chef Infra Client runs, performs all of the steps required for bringing a node into the expected state, including:

* Registering and authenticating the node with Chef Infra Server
* Building the node object
* Synchronizing cookbooks
* Compiling the resource collection by loading each of the required cookbooks, including recipes, attributes, and all other dependencies
* Taking the appropriate and required actions to configure the node
* Looking for exceptions and notifications, handling each as required

.. end_tag

This command has the following syntax:

.. code-block:: bash

   $ chef-client OPTION VALUE OPTION VALUE ...

This command has the following options specific to Microsoft Windows:

``-A``, ``--fatal-windows-admin-check``
   Cause a Chef Infra Client run to fail when Chef Infra Client does not have administrator privileges in Microsoft Windows.

``-d``, ``--daemonize``
   Run the executable as a daemon.

   This option is only available on machines that run in UNIX or Linux environments. For machines that are running Microsoft Windows that require similar functionality, use the ``chef-client::service`` recipe in the ``chef-client`` cookbook: https://supermarket.chef.io/cookbooks/chef-client. This will install a Chef Infra Client service under Microsoft Windows using the Windows Service Wrapper.

System Requirements
-----------------------------------------------------

The recommended minimum amount of RAM available to Chef Infra Client during a Chef Infra Client run is 512MB. Each node and workstation must have access to Chef Infra Server via HTTPS. The Chef Infra Client can be used to manage machines that run on the following versions of Microsoft Windows:

.. list-table::
   :widths: 200 200 200
   :header-rows: 1

   * - Operating System
     - Architecture
     - Version
   * - Windows
     - ``x86``, ``x64``
     - ``7``, ``8.1``, ``2008 R2``, ``2012``, ``2012 R2``, ``2016``, ``10 (all channels except "insider" builds)``, ``2019 (Long-term servicing channel (LTSC), both Desktop Experience and Server Core)``

After Chef Infra Client is installed, it is located at ``C:\opscode``. The main configuration file for Chef Infra Client is located at ``C:\chef\client.rb``.

Information for Windows Users
----------------------------------------------------

Run With Elevated Privileges
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_client_elevated_privileges

The Chef Infra Client may need to be run with elevated privileges in order to get a recipe to converge correctly. On UNIX and UNIX-like operating systems this can be done by running the command as root. On Microsoft Windows this can be done by running the command prompt as an administrator.

.. end_tag

.. tag ctl_chef_client_elevated_privileges_windows

On Microsoft Windows, running without elevated privileges (when they are necessary) is an issue that fails silently. It will appear that Chef Infra Client completed its run successfully, but the changes will not have been made. When this occurs, do one of the following to run Chef Infra Client as the administrator:

* Log in to the administrator account. (This is not the same as an account in the administrator's security group.)

* Run Chef Infra Client process from the administrator account while being logged into another account. Run the following command:

  .. code-block:: bash

     $ runas /user:Administrator "cmd /C chef-client"

  This will prompt for the administrator account password.

* Open a command prompt by right-clicking on the command prompt application, and then selecting **Run as administrator**. After the command window opens, Chef Infra Client can be run as the administrator

.. end_tag

Spaces and Directories
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag windows_spaces_and_directories

Directories that are used by Chef on Windows cannot have spaces. For example, ``C:\Users\User Name`` will not work, but ``C:\Users\UserName`` will. Chef commands may fail if used against a directory with a space in its name.

.. end_tag

Top-level Directory Names
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag windows_top_level_directory_names

Windows will throw errors when path name lengths are too long. For this reason, it's often helpful to use a very short top-level directory, much like what is done in UNIX and Linux. For example, Chef uses ``/opt/`` to install ChefDK on macOS. A similar approach can be done on Microsoft Windows, by creating a top-level directory with a short name. For example: ``C:\chef``.

.. end_tag

PATH System Variable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag windows_environment_variable_path

On Microsoft Windows, Chef Infra Client must have two entries added to the ``PATH`` environment variable:

* ``C:\opscode\chef\bin``
* ``C:\opscode\chef\embedded\bin``

This is typically done during the installation of Chef Infra Client automatically. If these values (for any reason) are not in the ``PATH`` environment variable, Chef Infra Client will not run properly.

.. image:: ../../images/includes_windows_environment_variable_path.png

This value can be set from a recipe. For example, from the ``php`` cookbook:

.. code-block:: ruby

   #  the following code sample comes from the ``package`` recipe in the ``php`` cookbook: https://github.com/chef-cookbooks/php

   if platform?('windows')

     include_recipe 'iis::mod_cgi'

     install_dir = File.expand_path(node['php']['conf_dir']).gsub('/', '\\')
     windows_package node['php']['windows']['msi_name'] do
       source node['php']['windows']['msi_source']
       installer_type :msi

       options %W[
         /quiet
         INSTALLDIR="#{install_dir}"
         ADDLOCAL=#{node['php']['packages'].join(',')}
       ].join(' ')
   end

   ...

   ENV['PATH'] += ";#{install_dir}"
   windows_path install_dir

   ...

.. end_tag

Proxy Settings
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag proxy_windows

To determine the current proxy server on the Microsoft Windows platform:

#. Open **Internet Properties**.
#. Open **Connections**.
#. Open **LAN settings**.
#. View the **Proxy server** setting. If this setting is blank, then a proxy server may not be available.

To configure proxy settings in Microsoft Windows:

#. Open **System Properties**.
#. Open **Environment Variables**.
#. Open **System variables**.
#. Set ``http_proxy`` and ``https_proxy`` to the location of your proxy server. This value **MUST** be lowercase.

.. end_tag

Remotely administering nodes
-----------------------------------------------------
.. tag knife_windows_summary

The ``knife windows`` subcommand is used to interact with Windows systems managed by Chef Infra. Nodes are configured using WinRM, which allows native objects---batch scripts, Windows PowerShell scripts, or scripting library variables---to be called by external applications. The ``knife windows`` subcommand supports NTLM and Kerberos methods of authentication.

.. end_tag

Se the `knife windows </knife_windows.html>`__ for more information.

Ports
+++++++++++++++++++++++++++++++++++++++++++++++++++++

.. tag knife_windows_winrm_ports

WinRM requires that a target node be accessible via the ports configured to support access via HTTP or HTTPS.

.. end_tag

Msiexec.exe
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag windows_msiexec

Msiexec.exe is used to install Chef Infra Client on a node as part of a bootstrap operation. The actual command that is run by the default bootstrap script is:

.. code-block:: bash

   $ msiexec /qn /i "%LOCAL_DESTINATION_MSI_PATH%"

where ``/qn`` is used to set the user interface level to "No UI", ``/i`` is used to define the location in which Chef Infra Client is installed, and ``"%LOCAL_DESTINATION_MSI_PATH%"`` is a variable defined in the default `windows-chef-client-msi.erb <https://github.com/chef/knife-windows/blob/master/lib/chef/knife/bootstrap/windows-chef-client-msi.erb>`_ bootstrap template. See http://msdn.microsoft.com/en-us/library/aa367988%28v=vs.85%29.aspx for more information about the options available to Msiexec.exe.

.. end_tag

ADDLOCAL Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag windows_msiexec_addlocal

The ``ADDLOCAL`` parameter adds two setup options specific to Chef Infra Client. These options can be passed along with an Msiexec.exe command:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Option
     - Description
   * - ``ChefClientFeature``
     - Use to install Chef Infra Client.
   * - ``ChefSchTaskFeature``
     - Use to configure Chef Infra Client as a scheduled task in Microsoft Windows.
   * - ``ChefPSModuleFeature``
     - Used to install the chef PowerShell module. This will enable chef command line utilities within PowerShell.

First install Chef Infra Client, and then enable it to run as a scheduled task. For example:

.. code-block:: bash

   $ msiexec /qn /i C:\inst\chef-client-14.5.27-1-x64.msi ADDLOCAL="ChefClientFeature,ChefSchTaskFeature,ChefPSModuleFeature"

.. end_tag

Install Chef Infra Client using the MSI Installer
-----------------------------------------------------
A Microsoft Installer Package (MSI) is available for installing Chef Infra Client on a Microsoft Windows machine from `Chef Downloads <https://downloads.chef.io/>`__.

Enable as a Scheduled Task
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag install_chef_client_windows_as_scheduled_task

To run Chef Infra Client at periodic intervals (so that it can check in with Chef Infra Server automatically), configure Chef Infra Client to run as a scheduled task. This can be done via the MSI, by selecting the **Chef Unattended Execution Options** --> **Chef Infra Client Scheduled Task** option on the **Custom Setup** page or by running the following command after Chef Infra Client is installed:

For example:

.. code-block:: none

   $ SCHTASKS.EXE /CREATE /TN ChefClientSchTask /SC MINUTE /MO 30 /F /RU "System" /RP /RL HIGHEST /TR "cmd /c \"C:\opscode\chef\embedded\bin\ruby.exe C:\opscode\chef\bin\chef-client -L C:\chef\chef-client.log -c C:\chef\client.rb\""

Refer `Schedule a Task <https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc748993(v=ws.11)>`_ for more details.

After Chef Infra Client is configured to run as a scheduled task, the default file path is: ``c:\chef\chef-client.log``.

.. end_tag

Install Chef Infra Client using an Existing Process
-----------------------------------------------------
.. tag windows_install_system_center

Many organizations already have processes in place for managing the applications and settings on various Microsoft Windows machines. For example, System Center. Chef Infra Client can be installed using this method.

.. end_tag

Windows Cookbooks
=====================================================
Some of the most popular Chef-maintained cookbooks that contain custom resources useful when configuring machines running Microsoft Windows are listed below:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Cookbook
     - Description
   * - `iis Cookbook <https://github.com/chef-cookbooks/iis>`_
     - The ``iis`` cookbook is used to install and configure Internet Information Services (IIS).
   * - `iis_urlrewrite Cookbook <https://github.com/chef-cookbooks/iis_urlrewrite>`_
     - This cookbook downloads and installs the IIS URL Rewrite 2.0 extension into Microsoft Internet Information Server.
   * - `PowerShell Cookbook <https://github.com/chef-cookbooks/powershell>`_
     - Installs and configures PowerShell 2.0, 3.0, 4.0 or 5.0.
   * - `Microsoft Azure Cookbook <https://github.com/chef-cookbooks/miccrosoft_azure>`_
     - This cookbook provides resources and providers to create an manage Microsoft Azure components.
   * - `Microsoft Visual C++ Runtime Cookbook <https://github.com/chef-cookbooks/vcruntime>`_
     - Installs Microsoft Visual C++ runtime version 6 (2005), 9 (2008), 10 (2010), 11 (2012), 12 (2013), 14 (2015) or 15 (2017) on Windows.
   * - `Mingw Cookbook <https://github.com/chef-cookbooks/mingw>`_
     - Installs ``msys/mingw`` compiler toolchains on windows.
   * - `Webpi Cookbook <https://github.com/chef-cookbooks/webpi>`_
     - The ``webpi`` cookbook is used to run the Microsoft Web Platform Installer (WebPI).
   * - `Windows Cookbook <https://github.com/chef-cookbooks/windows>`_
     - The ``windows`` cookbook is used to configure auto run, batch, reboot, enable built-in operating system packages, configure Microsoft Windows packages, reboot machines, and more.
   * - `Windows_dns Cookbook <https://github.com/chef-cookbooks/windows_dns>`_
     - This cookbook provides a resource for managing DNS on Windows hosts.
   * - `windows_uac Cookbook <https://github.com/chef-cookbooks/windows_uac>`_
     - The ``windows_uac`` resource configures UAC on Windows hosts by setting registry keys at ``HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System``


Community Supported Windows Projects
-----------------------------------------------------
Two community supports two provisioners for Kitchen:

* `kitchen-dsc <https://github.com/test-kitchen/kitchen-dsc>`_
* `kitchen-pester <https://github.com/test-kitchen/kitchen-pester>`_

Windows  Resources
=====================================================

.. tag resources_common

A resource is a statement of configuration policy that:

* Describes the desired state for a configuration item
* Declares the steps needed to bring that item to the desired state
* Specifies a resource type---such as ``package``, ``template``, or ``service``
* Lists additional details (also known as resource properties), as necessary
* Are grouped into recipes, which describe working configurations

.. end_tag

Windows Resources
-----------------------------------------------------

Chef Infra provides a growing number of Windows-specific resources.

* `Chocolatey_config </resource_chocolatey_config.html>`__
* `Chocolatey_package </resource_chocolatey_package.html>`__
* `Chocolatey_source </resource_chocolatey_package.html>`__
* `dsc_resource </resource_dsc_resource.html>`__
* `resource_registry_key </resource_registry_key.html>`__
* `Windows_ad_join </resource_windows_ad_join.html>`__
* `Windows_ad_join </resource_windows_ad_join.rst>`__
* `Windows_auto_run </resource_windows_auto_run.rst>`__
* `Windows_certificate </resource_windows_certificate.rst>`__
* `Windows_dfs_folder </resource_windows_dfs_folder.rst>`__
* `Windows_dfs_namespace </resource_windows_dfs_namespace.rst>`__
* `Windows_dfs_server </resource_windows_dfs_server.rst>`__
* `Windows_dns_record </resource_windows_dns_record.rst>`__
* `Windows_dns_zone </resource_windows_dns_zone.rst>`__
* `Windows_env </resource_windows_env.rst>`__
* `Windows_feature_dism </resource_windows_feature_dism.rst>`__
* `Windows_feature_powershell </resource_windows_feature_powershell.rst>`__
* `Windows_feature </resource_windows_feature.rst>`__
* `Windows_firewall_rule </resource_windows_firewall_rule.rst>`__
* `Windows_font </resource_windows_font.rst>`__
* `Windows_package </resource_windows_package.rst>`__
* `Windows_pagefile </resource_windows_pagefile.rst>`__
* `Windows_path </resource_windows_path.rst>`__
* `Windows_windows_printer_port </resource_windows_printer_port.rst>`__
* `Windows_printer </resource_windows_printer.rst>`__
* `Windows_service </resource_windows_service.rst>`__
* `Windows_share </resource_windows_share.rst>`__
* `Windows_shortcut </resource_windows_shortcut.rst>`__
* `Windows_task </resource_windows_task.rst>`__
* `Windows_uac </resource_windows_uac.rst>`__
* `Windows_workgroup </resource_windows_workgroup.rst>`__

Windows Compatible Resources
-----------------------------------------------------
The most popular core resources in Chef Infra Client work the same way in Microsoft Windows as they do on any UNIX- or Linux-based platform.

* `cookbook_file </resource_cookbook_file.html>`__
*  `directory </resource_directory.html>`__
* `env </resource_env.html>`__
* `execute </resource_execute.html>`__
* `file </resource_file.html>`__
* `group </resource_group.html>`__
* `http_request </resource_http_request.html>`__
* `link </resource_link.html>`__
* `mount </resource_mount.html>`__
* `package </resource_package.html>`__
* `remote_directory </resource_remote_directory.html>`__
* `remote_file </resource_remote_file.html>`__
* `ruby_block </resource_ruby_block.html>`__
* `service </resource_service.html>`__
* `template </resource_template.html>`__
* `user </resource_user.html>`__

The file-based resources have attributes that support unique requirements within the Microsoft Windows platform, including ``inherits`` (for file inheritance), ``mode`` (for octal modes), and ``rights`` (for access control lists, or ACLs).

* `cookbook_file </resource_cookbook_file.html>`__
* `file </resource_file.html>`__
* `remote_file </resource_remote_file.html>`__
* `template </resource_template.html>`__
