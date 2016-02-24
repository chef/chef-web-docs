.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``architecture``
   **Ruby Type:** Symbol

   |architecture windows_process| |architecture windows_process_i386| Possible values: ``:i386`` (for 32-bit processes) and ``:x86_64`` (for 64-bit processes).

``code``
   **Ruby Type:** String

   |code quoted_string|

``command``
   **Ruby Types:** String, Array

   |name command|

``creates``
   **Ruby Type:** String

   |creates file_exists|

``cwd``
   **Ruby Type:** String

   |cwd run_command|

``flags``
   **Ruby Type:** String

   |flags|

``group``
   **Ruby Types:** String, Integer

   |group command|

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst

``provider``
   **Ruby Type:** Chef Class

   Optional. |provider resource_parameter|

``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.

``returns``
   **Ruby Types:** Integer, Array

   |return_value cmd| Default value: ``0``.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst

``timeout``
   **Ruby Types:** Integer, Float

   |timeout command| Default value: ``3600``.

``user``
   **Ruby Types:** String, Integer

   |user name_or_id|

.. note:: .. include:: ../../includes_notes/includes_notes_batch_resource_link_to_cmdexe_technet.rst
