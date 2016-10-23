.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A LWRP is a part of a cookbook that is used to extend the chef-client in a way that allows custom actions to be defined, and then used in recipes in much the same way as any platform resource. In other words: a LWRP is a custom resource. A custom resource has two principal components:

* A custom resource that defines a set of actions and attributes that is located in a cookbook's ``/resources`` directory
* A custom provider that tells the chef-client how to handle each action, what to do if certain conditions are met, and so on that is located in a cookbook's ``/providers`` directory

A custom provider is typically built in a way that leverages the core resources that are built into Chef, but they may also be built using Ruby.

Once created, a custom resource becomes a Ruby class. During each chef-client run, the chef-client will read the custom resource from a recipe and will process it alongside all other resources. When it is time to configure the node, the chef-client will use the custom provider to determine the steps required to bring the system into the desired state.
