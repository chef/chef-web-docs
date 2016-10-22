.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``code``
   **Ruby Type:** String

   The code to be executed on a node located within a distributed Erlang system. Default value: ``q()``.
   
``cookie``
   **Ruby Type:** String

   The magic cookie for the node to which a connection is made.
   
``distributed``
   **Ruby Types:** TrueClass, FalseClass

   The node is a distributed Erlang node. Default value: ``false``.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.
   
``name_type``
   **Ruby Type:** String

   The ``node_name`` property as a short node name (``sname``) or a long node name (``name``). A node with a long node name cannot communicate with a node with a short node name. Default value: ``sname``.
   
``node_name``
   **Ruby Type:** String

   The hostname to which the node is to connect. Default value: ``chef@localhost``.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider.
   
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
