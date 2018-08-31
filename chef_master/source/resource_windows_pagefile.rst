=====================================================
windows_pagefile
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_pagefile.rst>`__

Use the **windows_pagefile** resource to configure pagefile settings on Windows.

**New in Chef Client 14.0.**

Syntax
=====================================================
This resource has the following syntax:

.. code-block:: ruby

   windows_pagefile 'name' do
     automatic_managed          True, False # default value: 'false'
     initial_size               Integer
     maximum_size               Integer
     path                       String # default value: 'name'
     system_managed             True, False
     action                     Symbol # defaults to :set if not specified
   end

where:

* ``windows_pagefile`` is the resource
* ``'path'`` is the path to the pagefile, or the name of the resource block
* ``automatic_managed``, ``initial_size``, ``maximum_size``, and ``path`` are the properties available to this resource.

Actions
=====================================================
``:set``
   Default. Configures the default pagefile, creating if it doesn't exist.

``:delete``
   Deletes the specified pagefile.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================

``automatic_managed``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Enable automatic management of pagefile initial and maximum size. Setting this to true ignores 'initial_size' and 'maximum_size' properties.

``initial_size``
   **Ruby Type:** Integer

   Initial size of the pagefile in megabytes.

``maximum_size``
   **Ruby Type:** Integer

   Maximum size of the pagefile in megabytes.

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

``path``
   **Ruby Type:** String | **Default Value:** ``'name'``

   The path to the pagefile if different from the resource name.

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

``system_managed``

   **Ruby Type:** true, false

   Configures whether the system manages the pagefile size.
