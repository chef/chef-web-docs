=====================================================
High Availability: Backend Cluster
=====================================================

.. warning:: This topic is about an upcoming feature of the Chef server.

This topic introduces the underlying concepts behind the architecture of the highly available |chef server| cluster. The topic then describes the setup and installation process for a highly available |chef server| cluster comprised of five nodes.

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Overview
=====================================================
The |chef server| can operate in a high availability configuration that provides automated load balancing and failover for stateful components in the system architecture. This type of configuration typically splits the servers into two segments: The backend cluster, and the frontend group.

* The frontend group, comprised of one (or more) nodes running the |chef server|. Nodes in the frontend group handle requests to the |api chef server| and access to the |chef manage|. Frontend group nodes should be load balanced, and may be scaled horizontally by increasing the number of nodes available to handle requests.
* The backend cluster, typically comprised of three nodes working together, provides highly available data persistence for the frontend group.

Key Differences From Standalone |chef server|
-----------------------------------------------------
There are several key differences between the highly available |chef server| cluster and a standalone |chef server| instance.

* While |apache solr| is used in standalone |chef server| instances, in the highly available |chef server| cluster it is replaced with |elasticsearch|. |elasticsearch| provides more flexible clustering options while maintaining search API compatibility with |apache solr|.
* Writes to the search engine and the database are handled asynchronously via |rabbitmq| and |chef expander| in standalone |chef server| instances. However, the highly available |chef server| cluster writes to the search engine and the database simultaneously. As such the |rabbitmq| and |chef expander| services are no longer present in the highly available |chef server| cluster.
* Standalone |chef server| instances write |chef bookshelf| data to the filesystem. In a highly available |chef server| cluster, |chef bookshelf| data is written to the database.

Recommended Cluster Topology
=====================================================
.. image:: ../../images/chef_server_ha_cluster.svg

Nodes
-----------------------------------------------------
* Three backend cluster nodes
* One or more frontend group nodes

Network Services
-----------------------------------------------------
* A load balancer between the rest of the network, and the frontend group (Not provided). Because management console session data is stored on each node in the frontend group individually, the load balancer should be configured with sticky sessions.

Network Port Requirements
-----------------------------------------------------

Inbound from load balancer to frontend group
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* TCP 80 (HTTP)
* TCP 443 (HTTPS)

Inbound from frontend group to backend cluster
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* TCP 2379 (|etcd|)
* TCP 5432 (|postgresql|)
* TCP 7331 (|leaderl|)
* TCP 9200 (|elasticsearch|)

Peer communication, backend cluster
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* 2379 (|etcd|)
* 2380 (|etcd|)
* 5432 (|postgresql|)
* 9200 (|elasticsearch|)
* 9300 (|elasticsearch|)

Cluster Components
=====================================================
The following sections describe the components of the highly available |chef server| cluster.

.. image:: ../../images/chef_server_ha_cluster.svg
   :width: 600px
   :align: center

The key elements are:

* The backend cluster
* The frontend group
* The proxy on each node in the frontend group, used to automatically route traffic to the backend leader
* The network ports open between the frontend group and the backend HA cluster
* The services that run on the nodes in the frontend group and on the nodes in the backend cluster

Each of these elements are discussed in more detail in the following sections.

Backend Cluster
-----------------------------------------------------
The backend cluster is comprised of three identical nodes, joined into a three-node cluster via the chef backend package. This backend cluster provides database and search capabilities for the entire highly available |chef server| cluster.

In the event that one node in the backend cluster is lost, services for the highly available |chef server| cluster will remain online and available. In the event that two nodes in the backend cluster are lost at once, services services for the highly available |chef server| cluster will be interrupted. However, data loss will not occur unless all three nodes in the backend cluster are simultaneously destroyed.

The backend cluster relies on four services to maintain the state of the cluster, provide storage, and to provide search capabilities:

|leaderl|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|leaderl| is an |erlang|-based service that runs on each node in the backend cluster. It coordinates the availability of the backend cluster, performing the following tasks:

* Leader election and failover for the backend cluster
* Automatic configuration of |postgresql| replication topology
* Advertising backend cluster leadership via a REST endpoint
* Internal monitoring of backend cluster services

leaderl listens on port TCP 7331, providing cluster status via an HTTP endpoint. The cluster leader will return code HTTP 200, while follower nodes will return code HTTP 503.

|elasticsearch|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|elasticsearch| provides search capabilities for the highly available |chef server| cluster. |elasticsearch| is configured as a unicast cluster of 3 nodes.

|elasticsearch| listens on port TCP 9200 for communication from nodes in the frontend group. All network traffic from the frontend group to |elasticsearch| is sent only to the backend cluster leader, as advertised by leaderl.

|postgresql|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|postgresql| is the primary data store for the highly available |chef server| cluster. It is configured to run as a leader with two followers connected via |postgresql| asynchronous streaming replication. Because this replication is asynchronous, any changes written to the leader but not yet written to the followers may be lost during failover.

During failover, leaderl will automatically configure the |postgresql| leader & follower state to match the backend cluster topology.

|postgresql| listens on port TCP 5432 for communication from nodes in the frontend group. All network traffic from the frontend group to |postgresql| is sent only to the backend cluster leader, as advertised by leaderl.

|etcd|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|etcd| provides distributed consensus and communication between nodes in the backend HA cluster. |leaderl| relies on |etcd| as its primary data store.

|etcd| listens on port TCP 2379 for communication from nodes in the frontend group.

Frontend Group
-----------------------------------------------------
The frontend group is comprised of one (or more) nodes running the |chef server|. Nodes in the frontend group each act autonomously, relying on the backend cluster as an external data store. The nodes in the frontend group handle requests to the |api chef server| from workstations and nodes, and requests to the |chef manage| from users.

Nodes in the frontend group do not share session data for the |chef manage|. Any load balancer that serves the frontend group should be configured with sticky sessions.

Each node in the frontend group provides many of the same services as a standalone |chef server|, with one significant addition:

haproxy
+++++++++++++++++++++++++++++++++++++++++++++++++++++
An instance of |haproxy| is bundled with each node in the frontend group and automatically routes traffic to the leader node in the backend HA cluster.

Cluster Security Considerations
=====================================================

.. This will need to be integrated into the server_ topics after all that is updated and finalized.

A backend cluster is expected to run in a trusted environment. This means that untrusted users that communicate with and/or eavesdrop on services provided by the backend cluster can potentially view sensitive data.

Communication Between Nodes
-----------------------------------------------------
|postgresql| communication between nodes in the backend cluster is encrypted, and uses password authentication. All other communication in the backend cluster is unauthenticated and happens in the clear (without encryption).

Communication Between Frontend Group & Backend Cluster
--------------------------------------------------------
|postgresql| communication from nodes in the frontend group to the leader of the backend cluster uses password authentication, but communication happens in the clear (without encryption).

|elasticsearch| communication is unauthenticated and happens in the clear (without encryption).

Securing Communication
-----------------------------------------------------
Because most of the peer communication between nodes in the backend cluster happens in the clear, the backend cluster is vulnerable to passive monitoring of network traffic between nodes. To help prevent an active attacker from intercepting or changing cluster data, |company_name| recommends using |iptables| or an equivalent network ACL tool to restrict access to |postgresql|, |elasticsearch| and |etcd| to only hosts that need access.

By service role, access requirements are as follows:

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Service
     - Access Requirements
   * - |postgresql|
     - All backend cluster members and all |chef server| frontend group nodes.
   * - |elasticsearch|
     - All backend cluster members and all |chef server| frontend group nodes.
   * - |etcd|
     - All backend cluster members and all |chef server| frontend group nodes.

Services and Secrets
-----------------------------------------------------
The following services run on each node in the backend cluster. The user account under which the service runs as listed the second column:


.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Service
     - Process Owner
   * - ``postgresql``
     - ``chef_pgsql``

       Communication with |postgresql| requires password authentication. The backend cluster generates |postgresql| users and passwords during the initial cluster-create. These passwords are present in the following files on disk:

       * ``/etc/chef-backend/secrets.json`` (owner root, 0600)
       * ``/var/opt/chef-backend/leaderl/data/sys.config`` (owner chef-backend, mode 0600.
       * ``/var/opt/chef-backend/PostgreSQL/9.5/recovery.conf`` (owner chef\_pgsql, mode 0600)

   * - ``elasticsearch``
     - ``chef-backend``
   * - ``etcd``
     - ``chef-backend``
   * - ``leaderl``
     - ``chef-backend``
   * - ``epmd``
     - ``root``


Chef Server Front End
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``chef-backend-ctl gen-server-config`` command, which can be run as root from any node in the backend cluster, will automatically generate a configuration file containing the superuser database access credentials for the backend cluster |postgresql| instance.

Software Versions
-----------------------------------------------------
The backend HA cluster uses the |omnibus installer| (https://github.com/chef/omnibus) to package all of the software necessary to run the services included in the backend cluster. For a full list of the software packages included (and their versions), see the file located at ``/opt/chef-backend/version-manifest.json``.

Do not attempt to upgrade individual components of the omnibus package. Due to the way omnibus packages are built, modifying any of the individual components in the package will lead to cluster instability. If the latest version of the backend cluster is providing an out-of-date package, please bring it to the attention of |company_name| by filling out a ticket with |support_email|.


Setup and Config
=====================================================
A backend HA cluster requires all nodes in both the frontend group and backend HA cluster to be running |chef server| 12.6.0 (or higher) and requires the backend HA cluster package to be 0.8.0 (or higher).

Before creating the backend HA cluster and building at least one |chef server| to be part of the frontend group, verify:

* The user who will install and build the backend HA cluster and frontend group has root access too all nodes.
* The number of backend and frontend nodes that are desired. It is required to have 3 backend nodes, but the number of frontend nodes may vary from a single node to a load-balanced tiered configuration.
* A virtual IP address is available and that it can be bound to any of the backend nodes.
* SSH access to all boxes that will belong to the backend HA cluster from the node that will be the initial bootstrap.
* A time synchronization policy is in place, such as |ntp|. Drift of less than 1.5 seconds must exist across all nodes in the backend HA cluster.


Bootstrap a Cluster
-----------------------------------------------------
The first node in the backend HA cluster must be bootstrapped to initialize the cluster. After the bootstrap process is finshed, this node's configuration will be used to create both follower nodes; all three nodes wil be identical, except for their status as leader and follower. The first node in the backend HA cluster is the initial cluster leader. 

Use the following steps to bootstrap the first node in the backend HA cluster:

#. As a root user, install the backend package on the server, using the name of the package provided by |company_name|. For |redhat| and |centos| 6:

   .. code-block:: bash
      
      $ rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For |ubuntu|:

   .. code-block:: bash
      
      $ dpkg -i /tmp/chef-server-core-<version>.deb

   After a few minutes, the backend package will be installed.

#. Update the ``chef-backend.rb`` file (located at ``/etc/chef-backend/``) with the following settings and values:

   .. code-block:: ruby

      publish_address 'EXTERNAL_IP_ADDRESS'
      vip 'VIP'
      vip_interface 'INTERFACE'

   where

   ``publish_address``
      The IP address that is published within the backend HA cluster. This IP address must be accessible to all nodes in the backend HA cluster.

   ``vip``
      An IP address that represents the backend HA cluster and is always assigned to the node that is the current leader.

   ``vip_interface``
      The network interface to which the backend VIP will bind in the event that this node becomes leader.

   For example:

   .. code-block:: ruby

      publish_address = '10.0.2.15'
      vip = '10.0.2.15'
      vip_interface = 'eth0'

#. Run the following to bootstrap the node:

   .. code-block:: bash
      
      $ chef-backend-ctl bootstrap


Shared Credentials
-----------------------------------------------------
The credentials file located at ``/etc/chef-backend/secrets.json`` is generated during the bootstrap process. This file must be shared with all nodes in the backend HA cluster. This file may be copied directly or they may be shared from a common mount point. This file will be removed from the node after the follower node is joined to the backend HA cluster.

.. note:: The credentials file is only required by the nodes in the backend HA cluster and should never be copied to any node in the frontend group.

For example:

.. code-block:: bash

   scp /etc/chef-backend/secrets.json <USER>@<IP_ADDRESS>:/home/<USER>

where

* ``USER`` is a user with root access to the follower node and also the directory to which the file will be copied
* ``IP_ADDRESS`` is the IP address for the follower node

This must be done for each of the follower nodes in the backend HA cluster.


Generate Config
-----------------------------------------------------
From the bootstrapped node, generate the ``chef-server.rb`` configuration file that will be used by all nodes that will belong to the frontend group. A ``chef-server.rb`` configuration file must be generated for each node that will belong to the frontend group.

#. Run the following command:

   .. code-block:: bash

      $ chef-backend-ctl gen-server-config <FE-FQDN> > chef-server.rb.<FE>

   where ``FE`` is the name of the frontend node that will be used to create the initial frontend group and ``FQDN`` is the |fqdn| for the frontend node.

#. Copy the configuration file to the frontend node:

   .. code-block:: bash

      $ scp chef-server.rb.FE1 USER@<IP_ADDRESS>:/home/<USER>

   .. note:: Do not copy the credentials file (located at ``/etc/chef-backend/secrets.json``) to any of the frontend nodes. It is only used in the backend HA cluster.


Build the Cluster
-----------------------------------------------------
The follower nodes in a backend cluster are installed like the bootstrap node, but then joined to the cluster (instead of bootstrapped).

Use the following steps to install, and then join nodes to the backend HA cluster:

#. As a root user, install the backend package on the server, using the name of the package provided by |company_name|. For |redhat| and |centos| 6:

   .. code-block:: bash
      
      $ rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For |ubuntu|:

   .. code-block:: bash
      
      $ dpkg -i /tmp/chef-server-core-<version>.deb

   After a few minutes, the backend package will be installed.

#. Run the following command to join the node to the backend HA cluster:

   .. code-block:: bash

      $ chef-backend-ctl join-cluster <IP_ADDRESS> -s ~/home/<USER>/secrets.json

   where

   * ``IP_ADDRESS`` is the IP address for the bootstrapped node
   * ``USER`` is the name of the directory in which the credentials file is located

#. Answer the prompts by providing the public IP address and network interface values. These are the same values used in the ``chef-backend.rb`` file for the bootstrapped node. For example:

   .. code-block:: ruby

      publish_address = '10.0.2.15'
      vip_interface = 'eth0'

#. Remove the credentials file that was previously copied to the user's ``/home`` directory.

#. Repeat these steps for each follower node, after which the cluster is online and available. From any node in the backend HA cluster, run the following command:

   .. code-block:: bash

      $ chef-backend-ctl status

   should return something like:

   .. code-block:: bash

      Service        Local Status        Time in State  Distributed Node Status 
      elasticsearch  running (pid 6661)  1d 5h 59m 41s  state: green; nodes online: 3/3
      etcd           running (pid 6742)  1d 5h 59m 39s  health: green; healthy nodes: 3/3 
      leaderl        running (pid 6788)  1d 5h 59m 35s  leader: 1; waiting: 0; follower: 2; total: 3
      postgresql     running (pid 6640)  1d 5h 59m 43s  leader: 1; offline: 0; syncing: 0; synced: 2


Build the Frontend
-----------------------------------------------------
Install a frontend |chef server| and configure it to communicate with the backend HA cluster. The frontend group may comprise a single |chef server| or it may be a load-balanced group similar to the tiered configuration.

#. Verify the generated configuration file was copied to the frontend node.

#. .. include:: ../../step_install/step_install_chef_server_install_package.rst

#. Move the configuration file previously copied to the user's ``/home`` directory into the ``/etc/chef-server/`` directory:

   .. code-block:: bash

      $ cp /home/<USER>/chef-server.rb.<FE1> /etc/chef-server/chef-server.rb

#. Run the following to start all of the services:

   .. code-block:: bash
      
      $ chef-server-ctl reconfigure

#. Load balance the frontend group, if desired. Repeat these steps for each node in the frontend group.


Add Nodes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
For each node that will be added to the frontend group, do the following:

#. Generate a ``chef-server.rb`` file:

   .. code-block:: bash

      $ chef-backend-ctl gen-server-config <FE-FQDN> > chef-server.rb.<FE>

   where

   * ``FE`` is the name of the frontend node that will be used to create the initial frontend group
   * ``FQDN`` is the |fqdn| for the frontend node

#. Copy the generated ``chef-server.rb`` file to the ``/etc/chef-server`` directory on the frontend node.
#. From the initial node in the frontend group, copy the ``/etc/chef-server/private-chef-secrets.json`` file to the ``/etc/chef-server`` directory on the node being added to the frontend group.
#. Run the following on the node being added to the frontend group:

   .. code-block:: bash
      
      $ chef-server-ctl reconfigure

Upgrade the Frontend
+++++++++++++++++++++++++++++++++++++++++++++++++++++
If a frontend node requires an upgrade for the |chef server|, follow the steps outlined at https://docs.chef.io/upgrade_server.html#standalone for all nodes in the frontend group, and then copy ``/var/opt/opscode/upgrades/migration-level`` from the first-upgraded node in the frontend group to the same directory on all other nodes in the frontend group.



chef-backend-ctl
=====================================================
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend.rst


backup
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_backup.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_backup_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_backup_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Backup a node in the backend HA cluster**

From a follower node, run the following command:

.. code-block:: bash

   $ chef-backend-ctl backup


bootstrap
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_bootstrap.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_bootstrap_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_bootstrap_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


cleanse
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_cleanse.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_cleanse_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_cleanse_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


cluster-status
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_cluster_status.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_cluster_status_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_cluster_status_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Return cluster health data as JSON**

.. code-block:: bash

   $ chef-backend-ctl cluster-status --json


demote
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_demote.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_demote_syntax.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


force-leader
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_force_leader.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_force_leader_syntax.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


gather-logs
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_gather_logs.rst


gen-sample-backend-config
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_gen_sample_backend_config.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_gen_sample_backend_config_syntax.rst

Example Output
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_gen_sample_backend_config_example.rst


gen-server-config
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_gen_server_config.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_gen_server_config_syntax.rst

Configure the Front End
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_gen_server_config_steps.rst

Example Output
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_gen_server_config_example.rst


help
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_help.rst


join-cluster
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_join_cluster.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_join_cluster_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_join_cluster_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


promote
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_promote.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_promote_syntax.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


reconfigure
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_reconfigure.rst


remove-node
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_remove_node.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_remove_node_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_remove_node_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


restore
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_restore.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_restore_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_restore_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Restore data to the backend leader**

From the leader node, run the following command:

.. code-block:: bash

   $ chef-backend-ctl restore /var/opt/chef-backup/backup_file.tgz


set-cluster-failover
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_set_cluster_failover.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_set_cluster_failover_syntax.rst


set-node-failover
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_set_node_failover.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_set_node_failover_syntax.rst


show-config
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_show_config.rst


status
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_status.rst


uninstall
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_uninstall.rst



Service Subcommands
-----------------------------------------------------
.. include:: ../../includes_ctl_common/includes_ctl_common_service_subcommands.rst

.. warning:: The following commands are disabled when an external |postgresql| database is configured for the |chef server|: ``hup``, ``int``, ``kill``, ``once``, ``restart``, ``service-list``, ``start``, ``stop``, ``tail``, and ``term``.

hup
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_hup.rst

int
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_int.rst

kill
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_kill.rst

once
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_once.rst

restart
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_restart.rst

service-list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_service_list.rst

start
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_start.rst

stop
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_stop.rst

tail
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_tail.rst

term
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_term.rst



