.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The **Single Controller + N Compute** (aka **1+N**) configuration refers to a single controller and variable number of nodes. This is suitable for relatively small deployments, such as those with fewer than twenty nodes. The size of the deployment depends on the nature of the workload. Compute nodes should typically be given more substantial hardware than the controller node.

* **On the Controller** Compute (services, not the hypervisor), Dashboard, Identity, Image, and Network. The database and messaging services also run on the Controller.
* **On the Compute Nodes** Compute (hypervisor, not the services)
* **Excluded** Object Storage, Metering, and Orchestration
