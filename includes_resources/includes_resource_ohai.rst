.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the |resource ohai| resource to reload the |ohai| configuration on a node. This allows recipes that change system attributes (like a recipe that adds a user) to refer to those attributes later on during the |chef client| run.
