.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |resource chef_handler| resource is used to allow cookbook authors to ship a product-specific handler. This resource configures and enables handlers on a node for the current |chef client| run and can pass arguments to the initializer, which allows initialization data to be pulled from a node's attribute data. This resource should be declared early in the compile phase so it may trigger exceptions during the |chef client| run. For a base role, recipes that register handlers should come first in the run_list.
