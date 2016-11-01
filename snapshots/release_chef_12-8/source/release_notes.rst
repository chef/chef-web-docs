=====================================================
Release Notes: chef-client 12.8
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
The following items are new for chef-client 12.8 and/or are changes from previous versions. The short version:

* **Support for OpenSSL validation of FIPS** The chef-client can be configured to allow OpenSSL to enforce FIPS-validated security during a chef-client run.
* **Support for multiple configuration files** The chef-client supports reading multiple configuration files by putting them inside a ``.d`` configuration directory.
* **New launchd resource** Use the **launchd** resource to manage system-wide services (daemons) and per-user services (agents) on the Mac OS X platform.
* **chef-zero support for Chef Server API endpoints** chef-zero now supports using all Chef server API version 12 endpoints, with the exception of ``/universe``.
* **Updated support for OpenSSL** OpenSSL is updated to version 1.0.1.
* **Ohai auto-detects hosts for Azure instances** Ohai will auto-detect hosts for instances that are hosted by Microsoft Azure.
* **gem attribute added to metadata.rb** Specify a gem dependency to be installed via the **chef_gem** resource after all cookbooks are synchronized, but before any other cookbook loading is done.

FIPS Mode
-----------------------------------------------------
.. tag chef_client_fips_mode

Federal Information Processing Standards (FIPS) is a United States government computer security standard that specifies security requirements for cryptography. The current version of the standard is FIPS 140-2. The chef-client can be configured to allow OpenSSL to enforce FIPS-validated security during a chef-client run. This will disable cryptography that is explicitly disallowed in FIPS-validated software, including certain ciphers and hashing algorithms. Any attempt to use any disallowed cryptography will cause the chef-client to throw an exception during a chef-client run.

.. note:: Chef uses MD5 hashes to uniquely identify files that are stored on the Chef server. MD5 is used only to generate a unique hash identifier and is not used for any cryptographic purpose.

Notes about FIPS:

* May be enabled for nodes running on Microsoft Windows and Enterprise Linux platforms
* Should only be enabled for environments that require FIPS 140-2 compliance
* May not be enabled for any version of the chef-client earlier than 12.8

.. end_tag

Enable FIPS Mode
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Allowing OpenSSL to enforce FIPS-validated security may be enabled by using any of the following ways:

* Set the ``fips`` configuration setting to ``true`` in the client.rb or knife.rb files
* Set the ``--fips`` command-line option when running any knife command or the chef-client executable
* Set the ``--fips`` command-line option when bootstrapping a node using the ``knife bootstrap`` command

Command Option
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following command-line option may be used to with a knife or chef-client executable command:

``--[no-]fips``
  Allows OpenSSL to enforce FIPS-validated security during the chef-client run.

**Bootstrap a node using FIPS**

.. tag knife_bootstrap_node_fips

.. To bootstrap a node:

.. code-block:: bash

   $ knife bootstrap 12.34.56.789 -P vanilla -x root -r 'recipe[apt],recipe[xfs],recipe[vim]' --fips

which shows something similar to:

.. code-block:: none

   OpenSSL FIPS 140 mode enabled
   ...
   12.34.56.789 Chef Client finished, 12/12 resources updated in 78.942455583 seconds

.. end_tag

Configuration Setting
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following configuration setting may be set in the knife.rb, client.rb, or config.rb files:

``fips``
  Allows OpenSSL to enforce FIPS-validated security during the chef-client run. Set to ``true`` to enable FIPS-validated security.

.d Directories
-----------------------------------------------------
.. tag config_rb_client_dot_d_directories

The chef-client supports reading multiple configuration files by putting them inside a ``.d`` configuration directory. For example: ``/etc/chef/client.d``. All files that end in ``.rb`` in the ``.d`` directory are loaded; other non-``.rb`` files are ignored.

``.d`` directories may exist in any location where the ``client.rb``, ``config.rb``, or ``solo.rb`` files are present, such as:

* ``/etc/chef/client.d``
* ``/etc/chef/config.d``
* ``~/chef/solo.d``
* ``c:/chef/config.d``

(There is no support for a ``knife.d`` directory; use ``config.d`` instead.)

For example, when using knife, the following configuration files would be loaded:

* ``~/.chef/config.rb``
* ``~/.chef/config.d/company_settings.rb``
* ``~/.chef/config.d/ec2_configuration.rb``
* ``~/.chef/config.d/old_settings.rb.bak``

The ``old_settings.rb.bak`` file is ignored because it's not a configuration file. The ``config.rb``, ``company_settings.rb``, and ``ec2_configuration`` files are merged together as if they are a single configuration file.

.. note:: If multiple configuration files exists in a ``.d`` directory, ensure that the same setting has the same value in all files.

.. end_tag

launchd
-----------------------------------------------------
.. tag resource_launchd_6

Use the **launchd** resource to manage system-wide services (daemons) and per-user services (agents) on the Mac OS X platform.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_launchd_syntax

A **launchd** resource manages system-wide services (daemons) and per-user services (agents) on the Mac OS X platform:

.. code-block:: ruby

   launchd 'call.mom.weekly' do
     program '/Library/scripts/call_mom.sh'
     start_calendar_interval 'weekday' => 7, 'hourly' => 10
     time_out 300
   end

The full syntax for all of the properties that are available to the **launchd** resource is:

.. code-block:: ruby

   launchd 'name' do
     abandon_process_group      TrueClass, FalseClass
     backup                     Integer, FalseClass
     cookbook                   String
     debug                      TrueClass, FalseClass
     disabled                   TrueClass, FalseClass
     enable_globbing            TrueClass, FalseClass
     enable_transactions        TrueClass, FalseClass
     environment_variables      Hash
     exit_timeout               Integer
     group                      String, Integer
     hard_resource_limits       Hash
     hash                       Hash
     ignore_failure             TrueClass, FalseClass
     inetd_compatibility        Hash
     init_groups                TrueClass, FalseClass
     keep_alive                 TrueClass, FalseClass
     label                      String
     launch_only_once           TrueClass, FalseClass
     limit_load_from_hosts      Array
     limit_load_to_hosts        Array
     limit_load_to_session_type String
     low_priority_io            TrueClass, FalseClass
     mach_services              Hash
     mode                       Integer, String
     nice                       Integer
     notifies                   # see description
     on_demand                  TrueClass, FalseClass
     owner                      Integer, String
     path                       String
     process_type               String
     program                    String
     program_arguments          Array
     provider                   Chef::Provider::Launchd
     queue_directories          Array
     retries                    Integer
     retry_delay                Integer
     root_directory             String
     run_at_load                TrueClass, FalseClass
     sockets                    Hash
     soft_resource_limits       Array
     standard_error_path        String
     standard_in_path           String
     standard_out_path          String
     start_calendar_interval    Hash
     start_interval             Integer
     start_on_mount             TrueClass, FalseClass
     subscribes                 # see description
     throttle_interval          Integer
     time_out                   Integer
     type                       String
     umask                      Integer
     username                   String
     wait_for_debugger          TrueClass, FalseClass
     watch_paths                Array
     working_directory          String
     action                     Symbol # defaults to :create if not specified
   end

where

* ``launchd`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``abandon_process_group``, ``backup``, ``cookbook``, ``debug``, ``disabled``, ``enable_globbing``, ``enable_transactions``, ``environment_variables``, ``exit_timeout``, ``group``, ``hard_resource_limits``, ``hash``, ``inetd_compatibility``, ``init_groups``, ``keep_alive``, ``label``, ``launch_only_once``, ``limit_load_from_hosts``, ``limit_load_to_hosts``, ``limit_load_to_session_type``, ``low_priority_io``, ``mach_services``, ``mode``, ``nice``, ``on_demand``, ``owner``, ``path``, ``process_type``, ``program``, ``program_arguments``, ``queue_directories``, ``retries``, ``retry_delay``, ``root_directory``, ``run_at_load``, ``sockets``, ``soft_resource_limits``, ``standard_error_path``, ``standard_in_path``, ``standard_out_path``, ``start_calendar_interval``, ``start_interval``, ``start_on_mount``, ``throttle_interval``, ``time_out``, ``type``, ``umask``, ``username``, ``wait_for_debugger``, ``watch_paths``, and ``working_directory`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_launchd_actions

This resource has the following actions:

``:create``
   Default. Create a launchd property list.

``:create_if_missing``
   Create a launchd property list, if it does not already exist.

``:delete``
   Delete a launchd property list. This will unload a daemon or agent, if loaded.

``:disable``
   Disable a launchd property list.

``:enable``
   Create a launchd property list, and then ensure that it is enabled. If a launchd property list already exists, but does not match, updates the property list to match, and then restarts the daemon or agent.

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_launchd_attributes

This resource has the following properties:

``backup``
   **Ruby Types:** Integer, FalseClass

   The number of backups to be kept in ``/var/chef/backup``. Set to ``false`` to prevent backups from being kept.

``cookbook``
   **Ruby Type:** String

   The name of the cookbook in which the source files are located.

``group``
   **Ruby Types:** String, Integer

   When launchd is run as the root user, the group to run the job as. If the ``username`` property is specified and this property is not, this value is set to the default group for the user.

``hash``
   **Ruby Type:** Hash

   A Hash of key value pairs used to create the launchd property list.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``label``
   **Ruby Type:** String

   The unique identifier for the job.

``mode``
   **Ruby Types:** Integer, String

   A quoted 3-5 character string that defines the octal mode. For example: ``'755'``, ``'0755'``, or ``00755``. If ``mode`` is not specified and if the directory already exists, the existing mode on the directory is used. If ``mode`` is not specified, the directory does not exist, and the ``:create`` action is specified, the chef-client assumes a mask value of ``'0777'``, and then applies the umask for the system on which the directory is to be created to the ``mask`` value. For example, if the umask on a system is ``'022'``, the chef-client uses the default value of ``'0755'``.

   The behavior is different depending on the platform.

   UNIX- and Linux-based systems: A quoted 3-5 character string that defines the octal mode that is passed to chmod. For example: ``'755'``, ``'0755'``, or ``00755``. If the value is specified as a quoted string, it works exactly as if the ``chmod`` command was passed. If the value is specified as an integer, prepend a zero (``0``) to the value to ensure that it is interpreted as an octal number. For example, to assign read, write, and execute rights for all users, use ``'0777'`` or ``'777'``; for the same rights, plus the sticky bit, use ``01777`` or ``'1777'``.

   Microsoft Windows: A quoted 3-5 character string that defines the octal mode that is translated into rights for Microsoft Windows security. For example: ``'755'``, ``'0755'``, or ``00755``. Values up to ``'0777'`` are allowed (no sticky bits) and mean the same in Microsoft Windows as they do in UNIX, where ``4`` equals ``GENERIC_READ``, ``2`` equals ``GENERIC_WRITE``, and ``1`` equals ``GENERIC_EXECUTE``. This property cannot be used to set ``:full_control``. This property has no effect if not specified, but when it and ``rights`` are both specified, the effects are cumulative.

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

``owner``
   **Ruby Types:** Integer, String

   A string or ID that identifies the group owner by user name, including fully qualified user names such as ``domain\user`` or ``user@domain``. If this value is not specified, existing owners remain unchanged and new owner assignments use the current user (when necessary).

``path``
   **Ruby Type:** String

   The path to the directory. Using a fully qualified path is recommended, but is not always required. Default value: the ``name`` of the resource block See "Syntax" section above for more information.

``provider``
   **Ruby Type:** Chef::Provider::Launchd

   Optional. Explicitly specifies a provider. See "Providers" section below for more information.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``session_type``
   **Ruby Type:** String

   The type of launchd plist to be created. Possible values: ``system`` (default) or ``user``.

``source``
   **Ruby Type:** String

   The path to the launchd property list.

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

``supports``
   **Ruby Type:** Array

   An array of options for supported mount features. Default value: ``{ :remount => false }``.

``type``
   **Ruby Type:** String

   The type of resource. Possible values: ``daemon`` (default), ``agent``.

The following resource properties may be used to define keys in the XML property list for a daemon or agent. Please refer to the Apple man page documentation for launchd for more information about these keys:

``abandon_process_group``
   **Ruby Types:** TrueClass, FalseClass

   If a job dies, all remaining processes with the same process ID may be kept running. Set to ``true`` to kill all remaining processes.

``debug``
   **Ruby Types:** TrueClass, FalseClass

   Sets the log mask to ``LOG_DEBUG`` for this job.

``disabled``
   **Ruby Types:** TrueClass, FalseClass

   Hints to ``launchctl`` to not submit this job to launchd. Default value: ``false``.

``enable_globbing``
   **Ruby Types:** TrueClass, FalseClass

   Update program arguments before invocation.

``enable_transactions``
   **Ruby Types:** TrueClass, FalseClass

   Track in-progress transactions; if none, then send the ``SIGKILL`` signal.

``environment_variables``
   **Ruby Type:** Hash

   Additional environment variables to set before running a job.

``exit_timeout``
   **Ruby Type:** Integer

   The amount of time (in seconds) launchd waits before sending a ``SIGKILL`` signal. Default value: ``20``.

``hard_resource_limits``
   **Ruby Type:** Hash

   A Hash of resource limits to be imposed on a job.

``inetd_compatibility``
   **Ruby Type:** Hash

   Specifies if a daemon expects to be run as if it were launched from ``inetd``. Set to ``wait => true`` to pass standard input, output, and error file descriptors. Set to ``wait => false`` to call the ``accept`` system call on behalf of the job, and then pass standard input, output, and error file descriptors.

``init_groups``
   **Ruby Types:** TrueClass, FalseClass

   Specify if ``initgroups`` is called before running a job. Default value: ``true`` (starting with Mac OS X 10.5).

``keep_alive``
   **Ruby Types:** TrueClass, FalseClass, Hash

   Keep a job running continuously (``true``) or allow demand and conditions on the node to determine if the job keeps running (``false``). Default value: ``false``.

   Hash type was added in Chef client 12.14.

``launch_only_once``
   **Ruby Types:** TrueClass, FalseClass

   Specify if a job can be run only one time. Set this value to ``true`` if a job cannot be restarted without a full machine reboot.

``limit_load_from_hosts``
   **Ruby Type:** Array

   An array of hosts to which this configuration file does not apply, i.e. "apply this configuration file to all hosts not specified in this array".

``limit_load_to_hosts``
   **Ruby Type:** Array

   An array of hosts to which this configuration file applies.

``limit_load_to_session_type``
   **Ruby Type:** String

   The session type to which this configuration file applies.

``low_priority_io``
   **Ruby Types:** TrueClass, FalseClass

   Specify if the kernel on the node should consider this daemon to be low priority during file system I/O.

``mach_services``
   **Ruby Type:** Hash

   Specify services to be registered with the bootstrap subsystem.

``nice``
   **Ruby Type:** Integer

   The program scheduling priority value in the range ``-20`` to ``20``.

``on_demand``
   **Ruby Types:** TrueClass, FalseClass

   Keep a job alive. Only applies to Mac OS X version 10.4 (and earlier); use ``keep_alive`` instead for newer versions.

``process_type``
   **Ruby Type:** String

   The intended purpose of the job: ``Adaptive``, ``Background``, ``Interactive``, or ``Standard``.

``program``
   **Ruby Type:** String

   The first argument of ``execvp``, typically the file name associated with the file to be executed. This value must be specified if ``program_arguments`` is not specified, and vice-versa.

``program_arguments``
   **Ruby Type:** Array

   The second argument of ``execvp``. If ``program`` is not specified, this property must be specified and will be handled as if it were the first argument.

``queue_directories``
   **Ruby Type:** Array

   An array of non-empty directories which, if any are modified, will cause a job to be started.

``root_directory``
   **Ruby Type:** String

   ``chroot`` to this directory, and then run the job.

``run_at_load``
   **Ruby Types:** TrueClass, FalseClass

   Launch a job once (at the time it is loaded). Default value: ``false``.

``sockets``
   **Ruby Type:** Hash

   A Hash of on-demand sockets that notify launchd when a job should be run.

``soft_resource_limits``
   **Ruby Type:** Array

   A Hash of resource limits to be imposed on a job.
``standard_error_path``
   **Ruby Type:** String

   The file to which standard error (``stderr``) is sent.

``standard_in_path``
   **Ruby Type:** String

   The file to which standard input (``stdin``) is sent.

``standard_out_path``
   **Ruby Type:** String

   The file to which standard output (``stdout``) is sent.

``start_calendar_interval``
   **Ruby Type:** Hash

   A Hash (similar to ``crontab``) that defines the calendar frequency at which a job is started. For example: ``{ minute => "0", hour => "20", day => "*", weekday => "1-5", month => "*" }`` will run a job at 8:00 PM every day, Monday through Friday, every month of the year.

``start_interval``
   **Ruby Type:** Integer

   The frequency (in seconds) at which a job is started.

``start_on_mount``
   **Ruby Types:** TrueClass, FalseClass

   Start a job every time a file system is mounted.

``throttle_interval``
   **Ruby Type:** Integer

   The frequency (in seconds) at which jobs are allowed to spawn. Default value: ``10``.

``time_out``
   **Ruby Type:** Integer

   The amount of time (in seconds) a job may be idle before it times out. If no value is specified, the default timeout value for launchd will be used.

``umask``
   **Ruby Type:** Integer

   A decimal value to pass to ``umask`` before running a job.

``username``
   **Ruby Type:** String

   When launchd is run as the root user, the user to run the job as.

``wait_for_debugger``
   **Ruby Types:** TrueClass, FalseClass

   Specify if launchd has a job wait for a debugger to attach before executing code.

``watch_paths``
   **Ruby Type:** Array

   An array of paths which, if any are modified, will cause a job to be started.

``working_directory``
   **Ruby Type:** String

   ``chdir`` to this directory, and then run the job.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Create a Launch Daemon from a cookbook file**

.. tag resource_launchd_create_from_cookbook

.. Create a Launch Daemon from a cookbook file:

.. code-block:: ruby

   launchd 'com.chef.every15' do
     source 'com.chef.every15.plist'
   end

.. end_tag

**Create a Launch Daemon using keys**

.. tag resource_launchd_create_using_keys

.. Create a Launch Daemon using keys**

.. code-block:: ruby

   launchd 'call.mom.weekly' do
     program '/Library/scripts/call_mom.sh'
     start_calendar_interval 'weekday' => 7, 'hourly' => 10
     time_out 300
   end

.. end_tag

**Remove a Launch Daemon**

.. tag resource_launchd_remove

.. Remove a Launch Daemon:

.. code-block:: ruby

   launchd 'com.chef.every15' do
     action :delete
   end

.. end_tag

gem, metadata.rb
-----------------------------------------------------
.. tag config_rb_metadata_settings_gem

Specifies a gem dependency to be installed via the **chef_gem** resource after all cookbooks are synchronized, but before any other cookbook loading is done. Use this attribute once per gem dependency. For example:

.. code-block:: ruby

   gem "poise"
   gem "chef-sugar"
   gem "chef-provisioning"

.. end_tag

Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
