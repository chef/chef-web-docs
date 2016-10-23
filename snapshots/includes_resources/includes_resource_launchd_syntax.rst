.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


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
