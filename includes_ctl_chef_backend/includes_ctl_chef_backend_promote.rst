.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``promote`` subcommand to promote the named node to be leader of the backend HA cluster. This command will:

#. Complete with an exit code of ``0`` when the leader of the backend HA cluster is replaced as leader by the named node.
#. Return an error message and a non-zero exit code if the named node is already leader, if ``set-cluster-failover`` is ``off``, or if the new leader could not be promoted within the allowed time.
