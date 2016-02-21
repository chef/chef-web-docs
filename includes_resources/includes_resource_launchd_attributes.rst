.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``backup``
   **Ruby Types:** Integer, FalseClass

   xxxxx

``cookbook``
   **Ruby Type:** String

   The name of the cookbook in which the source files are located.

``group``
   **Ruby Types:** String, Integer

   When |launchd| is run as the root user, the group to run the job as. If the ``username`` property is specified and this property is not, this value is set to the default group for the user.

``hash``
   **Ruby Type:** Hash

   xxxxx

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.

``label``
   **Ruby Type:** String

   The unique identifier for the job.

``mode``
   **Ruby Types:** Integer, String

   |mode resource| |mode resource_directory|
       
   The behavior is different depending on the platform.
       
   |unix|- and |linux|-based systems: |mode *nix|
       
   |windows|: |mode windows security|

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst

``owner``
   **Ruby Types:** Integer, String

   |owner windows security|
   
``path``
   **Ruby Type:** String

   |path directory| |path_fully_qualified| |resource_block_default| |see syntax|

``provider``
   **Ruby Type:** Chef::Provider::Launchd

   Optional. |provider resource_parameter| |see providers|

``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.

``session_type``
   **Ruby Type:** String

   The type of |launchd| plist to be created. Possible values: ``system`` (default) or ``user``.

``source``
   **Ruby Type:** String

   xxxxx

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

   |subscribes timers|

``supports``
   **Ruby Type:** Array

   |supports mount| Default value: ``{ :remount => false }``.

``type``
   **Ruby Type:** String

   xxxxx. Possible values: ``daemon`` (default), ``agent``.


The following resource properties may be used to define keys in the XML property list for a daemon or agent. Please refer to the |apple| man page documentation for |launchd| for more information about these keys:

``abandon_process_group``
   **Ruby Types:** TrueClass, FalseClass

   If a job dies, all remaining processes with the same process ID may be kept running. Set to ``true`` to kill all remaining processes.

``debug``
   **Ruby Types:** TrueClass, FalseClass

   Sets the log mask to ``LOG_DEBUG`` for this job.

``disabled``
   **Ruby Types:** TrueClass, FalseClass

   Hints to ``launchctl`` to not submit this job to |launchd|. Default value: ``false``.

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

   The amount of time (in seconds) |launchd| waits before sending a ``SIGKILL`` signal. Default value: ``20``.

``hard_resource_limits``
   **Ruby Type:** Hash

   A |ruby hash| of resource limits to be imposed on a job.

``inetd_compatibility``
   **Ruby Type:** Hash

   Specifies if a daemon expects to be run as if it were launched from ``inetd``. Set to ``wait => true`` to pass standard input, output, and error file descriptors. Set to ``wait => false`` to call the ``accept`` system call on behalf of the job, and then pass standard input, output, and error file descriptors.

``init_groups``
   **Ruby Types:** TrueClass, FalseClass

   Specify if ``initgroups`` is called before running a job. Default value: ``true`` (starting with |mac os x| 10.5).

``keep_alive``
   **Ruby Types:** TrueClass, FalseClass

   Keep a job running continuously (``true``) or allow demand and conditions on the node to determine if the job keeps running (``false``). Default value: ``false``.

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

   Keep a job alive. Only applies to |mac os x| version 10.4 (and earlier); use ``keep_alive`` instead for newer versions.

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

   A |ruby hash| of on-demand sockets that notify |launchd| when a job should be run.

``soft_resource_limits``
   **Ruby Type:** Array

   A |ruby hash| of resource limits to be imposed on a job.
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

   A |ruby hash| (similar to ``crontab``) that defines the calendar frequency at which a job is started. For example: ``{ minute => "0", hour => "20", day => "*", weekday => "1-5", month => "*" }`` will run a job at 8:00 PM every day, Monday through Friday, every month of the year.

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

   The amount of time (in seconds) a job may be idle before it times out. If no value is specified, the default timeout value for |launchd| will be used.

``umask``
   **Ruby Type:** Integer

   A decimal value to pass to ``umask`` before running a job.

``username``
   **Ruby Type:** String

   When |launchd| is run as the root user, the user to run the job as.

``wait_for_debugger``
   **Ruby Types:** TrueClass, FalseClass

   Specify if |launchd| has a job wait for a debugger to attach before executing code.

``watch_paths``
   **Ruby Type:** Array

   An array of paths which, if any are modified, will cause a job to be started.

``working_directory``
   **Ruby Type:** String

   ``chdir`` to this directory, and then run the job.
