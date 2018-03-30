=====================================================
rhsm_subscription
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_rhsm_subscription.rst>`__

Use the **rhsm_subscription** to add and remove Redhat Subscription Manager subscriptions to your host. This can be used when a host's ``activation_key`` does not attach all necessary subscriptions to your host.

New in Chef Client 14.0.

Syntax
=====================================================
This resource has the following syntax:

.. code-block:: ruby

   rhsm_subscription 'name' do
     pool_id                    String # default value: 'name'
     notifies                   # see description
     subscribes                 # see description
     action                     Symbol # defaults to :attach if not specified
   end

where:

* ``rhsm_subscription`` is the resource
* ``'name'`` is the RHSM subscription name, or the resource name
* ``repo_name``, ``notifies``, and ``subscribes`` are the properties available to this resource

Actions
=====================================================
``:attach``
   Default. Attach the node to a subscription pool. 

``:remove``
   Remove the node from a subscription pool. 

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag


Properties
=====================================================
``pool_id``
   **Ruby Type:** String

   An optional property for specifying the Pool ID if it differs from the resource's name.

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