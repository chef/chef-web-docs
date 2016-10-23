.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The chef-client `includes an option called local mode <https://docs.chef.io/ctl_chef_client.html#run-in-local-mode>`_ (``--local-mode`` or ``-z``), which runs the chef-client against the chef-repo on the local machine as if it were running against a Chef server. Local mode was added to the chef-client in the 11.8 release. If you are running that version of the chef-client (or later), you should consider using local mode instead of using chef-solo.
