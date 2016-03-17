.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


When running |chef| without |policyfile|, the |chef server| loads dependency data for all known versions of all known cookbooks, and then runs an expensive computation to determine the correct set.

|policyfile| moves this computation to the workstation, where it is done less frequently.
