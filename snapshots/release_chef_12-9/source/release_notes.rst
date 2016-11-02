=====================================================
Release Notes: chef-client 12.9
=====================================================

.. tag chef

Chef is a powerful automation platform that transforms infrastructure into code. Whether you’re operating in the cloud, on-premises, or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

This diagram shows how you develop, test, and deploy your Chef code.

.. image:: ../../images/start_chef.svg
   :width: 700px
   :align: center

.. end_tag

What's New
=====================================================
The following items are new for chef-client 12.9 and/or are changes from previous versions. The short version:

* **64-bit chef-client for Microsoft Windows** Starting with chef-client 12.9, 64-bit 
* **New property for the mdadm resource** Use the ``mdadm_defaults`` property to set the default values for ``chunk`` and ``metadata`` to ``nil``, which allows mdadm to apply its own default values.
* **File redirection in Windows for 32-bit applications** Files on Microsoft Windows that are managed by the **file** and **directory** resources are subject to file redirection, depending if the chef-client is 64-bit or 32-bit.
* **Registry key redirection in Windows for 32-bit applications** Registry keys on Microsoft Windows that are managed by the **registry_key** resource are subject to key redirection, depending if the chef-client is 64-bit or 32-bit.
* **New values for log_location** Use ``:win_evt`` to write log output to the (Windows Event Logger and ``:syslog`` to write log output to the syslog daemon facility with the originator set as ``chef-client``.
* **New timeout setting for knife ssh** Set the ``--ssh-timeout`` setting to an integer (in seconds) as part of a ``knife ssh`` command. The ``ssh_timeout`` setting may also be configured (as seconds) in the knife.rb file.
* **New "seconds to wait before first chef-client run" setting** The ``-daemonized`` option for the chef-client now allows the seconds to wait before starting the chef-client run to be specified. For example, if ``--daemonize 10`` is specified, the chef-client will wait ten seconds.

64-bit chef-client
-----------------------------------------------------
The chef-client now runs on 64-bit Microsoft Windows operating systems.

* Support for file redirection
* Support for key redirection

File Redirection
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resources_common_windows_file_redirection

64-bit versions of Microsoft Windows have a 32-bit compatibility layer that redirects attempts by 32-bit application to access the ``System32`` directory to a different location. Starting with chef-client version 12.9, the 32-bit version of the chef-client is subject to the file redirection policy.

For example, consider the following script:

.. code-block:: ruby

   process_type = ENV['PROCESSOR_ARCHITECTURE'] == 'AMD64' ? '64-bit' : '32-bit'
   system32_dir = ::File.join(ENV['SYSTEMROOT'], 'system32')
   test_dir = ::File.join(system32_dir, 'cheftest')
   test_file = ::File.join(test_dir, 'chef_architecture.txt')

   directory test_dir do
     # some directory
   end

   file test_file do
     content "Chef made me, I come from a #{process_type} process."
   end

When running a 32-bit version of chef-client, the script will write the ``chef_architecture`` file to the ``C:\Windows\SysWow64`` directory. However, when running a native 64-bit version of the chef-client, the script will write a file to the ``C:\Windows\System32`` directory, as expected.

For more information, see: |url msdn_file_redirection|.

.. end_tag

Key Redirection
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag notes_registry_key_redirection

64-bit versions of Microsoft Windows have a 32-bit compatibility layer in the registry that reflects and redirects certain keys (and their values) into specific locations (or logical views) of the registry hive.

The chef-client can access any reflected or redirected registry key. The machine architecture of the system on which the chef-client is running is used as the default (non-redirected) location. Access to the ``SysWow64`` location is redirected must be specified. Typically, this is only necessary to ensure compatibility with 32-bit applications that are running on a 64-bit operating system.

32-bit versions of the chef-client (12.8 and earlier) and 64-bit versions of the chef-client (12.9 and later) generally behave the same in this situation, with one exception: it is only possible to read and write from a redirected registry location using chef-client version 12.9 (and later).

For more information, see: |url msdn_registry_key|.

.. end_tag

Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
