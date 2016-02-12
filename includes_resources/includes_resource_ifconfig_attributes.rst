.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``bcast``
   **Ruby Type:** String

   |broadcast_address|
   
``bootproto``
   **Ruby Type:** String

   |boot_protocol|
   
``device``
   **Ruby Type:** String

   |device ifconfig|
   
``hwaddr``
   **Ruby Type:** String

   |hardware_address|
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.
   
``inet_addr``
   **Ruby Type:** String

   |internet_host_address|
   
``mask``
   **Ruby Type:** String

   |netmask| For example: ``255.255.255.0``.
   
``metric``
   **Ruby Type:** String

   |routing_metric|
   
``mtu``
   **Ruby Type:** String

   |maximum_transmission_unit|
   
``network``
   **Ruby Type:** String

   |network_address|
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst
   
``onboot``
   **Ruby Type:** String

   |onboot ifconfig|
   
``onparent``
   **Ruby Type:** String

   |onparent ifconfig|
   
``provider``
   **Ruby Type:** Chef Class

   Optional. |provider resource_parameter|
   
``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

   |subscribes timers|
   
``target``
   **Ruby Type:** String

   |target_interface| |resource_block_default| |see syntax|
