
=====================================================
Release Notes: |chef server_title| 12.3
=====================================================

.. include:: ../../includes_chef/includes_chef_index.rst

What's New
=====================================================
The following items are new for |chef server| 12.3:

* **Nginx stub_status module is enabled** The |nginx| ``stub_status`` module is enabled by default and may be viewed at the ``/nginx_status`` endpoint. The settings for this module are configurable.
* **RabbitMQ queue tuning** New settings for managing |rabbitmq| queues allow the size of the queue used by |chef analytics| to be configured, including settings for the queue length monitor and for tuning the |rabbitmq mgmt|.

|nginx| stub_status Module
-----------------------------------------------------
The following configuration settings are new and enable the |nginx| ``stub_status`` module:

``nginx['enable_stub_status']``
   |nginx stub_status| See ``nginx['stub_status']['allow_list']``, ``nginx['stub_status']['listen_host']``, ``nginx['stub_status']['listen_port']``, and ``nginx['stub_status']['location']``. Default value: ``true``.

``nginx['stub_status']['allow_list']``
   |nginx stub_status allow_list| Default value: ``["127.0.0.1"]``.

``nginx['stub_status']['listen_host']``
   |nginx stub_status listen_host| Default value: ``"127.0.0.1"``.

``nginx['stub_status']['listen_port']``
   |nginx stub_status listen_port| Default value: ``"9999"``.

``nginx['stub_status']['location']``
   |nginx stub_status location| Default value: ``"/nginx_status"``.

|rabbitmq| Queues
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_rabbitmq_analytics_queue.rst

.. include:: ../../includes_server_tuning/includes_server_tuning_rabbitmq_analytics_queue_settings.rst

What's Fixed
=====================================================
For the list of issues that were addressed for this release, please see the changelog on |github|: https://github.com/chef/opscode-omnibus/blob/master/CHANGELOG.md
