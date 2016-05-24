.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``--elasticsearch-wait-time``
   The maximum amount of time (in seconds) to wait for |elasticsearch| to start. Default value: ``30``.

``--etcd-wait-time``
   The maximum amount of time (in seconds) to wait for |etcd| to start. Default value: ``30``.

``--quorum-loss-recovery``
   Resets the cluster identifier in |etcd| to this node.

   If nodes in a backend HA cluster are not available, |etcd| may not be able to form a cluster. If |etcd| cannot form a cluster, rebuild the cluster. First reset the cluster identifier on an active node, rebuild the nodes that will be part of the cluster, and then rejoin the rebuilt nodes to the cluster by using the ``chef-backend-ctl join-cluster`` subcommand.

``-y``, ``--yes``
   |no_confirmation|
