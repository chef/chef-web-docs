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

``rabbitmq['consumer_id']``
   The identity of the consumer to which messages are published. Default value: ``'hotsauce'``.

``rabbitmq['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value: ``'/var/opt/opscode/rabbitmq/db'``.

``rabbitmq['dir']``
   The working directory. The default value is the recommended value. Default value: ``'/var/opt/opscode/rabbitmq'``.

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

``rabbitmq['node_ip_address']``
   The bind IP address for RabbitMQ. Default value: ``'127.0.0.1'``.

   Chef Analytics uses the same RabbitMQ service that is configured on the Chef server. When the Chef Analytics server is configured as a standalone server, the default settings for ``rabbitmq['node_ip_address']`` and ``rabbitmq['vip']`` must be updated. When the Chef Analytics server is configured as a standalone server, change this value to ``0.0.0.0``.

``rabbitmq['node_port']``
   The port on which the service is to listen. Default value: ``'5672'``.

``rabbitmq['nodename']``
   The name of the node. Default value: ``'rabbit@localhost'``.

``rabbitmq['password']``
   The password for the RabbitMQ user. Default value: ``'chefrocks'``.

``rabbitmq['reindexer_vhost']``
   Default value: ``'/reindexer'``.

``rabbitmq['user']``
   Default value: ``'chef'``.

``rabbitmq['vhost']``
   Default value: ``'/chef'``.

``rabbitmq['vip']``
   The virtual IP address. Default value: ``'127.0.0.1'``.

   Chef Analytics uses the same RabbitMQ service that is configured on the Chef server. When the Chef Analytics server is configured as a standalone server, the default settings for ``rabbitmq['node_ip_address']`` and ``rabbitmq['vip']`` must be updated. When the Chef Analytics server is configured as a standalone server, change this value to the backend VIP address for the Chef server.
