=====================================================
hostname resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_hostname.rst>`__

Use the **hostname** resource to set the system's hostname, configure hostname and hosts config file, and re-run the Ohai **hostname** plugin so the hostname will be available in subsequent cookbooks.

**New in Chef Client 14.0.**

Syntax
=====================================================
The hostname resource has the following syntax:

.. code-block:: ruby

  hostname 'name' do
    aliases             Array, nil
    compile_time        true, false # default value: true
    hostname            String # default value: 'name' unless specified
    ipaddress           String
    windows_reboot      true, false # default value: true
    action              Symbol # defaults to :set if not specified
  end

where:

* ``hostname`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``aliases``, ``compile_time``, ``hostname``, ``ipaddress``, and ``windows_reboot`` are the properties available to this resource.

Actions
=====================================================

The hostname resource has the following actions:

``:set``
   Default action. Set the node's hostname. 

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================

The hostname resource has the following properties:

``aliases``
   **Ruby Type**: Array, nil | **Default Value:** ``nil``

   An array of hostname aliases to use when configuring the hosts file.

``compile_time``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Determines whether or not the resource shoul be run at compile time.

``hostname``
   **Ruby Type:** String | **Default Value:** ``'name'``

   Used to specify the hostname if it is different than the resource's name.

``ipaddress``
   **Ruby Type:** String | **Default Value:** ``node["ipaddress"]``

   The IP address to use when configuring the hosts file. By default, this uses ``node["ipaddress"]`` information collected by Ohai.

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
  
``windows_reboot``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Determines whether or not Windows should be reboot after changing the hostname, as this is required for the change to take effect. 

Examples
=====================================================
**Set the hostname**

.. code-block:: ruby

   hostname 'example' do

The example above sets the hostname to ``example`` for the IP address, as detected by Ohai.

**Manually specify the hostname and IP address** 

.. code-block:: ruby

   hostname 'statically_configured_host' do
     hostname 'example'
     ipaddress '198.51.100.2'
   end
