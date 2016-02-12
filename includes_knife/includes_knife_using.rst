.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

|knife| runs from a management workstation and sits in-between a |chef server| and an organization's infrastructure. |knife| interacts with a |chef server| by using the same REST API that is used by a |chef client|. Role-based authentication controls (RBAC) can be used to authorize changes when |knife| is run with |chef server oec|. |knife| is configured during workstation setup, but subsequent modifications can be made using the |knife rb| configuration file.

