.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``-a``, ``--all-orgs``
   Use to reindex all organizations on the Chef server. This option will override any organization specified as part of the command, i.e. ``chef-server-ctl reindex ORG_NAME -a`` will reindex all organizations and not just the specified organization.

``-d``, ``--disable-api``
   Use to disable the Chef server API to prevent writes during reindexing.

``-t``, ``--with-timing``
   Use to print timing information for the reindex processes.

``-w``, ``--wait``
   Use to wait for the reindexing queue to clear before exiting.
