.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |chef server| acts as a hub for configuration data. The |chef server| stores cookbooks, the policies that are applied to nodes, and metadata that describes each registered node that is being managed by the |chef client|. Nodes use the |chef client| to ask the |chef server| for configuration details, such as recipes, templates, and file distributions. The |chef client| then does as much of the configuration work as possible on the nodes themselves (and not on the |chef server|). This scalable approach distributes the configuration effort throughout the organization.

