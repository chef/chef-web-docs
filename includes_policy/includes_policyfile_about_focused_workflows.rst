.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


The |knife| command line tool maps very closely to the |api chef server| and the objects defined by it: roles, environments, run-lists, cookbooks, data bags, nodes, and so on. The |chef client| assembles these pieces at run-time and configures a host to do useful work.

|policyfile| focuses that workflow onto the entire system, rather than the individual components. For example, |policyfile| describes whole systems, whereas each individual revision of the |policylock| file uploaded to the |chef server| describes a part of that system, inclusive of roles, environments, cookbooks, and the other |chef server| objects necessary to configure that part of the system.
