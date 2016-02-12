.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Every organization must have at least one environment. Every organization starts out with a single environment that is named ``_default``, which ensures that at least one environment is always available to the |chef server|. The ``_default`` environment cannot be modified in any way. Nodes, roles, run-lists, cookbooks (and cookbook versions), and attributes specific to an organization can only be associated with a custom environment.
