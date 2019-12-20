=====================================================
cron resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_cron.rst>`__

Use the **cron** resource to manage cron entries for time-based job scheduling.

.. warning:: The **cron** resource should only be used to modify an entry in a crontab file. The ``cron_d`` resource directly manages cron.d files. This resource ships in Chef 14.4 or later and can also be found in the `cron <https://github.com/chef-cookbooks/cron>`__ cookbook) for previous chef-client releases.



Syntax
=====================================================
A **cron** resource block manages cron entries. For example, to get a weekly cookbook report from the Chef Supermarket:

.. code-block:: ruby

   cron 'cookbooks_report' do
     action :create
     minute '0'
     hour '0'
     weekday '1'
     user 'getchef'
     mailto 'sysadmin@example.com'
     home '/srv/supermarket/shared/system'
     command %W{
       cd /srv/supermarket/current &&
       env RUBYLIB="/srv/supermarket/current/lib"
       RAILS_ASSET_ID=`git rev-parse HEAD` RAILS_ENV="#{rails_env}"
       bundle exec rake cookbooks_report
     }.join(' ')
   end

The full syntax for all of the properties that are available to the **cron** resource is:

.. code-block:: ruby

  cron 'name' do
    command          String
    day
    environment      Hash
    home             String
    hour
    mailto           String
    minute
    month
    path             String
    shell            String
    time             Symbol
    user             String # default value: "root"
    weekday          
    action           Symbol # defaults to :create if not specified
  end

where:

* ``cron`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps Chef Infra Client will take to bring the node into the desired state.
* ``command``, ``day``, ``environment``, ``home``, ``hour``, ``mailto``, ``minute``, ``month``, ``path``, ``shell``, ``time``, ``user``, and ``weekday`` are the properties available to this resource.

Actions
=====================================================

The cron resource has the following actions:

``:create``
   Default. Create an entry in a cron table file (crontab). If an entry already exists (but does not match), update that entry to match.

``:delete``
   Delete an entry from a cron table file (crontab).

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of a Chef Infra Client run.

   .. end_tag

.. note:: Chef Infra Client can only reliably manage crontab entries that it creates. To remove existing system entries we may use **execute** resource with a guard like:

  .. code-block:: ruby

    execute "remove foo_daemon from crontab" do
      command "sed -i '/foo_daemon/d' /etc/crontab"
      only_if "grep 'foo_daemon' /etc/crontab 2>&1 >/dev/null"
    end

Properties
=====================================================

The cron resource has the following properties:

``command``
   **Ruby Type:** String

   The command to be run, or the path to a file that contains the command to be run.

   Some examples:

   .. code-block:: none

      command if [ -x /usr/share/mdadm/checkarray ] && [ $(date +\%d) -le 7 ];
      then /usr/share/mdadm/checkarray --cron --all --idle --quiet; fi

   and:

   .. code-block:: ruby

      command %w{
        cd /srv/opscode-community-site/current &&
        env RUBYLIB="/srv/opscode-community-site/current/lib"
        RAILS_ASSET_ID=`git rev-parse HEAD` RAILS_ENV="#{rails_env}"
        bundle exec rake cookbooks_report
      }.join(' ')

   and:

   .. code-block:: ruby

      command "/srv/app/scripts/daily_report"

``day``
   **Ruby Type:** String | **Default Value:** ``*``

   The day of month at which the cron entry should run (1 - 31).

``environment``
   **Ruby Type:** Hash

   A Hash of environment variables in the form of ``({'ENV_VARIABLE' => 'VALUE'})``. (These variables must exist for a command to be run successfully.)

``home``
   **Ruby Type:** String

   Set the ``HOME`` environment variable.

``hour``
   **Ruby Type:** String | **Default Value:** ``*``

   The hour at which the cron entry is to run (0 - 23).

``mailto``
   **Ruby Type:** String

   Set the ``MAILTO`` environment variable.

``minute``
   **Ruby Type:** String | **Default Value:** ``*``

   The minute at which the cron entry should run (0 - 59).

``month``
   **Ruby Type:** String | **Default Value:** ``*``

   The month in the year on which a cron entry is to run (1 - 12).

``path``
   **Ruby Type:** String

   Set the ``PATH`` environment variable.

``shell``
   **Ruby Type:** String

   Set the ``SHELL`` environment variable.

``time``
   **Ruby Type:** Symbol

   A time interval. Possible values: ``:annually``, ``:daily``, ``:hourly``, ``:midnight``, ``:monthly``, ``:reboot``, ``:weekly``, or ``:yearly``.

``user``
   **Ruby Type:** String | **Default Value:** ``"root"``

   The name of the user that runs the command. If the user property is changed, the original user for the crontab program continues to run until that crontab program is deleted. This property is not applicable on the AIX platform.

``weekday``
   **Ruby Type:** String | **Default Value:** ``*``

   The day of the week on which this entry is to run (0 - 6), where Sunday = 0.

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

  Ensure that sensitive resource data is not logged by Chef Infra Client.

.. end_tag

Notifications
-----------------------------------------------------

``notifies``
  **Ruby Type:** Symbol, 'Chef::Resource[String]'

  .. tag resources_common_notification_notifies

  A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notify more than one resource; use a ``notifies`` statement for each resource to be notified.

  .. end_tag

.. tag resources_common_notification_timers

A timer specifies the point during a Chef Infra Client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the end of a Chef Infra Client run.

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

A timer specifies the point during a Chef Infra Client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the end of a Chef Infra Client run.

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

A guard property can be used to evaluate the state of a node during the execution phase of a Chef Infra Client run. Based on the results of this evaluation, a guard property is then used to tell Chef Infra Client if it should continue executing a resource. A guard property accepts either a string value or a Ruby block value:

* A string is executed as a shell command. If the command returns ``0``, the guard is applied. If the command returns any other value, then the guard property is not applied. String guards in a **powershell_script** run Windows PowerShell commands and may return ``true`` in addition to ``0``.
* A block is executed as Ruby code that must return either ``true`` or ``false``. If the block returns ``true``, the guard property is applied. If the block returns ``false``, the guard property is not applied.

A guard property is useful for ensuring that a resource is idempotent by allowing that resource to test for the desired state as it is being executed, and then if the desired state is present, for Chef Infra Client to do nothing.

.. end_tag

**Properties**

.. tag resources_common_guards_properties

The following properties can be used to define a guard that is evaluated during the execution phase of a Chef Infra Client run:

``not_if``
  Prevent a resource from executing when the condition returns ``true``.

``only_if``
  Allow a resource to execute only if the condition returns ``true``.

.. end_tag

Examples
=====================================================

The following examples demonstrate various approaches for using resources in recipes:

**Run a program at a specified interval**

.. To run a program on the fifth hour of the day:

.. code-block:: ruby

   cron 'noop' do
     hour '5'
     minute '0'
     command '/bin/true'
   end



**Run an entry if a folder exists**

.. To run an entry if a folder exists:

.. code-block:: ruby

   cron 'ganglia_tomcat_thread_max' do
     command "/usr/bin/gmetric
       -n 'tomcat threads max'
       -t uint32
       -v '/usr/local/bin/tomcat-stat
       --thread-max'"
     only_if do File.exist?('/home/jboss') end
   end



**Run every Saturday, 8:00 AM**

The following example shows a schedule that will run every hour at 8:00 each Saturday morning, and will then send an email to "admin@example.com" after each run.

.. code-block:: ruby

   cron 'name_of_cron_entry' do
     minute '0'
     hour '8'
     weekday '6'
     mailto 'admin@example.com'
     action :create
   end



**Run only in November**

The following example shows a schedule that will run at 8:00 PM, every weekday (Monday through Friday), but only in November:

.. code-block:: ruby

   cron 'name_of_cron_entry' do
     minute '0'
     hour '20'
     day '*'
     month '11'
     weekday '1-5'
     action :create
   end


