.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is included in Chef Delivery docs

A workstation is a computer that is configured to run various |chef| command-line tools that synchronize with a |chef repo|, author cookbooks, interact with the |chef server|, interact with nodes, or applications like |chef delivery|.

The workstation is the location from which most users do most of their work, including:

* Developing cookbooks and recipes (and authoring them using |ruby| syntax and patterns)
* Keeping the |chef repo| synchronized with version source control
* Using command-line tools
* Configuring organizational policy, including defining roles and environments and ensuring that critical data is stored in data bags
* Interacting with nodes, as (or when) required, such as performing a bootstrap operation
