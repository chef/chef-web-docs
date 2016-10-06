.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Only use knife supermarket if you are using a Chef 12.12 or earlier. If you are using Chef 12.13 or later, you should use the `knife cookbook site <https://docs.chef.io/knife_cookbook_site.html>`_ commands.


The ``knife supermarket`` subcommand is used to interact with cookbooks that are located in private |supermarket| configured inside the firewall. A user account is required for any community actions that write data to the |supermarket|; however, the following arguments do not require a user account: ``download``, ``search``, ``install``, and ``list``.
