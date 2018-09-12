=====================================================
windows_printer_port resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_printer_port.rst>`__

Use the **windows_printer_port** resource to create and delete TCP/IPv4 printer ports on Windows.

**New in Chef Client 14.0.**

Syntax
=====================================================
The windows_printer_port resource has the following syntax:

.. code-block:: ruby

  windows_printer_port 'name' do
    exists                true, false
    ipv4_address          String # default value: 'name' unless specified
    port_description      String
    port_name             String
    port_number           Integer # default value: 9100
    port_protocol         Integer # default value: 1
    snmp_enabled          true, false # default value: false
    action                Symbol # defaults to :create if not specified
  end

where:

* ``windows_printer_port`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``exists``, ``ipv4_address``, ``port_description``, ``port_name``, ``port_number``, ``port_protocol``, and ``snmp_enabled`` are the properties available to this resource.

Actions
=====================================================

``:create``
   Default. Create the printer port, if one doesn't already exist.

``:delete``
   Delete an existing printer port.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================
``ipv4_address``
   **Ruby Type:** String | **Default Value:** ``'name'``

   The IPv4 address of the printer, if it differs from the resource block name.

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

``port_description``
   **Ruby Type:** String

   The description of the port.

``port_name``
   **Ruby Type:** String

   The port name.

``port_number``
   **Ruby Type:** Integer | **Default Value:** ``9100``

   The port number.

``port_protocol``
   **Ruby Type:** Integer | **Default Value:** ``1``

   The printer port protocol; ``1`` (RAW) or ``2`` (LPR).

``snmp_enabled``
   **Ruby Type:** True, False | **Default Value:** ``false``

   Determines if SNMP is enabled on the port

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
