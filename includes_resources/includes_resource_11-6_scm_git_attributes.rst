.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following attributes:

``additional_remotes``
   **Ruby Type:** Hash

   |additional_remotes|

``depth``
   **Ruby Type:** Integer

   |depth git_shallow_clone| The default behavior will do a full clone.

``destination``
   **Ruby Type:** String

   |destination resource scm| |resource_block_default| |see syntax|

``enable_submodules``
   **Ruby Types:** TrueClass, FalseClass

   |enable_submodules| Default value: ``false``.

``group``
   **Ruby Types:** String, Integer

   |group deploy|

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst

``provider``
   **Ruby Type:** Chef Class

   Optional. |provider resource_parameter|

``reference``
   **Ruby Type:** String

   |reference resource scm|

``remote``
   **Ruby Type:** String

   |remote resource|

``repository``
   **Ruby Type:** String

   |uri repository_git|

``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.

``revision``
   **Ruby Type:** String

   |revision| Default value: ``HEAD``.

   .. include:: ../../includes_resources/includes_resource_scm_git_attributes_revision.rst

``ssh_wrapper``
   **Ruby Type:** String

   |ssh_wrapper resource|

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

   |subscribes timers|

``user``
   **Ruby Types:** String, Integer

   |user checked_out_code|
