=====================================================
Release Notes: |chef analytics_title| 1.2
=====================================================

.. include:: ../../includes_analytics/includes_analytics.rst

What's New
=====================================================
The following items are new for |chef analytics| 1.2 and/or are changes from previous versions. The short version:

* **Nodes view** The new **Nodes** view allows you to filter nodes by status: all nodes, nodes that failed to converge, nodes that are missing, and nodes that converged successfully.
* **RabbitMQ queue tuning** New settings in the |chef server| version 12.3 configuration file that support the management of |rabbitmq| queues to allow the size and behavior of the queue needed by |chef analytics| to be configured, including settings for the queue length monitor and for tuning the |rabbitmq mgmt|.
* **Purge node information** |chef analytics| stores |ohai| data for every |chef client| run. Use the ``purge-nodes`` command in ``opscode-analytics-ctl`` to manage this volume of data.

Nodes View
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_nodes_view.rst

|rabbitmq| Queues
-----------------------------------------------------
.. warning:: Tuning the |rabbitmq| queue settings requires |chef server|, version 12.3. These settings `must be configured in the chef-server.rb file <https://docs.chef.io/config_rb_server_optional_settings.html#rabbitmq>`__.

.. include:: ../../includes_server_tuning/includes_server_tuning_rabbitmq_analytics_queue.rst

.. include:: ../../includes_server_tuning/includes_server_tuning_rabbitmq_analytics_queue_settings.rst

Purge Node Information
-----------------------------------------------------
.. include:: ../../includes_ctl_analytics/includes_ctl_analytics_purge_nodes.rst
