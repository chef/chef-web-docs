.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``bitmap``
   **Ruby Type:** String

   The path to a file in which a write-intent bitmap is stored.
   
``chunk``
   **Ruby Type:** Integer

   The chunk size. This property should not be used for a RAID 1 mirrored pair (i.e. when the ``level`` property is set to ``1``). Default value: ``16``.
   
``devices``
   **Ruby Type:** Array

   A comma-separated list of devices to be part of a RAID array. Default value: ``[]``.
   
``exists``
   **Ruby Types:** TrueClass, FalseClass

   Indicates whether the RAID array exists. Default value: ``false``.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.
   
``level``
   **Ruby Type:** Integer

   The RAID level. Default value: ``1``.
   
``metadata``
   **Ruby Type:** String

   The superblock type for RAID metadata. Default value: ``0.90``.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider.
   
``raid_device``
   **Ruby Type:** String

   The name of the RAID device. Default value: the ``name`` of the resource block See "Syntax" section above for more information.
   
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
