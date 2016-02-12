.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``rabbitmq['consumer_id']``
   Default value: ``hotsauce``.

``rabbitmq['data_dir']``
   |directory generic_data| |default_value_recommended| Default value: ``/var/opt/chef-server/rabbitmq/db``.

``rabbitmq['dir']``
   |directory generic| |default_value_recommended| Default value: ``/var/opt/chef-server/rabbitmq``.

``rabbitmq['enable']``
   |enable service| Default value: ``true``.

``rabbitmq['ha']``
   |use ha| Default value: ``false``.

``rabbitmq['log_directory']``
   The directory in which log files are located. Default value: ``/var/log/chef-server/rabbitmq``.

``rabbitmq['node_ip_address']``
   |ip_address rabbitmq| Default value: ``0.0.0.0``.

``rabbitmq['node_port']``
   |port service| Default value: ``5672``.

``rabbitmq['nodename']``
   |name node|  Default value: ``rabbit@localhost``.

``rabbitmq['password']``
   |password rabbitmq| Default value: ``chefrocks``.

``rabbitmq['user']``
   The user. Default value: ``chef``.

``rabbitmq['vhost']``
   The virtual host. Default value: ``/chef``.

``rabbitmq['vip']``
   |ip_address virtual| Default value: ``127.0.0.1``.
