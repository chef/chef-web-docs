.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the |resource chef_handler| resource to enable handlers during a |chef client| run. The resource allows arguments to be passed to the |chef client|, which then applies the conditions defined by the custom handler to the node attribute data collected during the |chef client| run, and then processes the handler based on that data.

The |resource chef_handler| resource is typically defined early in a node's run-list (often being the first item). This ensures that all of the handlers will be available for the entire |chef client| run.

The |resource chef_handler| resource is included with the |cookbook chef_handler| cookbook. This cookbook defines the the resource itself and also provides the location in which the |chef client| looks for custom handlers. All custom handlers should be added to the ``files/default/handlers`` directory in the |cookbook chef_handler| cookbook.

