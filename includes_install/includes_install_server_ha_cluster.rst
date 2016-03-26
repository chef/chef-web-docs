.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This topic introduces, and then describes describes how to set up the |chef server| for high availability using a backend HA cluster comprised of three machines: one leader and two followers.


OVERVIEW
=====================================================
A backend HA cluster provides a highly available persistence system for the |chef server| that runs replicated |postgresql|, |elasticsearch|, |leaderl| and |etcd|.

* |postgresql| is the data store for |chef server| data
* |elasticsearch| creates the search indexes
* |leaderl| manages failover and the backend VIP
* |etcd| provides consensus and ties the backend HA cluster together

The only ports open between the frontend group and the backend HA cluster are ``9200`` and ``5432``, which allow the |chef server| nodes in the frontend group to access |elasticsearch| and |postgresql| respectively.

.. note:: Using a backend HA cluster requires all machines in both the frontend group and backend cluster to be running |chef server| 12.4.0 (or higher).


Components
=====================================================


Backend VIP
-----------------------------------------------------
All communication between nodes in the frontend group and nodes in the backend HA cluster must use the backend VIP. The backend VIP is an IP address that represents the backend HA cluster and is always assigned to the node that is the current leader.


Backend Cluster
-----------------------------------------------------
The backend cluster is three identical nodes running replicated |postgresql|, |elasticsearch|, |etcd|, and |leaderl|. This ensures that the backend HA cluster can lose one of the three backend nodes and remain online. Once the first node is lost, failover may no longer occur because at least two backend nodes must participate in the leader election process. However, all three nodes must be lost for data loss to occur.

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
The frontend group is one (or more) nodes running the |chef server| configured to support the backend HA cluster. Each node in the frontend group is effectively a standalone |chef server|, though the topology behaves much like a tiered configuration with each frontend node relying on an external data store and external search components. The Bookshelf component, previously installed on backend nodes, moves to the frontend. The nodes in the frontend group handle requests to the |api chef server| from workstations and nodes. Cookbooks are stored on the frontend nodes.




REQUIREMENTS




WHAT'S CHANGED
-----------------------------------------------------
Starting with |chef server| version 12.4, the need for file system-based storage for |apache solr| and Bookshelf on the backend is no longer required and |postgresql| replication capabilities provide redundancy:

* |apache solr| is replaced by |elasticsearch|, which allows moving cookbook storage (Bookshelf) to nodes in the frontend group
* Bookshelf is moved to nodes in the frontend group
* |rabbitmq|, along with some other services built to support queuing, are no longer needed
* |keepalived| is effectively replaced by |leaderl| and |etcd|; the previous implementation used |keepalived| to manage a VIP
* |drbd| is not longer required to replicate partitions between two backend nodes
* ``chef-server-ctl`` commands should only be run on nodes in the frontend group
* ``chef-backend-ctl`` commands should only be run on nodes in the backend HA cluster
