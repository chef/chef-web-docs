.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``demote`` subcommand to demote the current leader in the backend HA cluster, after which a new leader is elected from the group of available followers in the backend HA cluster. This command will:

#. Complete with an exit code of ``0`` if the original leader was demoted and a new leader was elected successfully.
#. Return an error message and a non-zero exit code if leader election is prevented because ``set-cluster-failover`` is ``off`` or if a new leader could not be elected within the allowed time.
