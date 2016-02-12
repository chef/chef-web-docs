.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An attribute can be defined in a recipe and then used to override the default settings on a node. When a recipe is applied during a |chef client| run, these attributes are compared to the attributes that are already present on the node. When the recipe attributes take precedence over the default attributes, the |chef client| will apply those new settings and values during the |chef client| run.
