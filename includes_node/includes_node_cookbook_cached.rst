.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A cookbook is the fundamental unit of distribution across the organization. All cookbooks are stored as part of the the node object for each node. Each cookbook that is required by a node is then cached on the node, including dependencies such as templates, file distributions, and other cookbooks. Caching cookbooks on the nodes ensures that as much work as possible is done by the |chef client| on the node itself, with minimal interaction between the |chef client| and the |chef server|.
