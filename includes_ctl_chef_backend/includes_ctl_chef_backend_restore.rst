.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``restore`` subcommand to restore a backup created by the ``chef-backend-ctl backup`` subcommand. This command should be executed on the leader node in the backend HA cluster. This command will delete all existing data and replace it with the data in the backup archive.
