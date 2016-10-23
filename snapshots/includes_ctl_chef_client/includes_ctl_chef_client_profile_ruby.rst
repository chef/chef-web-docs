.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``--profile-ruby`` option to dump a (large) profiling graph into ``/var/chef/cache/graph_profile.out``. Use the graph output to help identify, and then resolve performance bottlenecks in a chef-client run. This option:

* Generates a large amount of data about the chef-client run
* Has a dependency on the ``ruby-prof`` gem, which is packaged as part of Chef and the Chef development kit
* Increases the amount of time required to complete the chef-client run
* Should not be used in a production environment
