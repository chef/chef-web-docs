.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Chef Analytics includes a powerful rules processing system that allows notifications to be generated based on observed events in the data stream, such as:

* Cookbook uploads
* Modifications to environments
* Machines on which chef-client runs have failed
* Machines on which audit-mode runs have failed
* Resources that were updated as a result of a chef-client run

Notifications may be sent to any email address, a chat service like HipChat or Slack, or to a webhook-based service for generic intergrations.
