.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``cookbook``
   **Ruby Type:** String

   |cookbook file_location| The default value is the current cookbook.
   
``files_backup``
   **Ruby Types:** Integer, FalseClass

   |files_backup| Default value: ``5``.
   
``files_group``
   **Ruby Type:** String

   |files_group| |windows group_identifier|
   
``files_mode``
   **Ruby Type:** String

   The octal mode for a file.
       
   |unix|- and |linux|-based systems: |mode *nix|
       
   |windows|: |mode windows security|
   
``files_owner``
   **Ruby Type:** String

   |files_owner| |owner windows security|
   
``group``
   **Ruby Types:** Integer, String

   Use to configure permissions for directories. |windows group_identifier|
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.
   
``inherits``
   **Ruby Types:** TrueClass, FalseClass

   |windows| only. |inherits windows security| Default value: ``true``.
   
``mode``
   **Ruby Types:** Integer, String

   |mode resource| |mode resource_directory|
       
   The behavior is different depending on the platform.
       
   |unix|- and |linux|-based systems: |mode *nix|
       
   |windows|: |mode windows security|
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst
   
``overwrite``
   **Ruby Types:** TrueClass, FalseClass

   |use file_overwrite| Default value: ``true``.
   
``owner``
   **Ruby Types:** Integer, String

   Use to configure permissions for directories. |owner windows security|
   
``path``
   **Ruby Type:** String

   |path directory| |path_fully_qualified| |resource_block_default| |see syntax|
   
``provider``
   **Ruby Type:** Chef Class

   Optional. |provider resource_parameter|
   
``purge``
   **Ruby Types:** TrueClass, FalseClass

   |purge target_directory| Default value: ``false``.
   
``recursive``
   **Ruby Types:** TrueClass, FalseClass

   |recursive remote_directory| Default value: ``true``; the |chef client| must be able to create the directory structure, including parent directories (if missing), as defined in ``COOKBOOK_NAME/files/default/REMOTE_DIRECTORY``.
   
``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.
   
``rights``
   **Ruby Types:** Integer, String

   |windows| only. |rights windows security|
   
``source``
   **Ruby Type:** String

   |source remote_directory|
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

   |subscribes timers|
