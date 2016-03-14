.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``chef install`` subcommand to evaluate a policy file and find a compatible set of cookbooks, build a run-list, cache it locally, and then emit a |policylock| file that describes the locked policy set. The |policylock| file may be used to install the locked policy set to other machines and may be pushed to a policy group on the |chef server| to apply that policy to a group of nodes that are under management by |chef|.
