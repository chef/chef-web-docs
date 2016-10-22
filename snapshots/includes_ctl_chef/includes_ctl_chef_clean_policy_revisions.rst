.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``chef clean-policy-revisions`` subcommand to delete orphaned policy revisions to Policyfile files from the Chef server. An orphaned policy revision is not associated to any policy group and therefore is not in active use by any node. Use ``chef show-policy --orphans`` to view a list of orphaned policy revisions.
