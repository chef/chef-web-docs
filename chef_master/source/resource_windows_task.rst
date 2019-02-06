=====================================================
windows_task resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_task.rst>`__

Use the **windows_task** resource to create, delete or run a Windows scheduled task. Requires Windows Server 2008 or later due to API usage.

**New in Chef Client 13.0.**

.. note:: The ``windows_task`` resource that was provided as part of the ``windows`` cookbook included the ``:change`` action, which has been removed from ``windows_task`` in Chef client. The ``:create`` action can be used instead to update an existing task.

Syntax
=====================================================
The windows_task resource has the following syntax:

.. code-block:: ruby

  windows_task 'name' do
    command                             String
    cwd                                 String
    day                                 String, Integer
    description                         String
    disallow_start_if_on_batteries      true, false # default value: false
    execution_time_limit                String, Integer # default value: "PT72H"
    force                               true, false # default value: false
    frequency                           Symbol
    frequency_modifier                  Integer, String # default value: 1
    idle_time                           Integer
    interactive_enabled                 true, false # default value: false
    minutes_duration                    String, Integer
    minutes_interval                    String, Integer
    months                              String
    password                            String
    priority                            Integer # default value: 7
    random_delay                        String, Integer
    run_level                           Symbol # default value: :limited
    start_day                           String
    start_time                          String
    stop_if_going_on_batteries          true, false # default value: false
    task_name                           String # default value: 'name' unless specified
    user                                String # default value: The localized SYSTEM user for the node.
    action                              Symbol # defaults to :create if not specified
  end

where:

* ``windows_task`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``command``, ``cwd``, ``day``, ``description``, ``disallow_start_if_on_batteries``, ``execution_time_limit``, ``force``, ``frequency``, ``frequency_modifier``, ``idle_time``, ``interactive_enabled``, ``minutes_duration``, ``minutes_interval``, ``months``, ``password``, ``priority``, ``random_delay``, ``run_level``, ``start_day``, ``start_time``, ``stop_if_going_on_batteries``, ``task_name``, and ``user`` are the properties available to this resource.

Actions
=====================================================

The windows_task resource has the following actions:

``:create``
   Creates a task, or updates an existing task if any property has changed.

``:delete``
   Deletes a task.

``:run``
   Runs a task.

``:end``
   Ends a task.

``:enable``
   Enables a task.

``:disable``
   Disables a task.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================

The windows_task resource has the following properties:

``command``
   **Ruby Type:** String

   The command to be executed by the windows scheduled task.

``cwd``
   **Ruby Type:** String

   The directory the task will be run from.

``day``
   **Ruby Type:** String, Integer

   The day(s) on which the task runs.
    * Use with frequency ``:monthly`` and ``:weekly`` tasks,
    * Valid values with frequency ``:weekly`` are ``MON-SUN`` or ``\*``.
    * Valid values with frequency ``:monthly`` are ``1-31 `` or ``MON`` to ``SUN`` and ``LASTDAY``.
       * Use ``MON-SUN`` or ``LASTDAY`` if you are setting ``frequency_modifier`` as ``"FIRST, SECOND, THIRD etc."`` else use ``1-31``.
       * Multiple days should be comma separated. e.g ``"1, 2, 3"`` or ``"MON, WEN, FRI"``.

``description``
   **Ruby Type:** String

   The task description.

   *New in Chef Client 14.7.*

``disallow_start_if_on_batteries``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Disallow start of the task if the system is running on battery power.

   *New in Chef Client 14.4.*

``execution_time_limit``
   **Ruby Type:** String, Integer | **Default Value:** ``"PT72H"`` (72 hours)

   The maximum time (in seconds) the task will run.

``force``
   **Ruby Type:** true, false | **Default Value:** ``false``

   When used with create, will update the task.

``frequency``
   **Ruby Type:** Symbol

   * Frequency with which to run the task.
   * This is a mandatory property in Chef 14.1
   * Valid values: ``:minute``, ``:hourly``, ``:daily``, ``:weekly``, ``:monthly``, ``:none``, ``:once``, ``:on_logon``, ``:onstart``, ``:on_idle``.
   * The ``:once`` value requires the ``start_time`` property.
   * The ``:none`` frequency requires Chef 13.6 or later.

``frequency_modifier``
   **Ruby Type:** Integer, String | **Default Value:** ``1``

   * For frequency ``:minute`` valid values are 1 to 1439
   * For frequency ``:hourly`` valid values are 1 to 23
   * For frequency ``:daily`` valid values are 1 to 365
   * For frequency ``:weekly`` valid values are 1 to 52
   * For frequency ``:monthly`` valid values are ``('FIRST', 'SECOND', 'THIRD', 'FOURTH', 'LAST')`` OR ``1-12``.
      * e.g. If user want to run the task on ``second week of the month`` use ``frequency_modifier`` value as ``SECOND``. Multiple values for weeks of the month should be comma separated e.g. ``"FIRST, THIRD, LAST"``.
      * To run task every (n) months user values '1-12'.

``idle_time``
   **Ruby Type:** Integer

   For ``:on_idle`` frequency, the time (in minutes) without user activity that must pass to trigger the task, from ``1`` - ``999``.

``interactive_enabled``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Allow task to run interactively or non-interactively. Requires user and password to also be set.

``minutes_duration``
   **Ruby Type:** String, Integer

``minutes_interval``
   **Ruby Type:** String, Integer

``months``
   **Ruby Type:** String

   The Months of the year on which the task runs, such as: ``"JAN, FEB"`` or ``"\*"``. Multiple months should be comma delimited. e.g. ``"Jan, Feb, Mar, Dec"``

``password``
   **Ruby Type:** String

   The user’s password. The user property must be set if using this property.

``priority``
   **Ruby Type:** Integer | **Default Value:** ``7``

   Use to set Priority Levels range from 0 to 10.

``random_delay``
   **Ruby Type:** String, Integer

   Delays the task up to a given time (in seconds).

``run_level``
  **Ruby Type:** Symbol | **Default Value:** ``:limited``

  Run with ``:limited`` or ``:highest`` privileges.

``start_day``
   **Ruby Type:** String

   Specifies the first date on which the task runs in **MM/DD/YYYY** format.

``start_time``
   **Ruby Type:** String

   Specifies the start time to run the task, in **HH:mm** format.

``stop_if_going_on_batteries``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Scheduled task option when system is switching on battery.

   *New in Chef Client 14.4.*

``task_name``
   **Ruby Type:** String | **Default Value:** ``The resource block's name``

   An optional property to set the task name if it differs from the resource block's name. Example: 'Task Name' or '/Task Name'

``user``
   **Ruby Type:** String | **Default Value:** ``"The localized SYSTEM user for the node."``

   The user to run the task as.

Common Resource Functionality
=====================================================

Chef resources include common properties, notifications, and resource guards.

Common Properties
-----------------------------------------------------

.. tag resources_common_properties

The following properties are common to every resource:

``ignore_failure``
  **Ruby Type:** true, false | **Default Value:** ``false``

  Continue running a recipe if a resource fails for any reason.

``retries``
  **Ruby Type:** Integer | **Default Value:** ``0``

  The number of attempts to catch exceptions and retry the resource.

``retry_delay``
  **Ruby Type:** Integer | **Default Value:** ``2``

  The retry delay (in seconds).

``sensitive``
  **Ruby Type:** true, false | **Default Value:** ``false``

  Ensure that sensitive resource data is not logged by the chef-client.

.. end_tag

Notifications
-----------------------------------------------------

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

Guards
-----------------------------------------------------

.. tag resources_common_guards

A guard property can be used to evaluate the state of a node during the execution phase of the chef-client run. Based on the results of this evaluation, a guard property is then used to tell the chef-client if it should continue executing a resource. A guard property accepts either a string value or a Ruby block value:

* A string is executed as a shell command. If the command returns ``0``, the guard is applied. If the command returns any other value, then the guard property is not applied. String guards in a **powershell_script** run Windows PowerShell commands and may return ``true`` in addition to ``0``.
* A block is executed as Ruby code that must return either ``true`` or ``false``. If the block returns ``true``, the guard property is applied. If the block returns ``false``, the guard property is not applied.

A guard property is useful for ensuring that a resource is idempotent by allowing that resource to test for the desired state as it is being executed, and then if the desired state is present, for the chef-client to do nothing.

.. end_tag
.. tag resources_common_guards_properties

The following properties can be used to define a guard that is evaluated during the execution phase of the chef-client run:

``not_if``
  Prevent a resource from executing when the condition returns ``true``.

``only_if``
  Allow a resource to execute only if the condition returns ``true``.

.. end_tag

Examples
=====================================================

.. tag windows_task_examples

**Create a scheduled task to run every 15 minutes as the Administrator user**

.. code-block:: ruby

   windows_task 'chef-client' do
     user 'Administrator'
     password 'password'
     command 'chef-client'
     run_level :highest
     frequency :minute
     frequency_modifier 15
   end

**Create a scheduled task to run every 2 days**

.. code-block:: ruby

   windows_task 'chef-client' do
     command 'chef-client'
     run_level :highest
     frequency :daily
     frequency_modifier 2
   end

**Create a scheduled task to run on specific days of the week**

.. code-block:: ruby

   windows_task 'chef-client' do
     command 'chef-client'
     run_level :highest
     frequency :weekly
     day 'Mon, Thu'
   end

**Create a scheduled task to run only once**

.. code-block:: ruby

   windows_task 'chef-client' do
     command 'chef-client'
     run_level :highest
     frequency :once
     start_time "16:10"
   end

**Create a scheduled task to run on current day every 3 weeks and delay upto 1 min**

.. code-block:: ruby

   windows_task 'chef-client' do
     command 'chef-client'
     run_level :highest
     frequency :weekly
     frequency_modifier 3
     random_delay '60'
   end

**Create a scheduled task to run weekly starting on Dec 28th 2018**

.. code-block:: ruby

   windows_task 'chef-client 8' do
     command 'chef-client'
     run_level :highest
     frequency :weekly
     start_day '12/28/2018'
   end

**Create a scheduled task to run every Monday, Friday every 2 weeks**

.. code-block:: ruby

   windows_task 'chef-client' do
     command 'chef-client'
     run_level :highest
     frequency :weekly
     frequency_modifier 2
     day 'Mon, Fri'
   end

**Create a scheduled task to run when computer is idle with idle duration 20 min**

.. code-block:: ruby

   windows_task 'chef-client' do
     command 'chef-client'
     run_level :highest
     frequency :on_idle
     idle_time 20
   end

**Delete a task named "old task"**

.. code-block:: ruby

   windows_task 'old task' do
     action :delete
   end

**Enable a task named "chef-client"**

.. code-block:: ruby

   windows_task 'chef-client' do
     action :enable
   end

**Disable a task named "ProgramDataUpdater" with TaskPath "\\Microsoft\\Windows\\Application Experience\\ProgramDataUpdater"**

.. code-block:: ruby

   windows_task '\Microsoft\Windows\Application Experience\ProgramDataUpdater' do
     action :disable
   end

.. end_tag
