=====================================================
systemd_unit resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_systemd_unit.rst>`__

Use the **systemd_unit** resource to create, manage, and run `systemd units <https://www.freedesktop.org/software/systemd/man/systemd.html#Concepts>`_.

**New in Chef Client 12.11.**

Syntax
=====================================================
The systemd_unit resource has the following syntax:

.. code-block:: ruby

   systemd_unit 'sysstat-collect.timer' do
     content <<-EOU.gsub(/^\s+/, '')
     [Unit]
     Description=Run system activity accounting tool every 10 minutes

     [Timer]
     OnCalendar=*:00/10

     [Install]
     WantedBy=sysstat.service
     EOU

     action [:create, :enable]
   end

The full syntax for all of the properties that are available to the **systemd_unit** resource is:

.. code-block:: ruby

   systemd_unit 'name.service' do
     content                String or Hash
     user                   String
     triggers_reload        Boolean
   end

where:

* ``systemd_unit`` is the resource.
* ``name`` is the name of the unit. Must include the type/suffix (e.g. `name.socket` or `name.service`).
* ``user`` is the user account that systemd units run under. If not specified, systemd units will run under the system account.
* ``content`` describes the behavior of the unit

Actions
=====================================================

The systemd_unit resource has the following actions:

``:create``
   Create a unit file, if it does not already exist.

``:delete``
   Delete a unit file, if it exists.

``:enable``
   Ensure the unit will be started after the next system boot.

``:disable``
   Ensure the unit will not be started after the next system boot.

``:nothing``
   Default. Do nothing with the unit.

``:mask``
   Ensure the unit will not start, even to satisfy dependencies.

``:unmask``
   Stop the unit from being masked and cause it to start as specified.

``:preset``
   Restore the preset "enable/disable" configuration for a unit.

   New in Chef Client 14.0.

``:reenable``
   Reenable a unit file.

   New in Chef Client 14.0.

``:revert``
   Revet to a vendor's version of a unit file.

   New in Chef Client 14.0.

``:start``
   Start a unit based in its systemd unit file.

``:stop``
   Stop a running unit.

``:restart``
   Restart a unit.

``:reload``
   Reload the configuration file for a unit.

``:try_restart``
   Try to restart a unit if the unit is running.

``:reload_or_restart``
   For units that are services, this action reloads the configuration of the service without restarting, if possible; otherwise, it will restart the service so the new configuration is applied.

``:reload_or_try_restart``
   For units that are services, this action reloads the configuration of the service without restarting, if possible; otherwise, it will try to restart the service so the new configuration is applied.

Properties
=====================================================

The systemd_unit resource has the following properties:

``unit_name``
   **Ruby Type:** String | **Default Value:** ``'name'``


   New in Chef Client 13.7.

``user``
   **Ruby Type:** String

   The user account that the systemd unit process is run under. The path to the unit for that user would be something like
   ``/etc/systemd/user/sshd.service``. If no user account is specified, the systemd unit will run under a ``system`` account, with the path to the unit being something like ``/etc/systemd/system/sshd.service``.

``content``
   **Ruby Type:** String, Hash

   A string or hash that contains a systemd `unit file <https://www.freedesktop.org/software/systemd/man/systemd.unit.html>`_ definition that describes the properties of systemd-managed entities, such as services, sockets, devices, and so on. In Chef 14.4, repeatable options can be implemented with an array.

``triggers_reload``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Specifies whether to trigger a daemon reload when creating or deleting a unit.

``verify``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Specifies if the unit will be verified before installation. Systemd can be overly strict when verifying units, so in certain cases it is preferable not to verify the unit.

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

   The number of times to catch exceptions and retry the resource.

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

.. tag systemd_unit_examples

**Create etcd systemd service unit file**

.. code-block:: ruby

   systemd_unit 'etcd.service' do
     content({Unit: {
               Description: 'Etcd',
               Documentation: ['https://coreos.com/etcd', 'man:etcd(1)'],
               After: 'network.target',
             },
             Service: {
               Type: 'notify',
               ExecStart: '/usr/local/etcd',
               Restart: 'always',
             },
             Install: {
               WantedBy: 'multi-user.target',
             }})
     action :create
   end

.. end_tag
