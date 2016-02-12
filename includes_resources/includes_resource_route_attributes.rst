.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``device``
   **Ruby Type:** String

   |route_device|
   
``gateway``
   **Ruby Type:** String

   |route_gateway|
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.
   
``netmask``
   **Ruby Type:** String

   |netmask| For example: ``255.255.255.0``.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst
   
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

   |target_address| |resource_block_default| |see syntax|

.. Properties in the route resource that aren't in the route provider: domain, domainname, hostname, metric, networking, networking_ipv6, route_type ... these shouldn't be visible in this properties list at this time.
