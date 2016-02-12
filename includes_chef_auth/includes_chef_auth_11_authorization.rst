.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Users of the |chef server| can only perform authorized actions. The |chef server| has two authorization models:

* |chef server oec| uses a role-based access control (RBAC) model for both hosted and non-hosted versions
* The open source |chef server| has a single tenant access control model where users require admin rights to create, read, update, or delete objects; non-admins have read access to all objects and update access a single node