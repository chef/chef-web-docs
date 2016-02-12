.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``chef export`` subcommand is used to create a |chef zero|-compatible |chef repo| that contains the cookbooks described by a |policylock| file. After a |chef zero|-compatible |chef repo| is copied to a node, the policy can be applied locally on that machine by running ``chef-client -z`` (local mode).
