=====================================================
rhsm_register resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_rhsm_register.rst>`__

Use the **rhsm_register** resource to register a node with the Red Hat Subscription Manager or a local Red Hat Satellite server.

**New in Chef Client 14.0.**

Syntax
=====================================================
The rhsm_register resource has the following syntax:

.. code-block:: ruby

  rhsm_register 'name' do
    activation_key             String, Array
    auto_attach                true, false # default value: false
    environment                String
    force                      true, false # default value: false
    install_katello_agent      true, false # default value: true
    organization               String
    password                   String
    satellite_host             String
    username                   String
    action                     Symbol # defaults to :register if not specified
  end

where:

* ``rhsm_register`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``activation_key``, ``auto_attach``, ``environment``, ``force``, ``install_katello_agent``, ``organization``, ``password``, ``satellite_host``, and ``username`` are the properties available to this resource.

Actions
=====================================================
``:register``
   Default. Register the node with RHSM.

``:unregister``
   Unregister the node from RHSM.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================
``activation_key``
   **Ruby Type:** String, Array

   A string or array of  activation keys to use when registering; you must also specify the ``organization`` property when using this.

``auto_attach``
   **Ruby Type:** true, false | **Default Value:** ``false``

   If ``true``, RHSM will attempt to automatically attach the host to applicable subscriptions. It is generally better to use an activation key with the subscriptions predefined.

``environment``
   **Ruby Type:** String

   The environment to use when registering; required when using the ``username`` and ``password`` properties.

``force``
   **Ruby Type:** true, false | **Default Value:** ``false``

   If true, the system will be registered even if it is already registered. Normally, any register operations will fail if the machine has already been registered.

``install_katello_agent``
   **Ruby Type:** true, false | **Default Value:** ``true``

   If true, the ``katello-agent`` RPM will be installed.

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

``organization``
   **Ruby Type:** String

   The organization to use when registering; required when using the ``activation_key`` property.

``password``
   **Ruby Type:** String

   The password to use when registering. This property is not applicable if using an activation key. If specified, ``username`` and ``environment`` are also required.

``satellite_host``
   **Ruby Type:** String

   The FQDN of the Satellite host to register with. If this property is not specified, the host will register with Red Hat's public RHSM service.

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
