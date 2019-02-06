=====================================================
windows_firewall_rule resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_firewall_rule.rst>`__

Use the **windows_firewall_rule** resource to create, change or remove windows firewall rules.

**New in Chef Client 14.7.**

Syntax
=====================================================
The windows_firewall_rule resource has the following syntax:

.. code-block:: ruby

  windows_firewall_rule 'name' do
    description          String # default value: "Firewall rule"
    direction            Symbol, String # default value: :inbound
    enabled              true, false # default value: true
    firewall_action      Symbol, String # default value: :allow
    interface_type       Symbol, String # default value: :any
    local_address        String
    local_port           String, Integer, Array
    profile              Symbol, String # default value: :any
    program              String
    protocol             String # default value: "TCP"
    remote_address       String
    remote_port          String, Integer, Array
    rule_name            String # default value: 'name' unless specified
    service              String
    action               Symbol # defaults to :create if not specified
  end

where:

* ``windows_firewall_rule`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``description``, ``direction``, ``enabled``, ``firewall_action``, ``interface_type``, ``local_address``, ``local_port``, ``profile``, ``program``, ``protocol``, ``remote_address``, ``remote_port``, ``rule_name``, and ``service`` are the properties available to this resource.

Actions
=====================================================

The windows_firewall_rule resource has the following actions:

``:create``
    Create a Windows firewall entry.

``:delete``
    Delete an existing Windows firewall entry.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================

The windows_firewall_rule resource has the following properties:

``description``
   **Ruby Type:** String | **Default Value:** ``"Firewall rule"``

   The description to assign to the firewall rule.

``direction``
   **Ruby Type:** Symbol, String | **Default Value:** ``:inbound``

   The direction of the firewall rule. Direction means either inbound or outbound traffic.

``enabled``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Whether or not to enable the firewall rule.

``firewall_action``
   **Ruby Type:** Symbol, String | **Default Value:** ``:allow``

   The action of the firewall rule.

``interface_type``
   **Ruby Type:** Symbol, String | **Default Value:** ``:any``

   The interface type the firewall rule applies to.

``local_address``
   **Ruby Type:** String

   The local address the firewall rule applies to.

``local_port``
   **Ruby Type:** String, Integer, Array

   The local port the firewall rule applies to.

``profile``
   **Ruby Type:** Symbol, String | **Default Value:** ``:any``

   The profile the firewall rule applies to.

``program``
   **Ruby Type:** String

   The program the firewall rule applies to.

``protocol``
   **Ruby Type:** String | **Default Value:** ``"TCP"``

   The protocol the firewall rule applies to.

``remote_address``
   **Ruby Type:** String

   The remote address the firewall rule applies to.

``remote_port``
   **Ruby Type:** String, Integer, Array

   The remote port the firewall rule applies to.

``rule_name``
   **Ruby Type:** String | **Default Value:** ``The resource block's name``

   An optional property to set the name of the firewall rule to assign if it differs from the resource block's name.

``service``
   **Ruby Type:** String

   The service the firewall rule applies to.

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

**Allowing port 80 access**

.. code-block:: ruby

  windows_firewall_rule 'IIS' do
    local_port '80'
    protocol 'TCP'
    firewall_action :allow
  end


**Blocking WinRM over HTTP on a particular IP**

.. code-block:: ruby

  windows_firewall_rule 'Disable WinRM over HTTP' do
    local_port '5985'
    protocol 'TCP'
    firewall_action :block
    local_address '192.168.1.1'
  end


**Deleting an existing rule**

.. code-block:: ruby


  windows_firewall_rule 'Remove the SSH rule' do
    rule_name 'ssh'
    action :delete
  end
