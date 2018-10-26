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
* ``append``, ``excluded_members``, ``gid``, ``group_name``, ``members``, ``non_unique``, and ``system`` are the properties available to this resource.

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

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

``:remove``
   Remove a group.

Properties
=====================================================

The group resource has the following properties:

``append``
   **Ruby Type:** true, false | **Default Value:** ``false``

   How members should be appended and/or removed from a group. When ``true``, ``members`` are appended and ``excluded_members`` are removed. When ``false``, group members are reset to the value of the ``members`` property.

``excluded_members``
   **Ruby Type:** String, Array

   Remove users from a group. May only be used when ``append`` is set to ``true``.

``gid``
   **Ruby Type:** String, Integer

   The identifier for the group.

``group_name``
   **Ruby Type:** String | **Default Value:** ``'name'``

   The name of the group. Default value: the ``name`` of the resource block. See "Syntax" section above for more information.

``ignore_failure``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Continue running a recipe if a resource fails for any reason.

``members``
   **Ruby Type:** Array

   Which users should be set or appended to a group. When more than one group member is identified, the list of members should be an array: ``members ['user1', 'user2']``.

``non_unique``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Allow ``gid`` duplication. May only be used with the ``Groupadd`` provider.

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

``retries``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The number of times to catch exceptions and retry the resource.

``retry_delay``
   **Ruby Type:** Integer | **Default Value:** ``2``

   The retry delay (in seconds).

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

``system``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Set if a group belongs to a system group. Set to ``true`` if the group belongs to a system group.

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

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
