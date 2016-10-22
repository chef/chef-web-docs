.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

chef-solo is an open source version of the chef-client that allows using cookbooks with nodes without requiring access to a Chef server. chef-solo runs locally and requires that a cookbook (and any of its dependencies) be on the same physical disk as the node. chef-solo is a limited-functionality version of the chef-client and **does not support** the following:

* Node data storage
* Search indexes
* Centralized distribution of cookbooks
* Environments, including policy settings and cookbook versions
* A centralized API that interacts with and integrates infrastructure components
* Authentication or authorization
* Persistent attributes

