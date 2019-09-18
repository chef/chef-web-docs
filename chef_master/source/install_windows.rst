=====================================================
Install Chef Infra Client on Windows Nodes
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_windows.rst>`__


Nodes
=====================================================
.. tag node

A node is any system---physical, virtual, cloud, network device, etc.---that is under management by Chef Infra.

.. end_tag

.. tag windows_install_overview

Chef Infra Client can be installed on machines running Microsoft Windows in the following ways:

* By bootstraping Chef Infra Client using `knife bootstrap </knife_bootstrap.html>`__ from a local workstation using WinRM
* By downloading Chef Infra Client to the target node, and then running the Microsoft Installer Package (MSI) locally
* By using an existing process already in place for managing Microsoft Windows machines, such as System Center

.. end_tag

Use knife windows
-----------------------------------------------------
.. tag knife_windows_summary

The ``knife windows`` subcommand is used to interact with Windows systems managed by Chef Infra. Nodes are configured using WinRM, which allows native objects---batch scripts, Windows PowerShell scripts, or scripting library variables---to be called by external applications. The ``knife windows`` subcommand supports NTLM and Kerberos methods of authentication.

.. end_tag

Ports
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_windows_winrm_ports

WinRM requires that a target node be accessible via the ports configured to support access via HTTP or HTTPS.

.. end_tag

Msiexec.exe
-----------------------------------------------------
.. tag windows_msiexec

Msiexec.exe is used to install Chef Infra Client on a node as part of a bootstrap operation. The actual command that is run by the default bootstrap script is:

.. code-block:: bash

   $ msiexec /qn /i "%LOCAL_DESTINATION_MSI_PATH%"

where ``/qn`` is used to set the user interface level to "No UI", ``/i`` is used to define the location in which Chef Infra Client is installed, and ``"%LOCAL_DESTINATION_MSI_PATH%"`` is a variable defined in the default `windows-chef-client-msi.erb <https://github.com/chef/chef/blob/master/lib/chef/knife/bootstrap/templates/windows-chef-client-msi.erb>`_ bootstrap template. See https://docs.microsoft.com/en-us/windows/win32/msi/command-line-options for more information about the options available to Msiexec.exe.

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

   $ msiexec /qn /i C:\inst\chef-client-15.3.14-1-x64.msi ADDLOCAL="ChefClientFeature,ChefSchTaskFeature,ChefPSModuleFeature"

.. end_tag

Use MSI Installer
-----------------------------------------------------
A Microsoft Installer Package (MSI) is available for installing Chef Infra Client on a Microsoft Windows machine at `Chef Downloads <https://downloads.chef.io/>`__

Run as a Scheduled Task
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Chef Infra Client can be run as a scheduled task. On the Microsoft Windows platform, a scheduled task provides more visibility, configurability, and reliability around log rotation and permissions, as compared to running Chef Infra Client as a service. A scheduled task:

* Prevents log rotation issues, such as filling a disk partition
* Does not have an indeterminate status, such as a service for which only the watcher is "running"
* Prevents insufficient permissions related to service context
* Prevents issues related to a system reboot

Scheduled Task Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag install_chef_client_windows_as_scheduled_task

To run Chef Infra Client at periodic intervals (so that it can check in with Chef Infra Server automatically), configure Chef Infra Client to run as a scheduled task. This can be done via the MSI, by selecting the **Chef Unattended Execution Options** --> **Chef Infra Client Scheduled Task** option on the **Custom Setup** page or by running the following command after Chef Infra Client is installed:

For example:

.. code-block:: none

   $ SCHTASKS.EXE /CREATE /TN ChefClientSchTask /SC MINUTE /MO 30 /F /RU "System" /RP /RL HIGHEST /TR "cmd /c \"C:\opscode\chef\embedded\bin\ruby.exe C:\opscode\chef\bin\chef-client -L C:\chef\chef-client.log -c C:\chef\client.rb\""

Refer `Schedule a Task <https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc748993(v=ws.11)>`_ for more details.

After Chef Infra Client is configured to run as a scheduled task, the default file path is: ``c:\chef\chef-client.log``.

.. end_tag

Use an Existing Process
-----------------------------------------------------
.. tag windows_install_system_center

Many organizations already have processes in place for managing the applications and settings on various Microsoft Windows machines. For example, System Center. Chef Infra Client can be installed using this method.

.. end_tag

PATH System Variable
-----------------------------------------------------
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
