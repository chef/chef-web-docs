=====================================================
Release Notes: |chef client| 12.0 - 12.14
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New in 12.14
=====================================================
The following items are new for |chef client| 12.14 and/or are changes from previous versions. The short version:

* **Upgraded Ruby version from 2.1.9 to 2.3.1** Adds several performance and functionality enhancements.
* **Now support for Chef client runs on Windows Nano Server** A small patch to Ruby 2.3.1 and improvements to the Ohai network plugin now allow you to do chef client runs on Windows Nano Server.
* **New yum_repository resource** Use the |resource_yum_repository| resource to manage a yum repository configuration file.
* **Added the ability to mark a property of a custom resource as ``sensitive``** This will suppress the property's value when it's used in other outputs, such as messages used by the data collector.

yum_repository
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_yum_repository.rst

For syntax, a list of properties and actions, see :doc:`yum_repository </resource_yum_repository>`.

sensitive: true
-----------------------------------------------------
Some properties in custom resources may include sensitive data, such as a password for a database server. When the resource's state is built for use by data collector or a similar auditing tool, 
a hash is built of all state properties for that resource and their values. This leads to sensitive data being transmitted and potentially stored in the clear.

Individual properties can now be marked as sensitive and then have the value of that property suppressed when exporting the resource's state. To do this, add ``sensitive: true`` when definine the property, such as in the following example:

.. code-block:: ruby

   property :db_password, String, sensitive: true

What's New in 12.13
=====================================================
The following items are new for |chef client| 12.13 and/or are changes from previous versions. The short version:

* **Ohai 8.18 includes new plugin for gathering available user shells** Other additions include a new hardware plugin for OSX that gathers system information and detection of VMWare and VirtualBox installations.
* **New Chef client option to override any config key/value pair** Use ``chef-client --config-option`` to override any config setting from the command line.

--config-option
-----------------------------------------------------
Use the ``--config-option`` option to override a single configuration option when calling a command on ``chef-client``. To override multiple configuration options, simply add additional ``--config-option`` options like in the following example:

.. code-block:: bash

   $ chef-client --config-option chef_server_url=http://example --config-option policy_name=web"


Updated Dependencies
-----------------------------------------------------
* ruby - 2.1.9 (from 2.1.8)

Updated Gems
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* chef-zero - 4.8.0 (from 4.7.0)
* cheffish - 2.0.5 (from 2.0.4)
* compat_resource - 12.10.7 (from 12.10.6)
* ffi - 1.9.14 (from 1.9.10)
* ffi-yajl - 2.3.0 (from 2.2.3)
* fuzzyurl - 0.9.0 (from 0.8.0)
* mixlib-cli - 1.7.0 (from 1.6.0)
* mixlib-log - 1.7.0 (from 1.6.0)
* ohai - 8.18.0 (from 8.17.1)
* pry - 0.10.4 (from 0.10.3)
* rspec - 3.5.0 (from 3.4.0)
* rspec-core - 3.5.2 (from 3.4.4)
* rspec-expectations - 3.5.0 (from 3.4.0)
* rspec-mocks - 3.5.0 (from 3.4.1)
* rspec-support - 3.5.0 (from 3.4.1)
* simplecov - 0.12.0 (from 0.11.2)
* specinfra - 2.60.3 (from 2.59.4)
* mixlib-archive - 0.2.0 (added to package)

What's New in 12.12
=====================================================
The following items are new for |chef client| 12.12 and/or are changes from previous versions. The short version:

* **New node attribute APIs** Common set of methods to read, write, delete, and check if node attributes exist.
* **Data collector updates** Minor enhancements to data that the data collector reports on.
* **knife cookbook create has been deprecated** You should use `chef generate cookbook <https://docs.chef.io/ctl_chef.html#chef-generate-cookbook>`_ instead.

New node attribute read, write, unlink, and exist? APIs
-----------------------------------------------------------
The four methods ``read``, ``write``, ``unlink``, and ``exist?`` (and their corresponding unsafe versions) can be used on node objects to set, retrieve, delete, and validate existance of attributes.

read/read!
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``read`` method to retrieve an attribute value on a node object. It is a safe, non-autovivifying reader that returns ``nil`` if the attribute does not exist.  

``node.read("foo", "bar", "baz")`` is equivalent to ``node["foo"]["bar"]["baz"]`` but returns ``nil`` instead of raising an exception when no value is set.

The ``read!`` method is a non-autovivifying reader that also retrieves an attribute value on a node object; however, it will throw a NoMethodError exception if the attribute does not exist.

On the node level, ``node.default.read/read!("foo")`` behaves similarly to ``node.read("foo")``, but only on the default level.

write/write!
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``write`` method set an attribute value on a node object. It is a safe, autovivifying writer that replaces intermediate non-hash objects.

``node.write(:default, "foo", "bar", "baz")`` is equivalent to ``node.default["foo"]["bar"] = "baz"``.

The ``write!`` method is also an autovivifying method to set an attribute value on a node object; however, it will throw an NoSuchAttribute exception if there is a non-hash on an intermediate key.

.. note:: There is currently no non-autovivifying writer method for attributes.

On the node level, ``node.default.write/write!("foo", "bar")`` is equivalent to ``node.write/write!(:default, "foo", "bar")``.

unlink/unlink!
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``unlink`` method to delete an attribute on a node object. ``nil`` will be returned if the value is not a valid Hash or Array.

The ``unlink!`` method also deletes an attribute on a node object; however, it will throw a NoSuchAttribute exception if the attribute does not exist.

On the node level, ``node.default.unlink/unlink!("foo")`` is equivalent to ``node.unlink/unlink!(:default, "foo")``.

exist?
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the ``exist?`` method to check whether the attribute exists. For example, ``node.exist?("foo", "bar")`` can be used to see if ``node["foo"]["bar"]`` exists.

On the node level, ``node.default.exist?("foo", "bar")`` can be used to see if ``node.default["foo"]["bar"]`` exists.

Depreciated node attribute methods
--------------------------------------------------------
The following methods have been deprecated in this release:

* ``node.set``
* ``node.set_unless``

data_collector updates
-----------------------------------------------------
* Adds ``node`` to the data_collector message.
* ``data_collector`` reports on all resources and not just those that have been processed.

What's New in 12.11
=====================================================
The following items are new for |chef client| 12.11 and/or are changes from previous versions. The short version:

* **Support for standard exit codes in Chef client** Standard exit codes are now used by Chef client and should be identical across all OS platforms. New configuration setting ``exit_status`` has been added to specify how Chef client reports non-standard exit codes. 
* **New data collector functionality for run statistics** New feature that provides a unified method for sharing statistics about your Chef runs in webhook-like manner.
* **Default chef-solo behavior is equivalent to chef-client local mode** chef-solo now uses chef-client local mode. To use the previous ``chef-solo`` behavior, run in ``chef-solo --legacy-mode``.
* **New systemd_unit resource** Use the |resource systemd_unit| to manage systemd units.



exit_status
-----------------------------------------------------
|exit status| Default value: ``nil``.

   .. note:: The behavior with the default value consists of a warning on the use of deprecated and non-standard exit codes. In a future release of Chef client, using standardized exit codes will be the default behavior.


Data collector
-----------------------------------------------------
The data collector feature is new to Chef 12.11. It provides a unified method for sharing statistics about your Chef runs in a webhook-like manner. The data collector supports Chef in all its modes: Chef client, Chef solo (commonly referred to as "Chef client local mode"), and Chef solo legacy mode.

To enable the data collector, specify the following settings in your client configuration file:

* ``data_collector.server_url``: Required. The URL to which the Chef client will POST the data collector messages
* ``data_collector.token``: Optional. An token which will be sent in a x-data-collector-token HTTP header which can be used to authenticate the message.
* ``data_collector.mode``: The Chef mode in which the data collector should run. Chef client mode is chef client configured to use Chef server to provide Chef client its resources and artifacts. Chef solo mode is Chef client configured to use a local Chef zero server (``chef-client --local-mode``). This setting also allows you to only enable data collector in Chef solo mode but not Chef client mode. Available options are ``:solo``, ``:client``, or ``:both``. Default is ``:both``.
* ``data_collector.raise_on_failure``: If enabled, Chef will raise an exception and fail to run if the data collector cannot be reached at the start of the Chef run. Defaults to false.
* ``data_collector.organization``: Optional. In Chef solo mode, the organization field in the messages will be set to this value. Default is ``chef_solo``. This field does not apply to Chef client mode.

Replace previous Chef-solo behavior with Chef client local mode
----------------------------------------------------------------
The default operation of chef-solo is now the equivalent to ``chef-client -z`` or ``chef-client --local-mode``, but you can use the previous chef-solo behavior by running in ``chef-solo --legacy-mode``. 
As part of this change, environment and role files written in ruby are now fully supported by ``knife upload``.

systemd_unit
------------------------------------------------------
Use the |resource systemd_unit| resource to create, manage, and run `systemd units <https://www.freedesktop.org/software/systemd/man/systemd.html#Concepts>`_.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_systemd_unit_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_systemd_unit_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_systemd_unit_attributes.rst

What's New in 12.10
=====================================================
The following items are new for |chef client| 12.10 and/or are changes from previous versions. The short version:

* **New layout property for mdadm resource** Use the ``layout`` property to set the |raid5| parity algorithm. Possible values: ``left-asymmetric`` (or ``la``), ``left-symmetric`` (or ``ls``), ``right-asymmetric`` (or ``ra``), or ``right-symmetric`` (or ``rs``).
* **New with_run_context for the Recipe DSL** Use ``with_run_context`` to run resource blocks as part of the root or parent run context.
* **New Recipe DSL methods for declaring, deleting, editing, and finding resources** Use the ``declare_resource``, ``delete_resource``, ``edit_resource``, and ``find_resource`` methods to interact with resources in the resource collection. Use the ``delete_resource!``, ``edit_resource!``, or ``find_resource!`` methods to trigger an exception when the resource is not found in the collection.

with_run_context
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_with_run_context.rst

declare_resource
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_declare_resource.rst

delete_resource
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_delete_resource.rst

|delete_resource_bang|
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_delete_resource_bang.rst

edit_resource
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_edit_resource.rst

|edit_resource_bang|
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_edit_resource_bang.rst

find_resource
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_find_resource.rst

|find_resource_bang|
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_find_resource_bang.rst

What's New in 12.9
=====================================================
The following items are new for |chef client| 12.9 and/or are changes from previous versions. The short version:

* **64-bit chef-client for Microsoft Windows** Starting with |chef client| 12.9, 64-bit 
* **New property for the mdadm resource** Use the ``mdadm_defaults`` property to set the default values for ``chunk`` and ``metadata`` to ``nil``, which allows |mdadm| to apply its own default values.
* **File redirection in Windows for 32-bit applications** Files on |windows| that are managed by the |resource file| and |resource directory| resources are subject to file redirection, depending if the |chef client| is 64-bit or 32-bit.
* **Registry key redirection in Windows for 32-bit applications** Registry keys on |windows| that are managed by the |resource registry_key| resource are subject to key redirection, depending if the |chef client| is 64-bit or 32-bit.
* **New values for log_location** Use ``:win_evt`` to write log output to the (|windows event logger| and ``:syslog`` to write log output to the |syslog| daemon facility with the originator set as ``chef-client``.
* **New timeout setting for knife ssh** Set the ``--ssh-timeout`` setting to an integer (in seconds) as part of a ``knife ssh`` command. The ``ssh_timeout`` setting may also be configured (as seconds) in the |knife rb| file.
* **New "seconds to wait before first chef-client run" setting** The ``-daemonized`` option for the |chef client| now allows the seconds to wait before starting the |chef client| run to be specified. For example, if ``--daemonize 10`` is specified, the |chef client| will wait ten seconds.


64-bit chef-client
-----------------------------------------------------
The |chef client| now runs on 64-bit |windows| operating systems. 

* Support for file redirection
* Support for key redirection

File Redirection
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_windows_file_redirection.rst

Key Redirection
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_notes/includes_notes_registry_key_redirection.rst

What's New in 12.8
=====================================================
The following items are new for |chef client| 12.8 and/or are changes from previous versions. The short version:

* **Support for OpenSSL validation of FIPS** The |chef client| can be configured to allow |open ssl| to enforce |fips|-validated security during a |chef client| run.
* **Support for multiple configuration files** The |chef client| supports reading multiple configuration files by putting them inside a ``.d`` configuration directory.
* **New launchd resource** Use the |resource launchd| resource to manage system-wide services (daemons) and per-user services (agents) on the |mac os x| platform.
* **chef-zero support for Chef Server API endpoints** |chef zero| now supports using all |api chef server| version 12 endpoints, with the exception of ``/universe``.
* **Updated support for OpenSSL** |open ssl| is updated to version 1.0.1.
* **Ohai auto-detects hosts for Azure instances** |ohai| will auto-detect hosts for instances that are hosted by |azure|.
* **gem attribute added to metadata.rb** Specify a gem dependency to be installed via the |resource chef_gem| resource after all cookbooks are synchronized, but before any other cookbook loading is done.


|fips| Mode
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_fips_mode.rst

Enable FIPS Mode
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_client/includes_chef_client_fips_mode_enable.rst

Command Option
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following command-line option may be used to with a |knife| or |chef client| executable command:

``--[no-]fips``
  |chef_client fips|

**Bootstrap a node using FIPS**

.. include:: ../../step_knife/step_knife_bootstrap_node_fips.rst

Configuration Setting
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following configuration setting may be set in the |knife rb|, |client rb|, or |config rb| files:

``fips``
  |chef_client fips| Set to ``true`` to enable |fips|-validated security.


.d Directories
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_client_dot_d_directories.rst


launchd
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_launchd.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_launchd_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_launchd_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_launchd_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Create a Launch Daemon from a cookbook file**

.. include:: ../../step_resource/step_resource_launchd_create_from_cookbook.rst

**Create a Launch Daemon using keys**

.. include:: ../../step_resource/step_resource_launchd_create_using_keys.rst

**Remove a Launch Daemon**

.. include:: ../../step_resource/step_resource_launchd_remove.rst

gem, metadata.rb
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_metadata_settings_gem.rst

What's New in 12.7
=====================================================
The following items are new for |chef client| 12.7 and/or are changes from previous versions. The short version:

* **Chef::REST => require 'chef/rest'** Internal API calls are moved from ``Chef::REST`` to ``Chef::ServerAPI``. Any code that uses ``Chef::REST`` must use ``require 'chef/rest'``.
* **New chocolatey_package resource** Use the |resource package_chocolatey| resource to manage packages using |chocolatey| for the |windows| platform.
* **New osx_profile resource** Use the |resource osx_profile| resource to manage configuration profiles (``.mobileconfig`` files) on the |mac os x| platform.
* **New apt_update resource** Use the |resource apt_update| resource to manage |apt| repository updates on |debian| and |ubuntu| platforms.
* **Improved support for UTF-8** The |chef client| 12.7 release fixes a UTF-8 handling bug present in |chef client| versions 12.4, 12.5, and 12.6.
* **New options for the chef-client** The |chef client| has a new option: ``--delete-entire-chef-repo``.
* **Multi-package support for Chocolatey and Zypper** A resource may specify multiple packages and/or versions for platforms that use |zypper| or |chocolatey| package managers (in addition to the existing support for specifying multiple packages for |yum| and |apt| packages).


Chef::REST => require 'chef/rest'
-----------------------------------------------------
Internal API calls are moved from ``Chef::REST`` to ``Chef::ServerAPI``. As a result of this move, ``Chef::REST`` is no longer globally required. Any code that uses ``Chef::REST`` must be required as follows:

.. code-block:: ruby

   require 'chef/rest'

For code that is run using |knife| or |chef ctl| command line interfaces, consider using ``Chef::ServerAPI`` instead.

chocolatey_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_chocolatey.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chocolatey_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chocolatey_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chocolatey_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Install a package**

.. include:: ../../step_resource/step_resource_chocolatey_package_install.rst


osx_profile
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_osx_profile.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_osx_profile_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_osx_profile_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_osx_profile_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**One liner to install profile from cookbook file**

.. include:: ../../step_resource/step_resource_osx_profile_install_file_oneline.rst

**Install profile from cookbook file**

.. include:: ../../step_resource/step_resource_osx_profile_install_file.rst

**Install profile from a hash**

.. include:: ../../step_resource/step_resource_osx_profile_install_hash.rst

**Remove profile using identifier in resource name**

.. include:: ../../step_resource/step_resource_osx_profile_remove_by_name.rst

**Remove profile by identifier and user friendly resource name**

.. include:: ../../step_resource/step_resource_osx_profile_remove_by_identifier.rst




apt_update
-----------------------------------------------------

.. include:: ../../includes_resources/includes_resource_apt_update.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_apt_update_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_apt_update_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_apt_update_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Update the Apt repository at a specified interval** 

.. include:: ../../step_resource/step_resource_apt_update_periodic.rst

**Update the Apt repository at the start of a chef-client run** 

.. include:: ../../step_resource/step_resource_apt_update_at_start_of_client_run.rst


New chef-client options
-----------------------------------------------------
The |chef client| has the following new options:

``--delete-entire-chef-repo``
   |chef_client delete_repo|

What's New in 12.6
=====================================================
The following items are new for |chef client| 12.6 and/or are changes from previous versions. The short version:

* **New timer for resource notifications** Use the ``:before`` timer with the ``notifies`` and ``subscribes`` properties to specify that the action on a notified resource should be run before processing the resource block in which the notification is located. 
* **New ksh resource** The |resource script_ksh| resource is added and is based on the |resource script| resource.
* **New metadata.rb settings** The |metadata rb| file has settings for ``chef_version`` and ``ohai_version`` that allow ranges to be specified that declare the supported versions of the |chef client| and |ohai|.
* **dsc_resource supports reboots** The |resource dsc_resource| resource supports immediate and queued reboots. This uses the |resource reboot| resource and its ``:reboot_now`` or ``:request_reboot`` actions.
* **New and changed knife bootstrap options** The ``--identify-file`` option for the ``knife bootstrap`` subcommand is renamed to ``--ssh-identity-file``; the ``--sudo-preserve-home`` is new.
* **New installer types for the windows_package resource** The |resource package_windows| resource now supports the following installer types: ``:custom``, |inno setup| (``:inno``), |installshield| (``:installshield``), |microsoft installer package| (``:msi``), |nsis| (``:nsis``), |wise| (``:wise``). Prior versions of |chef| supported only ``:msi``.
* **dsc_resource resource may be run in non-disabled refresh mode** The latest version of |windows management_framework| 5 has relaxed the limitation that prevented the |chef client| from running in non-disabled refresh mode. Requires |windows powershell| 5.0.10586.0 or higher.
* **dsc_script and dsc_resource resources may be in the same run-list** The latest version of |windows management_framework| 5 has relaxed the limitation that prevented the |chef client| from running in non-disabled refresh mode, which allows the Local Configuration Manager to be set to ``Push``. Requires |windows powershell| 5.0.10586.0 or higher.
* **New --profile-ruby option** Use the ``--profile-ruby`` option to dump a (large) profiling graph into ``/var/chef/cache/graph_profile.out``.
* **New live_stream property for the execute resource** Set the ``live_stream`` property to ``true`` to send the output of a command run by the |resource execute| resource to the |chef client| event stream.


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

What's New in 12.5
=====================================================
The following items are new for |chef client| 12.5 and/or are changes from previous versions. The short version:

* **New way to build custom resources** The process for extending the collection of resources that are built into |chef| has been simplified. It is defined only in the ``/resources`` directory using a simplified syntax that easily leverages the built-in collection of resources. (All of the ways you used to build custom resources still work.)
* **"resource attributes" are now known as "resource properties"** In previous releases of |chef|, resource properties are referred to as attributes, but this is confusing for users because nodes also have attributes. Starting with |chef client| 12.5 release---and retroactively updated for all previous releases of the documentation---"resource attributes" are now referred to as "resource properties" and the word "attribute" now refers specifically to "node attributes".
* **ps_credential helper to embed usernames and passwords** Use the ``ps_credential`` helper on |windows| to create a ``PSCredential`` object---security credentials, such as a user name or password---that can be used in the |resource dsc_script| resource.
* **New Handler DSL** A new DSL exists to make it easier to use events that occur during the |chef client| run from recipes. The ``on`` method is easily associated with events. The action the |chef client| takes as a result of that event (when it occurs) is up to you.
* **The -j / --json-attributes supports policy revisions and environments** The |json| file used by the ``--json-attributes`` option for the |chef client| may now contain the policy name and policy group associated with a policy revision or may contain the name of the environment to which the node is associated.
* **verify property now uses path, not file** The ``verify`` property, used by file-based resources such as |resource remote_file| and |resource file|, runs user-defined correctness checks against the proposed new file before making the change. For versions of the |chef client| prior to 12.5, the name of the temporary file was stored as ``file``; starting with |chef client| 12.5, use ``path``. This change is documented as a warning across all versions in any topic in which the ``version`` attribute is documented.
* **depth property added to deploy resource** The ``depth`` property allows the depth of a |git| repository to be truncated to the specified number of versions.
* **The knife ssl check subcommand supports SNI** Support for Server Name Indication (SNI) is added to the ``knife ssl check`` subcommand.
* **Chef Policy group and name can now be part of the node object** |chef| policy is a beta feature of the |chef client| that will eventually replace roles, environments or manually specifying the run_list. Policy group and name can now be stored as part of the node object rather than in the |client rb| file. A recent version of the |chef server|, such as 12.2.0 or higher, is needed to fully utilize this feature.


Custom Resources
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources.rst

.. note:: See https://docs.chef.io/custom_resources.html for more information about custom resources, including a scenario that shows how to build a ``website`` resource. Read this scenario as an HTML presentation at https://docs.chef.io/decks/custom_resources.html.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_custom_resources/includes_custom_resources_syntax.rst

.. include:: ../../includes_custom_resources/includes_custom_resources_syntax_example.rst


|dsl custom_resource|
-----------------------------------------------------
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource.rst

converge_if_changed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_converge_if_changed.rst

Multiple Properties
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_converge_if_changed_multiple.rst

default_action
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_default_action.rst

load_current_value
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_load_current_value.rst

new_resource.property
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_new_resource.rst

property
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_property.rst

desired_state
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_property_desired_state.rst

identity
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_property_identity.rst

Block Arguments
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_property_block_argument.rst

property_is_set?
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_property_is_set.rst

provides
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_provides.rst

override
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_provides_override.rst

reset_property
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_reset_property.rst


Definition vs. Resource
-----------------------------------------------------
.. include:: ../../includes_definition/includes_definition_example.rst

As a Definition
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_definition/includes_definition_example_as_definition.rst

As a Resource
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_definition/includes_definition_example_as_resource.rst

Common Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_definition/includes_definition_example_as_resource_with_common_properties.rst


ps_credential Helper
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_dsc_script_helper_ps_credential.rst


|dsl handler|
-----------------------------------------------------
.. include:: ../../includes_dsl_handler/includes_dsl_handler.rst

on Method
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_handler/includes_dsl_handler_method_on.rst

Example: Send Email
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_handler/includes_dsl_handler_slide_send_email.rst

.. note:: See https://docs.chef.io/dsl_handler.html for more information about using event handlers in recipes. Read the scenario for sending email if the |chef client| run fails as an HTML presentation at https://docs.chef.io/decks/event_handlers.html.

**Define How Email is Sent**

.. include:: ../../includes_dsl_handler/includes_dsl_handler_slide_send_email_library.rst

**Add the Handler**

.. include:: ../../includes_dsl_handler/includes_dsl_handler_slide_send_email_handler.rst

**Test the Handler**

.. include:: ../../includes_dsl_handler/includes_dsl_handler_slide_send_email_test.rst


New Resource Properties
-----------------------------------------------------
The following property is new for the |resource deploy| resource:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Property
     - Description
   * - ``depth``
     - **Ruby Type:** Integer

       |depth git_truncated|


Specify Policy Revision
-----------------------------------------------------
.. include:: ../../includes_policy/includes_policy_revision_specify.rst

New Configuration Settings
-----------------------------------------------------
The following settings are new for the |client rb| file and enable the use of policy files:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``named_run_list``
     - |run_list policy|
   * - ``policy_group``
     - |name policy_name| (See "Specify Policy Revision" in this readme for more information.)
   * - ``policy_name``
     - |name policy_group| (See "Specify Policy Revision" in this readme for more information.)


|chef client| Options
-----------------------------------------------------
The following options are new or updated for the |chef client| executable and enable the use of policy files:

``-n NAME``, ``--named-run-list NAME``
   |run_list policy|

``-j PATH``, ``--json-attributes PATH``
   This option now supports using a |json| file to associate a policy revision.

   .. include:: ../../includes_policy/includes_policy_ctl_run_list.rst

   This option also supports using a |json| file to associate an environment:

   .. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_environment.rst

What's New in 12.4
=====================================================
The following items are new for |chef client| 12.4 and/or are changes from previous versions. The short version:

* **Validatorless bootstrap now requires the node name** Use of the ``-N node_name`` option with a validatorless bootstrap is now required.
* **remote_file resource supports Windows UNC paths for source location** A |windows| UNC path may be used to specify the location of a remote file.
* **Run PowerShell commands without excessive quoting** Use the ``Import-Module chef`` module to run |windows powershell| commands without excessive quotation.
* **Logging may use the Windows Event Logger** Log files may be sent to the |windows event logger|. Set the ``log_location`` setting in the |client rb| file to ``Chef::Log::WinEvt.new``.
* **Logging may be configured to use daemon facility available to the chef-client** Log files may be sent to the syslog available to the |chef client|. Set the ``log_location`` setting in the |client rb| file to ``Chef::Log::Syslog.new("chef-client", ::Syslog::LOG_DAEMON)``.
* **Package locations on the Windows platform may be specified using a URL** The location of a package may be at URL when using the |resource package_windows| resource.
* **Package locations on the Windows platform may be specified by passing attributes to the remote_file resource** Use the ``remote_file_attributes`` attribute to pass a |ruby hash| of attributes that modifies the |resource remote_file| resource.
* **Public key management for users and clients** The ``knife client`` and ``knife user`` subcommands may now create, delete, edit, list, and show public keys.
* **knife client create and knife user create options have changed** With the new key management subcommands, the options for ``knife client create`` and ``knife user create`` have changed.
* **chef-client audit-mode is no longer marked as "experimental"** The recommended version of |chef client_audit| is |chef client| 12.4, where it is no longer marked as experimental. The |chef client| will report audit failures independently of converge failures.

UNC paths, |resource remote_file|
-----------------------------------------------------
When using the |resource remote_file| resource, the location of a source file may be specified using a |windows| UNC. For example:

.. code-block:: ruby

   source "\\\\path\\to\\img\\sketch.png"

Import-Module chef
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_common_windows_quotes_module.rst

|client rb| Settings
-----------------------------------------------------
The following settings have changed:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``log_location``
     - |log_location| Possible values: ``/path/to/log_location``, ``STDOUT``, ``STDERR``, ``Chef::Log::WinEvt.new`` (|windows event logger|), or ``Chef::Log::Syslog.new("chef-client", ::Syslog::LOG_DAEMON)`` (writes to the syslog daemon facility with the originator set as ``chef-client``). The application log will specify the source as ``Chef``. Default value: ``STDOUT``.

|resource package_windows| Updates
-----------------------------------------------------
The |resource package_windows| resource has two new attributes (``checksum`` and ``remote_file_attributes``) and the ``source`` attribute now supports using a URL:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Attribute
     - Description
   * - ``checksum``
     - |checksum remote_file| Use when a URL is specified by the ``source`` attribute.
   * - ``remote_file_attributes``
     - |remote_file_attributes|
   * - ``source``
     - Optional. |source resource package| The location of the package may be at a URL. Default value: the ``name`` of the resource block. |see syntax|

Examples:

**Specify a URL for the source attribute**

.. include:: ../../step_resource/step_resource_package_windows_source_url.rst

**Specify path and checksum**

.. include:: ../../step_resource/step_resource_package_windows_source_url_checksum.rst

**Modify remote_file resource attributes**

.. include:: ../../step_resource/step_resource_package_windows_source_remote_file_attributes.rst



knife client key
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_client.rst

key create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_client_key_create.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_client_key_create_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_client_key_create_options.rst

key delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_client_key_delete.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_client_key_delete_syntax.rst

key edit
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_client_key_edit.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_client_key_edit_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_client_key_edit_options.rst

key list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_client_key_list.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_client_key_list_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_client_key_list_options.rst

key show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_client_key_show.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_client_key_show_syntax.rst


knife user key
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_user.rst

key create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_key_create.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_user_key_create_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_user_key_create_options.rst

key delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_key_delete.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_user_key_delete_syntax.rst

key edit
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_key_edit.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_user_key_edit_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_user_key_edit_options.rst

key list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_key_list.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_user_key_list_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_user_key_list_options.rst

key show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_key_show.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_user_key_show_syntax.rst

Updated |knife| Options
-----------------------------------------------------
With the new key management subcommands, the options for ``knife client create`` and ``knife user create`` have changed.

knife client create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_client_create_options.rst

knife user create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_create_options.rst

What's New in 12.3
=====================================================
The following items are new for |chef client| 12.3 and/or are changes from previous versions. The short version:

* **Socketless local mode with chef-zero** Port binding and HTTP requests on localhost may be disabled in favor of socketless mode.
* **Minimal Ohai plugins** Run only the plugins required for name resolution and resource/provider detection.
* **Dynamic resource and provider resolution** Four helper methods may be used in a library file to get resource and/or provider mapping details, and then set them per-resource or provider.
* **New clear_soruces attribute for the chef_gem and gem_package resources** |clear_sources|

Socketless Local Mode
-----------------------------------------------------
The |chef client| may disable port binding and HTTP requests on localhost by making a socketless request to |chef zero|. This may be done from the command line or with a configuration setting.

Use the following command-line option:

``--[no-]listen``
   |chef_zero_no_listen| Use ``--no-listen`` to disable port binding and HTTP requests on localhost.

Or add the following setting to the |client rb| file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``listen``
     - |chef_zero_no_listen| Set to ``false`` to disable port binding and HTTP requests on localhost.

Minimal |ohai|
-----------------------------------------------------
The following option may be used with |chef client|, |chef solo|, and |chef apply| to speed up testing intervals:

``--minimal-ohai``
   |minimal_ohai|

This setting may be configured using the ``minimal_ohai`` setting in the |client rb| file.

Dynamic Resolution
-----------------------------------------------------
.. include:: ../../includes_libraries/includes_libraries_dynamic_resolution.rst

What's New in 12.2
=====================================================
The following items are new for |chef client| 12.2 and/or are changes from previous versions. The short version:

* **New dsc_resource** Use the |resource dsc_resource| resource to use any |windows powershell_dsc_short| resource in a |chef| recipe.
* **New --exit-on-error option for knife-ssh** Use the ``--exit-on-error`` option to have the ``knife ssh`` subcommand exit on any error.

dsc_resource
-----------------------------------------------------

.. include:: ../../includes_resources_common/includes_resources_common_powershell.rst

.. include:: ../../includes_resources_common/includes_resources_common_powershell_dsc.rst

.. include:: ../../includes_resources/includes_resource_dsc_resource.rst

.. warning:: .. include:: ../../includes_resources/includes_resource_dsc_resource_requirements.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_resource_syntax.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_resource_attributes_12-5.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Open a Zip file**

.. include:: ../../step_resource/step_resource_dsc_resource_zip_file.rst

**Manage users and groups**

.. include:: ../../step_resource/step_resource_dsc_resource_manage_users.rst

What's New in 12.1
=====================================================
The following items are new for |chef client| 12.1 and/or are changes from previous versions. The short version:

* **chef-client may be run in audit-mode** Use |chef client_audit| to run audit tests against a node.
* **control method added to Recipe DSL** Use the ``control`` method to define specific tests that match directories, files, packages, ports, and services. A ``control`` method must be contained within a ``control_group`` block.
* **control_group method added to Recipe DSL** Use the ``control_group`` method to group one (or more) ``control`` methods into a single audit.
* **Bootstrap nodes without using the ORGANIZATION-validator.key file** A node may now be bootstrapped using the |user pem| file, instead of the |organization pem| file. Also known as a "validatorless bootstrap".
* **New options for knife-bootstrap** Use the ``--bootstrap-vault-file``, ``--bootstrap-vault-item``, and ``--bootstrap-vault-json`` options with ``knife bootstrap`` to specify items that are stored in |chef vault|.
* **New verify attribute for cookbook_file, file, remote_file, and template resources** Use the ``verify`` attribute to test a file using a block of code or a string.
* **New imports attribute for dsc_script resource** Use the ``imports`` attribute to import |windows powershell_dsc_short| resources from modules.
* **New attribute for chef_gem resource** Use the ``compile_time`` attribute to disable compile-time installation of |gems|.
* **New openbsd_package resource** Use the |resource package_openbsd| resource to install packages on the |open bsd| platform.
* **New --proxy-auth option for knife raw subcommand** |proxy_auth|.
* **New watchdog_timeout setting for the Windows platform** Use the ``windows_service.watchdog_timeout`` setting in the |client rb| file to specify the maximum amount of time allowed for a |chef client| run on the |windows| platform.
* **Support for multiple packages and versions** Multiple packages and versions may be specified for platforms that use |yum| or |apt|.
* **New attributes for windows_service resource** Use the ``run_as_user`` and ``run_as_password`` attributes to specify the user under which a |windows| service should run.

|chef client|, |chef client_audit|
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_audit_mode.rst

Use following option to run the |chef client| in |chef client_audit| mode:

``--audit-mode MODE``
   |audit_mode| Default value: ``disabled``.

The Audit Run
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_client/includes_chef_client_audit_mode_run.rst

control
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_controls.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_syntax.rst

directory Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_directory.rst

file Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_file.rst

package Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_package.rst

port Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_port.rst

service Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_service.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**A package is installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_package_installed.rst

**A package version is installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_package_installed_version.rst

**A package is not installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_package_not_installed.rst

**A service is enabled**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_service_enabled.rst

**A configuration file contains specific settings**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_file_sshd_configuration.rst

**A file contains desired permissions and contents**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_file_permissions.rst

control_group
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_group.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_group_syntax.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**control_group block with multiple control blocks**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_group_many_controls.rst

**Duplicate control_group names**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_group_duplicate_names.rst

**Verify a package is installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_group_simple_recipe.rst

Validatorless Bootstrap
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_bootstrap_no_validator.rst

knife bootstrap Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the following options to specify items that are stored in |chef vault|:

``--bootstrap-vault-file VAULT_FILE``
   |bootstrap vault_file|

``--bootstrap-vault-item VAULT_ITEM``
   |bootstrap vault_item|

``--bootstrap-vault-json VAULT_JSON``
   |bootstrap vault_json|

   .. include:: ../../step_knife/step_knife_bootstrap_vault_json.rst

New Resource Attributes
-----------------------------------------------------
The following attributes are new for |chef client| 12.1.

verify
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``verify`` attribute may be used with the |resource cookbook_file|, |resource file|, |resource remote_file|, and |resource template| resources.

``verify``
   |verify_file|

   The following examples show how the ``verify`` attribute is used with the |resource template| resource. The same approach (but with different resource names) is true for the |resource cookbook_file|, |resource file|, and |resource remote_file| resources:

   .. include:: ../../includes_resources/includes_resource_template_attributes_verify.rst


imports
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following attribute is new for the |resource dsc_script| resource:

``imports``
   Use to import |windows powershell_dsc_short| resources from a module. To import all resources from a module, specify only the module name:

   .. code-block:: ruby

      imports "module_name"

   To import specific resources, specify the module name and then the name for each resource in that module to import:

   .. code-block:: ruby

      imports "module_name", "resource_name_a", "resource_name_b", ...

   For example, to import all resources from a module named ``cRDPEnabled``:

   .. code-block:: ruby

      imports "cRDPEnabled"

   And to import only the ``PSHOrg_cRDPEnabled`` resource:

   .. code-block:: ruby

      imports "cRDPEnabled", "PSHOrg_cRDPEnabled"


compile_time
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following attribute is new for the |resource chef_gem| resource:

``compile_time``
   |chef_gem compile_time| Possible values: ``nil`` (for verbose warnings), ``true`` (to warn once per |chef client| run), or ``false`` (to remove all warnings). Recommended value: ``false``.
   
   .. include:: ../../includes_resources/includes_resource_package_chef_gem_attribute_compile_time.rst 


run_as_
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following attributes are new for the |resource service_windows| resource:

``run_as_password``
   |password windows_service_run_as|

``run_as_user``
   |user windows_service_run_as|


paludis_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_paludis.rst

.. note:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_paludis_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_paludis_actions.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_paludis_attributes_12-5.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Install a package**

.. include:: ../../step_resource/step_resource_paludis_package_install.rst


openbsd_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_openbsd.rst

.. note:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_openbsd_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_openbsd_actions.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_openbsd_attributes_12-5.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Install a package**

.. include:: ../../step_resource/step_resource_openbsd_package_install.rst

New |client rb| Settings
-----------------------------------------------------
The following |client rb| settings are new:

``chef_gem_compile_time``
   |chef_gem compile_time| Recommended value: ``false``.

   .. note:: .. include:: ../../includes_resources/includes_resource_package_chef_gem_attribute_compile_time.rst

``windows_service.watchdog_timeout``
   |watchdog_timeout| Default value: ``2 * (60 * 60)``.

Multiple Packages and Versions
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_multiple_packages.rst

What's New in 12.0
=====================================================
The following items are new for |chef client| 12.0 and/or are changes from previous versions. The short version:

* **Changing attributes** Attributes may be modified for named precedence levels, all precedence levels, and be fully assigned. These changes were `based on RFC-23 <https://github.com/chef/chef-rfc/blob/master/rfc023-chef-12-attributes-changes.md>`_.
* **Ruby 2.0 (or higher) for Windows; and Ruby 2.1 (or higher) for Unix/Linux** |ruby| versions 1.8.7, 1.9.1, 1.9.2, and 1.9.3 are no longer supported. See `this blog post <https://www.chef.io/blog/2014/11/25/ruby-1-9-3-eol-and-chef-12/>`_ for more info.
* **The number of changes between Ruby 1.9 and 2.0 is small** Please review the `Ruby 2.0 release notes <https://github.com/ruby/ruby/blob/v2_0_0_0/NEWS>`_ or `Ruby 2.1 release notes <https://github.com/ruby/ruby/blob/v2_1_0/NEWS>`_ for the full list of changes.
* **provides method for building custom resources** Use the ``provides`` method to associate a custom resource with a built-in |chef client| resource and to specify platforms on which the custom resource may be used.
* **The chef-client supports the AIX platform** The |chef client| may now be used to configure nodes that are running on the |ibm aix| platform, versions 6.1 (TL6 or higher, recommended) and 7.1 (TL0 SP3 or higher, recommended). The |resource service| resource supports starting, stopping, and restarting services that are managed by |ibm aix_src|, as well as managing all service states with |berkeley os|-based init systems. 
* **New bff_package resource** Use the |resource package_bff| resource to install packages on the |ibm aix| platform.
* **New homebrew_package resource** Use the |resource package_homebrew| resource to install packages on the |mac os x| platform. The |resource package_homebrew| resource also replaces the |resource package_macports| resource as the default package installer on the |mac os x| platform.
* **New reboot resource** Use the |resource reboot| resource to reboot a node during or at the end of a |chef client| run.
* **New windows_service resource** Use the |resource service_windows| resource to manage services on the |windows| platform.
* **New --bootstrap-template option** Use the ``--bootstrap-template`` option to install the |chef client| with a bootstrap template. Specify the name of a template, such as ``chef-full``, or specify the path to a custom bootstrap template. This option deprecates the ``--distro`` and ``--template-file`` options.
* **New SSL options for bootstrap operations** The ``knife bootstrap`` subcommand has new options that support |ssl| with bootstrap operations. Use the ``--[no-]node-verify-api-cert`` option to to perform |ssl| validation of the connection to the |chef server|. Use the ``--node-ssl-verify-mode`` option to validate |ssl| certificates.
* **New format options for knife status** Use the ``--medium`` and ``--long`` options to include attributes in the output and to format that output as |json|.
* **New fsck_device property for mount resource** The |resource mount| resource supports |fsck| devices for the |solaris| platform with the ``fsck_device`` property.
* **New settings for metadata.rb** The |metadata rb| file has two new settings: ``issues_url`` and ``source_url``. These settings are used to capture the source location and issues tracking location for a cookbook. These settings are also used with |supermarket|. In addition, the ``name`` setting is now **required**.
* **The http_request GET and HEAD requests drop the hard-coded query string** |http_request query_string|
* **New Recipe DSL methods** The |dsl recipe| has three new methods: ``shell_out``, ``shell_out!``, and ``shell_out_with_systems_locale``.
* **File specificity updates** File specificity for the |resource template| and |resource cookbook_file| resources now supports using the ``source`` attribute to define an explicit lookup path as an array.
* **Improved user password security for the user resource, Mac OS X platform** The |resource user| resource now supports salted password hashes for |mac os x| 10.7 (and higher). Use the ``iterations`` and ``salt`` attributes to calculate SALTED-SHA512 password shadow hashes for |mac os x| version 10.7 and SALTED-SHA512-PBKDF2 password shadow hashes for version 10.8 (and higher).
* **data_bag_item method in the Recipe DSL supports encrypted data bag items** Use ``data_bag_item(bag_name, item, secret)`` to specify the secret to use for an encrypted data bag item. |secret_config|
* **value_for_platform method in the Recipe DSL supports version constraints** Version constraints---``>``, ``<``, ``>=``, ``<=``, ``~>``---may be used when specifying a version. An exception is raised if two version constraints match. An exact match will always take precedence over a match made from a version constraint.
* **knife cookbook site share supports --dry-run** Use the ``--dry-run`` option with the ``knife cookbook site`` to take no action and only print out results.
* **chef-client configuration setting updates** The |chef client| now supports running an override run-list (via the ``--override-runlist`` option) without clearing the cookbook cache on the node. In addition, the ``--chef-zero-port`` option allows specifying a range of ports.
* **Unforked interval runs are no longer allowed** The ``--[no-]fork`` option may no longer be used in the same command with the ``--daemonize`` and ``--interval`` options.
* **Splay and interval values are applied before the chef-client run** The ``--interval`` and ``--splay`` values are applied before the |chef client| run when using the |chef client| and |chef solo| executables.
* **All files and templates in a cookbook are synchronized at the start of the chef-client run** The ``no_lazy_load`` configuration setting in the |client rb| file now defaults to ``true``. This avoids issues where time-sensitive URLs in a cookbook manifest timeout before the |resource cookbook_file| or |resource template| resources converged.
* **File staging now defaults to the destination directory by default** Staging into a system's temporary directory---typically ``/tmp`` or ``/var/tmp``---as opposed to the destination directory may cause issues with permissions, available space, or cross-device renames. Files are now staged to the destination directory by default.
* **Partial search updates** Use ``:filter_result`` to build search results into a |ruby hash|. This replaces the previous functionality that was provided by the ``partial_search`` cookbook, albeit with a different API. Use the ``--filter-result`` option to return only attributes that match the specified filter. For example: ``\"ServerName=name, Kernel=kernel.version\"``.
* **Client-side key generation is enabled by default** When a new |chef client| is created using the validation client account, the |chef server| allows the |chef client| to generate a key-pair locally, and then send the public key to the |chef server|. This behavior is controlled by the ``local_key_generation`` attribute in the |client rb| file and now defaults to ``true``. 
* **New guard_interpreter property defaults** The ``guard_interpreter`` property now defaults to ``:batch`` for the |resource batch| resource and ``:powershell_script`` for the |resource powershell_script| resource.
* **Events are sent to the Application event log on the Windows platform by default** Events are sent to the |windows| "Application" event log at the start and end of a |chef client| run, and also if a |chef client| run fails. Set the ``disable_event_logger`` configuration setting in the |client rb| file to ``true`` to disable event logging.
* **The installer_type property for the windows_package resource uses a symbol instead of a string** Previous versions of the |chef client| (starting with version 11.8) used a string.
* **The path property is deprecated for the execute resource** Use the ``environment`` property instead.
* **SSL certificate validation improvements** The default settings for |ssl| certificate validation now default in favor of validation. In addition, using the ``knife ssl fetch`` subcommand is now an important part of setting up your workstation.
* **New property for git resource** The |resource scm_git| resource has a new property: ``environment``, which takes a |ruby hash| of environment variables in the form of ``{"ENV_VARIABLE" => "VALUE"}``.

Please `view the notes <https://docs.chef.io/upgrade_client_notes.html>`__ for more background on the upgrade process from |chef client| 11 to |chef client| 12.

Change Attributes
-----------------------------------------------------
.. include:: ../../includes_node/includes_node_attribute_change.rst

Remove Precedence Level
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_node/includes_node_attribute_change_remove_level.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_node/includes_node_attribute_change_remove_level_examples.rst

Remove All Levels
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_node/includes_node_attribute_change_remove_all.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_node/includes_node_attribute_change_remove_all_examples.rst

Full Assignment
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_node/includes_node_attribute_change_full_assignment.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_node/includes_node_attribute_change_full_assignment_examples.rst

provides Method
-----------------------------------------------------
.. include:: ../../includes_dsl_resource/includes_dsl_resource_method_provides.rst

|ibm aix| Platform Support
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_aix.rst

**System Requirements**

.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_aix_requirements.rst

**Install the chef-client on the AIX platform**

.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_aix_setup.rst

**Increase system process limits**

.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_aix_system_process_limits.rst

**Install the UTF-8 character set**

.. include:: ../../includes_install/includes_install_chef_client_aix_en_us.rst

**New providers**

.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_aix_providers.rst

**Enable a service on AIX using the mkitab command**

.. include:: ../../step_resource/step_resource_service_aix_mkitab.rst

Recipe DSL, Encrypted Data Bags
-----------------------------------------------------
.. include:: ../../includes_data_bag/includes_data_bag_recipes_load_using_recipe_dsl.rst

bff_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_bff.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_bff_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_bff_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_bff_attributes_12-5.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_bff_providers.rst

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Install a package**

.. include:: ../../step_resource/step_resource_bff_package_install.rst


homebrew_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_homebrew.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_homebrew_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_homebrew_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_homebrew_attributes_12-5.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_homebrew_providers.rst

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Install a package**

.. include:: ../../step_resource/step_resource_homebrew_package_install.rst

**Specify the Homebrew user with a UUID**

.. include:: ../../step_resource/step_resource_homebrew_package_homebrew_user_as_uuid.rst

**Specify the Homebrew user with a string**

.. include:: ../../step_resource/step_resource_homebrew_package_homebrew_user_as_string.rst


reboot
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_service_reboot.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_reboot_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_reboot_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_reboot_attributes_12-5.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_reboot_providers.rst

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Reboot a node immediately**

.. include:: ../../step_resource/step_resource_service_reboot_immediately.rst

**Reboot a node at the end of a chef-client run**

.. include:: ../../step_resource/step_resource_service_reboot_request.rst

**Cancel a reboot**

.. include:: ../../step_resource/step_resource_service_reboot_cancel.rst


windows_service
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_service_windows.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_windows_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_windows_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_windows_attributes_12-5.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_windows_providers.rst

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Start a service manually**

.. include:: ../../step_resource/step_resource_service_windows_manual_start.rst


knife bootstrap Settings
-----------------------------------------------------
The following options are new:

``--[no-]node-verify-api-cert``
   |ssl_verify_mode_verify_api_cert| If this option is not specified, the setting for ``verify_api_cert`` in the configuration file is applied.

``--node-ssl-verify-mode PEER_OR_NONE``
   |ssl_verify_mode|
 
   |ssl_verify_bootstrap_none|

   |ssl_verify_bootstrap_peer| This is the recommended setting.

``-t TEMPLATE``, ``--bootstrap-template TEMPLATE``
   |template bootstrap| Default value: ``chef-full``, which installs the |chef client| using the |omnibus installer| on all supported platforms.

   .. note:: The ``--distro`` and ``--template-file`` options are deprecated.


knife status Settings
-----------------------------------------------------
The following options are new:

``-l``, ``--long``
   |show_all_attributes|

``-m``, ``--medium``
   |medium|


fsck_device Property
-----------------------------------------------------
The following property is new for the |resource mount| resource:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``fsck_device``
     - |fsck_device| Default value: ``-``.

|metadata rb| Settings
-----------------------------------------------------
The following settings are new:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``issues_url``
     - |url cookbook_issues| For example:

       .. code-block:: ruby

          source_url "https://github.com/chef-cookbooks/chef-client/issues"

   * - ``source_url``
     - |url cookbook_source| For example:

       .. code-block:: ruby

          source_url "https://github.com/chef-cookbooks/chef-client"

.. warning:: The ``name`` attribute is now a required setting in the |metadata rb| file.

http_request Actions
-----------------------------------------------------
|http_request query_string|

|dsl recipe|
-----------------------------------------------------
The following methods have been added to the |dsl recipe|: ``shell_out``, ``shell_out!``, and ``shell_out_with_systems_locale``.

shell_out
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_shell_out.rst

shell_out!
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_shell_out_bang.rst

shell_out_with_systems_locale
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_shell_out_with_systems_locale.rst

value_for_platform
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``value_for_platform`` helper may use version constraints, such as ``>=`` and ``~>`` to help resolve situations where version numbers look like ``7.0.<buildnumber>``. For example:

.. code-block:: ruby

   value_for_platform(
     "redhat" => {
       "~> 7.0" => "version 7.x.y"
       ">= 8.0" => "version 8.0.0 and greater"
     }
   }

.. note:: When two version constraints match it is considered ambiguous and will raise an exception. An exact match, however, will always take precedence over a version constraint.

File Specificity
-----------------------------------------------------
The pattern for file specificity depends on two things: the lookup path and the source attribute. The first pattern that matches is used:

#. /host-$fqdn/$source
#. /$platform-$platform_version/$source
#. /$platform/$source
#. /default/$source
#. /$source

Use an array with the ``source`` attribute to define an explicit lookup path. For example:

.. code-block:: ruby

   file '/conf.py' do
     source ["#{node.chef_environment}.py", 'conf.py']
   end

or:

.. code-block:: ruby

   template '/test' do
     source ["#{node.chef_environment}.erb", 'default.erb']
   end


|mac os x|, Passwords
-----------------------------------------------------
The following properties are new for the |resource user| resource:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``iterations``
     - |iterations|
   * - ``salt``
     - |salt| |mac os x| version 10.7 uses SALTED-SHA512 and version 10.8 (and higher) uses SALTED-SHA512-PBKDF2 to calculate password shadow hashes. 

**Use SALTED-SHA512 passwords**

.. include:: ../../step_resource/step_resource_user_password_shadow_hash_salted_sha512.rst

**Use SALTED-SHA512-PBKDF2 passwords**

.. include:: ../../step_resource/step_resource_user_password_shadow_hash_salted_sha512_pbkdf2.rst


|chef client| Options
-----------------------------------------------------
The following options are updated for the |chef client| executable:

``--chef-zero-port PORT``
   |port chef_zero| If a port is not specified---individually or as range of ports from within the command---the |chef client| will scan for ports between 8889-9999 and will pick the first port that is available. This port or port range may also be specified using the ``chef_zero.port`` setting in the |client rb| file.

``-o RUN_LIST_ITEM``, ``--override-runlist RUN_LIST_ITEM``
   |override_runlist| This option will not clear the list of cookbooks (and related files) that is cached on the node.

The following configuration settings are updated for the |client rb| file and now default to ``true``:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``disable_event_logger``
     - |disable event_logging_windows| Default value: ``true``.
   * - ``no_lazy_load``
     - |no_lazy_load| Default value: ``true``.
   * - ``file_staging_uses_destdir``
     - |file_staging_uses_destdir| Default value: ``true``.
   * - ``local_key_generation``
     - Use to specify whether the |chef server| or |chef client| will generate the private/public key pair. When ``true``, the |chef client| will generate the key pair, and then send the public key to the |chef server|. Default value: ``true``.


Filter Search Results
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_search_filter_result.rst

knife search
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``knife search`` subcommand allows filtering search results with a new option:

``-f FILTER``, ``--filter-result FILTER``
   Use to return only attributes that match the specified ``FILTER``. For example: ``\"ServerName=name, Kernel=kernel.version\"``.

|resource execute| Resource, ``path`` Property
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_resource_execute_attribute_path.rst

|resource scm_git| Property
-----------------------------------------------------
The following property is new for the |resource scm_git| resource:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Property
     - Description
   * - ``environment``
     - |environment variables|

       .. note:: The |resource scm_git| provider automatically sets the ``ENV['HOME']`` and ``ENV['GIT_SSH']`` environment variables. To override this behavior and provide different values, add ``ENV['HOME']`` and/or ``ENV['GIT_SSH']`` to the ``environment`` |ruby hash|.

Chef::Provider, Custom Resources
-----------------------------------------------------
.. include:: ../../includes_dsl_provider/includes_dsl_provider_11-16_method_updated_by_last_action_example.rst

.. include:: ../../includes_dsl_provider/includes_dsl_provider_method_updated_by_last_action_example.rst

SSL Certificates
-----------------------------------------------------
.. include:: ../../includes_server_security/includes_server_security_ssl_cert_client.rst

See `SSL Certificates <https://docs.chef.io/chef_client_security.html#ssl-certificates>`__ for more information about how |knife| and the |chef client| use |ssl| certificates generated by the |chef server|.

Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
