.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. note:: Chef Analytics has been replaced by Chef Automate.

The following settings must be modified when the Chef Analytics server is configured as a standalone server:

``rabbitmq['node_ip_address']``
   The bind IP address for RabbitMQ. Default value: ``"127.0.0.1"``.

   Chef Analytics uses the same RabbitMQ service that is configured on the Chef server. When the Chef Analytics server is configured as a standalone server, the default settings for ``rabbitmq['node_ip_address']`` and ``rabbitmq['vip']`` must be updated. When the Chef Analytics server is configured as a standalone server, change this value to ``0.0.0.0``.

``rabbitmq['vip']``
   The virtual IP address. Default value: ``"127.0.0.1"``.

   Chef Analytics uses the same RabbitMQ service that is configured on the Chef server. When the Chef Analytics server is configured as a standalone server, the default settings for ``rabbitmq['node_ip_address']`` and ``rabbitmq['vip']`` must be updated. When the Chef Analytics server is configured as a standalone server, change this value to the backend VIP address for the Chef server.
