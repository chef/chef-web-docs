=====================================================
Monitor Chef Analytics
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/analytics_monitor.rst>`__

.. tag analytics_legacy

.. note:: This documentation is meant to support existing Chef customers using Analytics.

          If you are a new Chef customer, or are looking to gain better insight into your fleet, try :doc:`Chef Automate </chef_automate>`. You'll get a graphical interface and query language that gives you insight into operational, compliance, and workflow events. Download Chef Automate `here <https://downloads.chef.io/automate/>`__.


.. end_tag

Application-level checks should be done periodically to ensure that there is enough disk space.

ZooKeeper
=====================================================
ZooKeeper is a centralized service that is used to maintain configuration information for Chef Analytics. ZooKeeper does not automatically remove snapshots and log files, which means that snapshots and log file removal must be done periodically as part of the maintenance of Chef Analytics.

If snapshots and log files are not cleaned up periodically, eventually the disk on the Chef Analytics server will fill up. To prevent this situation, clean up the snapshots and log files before they are full. If the disk does fill up, do the following:

#. Inspect the log file for ZooKeeper on the Chef Analytics machine:

   .. code-block:: bash

      less /var/log/opscode-analytics/zookeeper/current

   which should contain a log file pattern similar to:

   .. code-block:: bash

      2015-03-18_21:49:09.21424 2015-03-18 21:49:09,149 [myid:] - INFO  [main:NIOServerCnxnFactory@94] - binding to port 0.0.0.0/0.0.0.0:2181
      2015-03-18_21:49:10.16411 2015-03-18 21:49:10,163 [myid:] - INFO  [NIOServerCxn.Factory:0.0.0.0/0.0.0.0:2181:NIOServerCnxnFactory@197] - Accepted socket connection ...
      2015-03-18_21:49:10.16790 2015-03-18 21:49:10,167 [myid:] - WARN  [NIOServerCxn.Factory:0.0.0.0/0.0.0.0:2181:NIOServerCnxn@362] - ... ZooKeeperServer not running
      2015-03-18_21:49:10.16809 2015-03-18 21:49:10,167 [myid:] - INFO  [NIOServerCxn.Factory:0.0.0.0/0.0.0.0:2181:NIOServerCnxn@1007] - Closed socket connection ...
      ...
      2015-03-18_21:49:12.46510 2015-03-18 21:49:12,464 [myid:] - INFO  [NIOServerCxn.Factory:0.0.0.0/0.0.0.0:2181:NIOServerCnxnFactory@197] - Accepted socket connection ...
      2015-03-18_21:49:12.46511 2015-03-18 21:49:12,464 [myid:] - WARN  [NIOServerCxn.Factory:0.0.0.0/0.0.0.0:2181:NIOServerCnxn@362] - ... ZooKeeperServer not running
      2015-03-18_21:49:12.46512 2015-03-18 21:49:12,464 [myid:] - INFO  [NIOServerCxn.Factory:0.0.0.0/0.0.0.0:2181:NIOServerCnxn@1007] - Closed socket connection ...
      2015-03-18_21:49:12.54214 2015-03-18 21:49:12,541 [myid:] - ERROR [main:Util@239] - Last transaction was partial.
      2015-03-18_21:49:12.54472 2015-03-18 21:49:12,542 [myid:] - ERROR [main:ZooKeeperServerMain@63] - Unexpected exception, exiting abnormally
      2015-03-18_21:49:12.54473 java.io.EOFException
      2015-03-18_21:49:12.54473 at java.io.DataInputStream.readInt(DataInputStream.java:392)
      2015-03-18_21:49:12.54473 at org.apache.jute.BinaryInputArchive.readInt(BinaryInputArchive.java:63)
      2015-03-18_21:49:12.54473 at org.apache.zookeeper.server.persistence.FileHeader.deserialize(FileHeader.java:64)
      2015-03-18_21:49:12.54473 at org.apache.zookeeper.server.persistence.FileTxnLog$FileTxnIterator.inStreamCreated(FileTxnLog.java:576)
      2015-03-18_21:49:12.54474 at org.apache.zookeeper.server.persistence.FileTxnLog$FileTxnIterator.createInputArchive(FileTxnLog.java:595)
      2015-03-18_21:49:12.54474 at org.apache.zookeeper.server.persistence.FileTxnLog$FileTxnIterator.goToNextLog(FileTxnLog.java:561)
      2015-03-18_21:49:12.54474 at org.apache.zookeeper.server.persistence.FileTxnLog$FileTxnIterator.next(FileTxnLog.java:643)
      2015-03-18_21:49:12.54474 at org.apache.zookeeper.server.persistence.FileTxnSnapLog.restore(FileTxnSnapLog.java:158)
      2015-03-18_21:49:12.54475 at org.apache.zookeeper.server.ZKDatabase.loadDataBase(ZKDatabase.java:223)

   This type of log pattern indicates that the data store for ZooKeeper has been corrupted as a result of it being full, is no longer ingesting data, and must be cleaned up.

#. Shut down the Chef Analytics machine:

   .. code-block:: bash

      $ opscode-analytics-ctl stop

#. Remove ZooKeeper data:

   .. code-block:: bash

      $ rm -fr /var/opt/opscode-analytics/zookeeper/data/version-2/*

#. Start the Chef Analytics machine:

   .. code-block:: bash

      $ opscode-analytics-ctl start

#. Inspect the log file for ZooKeeper on the Chef Analytics machine:

   .. code-block:: bash

      $ less /var/log/opscode-analytics/zookeeper/current

   There should not be any errors or warnings in the ZooKeeper log file and the Chef server should be able to send actions data to the Chef Analytics server.

#. On the Chef server, verify the connection from Chef Analytics to the Chef server:

   .. code-block:: bash

      $ export PATH=/opt/opscode/embedded/bin:$PATH
      $ rabbitmqctl list_connections

   which should contain a log file pattern similar to:

   .. code-block:: bash

      Listing connections ...
      actions	33.33.33.3	59870	running
      chef	33.33.33.9	41501	running
      chef	33.33.33.9	47757	running
      chef	33.33.33.9	56086	running
      chef	33.33.33.9	56087	running
      chef	33.33.33.9	56088	running
      chef	33.33.33.9	56089	running
      ...done.

#. Verify that Chef Analytics started correctly. This information is located in ``/var/log/opscode-analytics/alaska/current``:

   .. code-block:: bash

      2015-03-19_21:34:32.81899 ok: run: zookeeper: (pid 5128) 4041s
      2015-03-19_21:34:33.52351 chef_analytics [INFO] ----------------------------------------------------------
      2015-03-19_21:34:33.52354 chef_analytics [INFO] Chef Analytics pipeline
      2015-03-19_21:34:33.52355 chef_analytics [INFO] Copyright 2014 Chef Software, Inc., formerly, Opscode Inc.
      2015-03-19_21:34:33.52357 chef_analytics [INFO] ----------------------------------------------------------
      2015-03-19_21:34:33.54686 chef_analytics [INFO] Loading config[/var/opt/opscode-analytics/storm/topology/alaska/alaska.conf]
      2015-03-19_21:34:33.56644 chef_analytics [INFO] Loaded schema [http_notification-0.0.1]
      2015-03-19_21:34:33.56680 chef_analytics [INFO] Loaded schema [smtp_notification-0.1.0]
      2015-03-19_21:34:33.57100 chef_analytics [INFO] Loaded schema [run_control-0.1.1]
      2015-03-19_21:34:33.57103 chef_analytics [INFO] Loaded schema [run_start-0.1.0]
      2015-03-19_21:34:33.57104 chef_analytics [INFO] Loaded schema [run_control_group-0.1.1]
      2015-03-19_21:34:33.57104 chef_analytics [INFO] Loaded schema [action-0.1.1]
      2015-03-19_21:34:33.57105 chef_analytics [INFO] Loaded schema [http_notification-0.1.0]
      2015-03-19_21:34:33.57106 chef_analytics [INFO] Loaded schema [pipeline_config-0.1.1]
      2015-03-19_21:34:33.57106 chef_analytics [INFO] Loaded schema [hipchat_notification-0.1.0]
      2015-03-19_21:34:33.57107 chef_analytics [INFO] Loaded schema [control_groups-0.1.0]
      2015-03-19_21:34:33.57107 chef_analytics [INFO] Loaded schema [hipchat_notification-0.0.1]
      2015-03-19_21:34:33.57108 chef_analytics [INFO] Loaded schema [control_groups-0.1.1]
      2015-03-19_21:34:33.57108 chef_analytics [INFO] Loaded schema [run_control_group-0.1.0]
      2015-03-19_21:34:33.57187 chef_analytics [INFO] Loaded schema [action-0.1.0]
      2015-03-19_21:34:33.57232 chef_analytics [INFO] Loaded schema [pipeline_egress-0.1.0]
      2015-03-19_21:34:33.57305 chef_analytics [INFO] Loaded schema [run_converge-0.1.0]
      2015-03-19_21:34:33.57329 chef_analytics [INFO] Loaded schema [run_control-0.1.0]
      2015-03-19_21:34:33.57376 chef_analytics [INFO] Loaded schema [run_resource-0.1.0]
      2015-03-19_21:34:34.27217 chef_analytics [INFO] Config ok
      2015-03-19_21:34:34.30079 chef_analytics [INFO] Configuring Graphite metrics via UDP
      2015-03-19_21:34:34.30937 chef_analytics [INFO] Started Graphite metrics reporting
      2015-03-19_21:34:34.37234 chef_analytics [INFO] Topology name: chef_analytics_pipeline_0-2-28
      2015-03-19_21:34:34.37238 chef_analytics [INFO] Running local topo
      2015-03-19_21:31:11.58057 chef_analytics [INFO] Preparing metrics hook for action_spout
      2015-03-19_21:31:11.62506 chef_analytics [INFO] Preparing metrics hook for actions_rule_engine_bolt
      2015-03-19_21:31:11.65001 chef_analytics [INFO] Preparing metrics hook for config_bolt
      2015-03-19_21:31:11.67106 chef_analytics [INFO] Preparing metrics hook for controls_rule_engine_bolt
      2015-03-19_21:31:11.69622 chef_analytics [INFO] Preparing metrics hook for egress_bolt
      2015-03-19_21:31:11.71801 chef_analytics [INFO] Preparing metrics hook for error_bolt
      2015-03-19_21:31:11.72892 chef_analytics [INFO] Preparing metrics hook for http_bolt
      2015-03-19_21:31:11.75243 chef_analytics [INFO] Preparing metrics hook for json_extraction_bolt
      2015-03-19_21:31:11.79425 chef_analytics [INFO] Preparing metrics hook for notification_bolt
      2015-03-19_21:31:11.80668 chef_analytics [INFO] Preparing metrics hook for notifier_config_spout
      2015-03-19_21:31:11.84040 chef_analytics [INFO] Preparing metrics hook for rabbitmq_publish_bolt
      2015-03-19_21:31:11.87711 chef_analytics [INFO] Preparing metrics hook for resources_rule_engine_bolt
      2015-03-19_21:31:11.91241 chef_analytics [INFO] Preparing metrics hook for __system
      2015-03-19_21:31:11.94101 chef_analytics [INFO] Preparing metrics hook for __acker

   Events in the ``/analytics/alaska`` queue that are pending should quickly show up in the Chef Analytics console. For example, a message that has been processed will appear in the log file similar to:

   .. code-block:: bash

      analytics.alaska_pipeline.AlaskaPipeline --schemadir /opt/opscode-analytics/embedded/docs/schema --standalonezk --alaskaconfig /var/opt/opscode-analytics/storm/topology/alaska/alaska.conf
      2015-03-16_15:59:23.48849 chef_analytics [INFO] json_extraction_bolt - 3ab6a680-06fd-4a91-b3f1-8481700635c6 validating message
      2015-03-16_15:59:23.48856 chef_analytics [INFO] json_extraction_bolt Message contains a valid ID, replacing ID 3ab6a680-06fd-4a91-b3f1-8481700635c6 with d831b7c6-adee-43df-9e8c-6bf54111cb7f
      2015-03-16_15:59:23.48857 chef_analytics [INFO] json_extraction_bolt - d831b7c6-adee-43df-9e8c-6bf54111cb7f emitting message to simple_rules
      2015-03-16_15:59:23.48857 chef_analytics [INFO] json_extraction_bolt - d831b7c6-adee-43df-9e8c-6bf54111cb7f acknowledging message
      2015-03-16_15:59:23.48858 chef_analytics [INFO] SimpleRuleEngineBolt - d831b7c6-adee-43df-9e8c-6bf54111cb7f received message
      2015-03-16_15:59:23.48858 chef_analytics [INFO] SimpleRuleEngineBolt - d831b7c6-adee-43df-9e8c-6bf54111cb7f emitting message to erchef
      2015-03-16_15:59:23.48859 chef_analytics [INFO] SimpleRuleEngineBolt - d831b7c6-adee-43df-9e8c-6bf54111cb7f acknowledging message
      2015-03-16_15:59:23.48859 chef_analytics [INFO] egress_bolt - d831b7c6-adee-43df-9e8c-6bf54111cb7f received message
      2015-03-16_15:59:23.48860 chef_analytics [INFO] egress_bolt - d831b7c6-adee-43df-9e8c-6bf54111cb7f validating egress message
      2015-03-16_15:59:23.48861 chef_analytics [INFO] egress_bolt - d831b7c6-adee-43df-9e8c-6bf54111cb7f emitting message to erchef
      2015-03-16_15:59:23.48861 chef_analytics [INFO] egress_bolt - d831b7c6-adee-43df-9e8c-6bf54111cb7f acknowledging message
      2015-03-16_15:59:23.48863 chef_analytics [INFO] http_bolt - d831b7c6-adee-43df-9e8c-6bf54111cb7f received message
      2015-03-16_15:59:23.48863 chef_analytics [INFO] http_bolt - d831b7c6-adee-43df-9e8c-6bf54111cb7f preparing message for sending
      2015-03-16_15:59:23.48864 chef_analytics [INFO] http_bolt - d831b7c6-adee-43df-9e8c-6bf54111cb7f posting message
      2015-03-16_15:59:23.49767 chef_analytics [INFO] http_bolt - d831b7c6-adee-43df-9e8c-6bf54111cb7f successfully posted message to endpoint
      2015-03-16_15:59:23.49769 chef_analytics [INFO] http_bolt - d831b7c6-adee-43df-9e8c-6bf54111cb7f acknowledging message
      2015-03-16_15:59:23.50477 chef_analytics [INFO] json_extraction_bolt - 2e7c0c70-028f-4765-b168-f38a8a15ac59 received message {"message_type":"action","message_version":"0.1.1","organization_name":"testsean","service_hostname":"centos-6.3","recorded_at":"2015-03-13T15:49:51Z","remote_hostname":"33.33.33.1","request_id":"g3IAA2QAEGVyY2hlZkAxMjcuMC4wLjEDAACdPQAAAAAAAAAA","requestor_name":"sean_horn","requestor_type":"user","user_agent":"Chef Knife/12.0.3 (ruby-2.1.1-p76; ohai-8.0.1; x86_64-darwin12.0; +http://opscode.com)","id":"b0d60543-e2da-4d14-a74d-6d84a92eab26","task":"create","entity_type":"item","entity_name":"seanitem9","parent_type":"bag","parent_name":"seanbag","remote_request_id":"ec2405c8-7cbf-42a7-93d4-56047182182f","data":{"id":"seanitem9"}}
      2015-03-16_15:59:23.50480 chef_analytics [INFO] json_extraction_bolt - 2e7c0c70-028f-4765-b168-f38a8a15ac59 validating message
      2015-03-16_15:59:23.50760 chef_analytics [INFO] json_extraction_bolt Message contains a valid ID, replacing ID 2e7c0c70-028f-4765-b168-f38a8a15ac59 with b0d60543-e2da-4d14-a74d-6d84a92eab26
      2015-03-16_15:59:23.50761 chef_analytics [INFO] json_extraction_bolt - b0d60543-e2da-4d14-a74d-6d84a92eab26 emitting message to simple_rules
      2015-03-16_15:59:23.50762 chef_analytics [INFO] json_extraction_bolt - b0d60543-e2da-4d14-a74d-6d84a92eab26 acknowledging message
      2015-03-16_15:59:23.50763 chef_analytics [INFO] SimpleRuleEngineBolt - b0d60543-e2da-4d14-a74d-6d84a92eab26 received message
      2015-03-16_15:59:23.50764 chef_analytics [INFO] SimpleRuleEngineBolt - b0d60543-e2da-4d14-a74d-6d84a92eab26 emitting message to erchef
      2015-03-16_15:59:23.50766 chef_analytics [INFO] SimpleRuleEngineBolt - b0d60543-e2da-4d14-a74d-6d84a92eab26 acknowledging message
      2015-03-16_15:59:23.50870 chef_analytics [INFO] egress_bolt - b0d60543-e2da-4d14-a74d-6d84a92eab26 received message
      2015-03-16_15:59:23.50872 chef_analytics [INFO] egress_bolt - b0d60543-e2da-4d14-a74d-6d84a92eab26 validating egress message
      2015-03-16_15:59:23.50973 chef_analytics [INFO] egress_bolt - b0d60543-e2da-4d14-a74d-6d84a92eab26 emitting message to erchef
      2015-03-16_15:59:23.50975 chef_analytics [INFO] egress_bolt - b0d60543-e2da-4d14-a74d-6d84a92eab26 acknowledging message
      2015-03-16_15:59:23.50997 chef_analytics [INFO] http_bolt - b0d60543-e2da-4d14-a74d-6d84a92eab26 received message
      2015-03-16_15:59:23.50999 chef_analytics [INFO] http_bolt - b0d60543-e2da-4d14-a74d-6d84a92eab26 preparing message for sending
      2015-03-16_15:59:23.51030 chef_analytics [INFO] http_bolt - b0d60543-e2da-4d14-a74d-6d84a92eab26 posting message
      2015-03-16_15:59:23.53049 chef_analytics [INFO] http_bolt - b0d60543-e2da-4d14-a74d-6d84a92eab26 successfully posted message to endpoint
      2015-03-16_15:59:23.53050 chef_analytics [INFO] http_bolt - b0d60543-e2da-4d14-a74d-6d84a92eab26 acknowledging message

Remove Events
=====================================================
Depending on the number and frequency of events published to the Chef Analytics server, it may be necessary to remove older events from the database. The following example shows a cron job that can be run daily (as root) to remove events that are older than three months.

.. code-block:: bash

   cat<<'EOF' > /etc/cron.daily/chef-analytics.cron
   #!/bin/sh
   log='/var/log/opscode-analytics/cull.log'
   echo "[$(date)] Stopping Alaska service..." >> $log
   opscode-analytics-ctl stop alaska >> $log 2>&1
   echo "[$(date)] Deleting Chef Analytics events older than 3 months" >> $log
   echo "delete from public.activities where recorded_at <  (now() - interval '3 months');" | su -l chef-pgsql -c 'psql actions' &>> $log
   echo "[$(date)] Starting Alaska service..." >> $log
   opscode-analytics-ctl start alaska >> $log 2>&1
   echo >> $log
   exit 0
   EOF
   chmod +x /etc/cron.daily/chef-analytics.cron

.. tag server_tuning_rabbitmq

.. note:: Chef Analytics has been replaced by Chef Automate.

The following settings must be modified when the Chef Analytics server is configured as a standalone server:

``rabbitmq['node_ip_address']``
   The bind IP address for RabbitMQ. Default value: ``"127.0.0.1"``.

   Chef Analytics uses the same RabbitMQ service that is configured on the Chef server. When the Chef Analytics server is configured as a standalone server, the default settings for ``rabbitmq['node_ip_address']`` and ``rabbitmq['vip']`` must be updated. When the Chef Analytics server is configured as a standalone server, change this value to ``0.0.0.0``.

``rabbitmq['vip']``
   The virtual IP address. Default value: ``"127.0.0.1"``.

   Chef Analytics uses the same RabbitMQ service that is configured on the Chef server. When the Chef Analytics server is configured as a standalone server, the default settings for ``rabbitmq['node_ip_address']`` and ``rabbitmq['vip']`` must be updated. When the Chef Analytics server is configured as a standalone server, change this value to the backend VIP address for the Chef server.

.. end_tag

Analytics Queues
=====================================================
.. warning:: Tuning the RabbitMQ queue settings requires Chef server, version 12.3. These settings must be configured in the chef-server.rb file.

.. tag server_tuning_rabbitmq_analytics_queue

If the RabbitMQ queue that is used by Chef Analytics stops consuming messages, the Chef server data partition will fill up and may affect the overall performance of the Chef server application itself. The settings for the RabbitMQ queue are tunable, including for queue length monitoring, queue capacity, maximum number of messages that can be in the queue before messages are dropped, the point at which messages are dropped, for settings used by the rabbitmq-management plugin, and so on.

.. end_tag

.. tag server_tuning_rabbitmq_analytics_queue_settings

The following settings may be used for tuning RabbitMQ queues used by Chef Analytics and the Chef server:

``rabbitmq['analytics_max_length']``
   The maximum number of messages that can be queued before RabbitMQ automatically drops messages from the front of the queue to make room for new messages. Default value: ``10000``.

``rabbitmq['drop_on_full_capacity']``
   Specify if messages will stop being sent to the RabbitMQ queue when it is at capacity. Default value: ``true``.

``rabbitmq['management_enabled']``
   Specify if the rabbitmq-management plugin is enabled. Default value: ``true``.

``rabbitmq['management_password']``
   The rabbitmq-management plugin password. Default value: ``'chefrocks'``.

``rabbitmq['management_port']``
   The rabbitmq-management plugin port. Default value: ``15672``.

``rabbitmq['management_user']``
   The rabbitmq-management plugin user. Default value: ``'rabbitmgmt'``.

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

``rabbitmq['ssl_versions']``
   The SSL versions used by the rabbitmq-management plugin. (See `RabbitMQ TLS Support <https://www.rabbitmq.com/ssl.html>`_ for more details.) Default value: ``['tlsv1.2', 'tlsv1.1']``.

.. end_tag

