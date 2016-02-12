.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

**All-in-One Compute** configurations are appropriate for small scale deployments like proof of concept projects, dedicated fenced development environments, or when the host will be a virtual machine. This machine need not be large, but it must be sufficient to launch a few virtual instances, assuming those instances are only used for testing purposes. This configuration is a good way to familiarize yourself with the basics of |openstack chef|.

The All-in-One Compute configuration may be used for testing with |vagrant|.

* **On the Controller** Compute, Dashboard, Identity, Image, and Network. The database and messaging services also run on the node.
* **Excluded** Block Storage, Object Storage, Metering, and Orchestration
