.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


When running |chef| without |policyfile| roles are global objects. Changes to roles are applied immediately to any node that contains that role in its run-list. This can make it hard to update roles and in some use cases discourages using roles at all.

|policyfile| effectively replaces roles. |policyfile| files are versioned automatically and new versions are applied to systems only when promoted.
