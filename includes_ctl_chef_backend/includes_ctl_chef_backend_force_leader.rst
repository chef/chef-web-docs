.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``force-leader`` subcommand to force the node from which the command is run to become the leader in the backend HA cluster if there is not already an elected leader.

This command should only be run if:

* The backend cluster appears to not have an elected and available leader
* All of the nodes in the backend HA cluster are believed to be in a healthy state; if one (or more) nodes are not healthy, first remove the unhealthy nodes, rebuild, and then rejoin them to the cluster
 
This command will:

#. Run the ``chef-backend-ctl cluster-status`` subcommand to determine if a leader exists.

   .. warning:: Nodes in the backend HA cluster may not be visible to each other when they are located in network parititions. This may prevent a cluster status check from discovering that a leader exists. If nodes exist on network parititions, to prevent this scenario, first run ``chef-backend-ctl cluster-status``, and then verify the expected number of nodes in the backend HA cluster as healthy and ``waiting_for_leader`` before running this command. 
#. Complete with an exit code of ``0`` if the node from which the command is run becomes the leader.
#. Return an error message and a non-zero exit code if a leader already exists.
