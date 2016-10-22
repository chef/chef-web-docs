.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Exception and report handlers are used to trigger certain behaviors in response to specific situations, typically identified during a chef-client run.

* An exception handler is used to trigger behaviors when a defined aspect of a chef-client run fails.
* A report handler is used to trigger behaviors when a defined aspect of a chef-client run is successful. 

Both types of handlers can be used to gather data about a chef-client run and can provide rich levels of data about all types of usage, which can be used later for trending and analysis across the entire organization.

Exception and report handlers are made available to the chef-client run in one of the following ways:

* By adding the **chef_handler** resource to a recipe, and then adding that recipe to the run-list for a node. (The **chef_handler** resource is available from the **chef_handler** cookbook.)
* By adding the handler to one of the following settings in the node's client.rb file: ``exception_handlers`` and/or ``report_handlers``
