=====================================================
group resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_group.rst>`__

.. tag resource_group_summary

Use the **group** resource to manage a local group.

.. end_tag

Syntax
=====================================================
The group resource has the following syntax:

.. code-block:: ruby

  group 'name' do
    append                true, false # default value: false
    comment               String
    excluded_members      String, Array
    gid                   String, Integer
    group_name            String # default value: 'name' unless specified
    members               String, Array
    non_unique            true, false # default value: false
    system                true, false # default value: false
    action                Symbol # defaults to :create if not specified
  end

where:

* ``group`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``append``, ``comment``, ``excluded_members``, ``gid``, ``group_name``, ``members``, ``non_unique``, and ``system`` are the properties available to this resource.

Actions
=====================================================

The group resource has the following actions:

``:create``
   Default. Create a group. If a group already exists (but does not match), update that group to match.

``:manage``
   Manage an existing group. This action does nothing if the group does not exist.

``:modify``
   Modify an existing group. This action raises an exception if the group does not exist.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Client run.

   .. end_tag

``:remove``
   Remove a group.

Properties
=====================================================

The group resource has the following properties:

``append``
   **Ruby Type:** true, false | **Default Value:** ``false``

   How members should be appended and/or removed from a group. When ``true``, ``members`` are appended and ``excluded_members`` are removed. When ``false``, group members are reset to the value of the ``members`` property.

``comment``
   **Ruby Type:** String

   Specifies a comment to associate with the local group.

   *New in Chef Client 14.9.*

``excluded_members``
   **Ruby Type:** String, Array

   Remove users from a group. May only be used when ``append`` is set to ``true``.

``gid``
   **Ruby Type:** String, Integer

   The identifier for the group.

``group_name``
   **Ruby Type:** String | **Default Value:** ``The resource block's name``

   The name of the group. Default value: the ``name`` of the resource block. See "Syntax" section above for more information.

``members``
   **Ruby Type:** Array

   Which users should be set or appended to a group. When more than one group member is identified, the list of members should be an array: ``members ['user1', 'user2']``.

``non_unique``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Allow ``gid`` duplication. May only be used with the ``Groupadd`` provider.

``system``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Set if a group belongs to a system group. Set to ``true`` if the group belongs to a system group.

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

The following examples demonstrate various approaches for using resources in recipes:

**Append users to groups**

.. tag resource_group_append_user

.. To append a user to an existing group:

.. code-block:: ruby

   group 'www-data' do
     action :modify
     members 'maintenance'
     append true
   end

.. end_tag

**Add a user to group on the Windows platform**

.. tag resource_group_add_user_on_windows

.. To add a group on the Windows platform:

.. code-block:: ruby

   group 'Administrators' do
     members ['domain\foo']
     append true
     action :modify
   end

.. end_tag
