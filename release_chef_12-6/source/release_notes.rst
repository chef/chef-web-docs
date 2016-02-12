=====================================================
Release Notes: |chef client| 12.6
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for |chef client| 12.6 and/or are changes from previous versions. The short version:

* **New ksh resource** The |resource script_ksh| resource is added and is based on the |resource script| resource.
* **New metadata.rb settings** The |metadata rb| file has settings for ``chef_version`` and ``ohai_version`` that allow ranges to be specified that declare the supported versions of the |chef client| and |ohai|.
* **dsc_resource supports reboots** The |resource dsc_resource| resource supports immediate and queued reboots. This uses the |resource reboot| resource and its ``:reboot_now`` or ``:request_reboot`` actions.
* **New and changed knife bootstrap options** The ``--identify-file`` option for the |subcommand knife bootstrap| subcommand is renamed to ``--ssh-identity-file``; the ``--sudo-preserve-home`` is new.
* **New installer types for the windows_package resource** The |resource package_windows| resource now supports the following installer types: ``:custom``, |inno setup| (``:inno``), |installshield| (``:installshield``), |microsoft installer package| (``:msi``), |nsis| (``:nsis``), |wise| (``:wise``). Prior versions of |chef| supported only ``:msi``.
* **dsc_resource resource may be run in non-disabled refresh mode** The latest version of |windows management_framework| 5 has relaxed the limitation that prevented the |chef client| from running in non-disabled refresh mode. Requires |windows powershell| 5.0.10586.0 or higher.
* **dsc_script and dsc_resource resources may be in the same run-list** The latest version of |windows management_framework| 5 has relaxed the limitation that prevented the |chef client| from running in non-disabled refresh mode, which allows the Local Configuration Manager to be set to ``Push``. Requires |windows powershell| 5.0.10586.0 or higher.
* **New --profile-ruby option** Use the ``--profile-ruby`` option to dump a (large) profiling graph into ``/var/chef/cache/graph_profile.out``.


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
The following settings are new for |metadata rb|:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``chef_version``
     - |metadata rb chef_version|

       .. include:: ../../includes_config/includes_config_rb_metadata_settings_example_chef_version.rst

   * - ``ohai_version``
     - |metadata rb chef_version|

       .. include:: ../../includes_config/includes_config_rb_metadata_settings_example_ohai_version.rst

.. note:: These settings are not visible in |supermarket|.


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
