.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``delay_mins``
   **Ruby Type:** Fixnum

   The amount of time (in seconds) to delay a reboot request.

   .. note:: This setting must be entered in seconds. Starting with |chef client| 12.5, this property is updated to correctly allow the entering of time in minutes.


``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources/includes_resource_service_reboot_attributes_notifies_syntax.rst

``reason``
   **Ruby Type:** String

   |reboot reason|

``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources/includes_resource_service_reboot_attributes_subscribes_syntax.rst

   |subscribes timers|
