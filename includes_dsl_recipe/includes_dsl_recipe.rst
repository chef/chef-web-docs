.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |dsl recipe| is a |ruby| DSL that is primarily used to declare resources from within a recipe. The |dsl recipe| also helps ensure that recipes interact with nodes (and node properties) in the desired manner. Most of the methods in the |dsl recipe| are used to find a specific parameter and then tell the |chef client| what action(s) to take, based on whether that parameter is present on a node.
