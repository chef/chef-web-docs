.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``comment``
   **Ruby Type:** String

   |comment user|

``force``
   **Ruby Types:** TrueClass, FalseClass

   |force_remove_user|

   .. warning:: .. include:: ../../includes_notes/includes_notes_user_resource_force_property.rst

``gid``
   **Ruby Types:** String, Integer

   |id group|

``home``
   **Ruby Type:** String

   |home_directory|

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.

``manage_home``
   **Ruby Types:** TrueClass, FalseClass

   |user homedir|

   |user homedir_create|

   |user homedir_modify|

``non_unique``
   **Ruby Types:** TrueClass, FalseClass

   |non_unique_user|

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst

``password``
   **Ruby Type:** String

   |password shadow_hash|

``provider``
   **Ruby Type:** Chef Class

   Optional. |provider resource_parameter| |see providers|

``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.

``shell``
   **Ruby Type:** String

   |shell|

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

   |subscribes timers|

``supports``
   **Ruby Type:** Hash

   |supports user| Default value: ``:manage_home => false, :non_unique => false``.

``system``
   **Ruby Types:** TrueClass, FalseClass

   |system user|

``uid``
   **Ruby Types:** String, Integer

   |user uid|

``username``
   **Ruby Type:** String

   |name user| |resource_block_default| |see syntax|
