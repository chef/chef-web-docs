=====================================================
route resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_route.rst>`__

.. tag resource_route_summary

Use the **route** resource to manage the system routing table in a Linux environment.

.. end_tag

Syntax
=====================================================
A **route** resource block manages the system routing table in a Linux environment:

.. code-block:: ruby

   route '10.0.1.10/32' do
     gateway '10.0.0.20'
     device 'eth1'
   end

The full syntax for all of the properties that are available to the **route** resource is:

.. code-block:: ruby

   route 'name' do
     comment                    String
     device                     String
     gateway                    String
     netmask                    String
     notifies                   # see description
     subscribes                 # see description
     target                     String # defaults to 'name' if not specified
     action                     Symbol # defaults to :add if not specified
   end

where

* ``route`` is the resource
* ``name`` is the name of the resource block. When the name is ``default``, the default gateway is modified and added to a file under ``/etc/sysconfig/network``` on RHEL and CentOS nodes.
* ``action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``device``, ``gateway``, ``netmask``, and ``target`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Actions
=====================================================
This resource has the following actions:

``:add``
   Default. Add a route.

``:delete``
   Delete a route.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================
This resource has the following properties:

``comment``
   **Ruby Type:** String
   
   Add a comment.
   
   New in Chef Client 14.0.

``device``
   **Ruby Type:** String

   The network interface to which the route applies.

``gateway``
   **Ruby Type:** String

   The gateway for the route.

``ignore_failure``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Continue running a recipe if a resource fails for any reason.

``netmask``
   **Ruby Type:** String

   The decimal representation of the network mask. For example: ``255.255.255.0``.

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

``retries``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The number of times to catch exceptions and retry the resource.

``retry_delay``
   **Ruby Type:** Integer | **Default Value:** ``2``

   The retry delay (in seconds).

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

   The IP address of the target route. Default value: the ``name`` of the resource block. See "Syntax" section above for more information.

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Add a host route**

.. tag resource_route_add_host

.. To add a host route:

.. code-block:: ruby

   route '10.0.1.10/32' do
     gateway '10.0.0.20'
     device 'eth1'
   end

.. end_tag

**Add a default route**

.. tag resource_route_add_default_route

.. To add a default route:

.. code-block:: ruby

   route 'default' do
     gateway '10.0.0.20'
   end

.. end_tag

**Delete a network route**

.. tag resource_route_delete_network

.. To delete a network route:

.. code-block:: ruby

   route '10.1.1.0/24' do
     gateway '10.0.0.20'
     action :delete
   end

.. end_tag
