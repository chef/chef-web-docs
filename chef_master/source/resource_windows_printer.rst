=====================================================
windows_printer
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_printer.rst>`__

Use the **windows_printer** resource to setup Windows printers. This resource does not install a printer driver; you must already have the driver installed on the system.

**New in Chef Client 14.0.**

Syntax
=====================================================
This resource has the following syntax:

.. code-block:: ruby

   windows_printer 'name' do
     comment                    String
     default                    True, False # default value: 'false'
     device_id                  String # default value: 'name'
     driver_name                String # required
     ipv4_address               String
     location                   String
     notifies                   # see description
     shared                     True, False # default value: 'false'
     share_name                 String
     subscribes                 # see description
     action                     Symbol # defaults to :create if not specified
   end

where:

* ``windows_printer`` is the resource
* ``'name'`` is the device name, or the name of the resource block
* ``comment``, ``default``, ``device_id``, ``driver_name``, ``exists``, ``ipv4_address``, ``location``, ``notifies``, ``shared``, ``share_name``, and ``subscribes`` are the properties available to this resource

Actions
=====================================================
``:create``
   Default. Create a new printer and printer port, if one doesn't already exist.
   
``:delete``
   Delete an existing printer. Note that this resource does not delete the associated printer port.
   
``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag
   
Properties
=====================================================
``comment``
   **Ruby Type:** String
   
   Optional descriptor for the printer queue.

``default``
   **Ruby Type:** True, False | **Default Value:** ``false``
   
   Determines whether or not this should be the system's default printer.

``device_id``
   **Ruby Type:** String | **Default Value:** ``'name'``

   Printer queue name, such as: ``"HP LJ 5200 2nd floor"``.

``driver_name``
   **Ruby Type:** String
   
   Required. The exact name of the installed printer driver on the system.   

``ipv4_address``
   **Ruby Type:** String
   
   The IPv4 address of the printer.

``location``
   **Ruby Type:** String
   
   Printer location, such as: ``"2nd floor copy room"``. 
   
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
      Default. Specifies that a notification should be queued up, and then executed at the very end of the Chef Client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_notifies_syntax

   The syntax for ``notifies`` is:

   .. code-block:: ruby

      notifies :action, 'resource[name]', :timer

   .. end_tag
   
``shared``
   **Ruby Type:** True, False | **Default Value:** ``false``
   
   Determines whether or not the printer is shared.

``share_name``
   **Ruby Type:** String
   
   The name used to identify the shared printer.
   
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
      Default. Specifies that a notification should be queued up, and then executed at the very end of the Chef Client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_subscribes_syntax

   The syntax for ``subscribes`` is:

   .. code-block:: ruby

      subscribes :action, 'resource[name]', :timer

   .. end_tag