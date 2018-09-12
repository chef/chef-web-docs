=====================================================
launchd resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_launchd.rst>`__

Use the **launchd** resource to manage system-wide services (daemons) and per-user services (agents) on the macOS platform.

**New in Chef Client 12.8.**

Syntax
=====================================================
The launchd resource has the following syntax:

.. code-block:: ruby

  launchd 'name' do
    abandon_process_group           true, false
    backup                          Integer, false
    cookbook                        String
    debug                           true, false
    disabled                        true, false # default value: false
    enable_globbing                 true, false
    enable_transactions             true, false
    environment_variables           Hash
    exit_timeout                    Integer
    group                           String, Integer
    hard_resource_limits            Hash
    inetd_compatibility             Hash
    init_groups                     true, false
    keep_alive                      true, false, Hash
    label                           String # default value: 'name' unless specified
    launch_only_once                true, false
    ld_group                        String
    limit_load_from_hosts           Array
    limit_load_to_hosts             Array
    limit_load_to_session_type      Array, String
    low_priority_io                 true, false
    mach_services                   Hash
    mode                            String, Integer
    nice                            Integer
    on_demand                       true, false
    owner                           String, Integer
    path                            String
    plist_hash                      Hash
    process_type                    String
    program                         String
    program_arguments               Array
    queue_directories               Array
    root_directory                  String
    run_at_load                     true, false
    session_type                    String
    sockets                         Hash
    soft_resource_limits            Array
    source                          String
    standard_error_path             String
    standard_in_path                String
    standard_out_path               String
    start_calendar_interval         Hash, Array
    start_interval                  Integer
    start_on_mount                  true, false
    throttle_interval               Integer
    time_out                        Integer
    type                            String # default value: daemon
    umask                           Integer
    username                        String
    wait_for_debugger               true, false
    watch_paths                     Array
    working_directory               String
    action                          Symbol # defaults to :create if not specified
  end

where:

* ``launchd`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``abandon_process_group``, ``backup``, ``cookbook``, ``debug``, ``disabled``, ``enable_globbing``, ``enable_transactions``, ``environment_variables``, ``exit_timeout``, ``group``, ``hard_resource_limits``, ``inetd_compatibility``, ``init_groups``, ``keep_alive``, ``label``, ``launch_only_once``, ``ld_group``, ``limit_load_from_hosts``, ``limit_load_to_hosts``, ``limit_load_to_session_type``, ``low_priority_io``, ``mach_services``, ``mode``, ``nice``, ``on_demand``, ``owner``, ``path``, ``plist_hash``, ``process_type``, ``program``, ``program_arguments``, ``queue_directories``, ``root_directory``, ``run_at_load``, ``session_type``, ``sockets``, ``soft_resource_limits``, ``source``, ``standard_error_path``, ``standard_in_path``, ``standard_out_path``, ``start_calendar_interval``, ``start_interval``, ``start_on_mount``, ``throttle_interval``, ``time_out``, ``type``, ``umask``, ``username``, ``wait_for_debugger``, ``watch_paths``, and ``working_directory`` are the properties available to this resource.

Actions
=====================================================
.. tag resource_launchd_actions

The launchd resource has the following actions:

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

``:restart``
   Restart a launchd managed daemon or agent.

.. end_tag

Properties
=====================================================
.. tag resource_launchd_attributes

This resource has the following properties:

``backup``
   **Ruby Types:** Integer, False

   The number of backups to be kept in ``/var/chef/backup``. Set to ``false`` to prevent backups from being kept.

``cookbook``
   **Ruby Type:** String

   The name of the cookbook in which the source files are located.

``group``
   **Ruby Types:** String, Integer

   When launchd is run as the root user, the group to run the job as. If the ``username`` property is specified and this property is not, this value is set to the default group for the user.

``ignore_failure``
   **Ruby Types:** True, False

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``label``
   **Ruby Type:** String

   The unique identifier for the job.

``mode``
   **Ruby Types:** Integer, String

   A quoted 3-5 character string that defines the octal mode. For example: ``'755'``, ``'0755'``, or ``00755``. Default value: ``'0755'``

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_notifies

   A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notify more than one resource; use a ``notifies`` statement for each resource to be notified.

   .. end_tag

   .. tag resources_common_notification_timers

   A timer specifies the point during the Chef Client run at which a notification is run. The following timers are available:

   ``:before``
      Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the end of the Chef Client run.

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

``plist_hash``
   **Ruby Type:** Hash

   A Hash of key value pairs used to create the launchd property list.

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

   Note that ``subscribes`` does not apply the specified action to the resource that it listens to - for example:

   .. code-block:: ruby

     file '/etc/nginx/ssl/example.crt' do
        mode '0600'
        owner 'root'
     end

     service 'nginx' do
        subscribes :reload, 'file[/etc/nginx/ssl/example.crt]', :immediately
     end

   In this case the ``subscribes`` property reloads the ``nginx`` service whenever its certificate file, located under ``/etc/nginx/ssl/example.crt``, is updated. ``subscribes`` does not make any changes to the certificate file itself, it merely listens for a change to the file, and executes the ``:reload`` action for its resource (in this example ``nginx``) when a change is detected.

   .. end_tag

   .. tag resources_common_notification_timers

   A timer specifies the point during the Chef Client run at which a notification is run. The following timers are available:

   ``:before``
      Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the end of the Chef Client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_subscribes_syntax

   The syntax for ``subscribes`` is:

   .. code-block:: ruby

      subscribes :action, 'resource[name]', :timer

   .. end_tag

``supports``
   **Ruby Type:** Hash

   Specify a Hash of supported mount features. Default value: ``remount: false``.

``type``
   **Ruby Type:** String

   The type of resource. Possible values: ``daemon`` (default), ``agent``.

The following resource properties may be used to define keys in the XML property list for a daemon or agent. Please refer to the Apple man page documentation for launchd for more information about these keys:

``abandon_process_group``
   **Ruby Types:** True, False

   If a job dies, all remaining processes with the same process ID may be kept running. Set to ``true`` to kill all remaining processes.

``debug``
   **Ruby Types:** True, False

   Sets the log mask to ``LOG_DEBUG`` for this job.

``disabled``
   **Ruby Types:** True, False

   Hints to ``launchctl`` to not submit this job to launchd. Default value: ``false``.

``enable_globbing``
   **Ruby Types:** True, False

   Update program arguments before invocation.

``enable_transactions``
   **Ruby Types:** True, False

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
   **Ruby Types:** True, False

   Specify if ``initgroups`` is called before running a job. Default value: ``true``.

``keep_alive``
   **Ruby Types:** True, False, Hash

   Keep a job running continuously (``true``) or allow demand and conditions on the node to determine if the job keeps running (``false``). Default value: ``false``.

``launch_only_once``
   **Ruby Types:** True, False

   Specify if a job can be run only one time. Set this value to ``true`` if a job cannot be restarted without a full machine reboot.

``limit_load_from_hosts``
   **Ruby Type:** Array

   An array of hosts to which this configuration file does not apply, i.e. "apply this configuration file to all hosts not specified in this array".

``limit_load_to_hosts``
   **Ruby Type:** Array

   An array of hosts to which this configuration file applies.

``limit_load_to_session_type``
   **Ruby Type:** Array, String

   The session type(s) to which this configuration file applies.

``low_priority_io``
   **Ruby Types:** True, False

   Specify if the kernel on the node should consider this daemon to be low priority during file system I/O.

``mach_services``
   **Ruby Type:** Hash

   Specify services to be registered with the bootstrap subsystem.

``nice``
   **Ruby Type:** Integer

   The program scheduling priority value in the range ``-20`` to ``20``.

``on_demand``
   **Ruby Types:** True, False

   Keep a job alive. Only applies to macOS version 10.4 (and earlier); use ``keep_alive`` instead for newer versions.

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
   **Ruby Types:** True, False

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

   A Hash (similar to ``crontab``) that defines the calendar frequency at which a job is started. For example: ``{ Minute => "0", Hour => "20", Day => "*", Weekday => "1-5", Month => "*" }`` will run a job at 8:00 PM every day, Monday through Friday, every month of the year.

``start_interval``
   **Ruby Type:** Integer

   The frequency (in seconds) at which a job is started.

``start_on_mount``
   **Ruby Types:** True, False

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
   **Ruby Types:** True, False

   Specify if launchd has a job wait for a debugger to attach before executing code.

``watch_paths``
   **Ruby Type:** Array

   An array of paths which, if any are modified, will cause a job to be started.

``working_directory``
   **Ruby Type:** String

   ``chdir`` to this directory, and then run the job.

.. end_tag

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

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
     start_calendar_interval 'Weekday' => 7, 'Hourly' => 10
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
