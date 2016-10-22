.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


chef-zero is a very lightweight Chef server that runs in-memory on the local machine. This allows the chef-client to be run against the chef-repo as if it were running against the Chef server. chef-zero was `originally a standalone tool <https://github.com/chef/chef-zero>`_; it is enabled from within the chef-client by using the ``--local-mode`` option. chef-zero is very useful for quickly testing and validating the behavior of the chef-client, cookbooks, recipes, and run-lists before uploading that data to the actual Chef server.



