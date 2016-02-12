.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.
   
``init_command``
   **Ruby Type:** String

   |command service_init| Use ``init_command`` to prevent the need to specify overrides for the ``start_command``, ``stop_command``, and ``restart_command`` properties. When this property is not specified, the |chef client| will use the default init command for the service provider being used.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst
   
``pattern``
   **Ruby Type:** String

   |pattern process_table| Default value: ``service_name``.
   
``priority``
   **Ruby Types:** Integer, String, Hash

   |debian| platform only. |priority service| May be an integer or a |ruby hash|. An integer is used to define the start run levels; stop run levels are then 100-integer. A |ruby hash| is used to define values for specific run levels. For example, ``{ 2 => [:start, 20], 3 => [:stop, 55] }`` will set a priority of twenty for run level two and a priority of fifty-five for run level three.
   
``provider``
   **Ruby Type:** Chef Class

   Optional. |provider resource_parameter| |see providers|
   
``reload_command``
   **Ruby Type:** String

   |command service_reload|
   
``restart_command``
   **Ruby Type:** String

   |command service_restart|
   
``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.
   
``service_name``
   **Ruby Type:** String

   |name service| |resource_block_default| |see syntax|
   
``start_command``
   **Ruby Type:** String

   |command service_start|
   
``status_command``
   **Ruby Type:** String

   |command service_status|
   
``stop_command``
   **Ruby Type:** String

   |command service_stop|
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

   |subscribes timers|
   
``supports``
   **Ruby Type:** Hash

   |supports service| Default value: ``{ :restart => false, :reload => false, :status => false }`` for all platforms (except for the |redhat| platform family, which defaults to ``{ :restart => false, :reload => false, :status => true }``.)
   
``timeout``
   **Ruby Type:** Integer

   |windows| platform only. |timeout| Default value: ``60``.
