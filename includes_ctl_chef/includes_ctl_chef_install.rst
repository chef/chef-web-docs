.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``chef install`` subcommand is used to evaluate a policy file and find a compatible set of cookbooks, build a run-list, cache it locally, and then emit a |policylock| file that describes the locked policy set. The |policylock| file may be used to install the locked policy set to other machines and may be pushed to a policy group on the |chef server| to apply that policy to a group of nodes that are under management by |chef|.

.. warning:: This feature is new and experimental. Some aspects of the design have not yet been finalized. If you are new to |chef|, please don't use it. If you are an experienced user, please try it out and provide feedback. If you do use it, please do so in a location that is isolated from production code.

For more information about policy and the configuration file used to manage and maintain policy---|policyfile rb|---please see this topic on |github|: https://gist.github.com/danielsdeleo/52c90c9e3c9c76b80316.
