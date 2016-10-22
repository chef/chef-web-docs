.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``bcast``
   **Ruby Type:** String

   The broadcast address for a network interface. On some platforms this property is not set using ifconfig, but instead is added to the startup configuration file for the network interface.
   
``bootproto``
   **Ruby Type:** String

   The boot protocol used by a network interface.
   
``device``
   **Ruby Type:** String

   The network interface to be configured.
   
``hwaddr``
   **Ruby Type:** String

   The hardware address for the network interface.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.
   
``inet_addr``
   **Ruby Type:** String

   The Internet host address for the network interface.
   
``mask``
   **Ruby Type:** String

   The decimal representation of the network mask. For example: ``255.255.255.0``.
   
``metric``
   **Ruby Type:** String

   The routing metric for the interface.
   
``mtu``
   **Ruby Type:** String

   The maximum transmission unit (MTU) for the network interface.
   
``network``
   **Ruby Type:** String

   The address for the network interface.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``onboot``
   **Ruby Type:** String

   Bring up the network interface on boot.
   
``onparent``
   **Ruby Type:** String

   Bring up the network interface when its parent interface is brought up.
   
``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider.
   
``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst
   
``target``
   **Ruby Type:** String

   The IP address that is to be assigned to the network interface. Default value: the ``name`` of the resource block See "Syntax" section above for more information.
