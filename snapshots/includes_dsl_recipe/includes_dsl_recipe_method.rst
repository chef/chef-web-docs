.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The Recipe DSL provides support for using attributes, data bags (and encrypted data), and search results in a recipe, as well as four helper methods that can be used to check for a node's platform from the recipe to ensure that specific actions are taken for specific platforms. The helper methods are:

* ``platform?``
* ``platform_family?``
* ``value_for_platform``
* ``value_for_platform_family``
