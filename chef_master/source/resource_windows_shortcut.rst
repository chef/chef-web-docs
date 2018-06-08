=====================================================
windows_shortcut
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_shortcut.rst>`__

Use the **windows_shortcut** resource to create shortcut files on Windows.

**New in Chef Client 14.0.**

Syntax
=====================================================
This resource has the following syntax:

.. code-block:: ruby

   windows_shortcut 'name' do
     arguments                  String
     description                String
     cwd                        String
     iconlocation               String
     notifies                   # see description
     shortcut_name              String # default value: 'name'
     subscribes                 # see description
     target                     String
     action                     Symbol # defaults to :create if not specified
   end

where:

* ``windows_shortcut`` is the resource
* ``'name'`` is the name of the shortcut, or the name of the resource block
* ``arguments``, ``description``, ``cwd``, ``iconlocation``, ``notifies``, ``shortcut_name``, ``subscribes``, and ``target`` are the properties available to this resource

Actions
=====================================================
``:create``
   Default. Create or modify a Windows shortcut. 
   
``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag
   
Properties
=====================================================
``arguments``
   **Ruby Type:** String
   
   Arguments to pass to the target when the shortcut is executed.

``description``
   **Ruby Type:** String
   
   A description of the shortcut.
   
``cwd``
   **Ruby Type:** String
   
   Working directory to use when the target is executed.
   
``iconlocation``
   **Ruby Type:** String
   
   Icon to use for the shortcut. Accepts the format of ``'path, index'``, where index is the icon file to use. See Microsoft's `documentation <https://msdn.microsoft.com/en-us/library/3s9bx7at.aspx>`__ for details.
   
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
   
``shortcut_name``
   **Ruby Type:** String | **Default Value:** ``'name'``
   
   The name for the shortcut, if it differs from the resource name.
   
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
   
``target``
   **Ruby Type:** String
   
   The destination that the shortcut links to.
