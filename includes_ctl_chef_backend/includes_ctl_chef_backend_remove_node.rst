.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``remove-node`` subcommand to remove the named node from the backend HA cluster by removing the node's status from |etcd| and deleting it from the |etcd| cluster. This command is useful when a node is going to be replaced or if the ``join-cluster`` command was unsuccessful.

This command may not be run from the node that is to be removed; the node itself must be shut down physically or have all services stopped (via the the ``chef-backend-ctl stop`` command). If the node is still running or otherwise available to the backend HA cluster, this command will return an error message and a non-zero exist code.
