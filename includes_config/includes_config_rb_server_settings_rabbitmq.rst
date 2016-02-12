.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``rabbitmq``:

``rabbitmq['actions_exchange']``
   The name of the exchange to which |chef actions| publishes actions data. Default value: ``'actions'``.

``rabbitmq['actions_password']``
   The password for the ``actions_user``. Default value: ``'changeme'``.

``rabbitmq['actions_user']``
   The user with permission to publish actions data. Default value: ``'actions'``.

``rabbitmq['actions_vhost']``
   The virtual host to which |chef actions| publishes actions data. Default value: ``'/analytics'``.

``rabbitmq['analytics_max_length']``
   |rabbitmq analytics_max_length| Default value: ``10000``.

``rabbitmq['consumer_id']``
   The identity of the consumer to which messages are published. Default value: ``'hotsauce'``.

``rabbitmq['data_dir']``
   |directory generic_data| |default_value_recommended| Default value: ``'/var/opt/opscode/rabbitmq/db'``.

``rabbitmq['dir']``
   |directory generic| |default_value_recommended| Default value: ``'/var/opt/opscode/rabbitmq'``.

``rabbitmq['drop_on_full_capacity']``
   |rabbitmq drop_on_full| Default value: ``true``.

``rabbitmq['enable']``
   |enable service| Default value: ``true``.

``rabbitmq['ha']``
   |use ha| |ha true| Default value: ``false``.

``rabbitmq['jobs_password']``
   Default value: ``'workcomplete'``.

``rabbitmq['jobs_user']``
   Default value: ``'jobs'``.

``rabbitmq['jobs_vhost']``
   Default value: ``'/jobs'``.

``rabbitmq['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``'/var/log/opscode/rabbitmq'``.

``rabbitmq['log_rotation']``
   |log_rotation| Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``rabbitmq['management_enabled']``
   |rabbitmq management_enabled| Default value: ``true``.

``rabbitmq['management_password']``
   |rabbitmq management_password| Default value: ``'chefrocks'``.

``rabbitmq['management_port']``
   |rabbitmq management_port| Default value: ``15672``.

``rabbitmq['management_user']``
   |rabbitmq management_user| Default value: ``'rabbitmgmt'``.

``rabbitmq['node_ip_address']``
   |ip_address rabbitmq| Default value: ``'127.0.0.1'``.

   |analytics rabbitmq_settings| When the |chef analytics| server is configured as a standalone server, change this value to ``0.0.0.0``.

``rabbitmq['node_port']``
   |port service| Default value: ``'5672'``.

``rabbitmq['nodename']``
   |name node| Default value: ``'rabbit@localhost'``.

``rabbitmq['password']``
   |password rabbitmq| Default value: ``'chefrocks'``.

``rabbitmq['prevent_erchef_startup_on_full_capacity']``
   |rabbitmq prevent_startup| Default value: ``false``.

``rabbitmq['queue_at_capacity_affects_overall_status']``
   |rabbitmq capacity_affects_status| Default value: ``false``.

``rabbitmq['queue_length_monitor_enabled']``
   |rabbitmq qmon_enabled| Default value: ``true``.

``rabbitmq['queue_length_monitor_millis']``
   |rabbitmq qmon_milliseconds| Default value: ``30000``.

``rabbitmq['queue_length_monitor_timeout_millis']``
   |rabbitmq qmon_timeout_milliseconds| Default value: ``5000``.

``rabbitmq['queue_length_monitor_queue']``
   |rabbitmq qmon_queue| Default value: ``'alaska'``.

``rabbitmq['queue_length_monitor_vhost']``
   |rabbitmq qmon_vhost| Default value: ``'/analytics'``.

``rabbitmq['rabbit_mgmt_http_cull_interval']``
   |rabbit_mgmt_http_cull_interval| Default value: ``60``.

``rabbitmq['rabbit_mgmt_http_init_count']``
   |rabbit_mgmt_http_init_count| Default value: ``25``.

``rabbitmq['rabbit_mgmt_http_max_age']``
   |rabbit_mgmt_http_max_age| Default value: ``70``.

``rabbitmq['rabbit_mgmt_http_max_connection_duration']``
   |rabbit_mgmt_http_max_connection_duration| Default value: ``70``.

``rabbitmq['rabbit_mgmt_http_max_count']``
   |rabbit_mgmt_http_max_count| Default value: ``100``.

``rabbitmq['rabbit_mgmt_ibrowse_options']``
   |rabbit_mgmt_ibrowse_options| Default value: ``'{connect_timeout, 10000}'``.

``rabbitmq['rabbit_mgmt_timeout']``
   |rabbit_mgmt_timeout| Default value: ``30000``.

``rabbitmq['reindexer_vhost']``
   Default value: ``'/reindexer'``.

``rabbitmq['ssl_versions']``
   |rabbitmq ssl_versions| (See also |url rabbitmqssl|.) Default value: ``['tlsv1.2', 'tlsv1.1']``.

``rabbitmq['user']``
   Default value: ``'chef'``.

``rabbitmq['vhost']``
   Default value: ``'/chef'``.

``rabbitmq['vip']``
   |ip_address virtual| Default value: ``'127.0.0.1'``.

   |analytics rabbitmq_settings| When the |chef analytics| server is configured as a standalone server, this value should be updated to be the backend VIP address for the |chef server|.
