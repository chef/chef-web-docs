=====================================================
Release Notes: chef-client 12.6
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
.. tag resources_common_notification_timers

A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

``:immediate``, ``:immediately``
   Specifies that a notification should be run immediately, per resource notified.

.. end_tag

ksh
-----------------------------------------------------
.. tag resource_script_ksh

Use the **ksh** resource to execute scripts using the Korn shell (ksh) interpreter. This resource may also use any of the actions and properties that are available to the **execute** resource. Commands that are executed with this resource are (by their nature) not idempotent, as they are typically unique to the environment in which they are run. Use ``not_if`` and ``only_if`` to guard this resource for idempotence.

.. note:: The **ksh** script resource (which is based on the **script** resource) is different from the **ruby_block** resource because Ruby code that is run with this resource is created as a temporary file and executed like other script resources, rather than run inline.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_script_ksh_syntax

A **ksh** resource block executes scripts using ksh:

.. code-block:: ruby

   ksh 'hello world' do
     code <<-EOH
       echo "Hello world!"
       echo "Current directory: " $cwd
       EOH
   end

where

* ``code`` specifies the command to run

The full syntax for all of the properties that are available to the **ksh** resource is:

.. code-block:: ruby

   ksh 'name' do
     code                       String
     creates                    String
     cwd                        String
     environment                Hash
     flags                      String
     group                      String, Integer
     notifies                   # see description
     path                       Array
     provider                   Chef::Provider::Script::Ksh
     returns                    Integer, Array
     subscribes                 # see description
     timeout                    Integer, Float
     user                       String, Integer
     umask                      String, Integer
     action                     Symbol # defaults to :run if not specified
   end

where

* ``ksh`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``code``, ``creates``, ``cwd``, ``environment``, ``flags``, ``group``, ``path``, ``provider``, ``returns``, ``timeout``, ``user``, and ``umask`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_script_ksh_actions

This resource has the following actions:

``:nothing``
   Prevent a command from running. This action is used to specify that a command is run only when another resource notifies it.

``:run``
   Default. Run a script.

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_script_ksh_attributes

This resource has the following properties:

``code``
   **Ruby Type:** String

   A quoted (" ") string of code to be executed.

``creates``
   **Ruby Type:** String

   Prevent a command from creating a file when that file already exists.

``cwd``
   **Ruby Type:** String

   The current working directory.

``environment``
   **Ruby Type:** Hash

   A Hash of environment variables in the form of ``({"ENV_VARIABLE" => "VALUE"})``. (These variables must exist for a command to be run successfully.)

``flags``
   **Ruby Type:** String

   One or more command line flags that are passed to the interpreter when a command is invoked.

``group``
   **Ruby Types:** String, Integer

   The group name or group ID that must be changed before running a command.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_notifies

   A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notifiy more than one resource; use a ``notifies`` statement for each resource to be notified.

   .. end_tag

   .. tag resources_common_notification_timers

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:before``
      Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_notifies_syntax

   The syntax for ``notifies`` is:

   .. code-block:: ruby

      notifies :action, 'resource[name]', :timer

   .. end_tag

``path``
   **Ruby Type:** Array

   An array of paths to use when searching for a command. These paths are not added to the command's environment $PATH. The default value uses the system path.

   .. warning:: .. tag resources_common_resource_execute_attribute_path

                The ``path`` property is not implemented by any provider in any version of the chef-client. Starting with chef-client 12, using the ``path`` property will return a warning. Starting with chef-client 13, the ``path`` property is deprecated and using it will return an exception. Cookbooks that currently use the ``path`` property should be updated to use the ``environment`` property instead.

                .. end_tag

      For example:

      .. code-block:: ruby

         ksh 'mycommand' do
           environment 'PATH' => "/my/path/to/bin:#{ENV['PATH']}"
         end

``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider. See "Providers" section below for more information.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``returns``
   **Ruby Types:** Integer, Array

   The return value for a command. This may be an array of accepted values. An exception is raised when the return value(s) do not match. Default value: ``0``.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_subscribes

   A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

   .. end_tag

   .. tag resources_common_notification_timers

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:before``
      Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_subscribes_syntax

   The syntax for ``subscribes`` is:

   .. code-block:: ruby

      subscribes :action, 'resource[name]', :timer

   .. end_tag

``timeout``
   **Ruby Types:** Integer, Float

   The amount of time (in seconds) a command is to wait before timing out. Default value: ``3600``.

``user``
   **Ruby Types:** String, Integer

   The user name or user ID that should be changed before running a command.

``umask``
   **Ruby Types:** String, Integer

   The file mode creation mask, or umask.

.. end_tag

Changes for PowerShell 5.0.10586.0
-----------------------------------------------------
.. tag resource_dsc_resource_requirements

Using the **dsc_resource** has the following requirements:

* Windows Management Framework (WMF) 5.0 February Preview (or higher), which includes Windows PowerShell 5.0.10018.0 (or higher).
* The ``RefreshMode`` configuration setting in the Local Configuration Manager must be set to ``Disabled``.

  **NOTE:** Starting with the chef-client 12.6 release, this requirement applies only for versions of Windows PowerShell earlier than 5.0.10586.0. The latest version of Windows Management Framework (WMF) 5 has relaxed the limitation that prevented the chef-client from running in non-disabled refresh mode.

* The **dsc_script** resource  may not be used in the same run-list with the **dsc_resource**. This is because the **dsc_script** resource requires that ``RefreshMode`` in the Local Configuration Manager be set to ``Push``, whereas the **dsc_resource** resource requires it to be set to ``Disabled``.

  **NOTE:** Starting with the chef-client 12.6 release, this requirement applies only for versions of Windows PowerShell earlier than 5.0.10586.0. The latest version of Windows Management Framework (WMF) 5 has relaxed the limitation that prevented the chef-client from running in non-disabled refresh mode, which allows the Local Configuration Manager to be set to ``Push``.

* The **dsc_resource** resource can only use binary- or script-based resources. Composite DSC resources may not be used.

  This is because composite resources aren't "real" resources from the perspective of the the Local Configuration Manager (LCM). Composite resources are used by the "configuration" keyword from the ``PSDesiredStateConfiguration`` module, and then evaluated in that context. When using DSC to create the configuration document (the Managed Object Framework (MOF) file) from the configuration command, the composite resource is evaluated. Any individual resources from that composite resource are written into the Managed Object Framework (MOF) document. As far as the Local Configuration Manager (LCM) is concerned, there is no such thing as a composite resource. Unless that changes, the **dsc_resource** resource and/or ``Invoke-DscResource`` command cannot directly use them.

.. end_tag

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

       .. tag config_rb_metadata_settings_example_chef_version

       For example, to match any 12.x version of the chef-client, but not 11.x or 13.x:

       .. code-block:: ruby

          chef_version "~> 12"

       Or matches any 12.x (or higher) version of the chef-client:

       .. code-block:: ruby

          chef_version ">= 12"

       Or matches any version of the chef-client greater than 12.5.1, any 13.x version, but no 14.x versions:

       .. code-block:: ruby

          chef_version ">= 12.5.1", "< 14.0"

       Or matches any version of the chef-client greater than or equal to 11.18.4 and less than 12.0 and also any version of the chef-client greater than or equal to 12.5.1, but less than 13.0:

       .. code-block:: ruby

          chef_version ">= 11.18.12", "< 12.0"
          chef_version ">= 12.5.1", "< 13.0"

       .. end_tag

   * - ``ohai_version``
     - A range of chef-client versions that are supported by this cookbook.

       .. tag config_rb_metadata_settings_example_ohai_version

       For example, to match any 8.x version of Ohai, but not 7.x or 9.x:

       .. code-block:: ruby

          ohai_version "~> 8"

       Or matches any 8.x (or higher) version of Ohai:

       .. code-block:: ruby

          ohai_version ">= 8"

       .. end_tag

.. note:: These settings are not visible in Chef Supermarket.

knife bootstrap Options
-----------------------------------------------------
The following option is new for ``knife bootstrap``:

``--sudo-preserve-home``
   Use to preserve the non-root user's ``HOME`` environment.

The ``--identify-file`` option is now ``--ssh-identify-file``.

--profile-ruby Option
-----------------------------------------------------
.. tag ctl_chef_client_profile_ruby

Use the ``--profile-ruby`` option to dump a (large) profiling graph into ``/var/chef/cache/graph_profile.out``. Use the graph output to help identify, and then resolve performance bottlenecks in a chef-client run. This option:

* Generates a large amount of data about the chef-client run
* Has a dependency on the ``ruby-prof`` gem, which is packaged as part of Chef and the Chef development kit
* Increases the amount of time required to complete the chef-client run
* Should not be used in a production environment

.. end_tag

Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
