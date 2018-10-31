=====================================================
ohai_hint resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_ohai_hint.rst>`__

Use the **ohai_hint** resource to aid in configuration detection by passing hint data to Ohai.

**New in Chef Client 14.0.**

Syntax
=====================================================
The ohai_hint resource has the following syntax:

.. code-block:: ruby

  ohai_hint 'name' do
    compile_time      true, false # default value: true
    content           Hash
    hint_name         String # default value: 'name' unless specified
    action            Symbol # defaults to :create if not specified
  end

where:

* ``ohai_hint`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``compile_time``, ``content``, and ``hint_name`` are the properties available to this resource.

Actions
=====================================================

The ohai_hint resource has the following actions:

``:create``
   Default. Create an Ohai hint file.

``:delete``
   Delete an Ohai hint file.

``:nothing``
   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, the resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

Properties
=====================================================

The ohai_hint resource has the following properties:

``compile_time``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Determines whether or not the resource is executed during the compile time phase.

``content``
   **Ruby Type:** Hash

   Values to include in the hint file.

``hint_name``
   **Ruby Type:** String | **Default Value:** ``'name'``

   The name of the hints file, if it differs from the resource name.

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

Examples
=====================================================
**Create a hint file**

.. code-block:: ruby

   ohai_hint 'example' do
     content Hash[:a, 'test_content']
   end


**Create a hint file with a name that does not match the resource name**

.. code-block:: ruby

   ohai_hint 'example' do
     hint_name 'custom'
   end

**Create a hint file that is not loaded at compile time**

.. code-block:: ruby

   ohai_hint 'example' do
     compile_time false
   end

**Delete a hint file**

.. code-block:: ruby

   ohai-hint 'example' do
     action :delete
   end
