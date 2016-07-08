.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. note:: Chef Analytics has been replaced by Chef Automate.

The following settings must be modified when the |chef analytics| server is configured as a standalone server:

``rabbitmq['node_ip_address']``
   |ip_address rabbitmq| Default value: ``"127.0.0.1"``.

   |analytics rabbitmq_settings| When the |chef analytics| server is configured as a standalone server, change this value to ``0.0.0.0``.

``rabbitmq['vip']``
   |ip_address virtual| Default value: ``"127.0.0.1"``.

   |analytics rabbitmq_settings| When the |chef analytics| server is configured as a standalone server, change this value to the backend VIP address for the |chef server|.
