=====================================================
High Availability: Backend Cluster
=====================================================

This topic introduces the underlying concepts behind the architecture
of the highly available |chef server| cluster. The topic then
describes the setup and installation process for a highly available
|chef server| cluster comprised of five nodes.

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Overview
=====================================================

The |chef server| can operate in a high availability configuration
that provides automated load balancing and failover for stateful
components in the system architecture. This type of configuration
typically splits the servers into two segments: The backend cluster,
and the frontend group.

* The frontend group, comprised of one (or more) nodes running the
  |chef server|. Nodes in the frontend group handle requests to the
  |api chef server| and access to the |chef manage|. Frontend group
  nodes should be load balanced, and may be scaled horizontally by
  increasing the number of nodes available to handle requests.

* The backend cluster, typically comprised of three nodes working
  together, provides highly available data persistence for the
  frontend group.

.. image:: ../../images/chef_server_ha_cluster.svg

Key Differences From Standalone |chef server|
-----------------------------------------------------
There are several key differences between the highly available |chef
server| cluster and a standalone |chef server| instance.

* While |apache solr| is used in standalone |chef server| instances,
  in the highly available |chef server| cluster it is replaced with
  |elasticsearch|. |elasticsearch| provides more flexible clustering
  options while maintaining search API compatibility with |apache
  solr|.

* Writes to the search engine and the database are handled
  asynchronously via |rabbitmq| and |chef expander| in standalone
  |chef server| instances. However, the highly available |chef server|
  cluster writes to the search engine and the database
  simultaneously. As such the |rabbitmq| and |chef expander| services
  are no longer present in the highly available |chef server| cluster.

* Standalone |chef server| instances write |chef bookshelf| data to
  the filesystem. In a highly available |chef server| cluster, |chef
  bookshelf| data is written to the database.

Recommended Cluster Topology
=====================================================

Nodes
-----------------------------------------------------
* Three backend cluster nodes
* One or more frontend group nodes

Network Services
-----------------------------------------------------
* A load balancer between the rest of the network, and the frontend
  group (Not provided). Because management console session data is
  stored on each node in the frontend group individually, the load
  balancer should be configured with sticky sessions.

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

Installation
=====================================================

These instructions assume you are using the following versions or newer:

- chef-server  : 12.5.0
- chef-backend : 0.8.0

Before creating the backend HA cluster and building at least one |chef
server| to be part of the frontend group, verify:

* The user who will install and build the backend HA cluster and
  frontend group has root access to all nodes.

* The number of backend and frontend nodes that are desired. It is
  required to have 3 backend nodes, but the number of frontend nodes
  may vary from a single node to a load-balanced tiered configuration.

* SSH access to all boxes that will belong to the backend HA cluster
  from the node that will be the initial bootstrap.

* A time synchronization policy is in place, such as |ntp|. Drift of
  less than 1.5 seconds must exist across all nodes in the backend HA
  cluster.

Step 1: Create Cluster
-----------------------------------------------------

The first node must be bootstrapped to initialize the cluster. The
node used to bootstrap the cluster will be the cluster leader when the
cluster comes online. After bootstrap completes this node is no
different from any other back-end node.

#. Install the chef-backend package on the first backend node as root

#. Update /etc/chef-backend/chef-backend.rb with the following
   content:

   .. code-block:: ruby

	publish_address 'external_IP_address_of_this_leader_box' # External ip address of this backend box

#. Run `chef-backend-ctl create-cluster`

Step 2: Shared Credentials
-----------------------------------------------------

The credentials file `/etc/chef-backend/chef-backend-secrets.json`
generated by bootstrapping must be shared with the other nodes.  You
may copy them directly, or expose them via a common mounted location.

For example, to copy using ssh:

  .. code-block:: bash

    $ scp /etc/chef-backend/chef-backend-secrets.json <USER>@<IP_BE2>:/home/<USER>
    $ scp /etc/chef-backend/chef-backend-secrets.json <USER>@<IP_BE3>:/home/<USER>

Delete this file from the destination after Step 4 has been completed
for each backend being joined to the cluster.

Step 3: Install and Configure remaining backend nodes
-----------------------------------------------------

For each additional node do the following in sequence (if you attempt
to join nodes in parallel the cluster may fail to become available):

#. Install backend package on the node.

#. As root or with sudo:

   .. code-block:: bash

      $ chef-backend-ctl join-cluster <IP_BE1> -s ~/home/<USER>/chef-backend-secrets.json

#. Answer the prompts regarding which public IP to use

   - As an alternative, you may specify them on the `chef-backend join-cluster` command line.  See `chef-backend-ctl join-cluster --help` for more information.

#. If you copied the shared chef-backend-secrets.json file to a user
   HOME directory on this host, remove it now.

#. Repeat these steps for each follower node, after which the cluster
   is online and available. From any node in the backend HA cluster,
   run the following command:

   .. code-block:: bash

      $ chef-backend-ctl status

   should return something like:

   .. code-block:: bash

      Service        Local Status        Time in State  Distributed Node Status
      elasticsearch  running (pid 6661)  1d 5h 59m 41s  state: green; nodes online: 3/3
      etcd           running (pid 6742)  1d 5h 59m 39s  health: green; healthy nodes: 3/3
      leaderl        running (pid 6788)  1d 5h 59m 35s  leader: 1; waiting: 0; follower: 2; total: 3
      postgresql     running (pid 6640)  1d 5h 59m 43s  leader: 1; offline: 0; syncing: 0; synced: 2

Step 4: Generate |chef server| Configuration
--------------------------------------------

Log into the node from Step 1, and we will generate our chef-server frontend node configuration:

  .. code-block:: bash

    $ chef-backend-ctl gen-server-config <FE1-FQDN> -f chef-server.rb.<FE1>
    $ scp chef-server.rb.FE1 USER@<IP_FE1>:/home/<USER>

*Note* `/etc/chef-backend/chef-backend-secrets.json` is *not* made
available to |chef server| frontend nodes.

Step 5: Install and Configure First Frontend
---------------------------------------------

On the first frontend node, assuming that the generated configuration
was copied as detailed in Step 4:

#. install the current chef-server-core package
#. `cp /home/<USER>/chef-server.rb.<FE1> /etc/opscode/chef-server.rb`
#. as root, run `chef-server-ctl reconfigure`

Adding More Frontends
-----------------------------------------------------

For each additional frontend node you wish to add to your cluster:

#. Generate a new `chef-server.rb` from any of the backend nodes via

    .. code-block:: bash

     		$ chef-backend-ctl gen-server-config <FE_NAME-FQDN> > chef-server.rb.<FE_NAME>

#. Copy it to /etc/opscode on the new frontend node.

#. From the first frontend node configured in Step 5, copy the
   following files from the first frontend to `/etc/opscode` on the
   new frontend node:

   - /etc/opscode/private-chef-secrets.json
   - /etc/opscode/webui_priv.pem
   - /etc/opscode/webui_pub.pem
   - /etc/opscode/pivotal.pem

# On the new frontend node: `mkdir -p /var/opt/opscode/upgrades/`

#. From the first frontend node, copy
   /var/opt/opscode/upgrades/migration-level to the same location on the
   new node.

#. On the new frontend run: `touch /var/opt/opscode/bootstrapped`

#. On the new frontend run: `chef-server-ctl reconfigure` as root

Upgrading chef-server on the frontend machines
----------------------------------------------

#. On any of the frontends follow documentation from:
   https://docs.chef.io/upgrade\_server.html#standalone to upgrade

#. On each of the remaining frontends, copy
   `/var/opt/opscode/upgrades/migration-level` from first upgraded
   frontend to `/var/opt/opscode/upgrades/migration-level` on current
   box.

Cluster Security Considerations
===============================

.. This will need to be integrated into the server_ topics after all that is updated and finalized.

A backend cluster is expected to run in a trusted environment. This
means that untrusted users that communicate with and/or eavesdrop on
services provided by the backend cluster can potentially view
sensitive data.

Communication Between Nodes
---------------------------

|postgresql| communication between nodes in the backend cluster is
encrypted, and uses password authentication. All other communication
in the backend cluster is unauthenticated and happens in the clear
(without encryption).

Communication Between Frontend Group & Backend Cluster
--------------------------------------------------------

|postgresql| communication from nodes in the frontend group to the
leader of the backend cluster uses password authentication, but
communication happens in the clear (without encryption).

|elasticsearch| communication is unauthenticated and happens in the clear (without encryption).

Securing Communication
-----------------------------------------------------

Because most of the peer communication between nodes in the backend
cluster happens in the clear, the backend cluster is vulnerable to
passive monitoring of network traffic between nodes. To help prevent
an active attacker from intercepting or changing cluster data,
|company_name| recommends using |iptables| or an equivalent network
ACL tool to restrict access to |postgresql|, |elasticsearch| and
|etcd| to only hosts that need access.

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

The following services run on each node in the backend cluster. The
user account under which the service runs as listed the second column:


.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Service
     - Process Owner
   * - ``postgresql``
     - ``chef_pgsql``

       Communication with |postgresql| requires password
       authentication. The backend cluster generates |postgresql|
       users and passwords during the initial cluster-create. These
       passwords are present in the following files on disk:

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


Chef Server Frontend
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``chef-backend-ctl gen-server-config`` command, which can be run
as root from any node in the backend cluster, will automatically
generate a configuration file containing the superuser database access
credentials for the backend cluster |postgresql| instance.

Software Versions
-----------------------------------------------------

The backend HA cluster uses the |omnibus installer|
(https://github.com/chef/omnibus) to package all of the software
necessary to run the services included in the backend cluster. For a
full list of the software packages included (and their versions), see
the file located at ``/opt/chef-backend/version-manifest.json``.

Do not attempt to upgrade individual components of the omnibus
package. Due to the way omnibus packages are built, modifying any of
the individual components in the package will lead to cluster
instability. If the latest version of the backend cluster is providing
an out-of-date package, please bring it to the attention of
|company_name| by filling out a ticket with |support_email|.

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


create-cluster
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_create_cluster.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_create_cluster_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_create_cluster_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


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

Configure the Frontend
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
