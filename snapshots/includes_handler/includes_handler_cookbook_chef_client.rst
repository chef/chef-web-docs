.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Start handlers can be distributed using the **chef-client** cookbook, which will install the handler on the target node during the initial configuration of the node. This ensures that the start handler is always present on the node so that it is available to the chef-client at the start of every run.
