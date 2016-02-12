.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``checksum``
   **Ruby Type:** String

   |checksum remote_file| Use when a URL is specified by the ``source`` property.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.

``installer_type``
   **Ruby Type:** Symbol

   |type package| Possible values: ``:msi``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst

``options``
   **Ruby Type:** String

   |command options|

``provider``
   **Ruby Type:** Chef Class

   Optional. |provider resource_parameter| |see providers|

``remote_file_attributes``
   **Ruby Type:** Hash

   |remote_file_attributes|

``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.

``returns``
   **Ruby Types:** String, Integer, Array

   |returns| This code signals a successful ``:install`` action. Default value: ``0``.

``source``
   **Ruby Type:** String

   Optional. |source resource package| The location of the package may be at a URL. |resource_block_default| |see syntax|

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

   |subscribes timers|

``timeout``
   **Ruby Types:** String, Integer

   |timeout| Default value: ``600`` (seconds).
