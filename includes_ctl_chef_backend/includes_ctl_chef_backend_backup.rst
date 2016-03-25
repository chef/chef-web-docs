.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``backup`` subcommand is to backup the data for a node in the backend HA cluster. This command is typically run against a follower node. Use the ``--force`` option to run this command against all nodes in the backend HA cluster. The backup is created as a |tar gz| file and is located in ``/var/opt/chef-backup/``.
