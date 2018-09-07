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
    disallow_start_if_on_batteries      true, false # default value: false
    execution_time_limit                String, Integer # default value: PT72H
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
    run_level                           Symbol # default value: limited
    start_day                           String
    start_time                          String
    stop_if_going_on_batteries          true, false # default value: false
    task_name                           String # default value: 'name' unless specified
    user                                String # default value: SYSTEM
    action                              Symbol # defaults to :create if not specified
  end

where:

* ``windows_task`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``command``, ``cwd``, ``day``, ``disallow_start_if_on_batteries``, ``execution_time_limit``, ``force``, ``frequency``, ``frequency_modifier``, ``idle_time``, ``interactive_enabled``, ``minutes_duration``, ``minutes_interval``, ``months``, ``password``, ``priority``, ``random_delay``, ``run_level``, ``start_day``, ``start_time``, ``stop_if_going_on_batteries``, ``task_name``, and ``user`` are the properties available to this resource.

Actions
=====================================================
This resource has the following actions:

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

Properties
=====================================================

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
       * Use ``MON-SUN`` or ``LASTDAY`` if you are setting ``frequency_modiifer`` as ``"FIRST, SECOND, THIRD etc."`` else use ``1-31``.
       * Multiple days should be comma seprated. e.g ``"1, 2, 3"`` or ``"MON, WEN, FRI"``.

``disallow_start_if_on_batteries``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Disallow start of the task if the system is running on battery power.
   New in Chef Client 14.4.

``execution_time_limit``
   **Ruby Type:** String, Integer | **Default Value:** ``PT72H`` (72 hours)

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
      * e.g. If user want to run the task on ``second week of the month`` use ``frequency_modifier`` value as ``SECOND``. Multiple values for weeks of the month should be comma seperated e.g. ``"FIRST, THIRD, LAST"``.
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
   New in Chef Client 14.4.

``task_name``
   **Ruby Type:** String | **Default Value:** ``'name'``

   The task name, such as ``"Task Name"`` or ``"/Task Name"``

``user``
   **Ruby Type:** String | **Default Value:** ``SYSTEM``

   The user to run the task as.

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
