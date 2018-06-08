=====================================================
swap_file
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_swap_file.rst>`__

Use the **swap_file** resource to create or delete swap files on Linux systems, and optionally to manage the swappiness configuration for a host.

New in Chef Client 14.0.

Syntax
=====================================================
This resource has the following syntax:

.. code-block:: ruby

   swap_file 'name' do
     notifies                   # see description
     path                       String # default value: 'name'
     persist                    True, False # default value: 'false'
     size                       Integer
     subscribes                 # see description
     swappiness                 Integer
     timeout                    Integer # default value: 600
     action                     Symbol # defaults to :create if not specified             
  end

where:

* ``swap_file`` is the resource
* ``'name`` is the path where the swap file will be created, or the name of the resource block
* ``notifies``, ``path``, ``persist``, ``size``, ``subscribes``, ``swappiness``, and ``timeout`` are the properties available to this resource

Actions
=====================================================
``:create``
   Default. Create a swap file. 

``:remove``
   Remove a swap file and disable swap. 

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================
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

   The path where the swap file will be created on the system, if it differs from the resource block name. 

``persist``
   **Ruby Type:** True, False | **Default Value:** ``false``

   Persist the swapon.

``size``
   **Ruby Type:** Integer

   The size (in MBs) of the swap file. 

``swappiness``
   **Ruby Type:** Integer

   The swappiness value to set on the system.

``timeout``
   **Ruby Type:** Integer | **Default Value:** ``600``

   Timeout for ``dd`` / ``fallocate`` commands. 

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
**Create a swap file**

.. code-block:: ruby
   
   swap_file '/dev/sda1' do
     size 1024
   end

**Remove a swap file**

.. code-block:: ruby

   swap_file '/dev/sda1' do
     action :remove
   end

