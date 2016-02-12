.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|push jobs| has the following requirements:

* An on-premises |chef server| version 11.0.1 (or later)
* To use the |cookbook push jobs| cookbook to configure the |push jobs| client, the |chef client| must also be present on the node (because only the |chef client| can use a cookbook to configure a node)
* .. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports_push_jobs.rst

The |push jobs| client can run on the following platforms:

* |ubuntu| 10.04, 10.10, 12.04, and 12.10
* |centos| 5 and 6
* |windows|
