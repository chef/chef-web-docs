.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``append``
   **Ruby Types:** TrueClass, FalseClass

   |append_group| Default value: ``false``.
   
``excluded_members``
   **Ruby Type:** Array

   |excluded_members|
   
``gid``
   **Ruby Types:** String, Integer

   |id group|
   
``group_name``
   **Ruby Type:** String

   |name group| |resource_block_default| |see syntax|
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.
   
``members``
   **Ruby Type:** Array

   |members_group| When more than one group member is identified, the list of members should be an array: ``members ['user1', 'user2']``.
   
``non_unique``
   **Ruby Types:** TrueClass, FalseClass

   |non_unique_members| Default value: ``false``.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``provider``
   **Ruby Type:** Chef Class

   Optional. |provider resource_parameter| |see providers|
   
``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst
   
``system``
   **Ruby Types:** TrueClass, FalseClass

   |system group|
