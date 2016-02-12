.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |chef client| can be run as a scheduled task. On the |windows| platform, a scheduled task provides more visibility, configurability, and reliability around log rotation and permissions, as compared to running the |chef client| as a service. A scheduled task:

* Prevents log rotation issues, such as filling a disk partition
* Does not have an indeterminate status, such as a service for which only the watcher is "running"
* Prevents insufficient permissions related to service context
* Prevents issues related to a system reboot
