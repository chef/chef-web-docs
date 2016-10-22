.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``chef clean-policy-cookbooks`` subcommand to delete cookbooks that are not used by Policyfile files. Cookbooks are considered unused when they are not referenced by any policy revisions on the Chef server.

.. note:: Cookbooks that are referenced by orphaned policy revisions are not removed. Use ``chef clean-policy-revisions`` to remove orphaned policies.
