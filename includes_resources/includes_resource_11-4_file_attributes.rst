.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``backup``
   **Ruby Types:** FalseClass, Integer

   |backups_kept| Default value: ``5``.

``checksum``
   **Ruby Type:** String

   |checksum file| Default value: no checksum required.

``content``
   **Ruby Type:** String

   |content file| The default behavior will not modify content.

``group``
   **Ruby Types:** Integer, String

   |windows group_identifier|

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.

``inherits``
   **Ruby Types:** TrueClass, FalseClass

   |windows| only. |inherits windows security| Default value: ``true``.

``mode``
   **Ruby Types:** Integer, String

   |mode resource| |mode resource_file_11-4|
       
   The behavior is different depending on the platform.
       
   |unix|- and |linux|-based systems: |mode *nix|
       
   |windows|: |mode windows security|

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst

``owner``
   **Ruby Types:** Integer, String

   |owner windows security|	

``path``
   **Ruby Type:** String

   |path full_path_to_file| For example: ``/files/file.txt``. |resource_block_default| |see syntax|

``provider``
   **Ruby Type:** Chef Class

   Optional. |provider resource_parameter|

``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.

``rights``
   **Ruby Types:** Integer, String

   |windows| only. |rights windows security|

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

   |subscribes timers|
