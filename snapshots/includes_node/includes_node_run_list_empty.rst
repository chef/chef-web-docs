.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


Use an empty run-list to determine if a failed chef-client run has anything to do with the recipes that are defined within that run-list. This is a quick way to discover if the underlying cause of a chef-client run failure is a configuration issue. If a failure persists even if the run-list is empty, check the following:

* Configuration settings in the knife.rb file
* Permissions for the user to both the Chef server and to the node on which the chef-client run is to take place
