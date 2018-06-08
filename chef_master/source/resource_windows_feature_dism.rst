=====================================================
windows_feature_dism
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_feature_dism.rst>`__

Use the **windows_feature_dism** resource to add, remove, or entirely delete Windows features and roles using DISM.

**New in Chef Client 14.0.**

Syntax
=====================================================
This resource has the following syntax:

.. code-block:: ruby

   windows_feature_dism 'name' do
     all                        True, False # default value: 'false'
     feature_name               Array, String # default value: 'name'
     notifies                   # see description
     source                     String
     subscribes                 # see description
     timeout                    Integer # default value: '600'
     action                     Symbol # defaults to :install if not specified
   end

where:

* ``windows_feature_dism`` is the resource
* ``'name'`` is the name of the Windows feature / role, or the name of the resource block
* ``all``, ``feature_name``, ``notifies``, ``source``, ``subscribes``, and ``timeout`` are the properties available to this resource

Actions
=====================================================
``:install``
   Default. Install a Windows role / feature using DISM.
   
``:remove``
   Remove a Windows role / feature using DISM.
   
``:delete``
   Delete a Windows role / feature from the image using DISM.
   
Properties
=====================================================
``all``
   **Ruby Type:** True, False | **Default Value:** ``false``
   
   Install all sub-features. When set to ``true``, this is the equivalent of specifying the ``/All`` switch to ``dism.exe``.
   
``feature_name``
   **Ruby Types:** String, Array | **Default Value:** ``'name'``
   
   The name of the feature(s) or role(s) to install, if it differs from the resource block name. 
   
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
   
``source``
   **Ruby Type:** String
   
   Specify a local repository for the feature install. 
   
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
   
``timeout``
   **Ruby Type:** Integer | **Default Value:** ``600``
   
   Specifies a timeout (in seconds) for the feature installation.
