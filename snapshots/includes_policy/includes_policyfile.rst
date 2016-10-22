.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


.. note:: Policyfile file is an optional way to manage role, environment, and community cookbook data.

Policyfile is a single document that is uploaded to the Chef server. It is associated with a group of nodes, cookbooks, and settings. When these nodes run, they run the recipes specified in the Policyfile run-list.

.. warning:: Policyfile is not integrated with Chef Automate and is not supported as part of a Chef Automate workflow.
