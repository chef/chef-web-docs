.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``knife diff`` subcommand to compare the differences between files and directories on the Chef server and in the chef-repo. For example, to compare files on the Chef server prior to an uploading or downloading files using the ``knife download`` and ``knife upload`` subcommands, or to ensure that certain files in multiple production environments are the same. This subcommand is similar to the ``git diff`` command that can be used to diff what is in the chef-repo with what is synced to a git repository.
