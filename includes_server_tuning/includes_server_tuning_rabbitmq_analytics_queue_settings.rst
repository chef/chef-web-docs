.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following settings may be used for tuning |rabbitmq| queues used by |chef analytics| and the |chef server|:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``rabbitmq['analytics_max_length']``
     - |rabbitmq analytics_max_length| Default value: ``10000``.
   * - ``rabbitmq['drop_on_full_capacity']``
     - |rabbitmq drop_on_full| Default value: ``true``.
   * - ``rabbitmq['management_enabled']``
     - |rabbitmq management_enabled| Default value: ``true``.
   * - ``rabbitmq['management_password']``
     - |rabbitmq management_password| Default value: ``'chefrocks'``.
   * - ``rabbitmq['management_port']``
     - |rabbitmq management_port| Default value: ``15672``.
   * - ``rabbitmq['management_user']``
     - |rabbitmq management_user| Default value: ``'rabbitmgmt'``.
   * - ``rabbitmq['prevent_erchef_startup_on_full_capacity']``
     - |rabbitmq prevent_startup| Default value: ``false``.
   * - ``rabbitmq['queue_at_capacity_affects_overall_status']``
     - |rabbitmq capacity_affects_status| Default value: ``false``.
   * - ``rabbitmq['queue_length_monitor_enabled']``
     - |rabbitmq qmon_enabled| Default value: ``true``.
   * - ``rabbitmq['queue_length_monitor_millis']``
     - |rabbitmq qmon_milliseconds| Default value: ``30000``.
   * - ``rabbitmq['queue_length_monitor_timeout_millis']``
     - |rabbitmq qmon_timeout_milliseconds| Default value: ``5000``.
   * - ``rabbitmq['queue_length_monitor_queue']``
     - |rabbitmq qmon_queue| Default value: ``'alaska'``.
   * - ``rabbitmq['queue_length_monitor_vhost']``
     - |rabbitmq qmon_vhost| Default value: ``'/analytics'``.
   * - ``rabbitmq['rabbit_mgmt_http_cull_interval']``
     - |rabbit_mgmt_http_cull_interval| Default value: ``60``.
   * - ``rabbitmq['rabbit_mgmt_http_init_count']``
     - |rabbit_mgmt_http_init_count| Default value: ``25``.
   * - ``rabbitmq['rabbit_mgmt_http_max_age']``
     - |rabbit_mgmt_http_max_age| Default value: ``70``.
   * - ``rabbitmq['rabbit_mgmt_http_max_connection_duration']``
     - |rabbit_mgmt_http_max_connection_duration| Default value: ``70``.
   * - ``rabbitmq['rabbit_mgmt_http_max_count']``
     - |rabbit_mgmt_http_max_count| Default value: ``100``.
   * - ``rabbitmq['rabbit_mgmt_ibrowse_options']``
     - |rabbit_mgmt_ibrowse_options| Default value: ``'{connect_timeout, 10000}'``.
   * - ``rabbitmq['rabbit_mgmt_timeout']``
     - |rabbit_mgmt_timeout| Default value: ``30000``.
   * - ``rabbitmq['ssl_versions']``
     - |rabbitmq ssl_versions| (See also |url rabbitmqssl|.) Default value: ``['tlsv1.2', 'tlsv1.1']``.
