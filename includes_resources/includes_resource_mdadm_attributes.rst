.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``bitmap``
   **Ruby Type:** String

   |path bitmap|
   
``chunk``
   **Ruby Type:** Integer

   |chunk_size| This property should not be used for a RAID 1 mirrored pair (i.e. when the ``level`` property is set to ``1``). Default value: ``16``.
   
``devices``
   **Ruby Type:** Array

   |device mdadm| Default value: ``[]``.
   
``exists``
   **Ruby Types:** TrueClass, FalseClass

   |raid_device exists| Default value: ``false``.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.
   
``level``
   **Ruby Type:** Integer

   |level mdadm| Default value: ``1``.
   
``metadata``
   **Ruby Type:** String

   |raid_device superblock_type| Default value: ``0.90``.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst
   
``provider``
   **Ruby Type:** Chef Class

   Optional. |provider resource_parameter|
   
``raid_device``
   **Ruby Type:** String

   |raid_device mdadm| |resource_block_default| |see syntax|
   
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
