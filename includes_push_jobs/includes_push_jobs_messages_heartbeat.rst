.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A heartbeat message is sent by the |push jobs| server to every managed node. This lets each of those nodes know that the |push jobs| server is available. This heartbeat message is one-way; no acknowledgements are returned by the nodes. The frequency of this heartbeat message is configurable.

A heartbeat message is sent by a node to the |push jobs| server. This lets the |push jobs| server know which nodes are available. This heartbeat message is one-way; no acknowledgements are returned by the |push jobs| server. If the |push jobs| server is unavailable, a node will discontinue heartbeats until the |push jobs| server heartbeat resumes.

A |push jobs| job may not be completed if either the |push jobs| server or a certain number of nodes are unavailable. (The number of nodes that may be unavailable is determined by the ``quorum`` setting when the job request is made.)
