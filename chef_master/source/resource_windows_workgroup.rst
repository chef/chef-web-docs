=====================================================
windows_workgroup
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_workgroup.rst>`__

Use the **windows_workgroup** resource to join a windows workgroup.

**New in Chef Client 14.4.**

Syntax
=====================================================
This resource has the following syntax:

.. code-block:: ruby

   windows_workgroup 'name' do
     workgroup_name             String # default value: 'name'
     password                   String # required
     user                       String # required
     notifies                   # see description
     reboot                     Symbol # see description
     subscribes                 # see description
     action                     Symbol # defaults to :join if not specified
   end

where:

* ``windows_workgroup`` is the resource
* ``'name'`` is the windows workgroup, or the name of the resource block
* ``workgroup_name``, ``password``, ``user``, ``notifies``, ``reboot``, and ``subscribes`` are the properties available to this resource

Actions
=====================================================

``:join``
   Default. Join the windows workgroup. 

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================
``workgroup_name``
   **Ruby Type:** String | **Default Value:** ``'name'``

   The name of the workgroup for the computer. 

``password``
   **Ruby Type:** String

   Required. The password for the local user. 

``user``
   **Ruby Type:** String

   Required. The local user to use to change the workgroup.

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

``reboot``
   **Ruby Type:** Symbol | **Default Value:** ``:immediate``

   Controls the system reboot behavior after joining the workgroup, with the following options:
   
   * ``:immediate``: reboot immediately
   * ``:delayed``: reboot after the Chef Client run completes 
   * ``:never``: do not reboot

   Note that a reboot is necessary for changes to take effect.

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

Examples
=====================================================
**Join a workgroup**

.. code-block:: ruby

   windows_workgroup 'example' do
     user 'admin'
     password 'p@ssw0rd1'
   end
