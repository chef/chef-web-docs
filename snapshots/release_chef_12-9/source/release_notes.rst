=====================================================
Release Notes: chef-client 12.9
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

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
.. include:: ../../includes_resources_common/includes_resources_common_windows_file_redirection.rst

Key Redirection
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_notes/includes_notes_registry_key_redirection.rst

Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
