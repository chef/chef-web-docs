=====================================================
chef-backend-ctl
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/ctl_chef_backend.rst>`__

.. tag ctl_chef_backend_summary

The Chef server backend HA cluster includes a command-line utility named chef-backend-ctl. This command-line tool is used to manage the Chef server backend HA cluster, start and stop individual services, and tail Chef server log files.

.. end_tag

backup
=====================================================
.. tag ctl_chef_backend_backup

Use the ``backup`` subcommand is to backup the data for a node in the backend HA cluster. This command is typically run against a follower node. Use the ``--force`` option to run this command against all nodes in the backend HA cluster. The backup is created as a tar.gz file and is located in ``/var/opt/chef-backup/``.

.. end_tag

Syntax
-----------------------------------------------------
.. tag ctl_chef_backend_backup_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl backup (options)

.. end_tag

Options
-----------------------------------------------------
.. tag ctl_chef_backend_cleanse_options

This subcommand has the following options:

``--with-external``
   Use to specify that data on an external PostgreSQL database should be removed.

.. end_tag

Examples
-----------------------------------------------------

**Backup a node in the backend HA cluster**

From a follower node, run the following command:

.. code-block:: bash

   $ chef-backend-ctl backup

create-cluster
=====================================================
.. tag ctl_chef_backend_create_cluster

Use the ``create-cluster`` subcommand to initialize the cluster state, including the PostgreSQL data store, and then bootstrap the first node in a backend HA cluster or assist in the recovery of the entire backend HA cluster.

.. end_tag

Syntax
-----------------------------------------------------
.. tag ctl_chef_backend_create_cluster_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl create-cluster (options)

.. end_tag

Options
-----------------------------------------------------
.. tag ctl_chef_backend_create_cluster_options

This subcommand has the following options:

``--elasticsearch-wait-time``
   The maximum amount of time (in seconds) to wait for Elasticsearch to start. Default value: ``30``.

``--etcd-wait-time``
   The maximum amount of time (in seconds) to wait for etcd to start. Default value: ``30``.

``--quorum-loss-recovery``
   Resets the cluster identifier in etcd to this node.

   If nodes in a backend HA cluster are not available, etcd may not be able to form a cluster. If etcd cannot form a cluster, rebuild the cluster. First reset the cluster identifier on an active node, rebuild the nodes that will be part of the cluster, and then rejoin the rebuilt nodes to the cluster by using the ``chef-backend-ctl join-cluster`` subcommand.

``-y``, ``--yes``
   Do not prompt for confirmation.

.. end_tag

Examples
-----------------------------------------------------
None.

cleanse
=====================================================
.. tag ctl_chef_backend_cleanse

The ``cleanse`` subcommand is used to re-set a machine in the Chef server backend HA cluster to the state it was in prior to the first time the ``reconfigure`` subcommand is run. This command will destroy all data, configuration files, and logs. The software that was put on-disk by the package installation will remain; re-run ``chef-backend-ctl reconfigure`` to recreate the default data and configuration files.

.. end_tag

Syntax
-----------------------------------------------------
.. tag ctl_chef_backend_cleanse_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl cleanse

.. end_tag

Options
-----------------------------------------------------
.. tag ctl_chef_backend_cleanse_options

This subcommand has the following options:

``--with-external``
   Use to specify that data on an external PostgreSQL database should be removed.

.. end_tag

Examples
-----------------------------------------------------
None.

cluster-status
=====================================================
.. tag ctl_chef_backend_cluster_status

Use the ``cluster-status`` subcommand to return a list of all accessible nodes, their role (leader, follower), and the status for PostgreSQL and Elasticsearch.

.. end_tag

Syntax
-----------------------------------------------------
.. tag ctl_chef_backend_cluster_status_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl cluster-status (options)

.. end_tag

Options
-----------------------------------------------------
.. tag ctl_chef_backend_cluster_status_options

This subcommand has the following options:

``--json``
   Return cluster health information as JSON.

.. end_tag

Examples
-----------------------------------------------------

**Return cluster health data as JSON**

.. code-block:: bash

   $ chef-backend-ctl cluster-status --json

demote
=====================================================
.. tag ctl_chef_backend_demote

Use the ``demote`` subcommand to demote the current leader in the backend HA cluster, after which a new leader is elected from the group of available followers in the backend HA cluster. This command will:

* Complete with an exit code of ``0`` if the original leader was demoted and a new leader was elected successfully.
* Return an error message and a non-zero exit code if leader election is prevented because failover has been disabled (for either the cluster or the node) or if a new leader could not be elected within the allowed time.

.. end_tag

Syntax
-----------------------------------------------------
.. tag ctl_chef_backend_demote_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl demote

.. end_tag

Examples
-----------------------------------------------------
None.

force-leader
=====================================================
.. tag ctl_chef_backend_force_leader

Use the ``force-leader`` subcommand to force the node from which the command is run to become the leader in the backend HA cluster if there is not already an elected leader.

This command should only be run if:

* The backend cluster appears to not have an elected and available leader
* All of the nodes in the backend HA cluster are believed to be in a healthy state; if one (or more) nodes are not healthy, first remove the unhealthy nodes, rebuild, and then rejoin them to the cluster

This command will:

* Run the ``chef-backend-ctl cluster-status`` subcommand to determine if a leader exists.

  .. warning:: Nodes in the backend HA cluster may not be visible to each other when they are located in network partitions. This may prevent a cluster status check from discovering that a leader exists. If nodes exist on network partitions, to prevent this scenario, first run ``chef-backend-ctl cluster-status``, and then verify the expected number of nodes in the backend HA cluster as healthy and ``waiting_for_leader`` before running this command.
* Complete with an exit code of ``0`` if the node from which the command is run becomes the leader.
* Return an error message and a non-zero exit code if a leader already exists.

.. end_tag

Syntax
-----------------------------------------------------
.. tag ctl_chef_backend_force_leader_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl force-leader

.. end_tag

Examples
-----------------------------------------------------
None.

gather-logs
=====================================================
.. tag ctl_chef_backend_gather_logs

Use the ``gather-logs`` subcommand to gather the log files for a machine in the Chef server backend HA cluster into a tarball that contains all of the important log files and system information.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl gather-logs

.. end_tag

gen-sample-backend-config
=====================================================
.. tag ctl_chef_backend_gen_sample_backend_config

Use the ``gen-sample-backend-config`` subcommand to generate output that contains all of the backend HA cluster settings along with their default values. Use this subcommand to get the values for ``publish_address`` and ``vip_interface`` prior to bootstrapping a new node for the backend HA cluster.

.. warning:: Service-specific configuration settings---``etcd``, ``elasticsearch``, ``leaderl``, and ``postgresl``---are generated automatically by the backend and should only be tuned under guidance from Chef. Service-specific configuration settings must be identical on all nodes in the backend HA cluster unless directed otherwise.

.. end_tag

Syntax
-----------------------------------------------------
.. tag ctl_chef_backend_gen_sample_backend_config_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl gen-sample-backend-config

.. end_tag

Example Output
-----------------------------------------------------
.. tag ctl_chef_backend_gen_sample_backend_config_example

The following example shows the results of running the ``chef-backend-ctl gen-sample-backend-config`` subcommand. The settings and output will vary, depending on the configuration. The ``elasticsearch``, ``etcd``, ``leaderl``, and ``postgresql`` settings are generated automatically and should not be modified:

.. code-block:: ruby

   fqdn = 'be1'
   hide_sensitive = true
   ip_version = 'ipv4'
   publish_address = '10.0.2.15'
   vip = '10.0.2.15'
   vip_interface = 'eth0'
   etcd.client_port = 2379
   etcd.enable = true
   etcd.log_directory = '/var/log/chef-backend/etcd'
   etcd.peer_port = 2380
   etcd.log_rotation.file_maxbytes = 104857600
   etcd.log_rotation.num_to_keep = 10
   postgresql.archive_command = ''
   postgresql.archive_mode = 'off'
   postgresql.archive_timeout = 0
   postgresql.checkpoint_completion_target = 0.5
   postgresql.checkpoint_timeout = '5min'
   postgresql.checkpoint_warning = '30s'
   postgresql.data_dir = '/var/opt/chef-backend/postgresql/9.5/data'
   postgresql.db_superuser = 'chef_pgsql'
   postgresql.effective_cache_size = '496MB'
   postgresql.enable = true
   postgresql.hot_standby = 'on'
   postgresql.keepalives_count = 2
   postgresql.keepalives_idle = 60
   postgresql.keepalives_interval = 15
   postgresql.log_directory = '/var/log/chef-backend/postgresql/9.5'
   postgresql.log_min_duration_statement = -1
   postgresql.max_connections = 350
   postgresql.max_replication_slots = 12
   postgresql.max_wal_senders = 12
   postgresql.max_wal_size = 64
   postgresql.md5_auth_cidr_addresses = '["samehost", "samenet"]'
   postgresql.min_wal_size = 5
   postgresql.port = 5432
   postgresql.replication_user = 'replicator'
   postgresql.shared_buffers = '248MB'
   postgresql.shmall = 4194304
   postgresql.shmmax = 17179869184
   postgresql.username = 'chef_pgsql'
   postgresql.wal_keep_segments = 32
   postgresql.wal_level = 'hot_standby'
   postgresql.wal_log_hints = 'on'
   postgresql.work_mem = '8MB'
   postgresql.log_rotation.file_maxbytes = 104857600
   postgresql.log_rotation.num_to_keep = 10
   elasticsearch.data_dir = '/var/opt/chef-backend/elasticsearch/data'
   elasticsearch.enable = true
   elasticsearch.heap_size = 248
   elasticsearch.java_opts = ''
   elasticsearch.log_directory = '/var/log/chef-backend/elasticsearch'
   elasticsearch.new_size = 32
   elasticsearch.plugins_directory = '/var/opt/chef-backend/elasticsearch/plugins'
   elasticsearch.port = 9200
   elasticsearch.scripts_directory = '/var/opt/chef-backend/elasticsearch/scripts'
   elasticsearch.temp_directory = '/var/opt/chef-backend/elasticsearch/'
   elasticsearch.log_rotation.file_maxbytes = 104857600
   elasticsearch.log_rotation.num_to_keep = 10
   leaderl.control_worker_timeout_seconds = 30
   leaderl.db_timeout = 2000
   leaderl.enable = true
   leaderl.health_check_interval_seconds = 2
   leaderl.leader_ttl_seconds = 10
   leaderl.log_directory = '/var/log/chef-backend/leaderl'
   leaderl.status_internal_update_interval_seconds = 5
   leaderl.status_post_update_interval_seconds = 10
   leaderl.log_rotation.file_maxbytes = 104857600
   leaderl.log_rotation.max_messages_per_second = 1000
   leaderl.log_rotation.num_to_keep = 10
   leaderl.etcd_pool.cull_interval_seconds = 60
   leaderl.etcd_pool.http_timeout_ms = 5000
   leaderl.etcd_pool.ibrowse_options = '{inactivity_timeout, infinity}'
   leaderl.etcd_pool.init_count = 10
   leaderl.etcd_pool.max_age_seconds = 60
   leaderl.etcd_pool.max_connection_duration_seconds = 300
   leaderl.etcd_pool.max_count = 10
   ssl.certificate = nil
   ssl.certificate_key = nil
   ssl.ciphers = (a list of cipers, not shown)
   ssl.company_name = 'YouCorp'
   ssl.country_name = 'US'
   ssl.data_dir = '/var/opt/chef-backend/ssl/'
   ssl.duration = 3650
   ssl.key_length = 2048
   ssl.organizational_unit_name = 'Operations'

.. end_tag

gen-server-config
=====================================================
.. tag ctl_chef_backend_gen_server_config

Use the ``gen-server-config`` subcommand to generate output for the ``/etc/opscode/chef-server.rb`` configuration file. This command may be run from any machine in the backend HA cluster, but must be run separately for each node that is part of the frontend group. This command will:

* Complete with an exit code of ``0`` if the ``chef-server.rb`` file is created successfully.
* Return an error message and a non-zero exit code if a node has  not been bootstrapped or joined or if a FQDN is not provided.

.. end_tag

Syntax
-----------------------------------------------------
.. tag ctl_chef_backend_gen_server_config_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl gen-server-config FQDN

.. end_tag

Configure the Front End
-----------------------------------------------------
.. tag ctl_chef_backend_gen_server_config_steps

#. On any node in the backend HA cluster, run the following command for each node in the frontend group:

   .. code-block:: bash

      $ chef-backend-ctl gen-server-config FQDN -f chef-server.rb.fqdn

   where ``FQDN`` is the FQDN for the frontend machine. The generated ``chef-server.rb`` file will contain all of the values necessary for any frontend Chef server to connect to and bootstrap against the backend HA cluster.

#. On each frontend machine, install the ``chef-server-core`` package (version 12.4.0 or higher).
#. On each frontend machine, copy the generated ``chef-server.rb``.fqdn to ``/etc/opscode/chef-server.rb``.
#. On each frontend machine, with root permission, run the following command:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

.. end_tag

Example Output
-----------------------------------------------------
.. tag ctl_chef_backend_gen_server_config_example

The following example shows the results of running the ``chef-backend-ctl gen-server-config`` subcommand. The settings and output will vary, depending on the configuration. These settings should be modified carefully:

.. code-block:: ruby

   fqdn "frontend1.chef-demo.com"
   postgresql['external'] = true
   postgresql['vip'] = '192.0.2.0'
   postgresql['db_superuser'] = 'chef_pgsql'
   postgresql['db_superuser_password'] = '...6810e52a01e562'
   opscode_solr4['external'] = true
   opscode_solr4['external_url'] = 'http://192.0.2.0:9200'
   opscode_erchef['search_provider'] = 'elasticsearch'
   opscode_erchef['search_queue_mode'] = 'batch'
   bookshelf['storage_type'] = :sql
   rabbitmq['enable'] = false
   rabbitmq['management_enabled'] = false
   rabbitmq['queue_length_monitor_enabled'] = false
   opscode_expander['enable'] = false
   dark_launch['actions'] = false
   opscode_erchef['nginx_bookshelf_caching'] = :on
   opscode_erchef['s3_url_expiry_window_size'] = '50%'

.. note:: The ``opscode_solr4``, ``postgresql``, and ``rabbitmq`` services are disabled in this configuration file for the frontend machines when running the Chef server with a backend HA cluster.

.. end_tag

help
=====================================================
.. tag ctl_chef_backend_help

Use the ``help`` subcommand to print a list of all available chef-backend-ctl commands.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl help

.. end_tag

join-cluster
=====================================================
.. tag ctl_chef_backend_join_cluster

Use the ``join-cluster`` subcommand to configure a node to be a member of the backend HA cluster as a peer of the node at the specified ``PEER_NODE_IP`` IP address. This command will query the existing cluster to identify any necessary configuration information. If the ``--publish-address`` and ``--vip-interface`` options are not specified, and are specified in ``chef-backend.rb``, the command will prompt with a list of items from which to choose.

This command will return an error message and a non-zero exit code when:

* The ``--secrets-file-path`` option is specified, a non-empty secrets file already exists at ``/etc/chef-backend/secrets.json``, and the user declines to overwrite it.
* The ``--secrets-file-path`` option is specified, but does not specify a valid file and/or the file at ``/etc/chef-backend/secrets.json`` is empty or does not exist.
* The IP address specified by the ``--publish-address`` option does not exist on the node.
* The interface specified by the ``--vip-interface`` option does not exist on the node.
* Any IP address on the node is already registered in the backend HA cluster.
* The node is already configured for the backend HA cluster and the ``--recovery`` option is not specified.
* The ``--recovery`` option is specified, but no existing installation is found.
* ``--publish-address`` and/or ``--vip-interface`` are specified, but a non-empty ``chef-backend.rb`` file already exists. (This command will not overwrite a ``chef-backend.rb`` file.)

If successful, this command will generate a ``chef-backend.rb`` file at ``/etc/chef-backend/chef-backend.rb`` with the values for the ``publish_address``, ``vip_interface``, and ``vip`` added automatically.

.. end_tag

Syntax
-----------------------------------------------------
.. tag ctl_chef_backend_join_cluster_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl join-cluster PEER_NODE_IP (options)

where ``PEER_NODE_IP`` is the IP address of a peer in the cluster to be joined.

.. end_tag

Options
-----------------------------------------------------
.. tag ctl_chef_backend_join_cluster_options

This subcommand has the following options:

``-i INTERFACE``, ``--vip-interface INTERFACE``
   The network interface to which the backend VIP will bind in the event that this node becomes leader. If not provided, and if not specified in ``chef-backend.rb``, this command will prompt to choose from a list of interfaces that are currently available on the node.

   .. note:: This option should only be used the first time a node joins the backend HA cluster.

``-p IP_ADDRESS``, ``--publish-address IP_ADDRESS``
   The IP address that is published within the backend HA cluster. This IP address must be accessible to all nodes in the backend HA cluster. If not provided, and if not specified in ``chef-backend.rb``, this command will prompt to choose from a list of IP addresses that are currently bound on the node.

   .. note:: This option should only be used the first time a node joins the backend HA cluster.

``--recovery``
  Force this node to rejoin the backend HA cluster if it has been removed via the ``chef-backend-ctl remove-node`` or ``chef-backend-ctl bootstrap --with-quorum-recovery`` commands.

   .. note:: This option will run against the existing ``chef-backend.rb`` file, which means the ``--vip-interface`` and ``--publish-address`` options should not be specified. (They are already defined in the ``chef-backend.rb`` file.)

``-s PATH``, ``--secrets-file-path PATH``
   The path to the location of the ``secrets.json`` file on the bootstrapping node. Default value: ``/etc/chef-backend/secrets.json``.

``-y``, ``--yes``
   Do not prompt for confirmation.

.. end_tag

Examples
-----------------------------------------------------
None.

promote
=====================================================
.. tag ctl_chef_backend_promote

Use the ``promote`` subcommand to promote the named node to be leader of the backend HA cluster. This command will:

* Complete with an exit code of ``0`` when the leader of the backend HA cluster is replaced as leader by the named node.
* Return an error message and a non-zero exit code if the named node is already leader because failover has been disabled (for either the cluster or the node) or if the new leader could not be promoted within the allowed time.

.. end_tag

Syntax
-----------------------------------------------------
.. tag ctl_chef_backend_promote_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl promote NODE

.. end_tag

Examples
-----------------------------------------------------
None.

reconfigure
=====================================================
.. tag ctl_chef_backend_reconfigure

Use the ``reconfigure`` subcommand to reconfigure a machine in the Chef server backend HA cluster. This subcommand will also restart any services for which the ``service_name['enabled']`` setting is set to ``true``.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl reconfigure

.. end_tag

remove-node
=====================================================
.. tag ctl_chef_backend_remove_node

Use the ``remove-node`` subcommand to remove the named node from the backend HA cluster by removing the node's status from etcd and deleting it from the etcd cluster. This command is useful when a node is going to be replaced or if the ``join-cluster`` command was unsuccessful.

This command may not be run from the node that is to be removed; the node itself must be shut down physically or have all services stopped (via the the ``chef-backend-ctl stop`` command). If the node is still running or otherwise available to the backend HA cluster, this command will return an error message and a non-zero exist code.

.. end_tag

Syntax
-----------------------------------------------------
.. tag ctl_chef_backend_remove_node_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl remove-node NODE_NAME

.. end_tag

Options
-----------------------------------------------------
.. tag ctl_chef_backend_remove_node_options

This subcommand has the following options:

``-y``, ``--yes``
   Do not prompt for confirmation.

.. end_tag

Examples
-----------------------------------------------------
None.

restore
=====================================================
.. tag ctl_chef_backend_restore

Use the ``restore`` subcommand to restore a backup created by the ``chef-backend-ctl backup`` subcommand. This command should be executed on the leader node in the backend HA cluster. This command will delete all existing data and replace it with the data in the backup archive.

.. end_tag

Syntax
-----------------------------------------------------
.. tag ctl_chef_backend_restore_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl restore PATH (options)

where ``PATH`` is the path to a tar.gz file that was created by the ``chef-backend-ctl backup`` subcommand.

.. end_tag

Options
-----------------------------------------------------
.. tag ctl_chef_backend_restore_options

This subcommand has the following options:

``-d DIRECTORY``, ``--staging-dir DIRECTORY``
   The path to an empty directory to be used during the restore operation. This directory must have enough available space to expand all data in the backup archive.

``-y``, ``--yes``
   Do not prompt for confirmation.

.. end_tag

Examples
-----------------------------------------------------

**Restore data to the backend leader**

From the leader node, run the following command:

.. code-block:: bash

   $ chef-backend-ctl restore /var/opt/chef-backup/backup_file.tgz

set-cluster-failover
=====================================================
.. tag ctl_chef_backend_set_cluster_failover

Use the ``set-cluster-failover`` subcommand to enable or disable failover across the backend HA cluster.

.. end_tag

Syntax
-----------------------------------------------------
.. tag ctl_chef_backend_set_cluster_failover_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl set-cluster-failover STATE

where ``STATE`` may be one of ``on``, ``off``, ``true``, ``false``, ``enabled``, or ``disabled``.

.. end_tag

set-node-failover
=====================================================
.. tag ctl_chef_backend_set_node_failover

Use the ``set-node-failover`` subcommand to enable or disable failover for a node in the backend HA cluster.

.. end_tag

Syntax
-----------------------------------------------------
.. tag ctl_chef_backend_set_node_failover_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl set-node-failover STATE

where ``STATE`` may be one of ``on``, ``off``, ``true``, ``false``, ``enabled``, or ``disabled``.

.. end_tag

show-config
=====================================================
.. tag ctl_chef_backend_show_config

The ``show-config`` subcommand is used to view the configuration that will be generated by the ``reconfigure`` subcommand. This command is most useful in the early stages of a deployment to ensure that everything is built properly prior to installation.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl show-config

.. end_tag

status
=====================================================
.. tag ctl_chef_backend_status

Use the ``status`` subcommand to show the status of all services available to a node in the backend HA cluster. This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl status

and will return the status for all services. Status can be returned for individual services by specifying the name of the service as part of the command:

.. code-block:: bash

   $ chef-backend-ctl status SERVICE_NAME

For example, full output:

.. code-block:: bash

   $ chef-backend-ctl status

is similar to:

.. code-block:: bash

   Service        Local Status        Time in State  Distributed Node Status
   elasticsearch  running (pid 6661)  1d 5h 59m 41s  state: green; nodes online: 3/3
   etcd           running (pid 6742)  1d 5h 59m 39s  health: green; healthy nodes: 3/3
   leaderl        running (pid 6788)  1d 5h 59m 35s  leader: 1; waiting: 0; follower: 2; total: 3
   postgresql     running (pid 6640)  1d 5h 59m 43s  leader: 1; offline: 0; syncing: 0; synced: 2

which shows status for a healthy backend HA cluster. The first three columns--``Service``, ``Local Status``, and ``Time in State`` summarize the local state. The ``Distributed Node Status`` column shows:

* A three node cluster
* All nodes healthy and online
* A leader selected with two followers (for both leader/follower status for the ``leaderl`` service and a leader/synced state for the ``postgresql`` service)

Simple output:

.. code-block:: bash

   $ chef-backend-ctl status --simple

is similar to:

.. code-block:: bash

   run: elasticsearch: (pid 6661) 106983s; run: log: (pid 6667) 106983s
   run: etcd: (pid 6742) 106981s; run: log: (pid 6630) 106984s
   run: leaderl: (pid 6788) 106976s; run: log: (pid 6739) 106982s
   run: postgresql: (pid 6640) 106984s; run: log: (pid 6653) 106983s

which shows the state of the services, process identifiers, and uptime (in seconds). Simple output is useful if one (or more) nodes in the backend HA cluster are down or in a degraded state.

.. end_tag

uninstall
=====================================================
.. tag ctl_chef_backend_uninstall

The ``uninstall`` subcommand is used to remove the Chef server application from a machine in the backend HA cluster, but without removing any of the data. This subcommand will shut down all services (including the ``runit`` process supervisor).

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl uninstall

.. note:: To revert the ``uninstall`` subcommand, run the ``reconfigure`` subcommand (because the ``start`` subcommand is disabled by the ``uninstall`` command).

.. end_tag

Service Subcommands
=====================================================
.. tag ctl_common_service_subcommands

This command has a built in process supervisor that ensures all of the required services are in the appropriate state at any given time. The supervisor starts two processes per service and provides the following subcommands for managing services: ``hup``, ``int``, ``kill``, ``once``, ``restart``, ``service-list``, ``start``, ``status``, ``stop``, ``tail``, and ``term``.

.. end_tag

.. warning:: The following commands are disabled when an external PostgreSQL database is configured for the Chef server: ``hup``, ``int``, ``kill``, ``once``, ``restart``, ``service-list``, ``start``, ``stop``, ``tail``, and ``term``.

hup
-----------------------------------------------------
.. tag ctl_chef_backend_hup

Use the ``hup`` subcommand to send a ``SIGHUP`` to all services on a machine in the Chef server backend HA cluster. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl hup SERVICE_NAME

where ``SERVICE_NAME`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

int
-----------------------------------------------------
.. tag ctl_chef_backend_int

Use the ``int`` subcommand to send a ``SIGINT`` to all services on a machine in the Chef server backend HA cluster. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl int SERVICE_NAME

where ``SERVICE_NAME`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

kill
-----------------------------------------------------
.. tag ctl_chef_backend_kill

Use the ``kill`` subcommand to send a ``SIGKILL`` to all services on a machine in the Chef server backend HA cluster. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl kill SERVICE_NAME

where ``SERVICE_NAME`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

once
-----------------------------------------------------
.. tag ctl_chef_backend_once

The supervisor for a machine in the Chef server backend HA cluster is configured to restart any service that fails, unless that service has been asked to change its state. The ``once`` subcommand is used to tell the supervisor to not attempt to restart any service that fails.

This command is useful when troubleshooting configuration errors that prevent a service from starting. Run the ``once`` subcommand followed by the ``status`` subcommand to look for services in a down state and/or to identify which services are in trouble. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl once SERVICE_NAME

where ``SERVICE_NAME`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

restart
-----------------------------------------------------
.. tag ctl_chef_backend_restart

Use the ``restart`` subcommand to restart all services enabled on a machine in the Chef server backend HA cluster, or to restart an individual service by specifying the name of that service in the command.

.. warning:: When running the Chef server in a high availability configuration, restarting all services may trigger failover.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl restart SERVICE_NAME

where ``SERVICE_NAME`` represents the name of any service that is listed after running the ``service-list`` subcommand. When a service is successfully restarted the output should be similar to:

.. code-block:: bash

   $ ok: run: service_name: (pid 12345) 1s

.. end_tag

service-list
-----------------------------------------------------
.. tag ctl_chef_backend_service_list

Use the ``service-list`` subcommand to display a list of all available services on a machine in the Chef server backend HA cluster. A service that is enabled is labeled with an asterisk (*).

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl service-list

.. end_tag

start
-----------------------------------------------------
.. tag ctl_chef_backend_start

Use the ``start`` subcommand to start all services that are enabled on a machine in the Chef server backend HA cluster. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl start SERVICE_NAME

where ``SERVICE_NAME`` represents the name of any service that is listed after running the ``service-list`` subcommand. When a service is successfully started the output should be similar to:

.. code-block:: bash

   $ ok: run: service_name: (pid 12345) 1s

The supervisor for a machine in the Chef server backend HA cluster is configured to wait seven seconds for a service to respond to a command from the supervisor. If you see output that references a timeout, it means that a signal has been sent to the process, but that the process has yet to actually comply. In general, processes that have timed out are not a big concern, unless they are failing to respond to the signals at all. If a process is not responding, use a command like the ``kill`` subcommand to stop the process, investigate the cause (if required), and then use the ``start`` subcommand to re-enable it.

.. end_tag

stop
-----------------------------------------------------
.. tag ctl_chef_backend_stop

Use the ``stop`` subcommand to stop all services enabled on the Chef server backend HA cluster. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl stop SERVICE_NAME

where ``SERVICE_NAME`` represents the name of any service that is listed after running the ``service-list`` subcommand. When a service is successfully stopped the output should be similar to:

.. code-block:: bash

   $ ok: diwb: service_name: 0s, normally up

For example:

.. code-block:: bash

   $ chef-backend-ctl stop

will return something similar to:

.. code-block:: bash

   ok: down: etcd: 393s, normally up
   ok: down: postgresql: 388s, normally up

.. end_tag

tail
-----------------------------------------------------
.. tag ctl_chef_backend_tail

Use the ``tail`` subcommand to follow all of the logs for all services on a machine in the Chef server backend HA cluster. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl tail SERVICE_NAME

where ``SERVICE_NAME`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

term
-----------------------------------------------------
.. tag ctl_chef_backend_term

Use the ``term`` subcommand to send a ``SIGTERM`` to all services on a machine in the Chef server backend HA cluster. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl term SERVICE_NAME

where ``SERVICE_NAME`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag
