.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


When running |chef| without |policyfile|, the exact set of cookbooks that are applied to a node is defined by:

* The node's ``run_list`` property
* Any roles that are present in the node's run-list or recursively included by those roles
* The environment, which restricts the set of valid cookbook versions for a node based on a variety of constraint operators
* Dependencies, as defined by each cookbook's metadata
* Dependency resolution picks the "best" set of cookbooks that meet dependency and environment criteria

These conditions are re-evaluated every time the |chef client| runs, which can make it harder to know which cookbooks will be run by the |chef client| or what the effects of updating a role or uploading a new cookbook will be.

|policyfile| simplifies this behavior by computing the cookbook set on the workstation, and then producing a readable document of that solution: a |policylock| file. This pre-computed file is uploaded to the |chef server|, and is then used by all of the |chef client| runs that are managed by that particular policy group.
