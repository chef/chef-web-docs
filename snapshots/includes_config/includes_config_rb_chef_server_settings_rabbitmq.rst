.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``rabbitmq['consumer_id']``
   Default value: ``hotsauce``.

``rabbitmq['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value: ``/var/opt/chef-server/rabbitmq/db``.

``rabbitmq['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/chef-server/rabbitmq``.

``rabbitmq['enable']``
   Enable a service. Default value: ``true``.

``rabbitmq['ha']``
   Run the Chef server in a high availability topology. Default value: ``false``.

``rabbitmq['log_directory']``
   The directory in which log files are located. Default value: ``/var/log/chef-server/rabbitmq``.

``rabbitmq['node_ip_address']``
   The bind IP address for RabbitMQ. Default value: ``0.0.0.0``.

``rabbitmq['node_port']``
   The port on which the service is to listen. Default value: ``5672``.

``rabbitmq['nodename']``
   The name of the node.  Default value: ``rabbit@localhost``.

``rabbitmq['password']``
   The password for the RabbitMQ user. Default value: ``chefrocks``.

``rabbitmq['user']``
   The user. Default value: ``chef``.

``rabbitmq['vhost']``
   The virtual host. Default value: ``/chef``.

``rabbitmq['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.
