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

``rabbitmq['consumer_id']``
   The identity of the consumer to which messages are published. Default value: ``'hotsauce'``.

``rabbitmq['data_dir']``
   |directory generic_data| |default_value_recommended| Default value: ``'/var/opt/opscode/rabbitmq/db'``.

``rabbitmq['dir']``
   |directory generic| |default_value_recommended| Default value: ``'/var/opt/opscode/rabbitmq'``.

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

``rabbitmq['node_ip_address']``
   |ip_address rabbitmq| Default value: ``'127.0.0.1'``.

   |analytics rabbitmq_settings| When the |chef analytics| server is configured as a standalone server, change this value to ``0.0.0.0``.

``rabbitmq['node_port']``
   |port service| Default value: ``'5672'``.

``rabbitmq['nodename']``
   |name node| Default value: ``'rabbit@localhost'``.

``rabbitmq['password']``
   |password rabbitmq| Default value: ``'chefrocks'``.

``rabbitmq['reindexer_vhost']``
   Default value: ``'/reindexer'``.

``rabbitmq['user']``
   Default value: ``'chef'``.

``rabbitmq['vhost']``
   Default value: ``'/chef'``.

``rabbitmq['vip']``
   |ip_address virtual| Default value: ``'127.0.0.1'``.

   |analytics rabbitmq_settings| When the |chef analytics| server is configured as a standalone server, change this value to the backend VIP address for the |chef server|.
