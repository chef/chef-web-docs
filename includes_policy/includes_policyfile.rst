.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


.. note:: |policyfile| file is an optional way to manage role, environment, and community cookbook data.

|policyfile| is a single document that is uploaded to the |chef server|. It is associated with a group of nodes, cookbooks, and settings. When these nodes run, they run the recipes specified in the |policyfile| run-list.

.. warning:: |policyfile| is not integrated with |chef delivery| and is not supported as part of a |chef delivery| workflow.
