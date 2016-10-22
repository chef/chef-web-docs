=====================================================
Release Notes: chef-client 12.6
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for chef-client 12.6 and/or are changes from previous versions. The short version:

* **New timer for resource notifications** Use the ``:before`` timer with the ``notifies`` and ``subscribes`` properties to specify that the action on a notified resource should be run before processing the resource block in which the notification is located. 
* **New ksh resource** The **ksh** resource is added and is based on the **script** resource.
* **New metadata.rb settings** The metadata.rb file has settings for ``chef_version`` and ``ohai_version`` that allow ranges to be specified that declare the supported versions of the chef-client and Ohai.
* **dsc_resource supports reboots** The **dsc_resource** resource supports immediate and queued reboots. This uses the **reboot** resource and its ``:reboot_now`` or ``:request_reboot`` actions.
* **New and changed knife bootstrap options** The ``--identify-file`` option for the ``knife bootstrap`` subcommand is renamed to ``--ssh-identity-file``; the ``--sudo-preserve-home`` is new.
* **New installer types for the windows_package resource** The **windows_package** resource now supports the following installer types: ``:custom``, Inno Setup (``:inno``), InstallShield (``:installshield``), Microsoft Installer Package (MSI) (``:msi``), Nullsoft Scriptable Install System (NSIS) (``:nsis``), Wise (``:wise``). Prior versions of Chef supported only ``:msi``.
* **dsc_resource resource may be run in non-disabled refresh mode** The latest version of Windows Management Framework (WMF) 5 has relaxed the limitation that prevented the chef-client from running in non-disabled refresh mode. Requires Windows PowerShell 5.0.10586.0 or higher.
* **dsc_script and dsc_resource resources may be in the same run-list** The latest version of Windows Management Framework (WMF) 5 has relaxed the limitation that prevented the chef-client from running in non-disabled refresh mode, which allows the Local Configuration Manager to be set to ``Push``. Requires Windows PowerShell 5.0.10586.0 or higher.
* **New --profile-ruby option** Use the ``--profile-ruby`` option to dump a (large) profiling graph into ``/var/chef/cache/graph_profile.out``.
* **New live_stream property for the execute resource** Set the ``live_stream`` property to ``true`` to send the output of a command run by the **execute** resource to the chef-client event stream.


Notification Timers
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

ksh
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_script_ksh.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_ksh_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_ksh_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_ksh_attributes.rst

Changes for PowerShell 5.0.10586.0
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_dsc_resource_requirements.rst

New metadata.rb Settings
-----------------------------------------------------
The following settings are new for metadata.rb:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``chef_version``
     - A range of chef-client versions that are supported by this cookbook.

       .. include:: ../../includes_config/includes_config_rb_metadata_settings_example_chef_version.rst

   * - ``ohai_version``
     - A range of chef-client versions that are supported by this cookbook.

       .. include:: ../../includes_config/includes_config_rb_metadata_settings_example_ohai_version.rst

.. note:: These settings are not visible in Chef Supermarket.


knife bootstrap Options
-----------------------------------------------------
The following option is new for ``knife bootstrap``:

``--sudo-preserve-home``
   Use to preserve the non-root user's ``HOME`` environment.

The ``--identify-file`` option is now ``--ssh-identify-file``.

--profile-ruby Option
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_profile_ruby.rst




Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
