=====================================================
Install the chef-client on Microsoft Windows
=====================================================

.. include:: ../../includes_windows/includes_windows_install_overview.rst

Use knife windows
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows.rst

Ports
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_winrm_ports.rst

Msiexec.exe
-----------------------------------------------------
.. include:: ../../includes_windows/includes_windows_msiexec.rst

ADDLOCAL Options
-----------------------------------------------------
.. include:: ../../includes_windows/includes_windows_msiexec_addlocal.rst

Use MSI Installer
=====================================================
A Microsoft Installer Package (MSI) is available for installing the chef-client on a Microsoft Windows machine.

.. include:: ../../includes_install/includes_install_chef_client_windows.rst

Run as a Service
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_chef_client_windows_as_service.rst

Run as a Scheduled Task
-----------------------------------------------------
The chef-client can be run as a scheduled task. On the Microsoft Windows platform, a scheduled task provides more visibility, configurability, and reliability around log rotation and permissions, as compared to running the chef-client as a service. A scheduled task:

* Prevents log rotation issues, such as filling a disk partition
* Does not have an indeterminate status, such as a service for which only the watcher is "running"
* Prevents insufficient permissions related to service context
* Prevents issues related to a system reboot

Use an Existing Process
=====================================================
.. include:: ../../includes_windows/includes_windows_install_system_center.rst

PATH System Variable
=====================================================
.. include:: ../../includes_windows/includes_windows_environment_variable_path.rst
