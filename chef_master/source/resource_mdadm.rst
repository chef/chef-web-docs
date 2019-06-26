=====================================================
mdadm resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_mdadm.rst>`__

Use the **mdadm** resource to manage RAID devices in a Linux environment using the mdadm utility. The **mdadm** resource will create and assemble an array, but it will not create the config file that is used to persist the array upon reboot. If the config file is required, it must be done by specifying a template with the correct array layout, and then by using the **mount** resource to create a file systems table (fstab) entry.

Syntax
=====================================================
The mdadm resource has the following syntax:

.. code-block:: ruby

  mdadm 'name' do
    bitmap           String
    chunk            Integer # default value: 16
    devices          Array
    layout           String
    level            Integer # default value: 1
    metadata         String # default value: "0.90"
    raid_device      String # default value: 'name' unless specified
    action           Symbol # defaults to :create if not specified
  end

where:

* ``mdadm`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``bitmap``, ``chunk``, ``devices``, ``layout``, ``level``, ``metadata``, and ``raid_device`` are the properties available to this resource.

Actions
=====================================================

The mdadm resource has the following actions:

``:assemble``
   Assemble a previously created array into an active array.

``:create``
   Default. Create an array with per-device superblocks. If an array already exists (but does not match), update that array to match.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Infra Client run.

   .. end_tag

``:stop``
   Stop an active array.

Properties
=====================================================

The mdadm resource has the following properties:

``bitmap``
   **Ruby Type:** String

   The path to a file in which a write-intent bitmap is stored.

``chunk``
   **Ruby Type:** Integer | **Default Value:** ``16``

   The chunk size. This property should not be used for a RAID 1 mirrored pair (i.e. when the ``level`` property is set to ``1``).

``devices``
   **Ruby Type:** Array

   The devices to be part of a RAID array.

``layout``
   **Ruby Type:** String

   The RAID5 parity algorithm. Possible values: ``left-asymmetric`` (or ``la``), ``left-symmetric`` (or ``ls``), ``right-asymmetric`` (or ``ra``), or ``right-symmetric`` (or ``rs``).

``level``
   **Ruby Type:** Integer | **Default Value:** ``1``

   The RAID level.

``metadata``
   **Ruby Type:** String | **Default Value:** ``"0.90"``

   The superblock type for RAID metadata.


``raid_device``
   **Ruby Type:** String | **Default Value:** ``The resource block's name``

   Optional property to specify the name of the RAID device if it differs from the resource block's name.



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

  Ensure that sensitive resource data is not logged by the Chef Infra Client.

.. end_tag

Notifications
-----------------------------------------------------

``notifies``
  **Ruby Type:** Symbol, 'Chef::Resource[String]'

  .. tag resources_common_notification_notifies

  A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notify more than one resource; use a ``notifies`` statement for each resource to be notified.

  .. end_tag

.. tag resources_common_notification_timers

A timer specifies the point during the Chef Infra Client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the end of the Chef Infra Client run.

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

A timer specifies the point during the Chef Infra Client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the end of the Chef Infra Client run.

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

A guard property can be used to evaluate the state of a node during the execution phase of the Chef Infra Client run. Based on the results of this evaluation, a guard property is then used to tell the Chef Infra Client if it should continue executing a resource. A guard property accepts either a string value or a Ruby block value:

* A string is executed as a shell command. If the command returns ``0``, the guard is applied. If the command returns any other value, then the guard property is not applied. String guards in a **powershell_script** run Windows PowerShell commands and may return ``true`` in addition to ``0``.
* A block is executed as Ruby code that must return either ``true`` or ``false``. If the block returns ``true``, the guard property is applied. If the block returns ``false``, the guard property is not applied.

A guard property is useful for ensuring that a resource is idempotent by allowing that resource to test for the desired state as it is being executed, and then if the desired state is present, for the Chef Infra Client to do nothing.

.. end_tag

.. tag resources_common_guards_properties

The following properties can be used to define a guard that is evaluated during the execution phase of the Chef Infra Client run:

``not_if``
  Prevent a resource from executing when the condition returns ``true``.

``only_if``
  Allow a resource to execute only if the condition returns ``true``.

.. end_tag

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes:

**Create and assemble a RAID 0 array**

.. tag resource_mdadm_raid0

The mdadm command can be used to create RAID arrays. For example, a RAID 0 array named ``/dev/md0`` with 10 devices would have a command similar to the following:

.. code-block:: bash

   $ mdadm --create /dev/md0 --level=0 --raid-devices=10 /dev/s01.../dev/s10

where ``/dev/s01 .. /dev/s10`` represents 10 devices (01, 02, 03, and so on). This same command, when expressed as a recipe using the **mdadm** resource, would be similar to:

.. code-block:: ruby

   mdadm '/dev/md0' do
     devices [ '/dev/s01', ... '/dev/s10' ]
     level 0
     action :create
   end

(again, where ``/dev/s01 .. /dev/s10`` represents devices /dev/s01, /dev/s02, /dev/s03, and so on).

.. end_tag

**Create and assemble a RAID 1 array**

.. tag resource_mdadm_raid1

.. To create and assemble a RAID 1 array from two disks with a 64k chunk size:

.. code-block:: ruby

   mdadm '/dev/md0' do
     devices [ '/dev/sda', '/dev/sdb' ]
     level 1
     action [ :create, :assemble ]
   end

.. end_tag

**Create and assemble a RAID 5 array**

.. tag resource_mdadm_raid5

The mdadm command can be used to create RAID arrays. For example, a RAID 5 array named ``/dev/sd0`` with 4, and a superblock type of ``0.90`` would be similar to:

.. code-block:: ruby

   mdadm '/dev/sd0' do
     devices [ '/dev/s1', '/dev/s2', '/dev/s3', '/dev/s4' ]
     level 5
     metadata '0.90'
     chunk 32
     action :create
   end

.. end_tag
