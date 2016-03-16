.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``chef undelete`` subcommand to recover a deleted policy or policy group. This command:

* Does not detect conflicts. If a deleted item has been recreated, running this command will overwrite it
* Does not include cookbooks that may be referenced by policy files; cookbooks that are cleaned after running this command may not be fully restorable to their previous state
* Does not store access control data
