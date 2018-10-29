=====================================================
ifconfig resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_ifconfig.rst>`__

.. tag resource_ifconfig_summary

Use the **ifconfig** resource to manage interfaces on Unix and Linux systems.

.. end_tag

Syntax
=====================================================
An **ifconfig** resource block manages interfaces, such as a static IP address:

.. code-block:: ruby

   ifconfig '33.33.33.80' do
     device 'eth1'
   end

The full syntax for all of the properties that are available to the **ifconfig** resource is:

.. code-block:: ruby

  ifconfig 'name' do
    bcast             String
    bonding_opts      String
    bootproto         String
    device            String
    ethtool_opts      String
    family            String # default value: inet
    gateway           String
    hwaddr            String
    inet_addr         String
    mask              String
    master            String
    metric            String
    mtu               String
    network           String
    onboot            String
    onparent          String
    slave             String
    target            String # default value: 'name' unless specified
    vlan              String
    action            Symbol # defaults to :add if not specified
  end

where:

* ``ifconfig`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``bcast``, ``bonding_opts``, ``bootproto``, ``device``, ``ethtool_opts``, ``family``, ``gateway``, ``hwaddr``, ``inet_addr``, ``mask``, ``master``, ``metric``, ``mtu``, ``network``, ``onboot``, ``onparent``, ``slave``, ``target``, and ``vlan`` are the properties available to this resource.

Actions
=====================================================

The ifconfig resource has the following actions:

``:add``
   Default. Run ifconfig to configure a network interface and (on some platforms) write a configuration file for that network interface.

``:delete``
   Run ifconfig to disable a network interface and (on some platforms) delete that network interface's configuration file.

``:disable``
   Run ifconfig to disable a network interface.

``:enable``
   Run ifconfig to enable a network interface.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================

The ifconfig resource has the following properties:

``bcast``
   **Ruby Type:** String

   The broadcast address for a network interface. On some platforms this property is not set using ifconfig, but instead is added to the startup configuration file for the network interface.

``bonding_opts``
   **Ruby Type:** String

   Bonding options to pass via ``BONDING_OPTS`` on RHEL and CentOS. For example: ``mode=active-backup miimon=100``

   New in Chef Client 13.4.

``bootproto``
   **Ruby Type:** String

   The boot protocol used by a network interface.

``device``
   **Ruby Type:** String

   The network interface to be configured.

``ethtool_opts``
   **Ruby Type:** String

   Options to be passed to ethtool(8). For example: ``-A eth0 autoneg off rx off tx off``

   New in Chef Client 13.4.

``family``
   **Ruby Type:** String | **Default Value:** ``inet``

   Networking family option for Debian-based systems; for example: ``inet`` or ``inet6``.

   New in Chef Client 14.0.

``gateway``
   **Ruby Type:** String

   The gateway to use for the interface.

   New in Chef Client 14.4.

``hwaddr``
   **Ruby Type:** String

   The hardware address for the network interface.

``inet_addr``
   **Ruby Type:** String

   The Internet host address for the network interface.

``mask``
   **Ruby Type:** String

   The decimal representation of the network mask. For example: ``255.255.255.0``.

``master``
   **Ruby Type:** String

   Specifies the channel bonding interface to which the Ethernet interface is linked.

   New in Chef Client 13.4.

``metric``
   **Ruby Type:** String

   The routing metric for the interface.

``mtu``
   **Ruby Type:** String

   The maximum transmission unit (MTU) for the network interface.

``network``
   **Ruby Type:** String

   The address for the network interface.

``onboot``
   **Ruby Type:** String

   Bring up the network interface on boot.

``onparent``
   **Ruby Type:** String

   Bring up the network interface when its parent interface is brought up.

``slave``
   **Ruby Type:** String

   When set to ``yes``, this device is controlled by the channel bonding interface that is specified via the ``master`` property.

   New in Chef Client 13.4.

``target``
   **Ruby Type:** String | **Default Value:** ``'name'``

   The IP address that is to be assigned to the network interface. Default value: the ``name`` of the resource block. See "Syntax" section above for more information.

``vlan``
   **Ruby Type:** String

   The VLAN to assign the interface to.
   New in Chef Client 14.4.

   Common Resource Functionality
   =====================================================

   Chef resources include common properties, notifications, and resource guards.

   Common Properties
   -----------------------------------------------------

   .. tag resources_common_properties

   The following properties are common to every resource:

   ``ignore_failure``
      **Ruby Type:** true, false | **Default Value:** ``false``

      Continue running a recipe if a resource fails for any reason.

   ``retries``
      **Ruby Type:** Integer | **Default Value:** ``0``

      The number of times to catch exceptions and retry the resource.

   ``retry_delay``
      **Ruby Type:** Integer | **Default Value:** ``2``

      The retry delay (in seconds).

   ``sensitive``
      **Ruby Type:** true, false | **Default Value:** ``false``

      Ensure that sensitive resource data is not logged by the chef-client.

   .. end_tag

   Notifications
   -----------------------------------------------------
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

   Guards
   -----------------------------------------------------

   .. tag resources_common_guards

   A guard property can be used to evaluate the state of a node during the execution phase of the chef-client run. Based on the results of this evaluation, a guard property is then used to tell the chef-client if it should continue executing a resource. A guard property accepts either a string value or a Ruby block value:

   * A string is executed as a shell command. If the command returns ``0``, the guard is applied. If the command returns any other value, then the guard property is not applied. String guards in a **powershell_script** run Windows PowerShell commands and may return ``true`` in addition to ``0``.
   * A block is executed as Ruby code that must return either ``true`` or ``false``. If the block returns ``true``, the guard property is applied. If the block returns ``false``, the guard property is not applied.

   A guard property is useful for ensuring that a resource is idempotent by allowing that resource to test for the desired state as it is being executed, and then if the desired state is present, for the chef-client to do nothing.

   .. end_tag
   .. tag resources_common_guards_properties

   The following properties can be used to define a guard that is evaluated during the execution phase of the chef-client run:

   ``not_if``
      Prevent a resource from executing when the condition returns ``true``.

   ``only_if``
      Allow a resource to execute only if the condition returns ``true``.

   .. end_tag

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Configure a network interface**

.. tag resource_ifconfig_boot_protocol

.. To specify a boot protocol:

.. code-block:: ruby

   ifconfig "33.33.33.80" do
     bootproto "dhcp"
     device "eth1"
   end

will create the following interface:

.. code-block:: none

   vagrant@default-ubuntu-1204:~$ cat /etc/network/interfaces.d/ifcfg-eth1
   iface eth1 inet dhcp

.. end_tag

**Specify a boot protocol**

.. tag resource_ifconfig_configure_network_interface

.. To configure a network interface:

.. code-block:: ruby

   ifconfig '192.186.0.1' do
     device 'eth0'
   end

.. end_tag

**Specify a static IP address**

.. tag resource_ifconfig_static_ip_address

.. To specify a static IP address:

.. code-block:: ruby

   ifconfig "33.33.33.80" do
     device "eth1"
   end

will create the following interface:

.. code-block:: none

   iface eth1 inet static
     address 33.33.33.80

.. end_tag

**Update a static IP address with a boot protocol**

.. tag resource_ifconfig_update_static_ip_with_boot_protocol

.. To update a static IP address with a boot protocol*:

.. code-block:: ruby

   ifconfig "33.33.33.80" do
     bootproto "dhcp"
     device "eth1"
   end

will update the interface from ``static`` to ``dhcp``:

.. code-block:: none

   iface eth1 inet dhcp
     address 33.33.33.80

.. end_tag
