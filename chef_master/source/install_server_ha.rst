=====================================================
High Availability: Backend Cluster
=====================================================

.. warning:: This topic is about an upcoming feature of the Chef server.

This topic introduces, and then describes describes how to set up the |chef server| for high availability using a backend HA cluster comprised of three machines: one leader and two followers.

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Overview
=====================================================
A backend HA cluster provides a highly available persistence system for the |chef server| that runs replicated |postgresql|, |elasticsearch|, |leaderl| and |etcd|.

* |postgresql| is the data store for |chef server| data
* |elasticsearch| creates the search indexes
* |leaderl| manages failover and the backend VIP
* |etcd| provides consensus and ties the backend HA cluster together

The only ports open between the frontend group and the backend HA cluster are ``9200`` and ``5432``, which allow the |chef server| nodes in the frontend group to access |elasticsearch| and |postgresql| respectively.


Components
=====================================================
The following sections describe the components of the backend HA cluster configuration.

.. image:: ../../images/chef_server_ha_cluster.svg
   :width: 600px
   :align: center

The key elements are:

* Backend VIP
* The backend HA cluster
* The frontend group
* The ports open between the frontend group and the backend HA cluster
* The services that run on the nodes in the frontend group and on the nodes in the backend cluster

Each of these are discussed in more detail in the following sections.

Backend VIP
-----------------------------------------------------
All communication between nodes in the frontend group and nodes in the backend HA cluster must use the backend VIP. The backend VIP is an IP address that represents the backend HA cluster and is always assigned to the node that is the current leader.

Backend Cluster
-----------------------------------------------------
The backend cluster is three identical nodes running replicated |postgresql|, |elasticsearch|, |etcd|, and |leaderl|. This ensures that the backend HA cluster can lose one of the three backend nodes and remain online. Once the first node is lost, failover may no longer occur because at least two backend nodes must participate in the leader election process. However, all three nodes must be lost for data loss to occur.

The backend HA cluster relies on four services to maintain the state of the cluster, provide storage, and search capabilities.

|elasticsearch|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|elasticsearch| provides highly available search capabilities. |elasticsearch| uses port 9200 for communication between the backend data store and nodes in the frontend group.

|etcd|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|etcd| provides distributed consensus and communication between nodes in the backend HA cluster. Various status and control commands read and set information about the cluster in |etcd|, which controls the state of the cluster. |etcd| is relied on by |leaderl| as a source of control information, such as failover restrictions or general health and status information about each node.

|leaderl|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|leaderl| is an |erlang|-based service that runs on each node in the backend HA cluster. It coordinates the availability of the system, including:

* Leader election and failover, which is managed by a key in |etcd|
* Health monitoring of the services
* Determining which host binds to the backend VIP and address resolution
* Configuration of the |postgresql| leader and followers

Leader election occurs when healthy backend nodes attempt to assert the leader key in |etcd|; the winner is declared the leader. At least two nodes must assert the leader key for an election to occur. The current leader refreshes the key periodically or times out, after which a new leader election takes place.

|postgresql|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|postgresql| is the backend data store run as a leader with two followers connected by |postgresql| streaming replication. |postgresql| uses port 5432 for communication between the backend data store and nodes in the frontend group.

One limitation of the replication system is that replication is asynchronous. A request may be returned by the leader before related changes are committed to followers. If failover happens in that moment, it's possible for reccently-committed data loss to occur.

Frontend Group
-----------------------------------------------------
The frontend group is one (or more) nodes running the |chef server| configured to support the backend HA cluster. Each node in the frontend group is effectively a standalone |chef server|, though the topology behaves much like a tiered configuration with each frontend node relying on an external data store and external search components.  The nodes in the frontend group handle requests to the |api chef server| from workstations and nodes. Cookbooks are stored on the frontend nodes.

The frontend group uses many familiar |chef server| services, but with one important difference: the bookshelf service runs on the frontend nodes because the cookbook file store is no longer part of the backend.

What's Changed?
-----------------------------------------------------
Starting with |chef server| version 12.4, the need for file system-based storage for |apache solr| and Bookshelf on the backend is no longer required:

* |apache solr| is replaced by |elasticsearch|, which allows moving cookbook storage (Bookshelf) to nodes in the frontend group
* Bookshelf is moved to nodes in the frontend group
* |postgresql| replication capabilities provide redundancy for the backend HA cluster and cookbook storage on the frontend
* |rabbitmq|, along with some other services built to support queuing, are no longer needed
* |keepalived| is effectively replaced by |leaderl| and |etcd|; the previous implementation used |keepalived| to manage a VIP
* |drbd| is not longer required to replicate partitions between two backend nodes
* ``chef-server-ctl`` commands should only be run on nodes in the frontend group
* ``chef-backend-ctl`` commands should only be run on nodes in the backend HA cluster



Setup and Config
=====================================================
A backend HA cluster requires all machines in both the frontend group and backend HA cluster to be running |chef server| 12.4.0 (or higher) and requires the backend HA cluster package to be 0.3.0 (or higher).

Before creating the backend HA cluster and building at least one |chef server| to be part of the frontend group, verify:

* The user who `'will install'` and build the backend HA cluster and frontend group has root access too all nodes.
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

   where

   * ``FE`` is the name of the frontend node that will be used to create the initial frontend group
   * ``FQDN`` is the |fqdn| for the frontend node

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


status
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_status.rst

