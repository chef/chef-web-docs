.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``chef delete-policy-group`` subcommand to delete the named policy group from the Chef server. Any policy revision associated with that policy group is not deleted. (The state of the policy group is backed up locally and may be restored using the ``chef undelete`` subcommand.)
