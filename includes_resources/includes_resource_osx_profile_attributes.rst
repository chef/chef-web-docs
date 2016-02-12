.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``identifier``
   **Ruby Type:** String

   Use to specify the identifier for the profile, such as ``com.company.screensaver``.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst

``profile``
   **Ruby Types:** String, Hash

   Use to specify a profile. This may be the name of a profile contained in a cookbook or a |ruby hash| that contains the contents of the profile.
   
``profile_name``
   **Ruby Type:** String

   Use to specify the name of the profile, if different from the name of the resource block.
   
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
