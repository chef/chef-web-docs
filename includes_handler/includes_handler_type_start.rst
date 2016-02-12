.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A start handler is not loaded into the |chef client| run from a recipe, but is instead listed in the |client rb| file using the ``start_handlers`` attribute. The start handler must be installed on the node and be available to the |chef client| prior to the start of the |chef client| run. Use the |cookbook chef_client| cookbook to install the start handler.

Start handlers are made available to the |chef client| run in one of the following ways:

* By adding a start handler to the |cookbook chef_client| cookbook, which installs the handler on the node so that it is available to the |chef client| at the start of the |chef client| run
* By adding the handler to one of the following settings in the node's client.rb file: ``start_handlers``
