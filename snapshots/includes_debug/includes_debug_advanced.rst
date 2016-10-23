.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Some more complex ways to debug issues with a chef-client run include:

* Using the **chef_handler** cookbook
* Using the chef-shell and the **breakpoint** resource to add breakpoints to recipes, and to then step through the recipes using the breakpoints
* Using the ``debug_value`` method from chef-shell to indentify the location(s) from which attribute values are being set
* Using the ``ignore_failure`` method in a recipe to force the chef-client to move past an error to see what else is going on in the recipe, outside of a known failure
* Using chef-solo to run targeted chef-client runs for specific scenarios
