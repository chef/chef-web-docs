.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This resource has the following properties:

``destination``
   **Ruby Type:** String

   |destination resource scm| |resource_block_default| |see syntax|

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

``repository``
   **Ruby Type:** String

   |uri repository_svn|

``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.

``revision``
   **Ruby Type:** String

   |revision| Default value: ``HEAD``.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

   |subscribes timers|

``svn_arguments``
   **Ruby Type:** String

   |svn_arguments resource|

``svn_info_args``
   **Ruby Type:** String

   |svn_info_args resource|

``svn_password``
   **Ruby Type:** String

   |svn_password resource|

``svn_username``
   **Ruby Type:** String

   |svn_username resource|

``user``
   **Ruby Types:** String, Integer

   |user checked_out_code|
