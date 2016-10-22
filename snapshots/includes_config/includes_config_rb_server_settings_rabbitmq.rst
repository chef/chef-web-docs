.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``rabbitmq``:

``rabbitmq['actions_exchange']``
   The name of the exchange to which Chef actions publishes actions data. Default value: ``'actions'``.

``rabbitmq['actions_password']``
   The password for the ``actions_user``. Default value: ``'changeme'``.

``rabbitmq['actions_user']``
   The user with permission to publish actions data. Default value: ``'actions'``.

``rabbitmq['actions_vhost']``
   The virtual host to which Chef actions publishes actions data. Default value: ``'/analytics'``.

``rabbitmq['analytics_max_length']``
   The maximum number of messages that can be queued before RabbitMQ automatically drops messages from the front of the queue to make room for new messages. Default value: ``10000``.

``rabbitmq['consumer_id']``
   The identity of the consumer to which messages are published. Default value: ``'hotsauce'``.

``rabbitmq['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value: ``'/var/opt/opscode/rabbitmq/db'``.

``rabbitmq['dir']``
   The working directory. The default value is the recommended value. Default value: ``'/var/opt/opscode/rabbitmq'``.

``rabbitmq['drop_on_full_capacity']``
   Specify if messages will stop being sent to the RabbitMQ queue when it is at capacity. Default value: ``true``.

``rabbitmq['enable']``
   Enable a service. Default value: ``true``.

``rabbitmq['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``rabbitmq['jobs_password']``
   Default value: ``'workcomplete'``.

``rabbitmq['jobs_user']``
   Default value: ``'jobs'``.

``rabbitmq['jobs_vhost']``
   Default value: ``'/jobs'``.

``rabbitmq['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``'/var/log/opscode/rabbitmq'``.

``rabbitmq['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``rabbitmq['management_enabled']``
   Specify if the rabbitmq-management plugin is enabled. Default value: ``true``.

``rabbitmq['management_password']``
   The rabbitmq-management plugin password. Default value: ``'chefrocks'``.

``rabbitmq['management_port']``
   The rabbitmq-management plugin port. Default value: ``15672``.

``rabbitmq['management_user']``
   The rabbitmq-management plugin user. Default value: ``'rabbitmgmt'``.

``rabbitmq['node_ip_address']``
   The bind IP address for RabbitMQ. Default value: ``'127.0.0.1'``.

   Chef Analytics uses the same RabbitMQ service that is configured on the Chef server. When the Chef Analytics server is configured as a standalone server, the default settings for ``rabbitmq['node_ip_address']`` and ``rabbitmq['vip']`` must be updated. When the Chef Analytics server is configured as a standalone server, change this value to ``0.0.0.0``.

``rabbitmq['node_port']``
   The port on which the service is to listen. Default value: ``'5672'``.

``rabbitmq['nodename']``
   The name of the node. Default value: ``'rabbit@localhost'``.

``rabbitmq['password']``
   The password for the RabbitMQ user. Default value: ``'chefrocks'``.

``rabbitmq['prevent_erchef_startup_on_full_capacity']``
   Specify if the Chef server will start when the monitored RabbitMQ queue is full. Default value: ``false``.

``rabbitmq['queue_at_capacity_affects_overall_status']``
   Specify if the ``_status`` endpoint in the Chef server API will fail if the monitored queue is at capacity. Default value: ``false``.

``rabbitmq['queue_length_monitor_enabled']``
   Specify if the queue length monitor is enabled. Default value: ``true``.

``rabbitmq['queue_length_monitor_millis']``
   The frequency (in milliseconds) at which the length of the RabbitMQ queue is checked. Default value: ``30000``.

``rabbitmq['queue_length_monitor_timeout_millis']``
   The timeout (in milliseconds) at which calls to the queue length monitor will stop if the Chef server is overloaded. Default value: ``5000``.

``rabbitmq['queue_length_monitor_queue']``
   The RabbitMQ queue that is observed by queue length monitor. Default value: ``'alaska'``.

``rabbitmq['queue_length_monitor_vhost']``
   The virtual host for the RabbitMQ queue that is observed by queue length monitor. Default value: ``'/analytics'``.

``rabbitmq['rabbit_mgmt_http_cull_interval']``
   The maximum cull interval (in seconds) for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``60``.

``rabbitmq['rabbit_mgmt_http_init_count']``
   The initial worker count for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``25``.

``rabbitmq['rabbit_mgmt_http_max_age']``
   The maximum connection worker age (in seconds) for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``70``.

``rabbitmq['rabbit_mgmt_http_max_connection_duration']``
   The maximum connection duration (in seconds) for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``70``.

``rabbitmq['rabbit_mgmt_http_max_count']``
   The maximum worker count for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``100``.

``rabbitmq['rabbit_mgmt_ibrowse_options']``
   An array of comma-separated key-value pairs of ibrowse options for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``'{connect_timeout, 10000}'``.

``rabbitmq['rabbit_mgmt_timeout']``
   The timeout for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``30000``.

``rabbitmq['reindexer_vhost']``
   Default value: ``'/reindexer'``.

``rabbitmq['ssl_versions']``
   The SSL versions used by the rabbitmq-management plugin. (See also |url rabbitmqssl|.) Default value: ``['tlsv1.2', 'tlsv1.1']``.

``rabbitmq['user']``
   Default value: ``'chef'``.

``rabbitmq['vhost']``
   Default value: ``'/chef'``.

``rabbitmq['vip']``
   The virtual IP address. Default value: ``'127.0.0.1'``.

   Chef Analytics uses the same RabbitMQ service that is configured on the Chef server. When the Chef Analytics server is configured as a standalone server, the default settings for ``rabbitmq['node_ip_address']`` and ``rabbitmq['vip']`` must be updated. When the Chef Analytics server is configured as a standalone server, this value should be updated to be the backend VIP address for the Chef server.
