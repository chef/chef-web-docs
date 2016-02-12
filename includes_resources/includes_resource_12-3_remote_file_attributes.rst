.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``atomic_update``
   **Ruby Types:** TrueClass, FalseClass

   |atomic_update| Default value: ``true``.

``backup``
   **Ruby Types:** FalseClass, Integer

   |backups_kept| Default value: ``5``.

``checksum``
   **Ruby Type:** String

   Optional, see ``use_conditional_get``. |checksum remote_file|

``force_unlink``
   **Ruby Types:** TrueClass, FalseClass

   |force_unlink| Default value: ``false``.

``ftp_active_mode``
   **Ruby Types:** TrueClass, FalseClass

   |ftp_active_mode| Default value: ``false``.

``group``
   **Ruby Types:** Integer, String

   |windows group_identifier|

``headers()``
   **Ruby Type:** Hash

   |headers custom| Default value: ``{}``. For example:

   .. code-block:: ruby

      headers({ "Cookie" => "user=grantmc; pass=p@ssw0rd!" })

   or:

   .. code-block:: ruby

      headers({ "Referer" => "#{header}" })

   or:

   .. code-block:: ruby

      headers( "Authorization"=>"Basic #{ Base64.encode64("#{username}:#{password}").strip }" )

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.

``inherits``
   **Ruby Types:** TrueClass, FalseClass

   |windows| only. |inherits windows security| Default value: ``true``.

``manage_symlink_source``
   **Ruby Types:** TrueClass, FalseClass, NilClass

   |manage_symlink_source| Possible values: ``nil``, ``true``, or ``false``. When this value is set to ``nil``, the |chef client| will manage a symlink's source file and emit a warning. When this value is set to ``true``, the |chef client| will manage a symlink's source file and not emit a warning. Default value: ``nil``. The default value will be changed to ``false`` in a future version.

``mode``
   **Ruby Types:** Integer, String

   |mode resource| |mode resource_file|
       
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

   |path full_path_to_file| |resource_block_default| |see syntax|

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

``source``
   **Ruby Types:** String, Array

   Required. |source file_location| |source file_location http_ftp_local|
       
   .. include:: ../../includes_file/includes_file_12-3_remote_source_location.rst


``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

   |subscribes timers|

``use_conditional_get``
   **Ruby Types:** TrueClass, FalseClass

   |use conditional_get| Default value: ``true``.

``use_etag``
   **Ruby Types:** TrueClass, FalseClass

   |use etag| Default value: ``true``.

``use_last_modified``
   **Ruby Types:** TrueClass, FalseClass

   |use last_modified| Default value: ``true``.

``verify``
   **Ruby Types:** String, Block

   |verify_file|

   .. include:: ../../includes_resources/includes_resource_remote_file_attributes_verify.rst
