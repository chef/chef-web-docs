.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


When the ``chef install`` command is run, the Chef development kit caches any necessary cookbooks and emits a Policyfile.lock.json file that describes:

* The versions of cookbooks in use
* A Hash of cookbook content
* The source for all cookbooks

A Policyfile.lock.json file is associated with a specific policy group, i.e. is associated with one (or more) nodes that use the same revision of a given policy.
