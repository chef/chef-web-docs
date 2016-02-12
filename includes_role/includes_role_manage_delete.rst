.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

When an environment is deleted, it will remain within a run-list for a role until it is removed from that run-list. If a new environment is created that has an identical name to an environment that was deleted, a run-list that contains an old environment name will use the new one.
