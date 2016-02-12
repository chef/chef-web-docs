=====================================================
Monitor |chef analytics_title|
=====================================================

Application-level checks should be done periodically to ensure that there is enough disk space.

|zookeeper|
=====================================================
.. include:: ../../includes_server_monitor/includes_server_monitor_analytics_zookeeper.rst

Remove Events
=====================================================
.. include:: ../../includes_server_monitor/includes_server_monitor_analytics_remove_old_events.rst

.. include:: ../../includes_server_tuning/includes_server_tuning_rabbitmq.rst

Analytics Queues
=====================================================
.. warning:: Tuning the |rabbitmq| queue settings requires |chef server|, version 12.3. These settings `must be configured in the chef-server.rb file <https://docs.chef.io/config_rb_server_optional_settings.html#rabbitmq>`__.

.. include:: ../../includes_server_tuning/includes_server_tuning_rabbitmq_analytics_queue.rst

.. include:: ../../includes_server_tuning/includes_server_tuning_rabbitmq_analytics_queue_settings.rst