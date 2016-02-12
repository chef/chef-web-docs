.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``format``
   Use to specify the format of a public key. Possible values: ``pem`` and ``der``. Default value: ``pem``.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst
   
``path``
   The path to a public key.
   
``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.
   
``source_key``
   Use to copy a public key, but apply a different ``format`` and ``password``. Use in conjunction with ``source_key_pass_phrase``` and ``source_key_path``.
   
``source_key_pass_phrase``
   The pass phrase for the public key. Use in conjunction with ``source_key``` and ``source_key_path``.
   
``source_key_path``
   The path to the public key. Use in conjunction with ``source_key``` and ``source_key_pass_phrase``.
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

   |subscribes timers|
