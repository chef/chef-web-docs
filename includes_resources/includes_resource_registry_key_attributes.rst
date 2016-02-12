.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``architecture``
   **Ruby Type:** Symbol

   |architecture registry_key| Default value: ``:machine``.

   |architecture registry_key machine|

   .. note:: .. include:: ../../includes_notes/includes_notes_registry_key_architecture.rst
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.
   
``key``
   **Ruby Type:** String

   |key_name resource registry_key| |resource_block_default| |see syntax|
   |key_name resource registry_key hives|
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst
   
``provider``
   **Ruby Type:** Chef Class

   Optional. |provider resource_parameter|
   
``recursive``
   **Ruby Types:** TrueClass, FalseClass

   |recursive registry_key|

   .. note:: .. include:: ../../includes_notes/includes_notes_registry_key_resource_recursive.rst
   
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
   
``values``
   **Ruby Types:** Hash, Array

   |values resource registry_key|
       
   |values resource registry_key types|

   .. warning:: |values resource registry_key multi_string|
