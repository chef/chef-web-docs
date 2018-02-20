=====================================================
Chef Backend Failure Recovery
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/backend_failure_recovery.rst>`__

This document contains the recommended actions for responding to failures in your Chef Backend cluster.

.. note:: If you have concerns about applying the Backend recovery process to your cluster, please consult with Support before taking the steps outlined in this guide.

Assumptions
=====================================================
All instructions currently assume a 3-node backend cluster running Chef Backend 0.3.0 or greater. The user should have SSH access with root privileges to all nodes in the cluster.

Node Failures
=====================================================
This section covers how to respond to failures that have brought the entire node down or off the network.

Single-node Failure
-----------------------------------------------------
Temporary single-node failures require little administrator intervention to resolve. Once the administrator has addressed the failure and restarted the node, it will reconnect to the
cluster and sync from the current leader.

However if the failing node cannot be brought back online, it must be replaced:

#. From any node in the cluster, run the following commands to remove the failed node from etcd's configuration:

   .. code-block:: none

      chef-backend-ctl remove-node NODE_NAME_OR_IP

#. Install Chef Backend on the new node, and join it to the cluster using:

   .. code-block:: none

      chef-backend-ctl join-cluster IP_OF_RUNNING_NODE -s PATH_TO_SHARED_SECRETS

See the `installation instructions </install_server_ha.html#step-3-install-and-configure-remaining-backend-nodes>`__ for more details on joining nodes to the cluster.

Two-node Failure
-----------------------------------------------------
In the case of a two-node failure in a standard three-node configuration, the cluster is no longer able to operate, as leader election requires a quorum of two nodes.

This procedure assumes that the remaining node has the most up-to-date copy of the data. If that is not the case it is advised that you restore the existing node from a backup before proceeding. See the `Backup and Restore </server_backup_restore.html#backup-and-restore-a-chef-backend-install>`__ documentation for details.

#. On the surviving node, run the following command:

   .. code-block:: none

      chef-backend-ctl create-cluster --quorum-loss-recovery

#. On each of the two new nodes, install ``chef-backend-ctl`` and join to the cluster using:

   .. code-block:: none

      chef-backend-ctl join-cluster IP_OF_LEADER -s PATH_TO_SHARED_SECRETS

   See the `installation instructions </install_server_ha.html#step-3-install-and-configure-remaining-backend-nodes>`__ for more details on joining nodes to the cluster.

Partitions
=====================================================
For the purpose of this section, a **partition** refers to the loss of network connectivity between two nodes. From the perspective of other nodes in the cluster, it is impossible to tell whether a node is down or has been partitioned. However, because a partition is often characterized by the node and the software on the node still being up, this section covers some special care to take when recovering a cluster that has been partitioned at the network level.

No Loss of Quorum
-----------------------------------------------------
If the network partition did not result in a loss of quorum, then the failed nodes in the cluster should recover on their own once connectivity is restored.

Loss of Quorum
-----------------------------------------------------
This section covers two potential remediation options for instances where a lack of network connectivity has resulted in loss of quorum between nodes.

Promoting a Specific Node
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This procedure only works currently if the administrator can take action before the network split resolves itself.

#. Resolve the network partition. As the nodes come back online, they will all move into a ``waiting_for_leader`` state.

#. On the node you would like to promote, run ``chef-backend-ctl create-cluster``

Promoting a Previous Leader
+++++++++++++++++++++++++++++++++++++++++++++++++++++
If a recently deposed leader is likely the node with the most up-to-date data, you may want to reinstate its leadership.

#. To ensure that the deposed leader can come up correctly, you will need to override the safety check that prevents deposed leaders from starting PostgreSQL. On the deposed leader node that is being promoted, run the following command:

   .. code-block:: bash

      rm /var/opt/chef-backend/leaderl/data/no-start-pgsql

#. Then restart PostgresSQL:

   .. code-block:: none

      chef-backend-ctl restart postgresql

#. Finally, promote the deposed leader node:

   .. code-block:: none

      chef-backend-ctl create-cluster


Service Level Failures
=====================================================
This section documents the expected behavior that occurs when a single service fails. This currently extends to the service's process on the machine dying, not more complicated service failures where the process is up and taking requests but returning incorrect results.

Note that the number of service-level failures that a service can sustain depends upon whether or not the failure is happening in isolation. In general an operator should assume that the cluster can sustain a failure on a single node, but a second failure is likely to cause a loss of availability if the first failure is not resolved.

PostgreSQL
-----------------------------------------------------
The leader/follower state of PostgresSQL is managed by Leaderl. Leaderl performs health checks on PostgreSQL and fails over to a follower if the health check fails.

Assuming that ``etcd`` and ``leaderl`` are running properly, two of the three nodes can have service-level PostgreSQL failures. Once the service-level problems have been resolved, the two failed nodes can be resynced from the leader node.

Elasticsearch
-----------------------------------------------------
* Elasticsearch manages its own availability. 1 of the 3 nodes can have a service-level Elasticsearch failure without affecting the availability of the cluster.

* Elasticsearch failovers are independent of PostgreSQL failovers; however, since the Chef Server can only talk to a single Elasticsearch instance, if Elasticsearch fails on the leader node, Leaderl will failover (including a PostgreSQL failover) to another node.

* Once the root cause of the service-level problems has been identified and solved, the failed node should be able to rejoin the cluster.

Etcd
-----------------------------------------------------
Etcd is used by Leaderl to elect a PostgreSQL leader and store status and cluster state information. Its availability is required for Leaderl to continue functioning properly. 1 of the 3 nodes can have service-level etcd failures and the cluster should remain available. If the Etcd failure is on the current leader, a PostgreSQL failover will occur.

Leaderl
-----------------------------------------------------
Leaderl is responsible for ensuring that leadership is assigned to a node that can resolve all requests. If Leaderl fails on the leader node, it will be unable to respond to failures in the PostgreSQL service. The other nodes in the cluster will detect Leaderl's failure and attempt to take over as leader. However, since Leaderl on the failing node is down, PostgreSQL may still be up and accepting connections.

Other Failures
=====================================================

Handling nodes reporting ``partially_synced: true``
-----------------------------------------------------
When a node starts to sync from a leader, Leaderl will write the following file to disk:

.. code-block:: none

   /var/opt/chef-backend/leaderl/data/unsynced

When the sync completes successfully the file is removed. If the sync fails, the file will remain in place, the node will be placed in a ``waiting_for_leader`` state, and will report as leader ineligible. The cluster will report an unhealthy status until the issue is resolved.

Resolving the issue requires an understanding of what caused the sync failure. One way to determine the cause is by manually running a sync and inspecting the output:

.. code-block:: none

   chef-backend-ctl stop leaderl
   PSQL_INTERNAL_OK-true chef-backend-ctl pgsql-follow LEADER_IP --verbose

Once you've resolved the issue and can run the ``pgsql-follow`` command successfully, you can manually remove the sentinel file and restart Leaderl:

.. code-block:: none

   rm /var/opt/chef-backend/leaderl/data/unsynced
   chef-backend-ctl start leaderl
