=====================================================
windows_share resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_share.rst>`__

Use the **windows_share** resource to create, modify and remove Windows shares.

**New in Chef Client 14.7.**

Syntax
=====================================================
The windows_share resource has the following syntax:

.. code-block:: ruby

  windows_share 'name' do
    ca_timeout                  Integer # default value: 0
    change_users                Array
    concurrent_user_limit       Integer # default value: 0
    continuously_available      true, false # default value: false
    description                 String
    encrypt_data                true, false # default value: false
    full_users                  Array
    path                        String
    read_users                  Array
    scope_name                  String # default value: "*"
    share_name                  String # default value: 'name' unless specified
    temporary                   true, false # default value: false
    action                      Symbol # defaults to :create if not specified
  end

where:

* ``windows_share`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``ca_timeout``, ``change_users``, ``concurrent_user_limit``, ``continuously_available``, ``description``, ``encrypt_data``, ``full_users``, ``path``, ``read_users``, ``scope_name``, ``share_name``, and ``temporary`` are the properties available to this resource.

Actions
=====================================================

The windows_share resource has the following actions:

``:create``
    Create and modify Windows shares.

``:delete``
    Delete an existing Windows share.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================

The windows_share resource has the following properties:

``ca_timeout``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The continuous availability time-out for the share.

``change_users``
   **Ruby Type:** Array

   The users that should have 'modify' permission on the share in domain\username format.

``concurrent_user_limit``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The maximum number of concurrently connected users the share can accommodate.

``continuously_available``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Indicates that the share is continuously available.

``description``
   **Ruby Type:** String

   The description to be applied to the share.

``encrypt_data``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Indicates that the share is encrypted.

``full_users``
   **Ruby Type:** Array

   The users that should have 'Full control' permissions on the share in domain\username format.

``path``
   **Ruby Type:** String

   The path of the folder to share. Required when creating. If the share already exists on a different path then it is deleted and re-created.

``read_users``
   **Ruby Type:** Array

   The users that should have 'read' permission on the share in domain\username format.

``scope_name``
   **Ruby Type:** String | **Default Value:** ``"*"``

   The scope name of the share.

``share_name``
   **Ruby Type:** String | **Default Value:** ``The resource block's name``

   An optional property to set the share name if it differs from the resource block's name.

``temporary``
   **Ruby Type:** true, false | **Default Value:** ``false``

   The lifetime of the new SMB share. A temporary share does not persist beyond the next restart of the computer.

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
==========================================

**Create a share**

.. code-block:: ruby

  windows_share 'foo' do
    action :create
    path 'C:\\foo'
    full_users ['DOMAIN_A\\some_user', 'DOMAIN_B\\some_other_user']
    read_users ['DOMAIN_C\\Domain users']
  end

** Delete a share **

.. code-block:: ruby

  windows_share 'foo' do
    action :delete
  end
