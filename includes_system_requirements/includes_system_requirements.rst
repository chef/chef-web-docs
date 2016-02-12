.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Before installing |chef|:

* Ensure that each machine that will be a node is running a :doc:`supported platform </supported_platforms>`
* Ensure that the machine that will run the |chef server| is sufficiently powerful
* Ensure that any network and firewall settings are configured correctly

Install and configure the |chef server|, then install and configure a workstation, and then run the bootstrap command from the workstation to install the |chef client| on each node.
