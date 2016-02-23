.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``chef_server``
   **Ruby Type:** Hash

   |chef_server_url|
   
``command``
   **Ruby Type:** String

   |name command| |resource_block_default| |see syntax|
   
``driver``
   **Ruby Type:** Chef::Provisioning::Driver

   Use to specify the driver to be used for provisioning.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.
   
``live_stream``
   **Ruby Types:** TrueClass, FalseClass

   Default value: ``false``.
   
``machine``
   **Ruby Type:** String

   Use to specify the machine type.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst
