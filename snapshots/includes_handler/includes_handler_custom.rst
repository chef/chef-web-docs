.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A custom handler can be created to support any situation. The easiest way to build a custom handler:

#. Download the **chef_handler** cookbook
#. Create a custom handler
#. Write a recipe using the **chef_handler** resource
#. Add that recipe to a node's run-list, often as the first recipe in that run-list
