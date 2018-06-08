=====================================================
sysctl
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_sysctl.rst>`__

Use the **sysctl** resource to set or remove kernel parameters using the ``sysctl`` command line tool and configuration files in the system's ``sysctl.d`` directory. Configuration files managed by this resource are named ``99-chef-KEYNAME.conf``. If an existing value was already set, it will be backed up to the node and restored if the ``:remove`` action is used later. 

New in Chef Client 14.0.

Syntax
=====================================================
This resource has the following syntax:

.. code-block:: ruby

   sysctl 'name' do
     conf_dir                   String # default value: "/etc/sysctl.d"
     ignore_error               True, False # default value: 'false'
     key                        String # default value: 'name'
     notifies                   # see description
     subscribes                 # see description
     value                      Array, String, Integer, Float # required
     action                     Symbol # defaults to :apply if not specified      
  end

where:

* ``sysctl`` is the resource
* ``'name'`` is the kernel parameter, or the name of the resource block
* ``conf_dir``, ``ignore_error``, ``key``, ``notifies``, ``subscribes``, and ``value`` are the resources available to this property

Actions
=====================================================
``:apply``
   Default. Set the kernel parameter and update the ``sysctl`` settings.

``:remove``
   Remove the kernel parameter and update the ``sysctl`` settings. 

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================
``conf_dir``
   **Ruby Type:** String | **Default Value:** ``/etc/sysctl.d``

   The configuration directory to write the config to. 

``ignore_error`` 
   **Ruby Type:** True, False | **Default Value:** ``false``

   Ignore any errors when setting the value on the command line. 

``key``
   **Ruby Type:** String | **Default Value:** ``'name'``

   The kernel paramater key in dotted format, if it differs from the resource block name. 

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

``value``
   **Ruby Types:** Array, String, Integer, Float

   Required. The value to set.

