.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``chef push`` subcommand is used to upload an existing |policylock| file to the |chef server|, along with all of the cookbooks that are contained in the |policylock| file. The |policylock| file will be applied to the specified policy group, which is a set of nodes that share the same run-list and cookbooks. 

.. warning:: This feature is new and experimental. Some aspects of the design have not yet been finalized. If you are new to |chef|, please don't use it. If you are an experienced user, please try it out and provide feedback. If you do use it, please do so in a location that is isolated from production code.

For more information about policy and the configuration file used to manage and maintain policy---|policyfile rb|---please see this topic on |github|: https://gist.github.com/danielsdeleo/52c90c9e3c9c76b80316.


