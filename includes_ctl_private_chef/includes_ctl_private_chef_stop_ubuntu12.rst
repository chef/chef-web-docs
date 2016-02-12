.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``private-chef-ctl stop`` subcommand should not be run when the |chef server| 11.x server is instaled on |ubuntu| 12 in a high availability configuration. This will stop |keepalived|, and then trigger a |drbd| failover. Instead, stop each service individually (e.g. ``private-chef-ctl stop name_of_service``), as described below. This behavior has been fixed in the |chef server| 12 release.
