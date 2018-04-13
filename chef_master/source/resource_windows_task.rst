==========================================
windows_task
==========================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_task.rst>`__

Use the **windows_task** resource to create, delete or run a Windows scheduled task. Requires Windows Server 2008 or later due to API usage.

**New in Chef Client 13**

.. note:: The ``windows_task`` resource that was provided as part of the ``windows`` cookbook included the ``:change`` action, which has been removed from ``windows_task`` in Chef client. The ``:create`` action can be used instead to update an existing task.

Syntax
==========================================
A **windows_task** resource creates, deletes or runs a Windows scheduled task.

.. code-block:: ruby

   windows_task 'name' do
     task_name                   String
     command                     String
     cwd                         String
     user                        String # defaults to SYSTEM
     password                    String
     run_level                   Symbol # defaults to :limited
     force                       True, False # defaults to false
     interactive_enabled         True, False # defaults to false
     frequency                   Symbol
     frequency_modifier          Integer, String # defaults to 1
     start_day                   String
     start_time                  String
     day                         String, Integer
     months                      String
     idle_time                   Integer
     random_delay                String, Integer
     execution_time_limit        String, Integer
     action                      Symbol #defaults to :create
   end

where

* ``windows_task`` is the resource.
* ``name`` is the name of the resource block.
* ``task_name`` is the name of the task.
* ``command`` is the command to be executed by the windows scheduled task.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state
* ``cwd``, ``user``, ``password``, ``run_level``, ``force``, ``interactive_enabled``, ``frequency``, ``frequency_modifier``, ``start_day``, ``start_time``, ``day``, ``months``, ``idle_time`` etc. are the properties of this resource, with the Ruby type shown. See the “Properties” section below for more information about all of the properties that may be used with this resource.

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
This resource has the following properties:

``task_name``
   **Ruby Type:** String

   The task name, such as ``"Task Name"`` or ``"/Task Name"``

``force``
   **Ruby Type:** True, False

   When used with create, will update the task.

``cwd``
   **Ruby Type:** String

   The directory the task will be run from.

``user``
   **Ruby Type:** String | **Default Value:** ``'SYSTEM'``

   The user to run the task as.

``password``
   **Ruby Type:** String

   The user's password. Requires user.

``run_level``
   **Ruby Type:** Symbol | **Default Value:** ``:limited``

   Run with ``:limited`` or ``:highest`` privileges.

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


``start_day``
   **Ruby Type:** String

   Specifies the first date on which the task runs in **MM/DD/YYYY** format.

``start_time``
   **Ruby Type:** String

   Specifies the start time to run the task, in **HH:mm** format.

``interactive_enabled``
   **Ruby Type:** True, False | **Default Value:** ``False``

   Allow task to run interactively or non-interactively. Requires user and password.

``day``
   **Ruby Type:** Integer, String

   The day(s) on which the task runs.
    * Use with frequency ``:monthly`` and ``:weekly`` tasks,
    * Valid values with frequency ``:weekly`` are ``MON-SUN`` or ``\*``.
    * Valid values with frequency ``:monthly`` are ``1-31 `` or ``MON`` to ``SUN`` and ``LASTDAY``.
       * Use ``MON-SUN`` or ``LASTDAY`` if you are setting ``frequency_modiifer`` as ``"FIRST, SECOND, THIRD etc."`` else use ``1-31``.
       * Multiple days should be comma seprated. e.g ``"1, 2, 3"`` or ``"MON, WEN, FRI"``.

``months``
   **Ruby Type:** String

   The Months of the year on which the task runs, such as: ``"JAN, FEB"`` or ``"\*"``. Multiple months should be comma delimited. e.g. ``"Jan, Feb, Mar, Dec"``

``idle_time``
   **Ruby Type:** Integer

   For ``:on_idle`` frequency, the time (in minutes) without user activity that must pass to trigger the task, from ``1`` - ``999``.

``execution_time_limit``
   **Ruby Type:** String | **Default Value:** ``PT72H`` (72 hours)

   The maximum time (in seconds) the task will run.

``random_delay``
   **Ruby Type:** Integer, String

   Delays the task upto given time (in seconds).


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
