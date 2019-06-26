=====================================================
macos_userdefaults resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_macos_userdefaults.rst>`__

Use the **macos_userdefaults** resource to manage the macOS `user defaults <https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/UserDefaults/AboutPreferenceDomains/AboutPreferenceDomains.html#//apple_ref/doc/uid/10000059i-CH2-SW6>`__ system. The properties of the resource are passed to the ``defaults`` command, and the parameters follow the conventions of that command. See the ``defaults`` man page for additional information.

**New in Chef Client 14.0.**

Syntax
=====================================================
The macos_userdefaults resource has the following syntax:

.. code-block:: ruby

  macos_userdefaults 'name' do
    domain      String
    global      true, false # default value: false
    key         String
    sudo        true, false # default value: false
    type        String
    user        String
    value       Integer, Float, String, true, false, Hash, Array
    action      Symbol # defaults to :write if not specified
  end

where:

* ``macos_userdefaults`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``domain``, ``global``, ``key``, ``sudo``, ``type``, ``user``, and ``value`` are the properties available to this resource.

Actions
=====================================================

The macos_userdefaults resource has the following actions:

``:write``
   Default. Writes the setting to the specified domain. 

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Infra Client run.

   .. end_tag

Properties
=====================================================

The macos_userdefaults resource has the following properties:

``domain``
   **Ruby Type:** String | ``REQUIRED``

   The domain that the user defaults belong to.

``global``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Determines whether or not the domain is `global <https://developer.apple.com/documentation/foundation/nsglobaldomain>`__.

``key``
   **Ruby Type:** String

   The preference key.
   

``sudo``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Set to ``true`` if the setting you wish to modify requires privileged access.

``type``
   **Ruby Type:** String

   The value type of the preference key.

``user``
   **Ruby Type:** String

   The system user that the default will be applied to.

``value``
   **Ruby Type:** Integer, Float, String, true, false, Hash, Array | ``REQUIRED``

   The value of the key.

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
**Specify a global domain**

.. code-block:: ruby

   macos_userdefaults 'full keyboard access to all controls' do
     domain 'AppleKeyboardUIMode'
     global true
     value '2'
   end

**Use an integer value**

.. code-block:: ruby

   macos_userdefaults 'enable macOS firewall' do
     domain '/Library/Preferences/com.apple.alf'
     key 'globalstate'
     value '1'
     type 'int'
   end

**Use a boolean value**

.. code-block:: ruby

   macos_userdefaults 'finder expanded save dialogs' do
     domain 'NSNavPanelExpandedStateForSaveMode'
     global true
     value 'TRUE'
     type 'bool'
   end
