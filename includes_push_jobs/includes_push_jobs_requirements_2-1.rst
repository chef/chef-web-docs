.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|push jobs| has the following requirements:

* An on-premises |chef server| version 12.6 (or later); |push jobs| is not supported when running |chef| with the hosted |chef server|
* To use the |cookbook push jobs| cookbook to configure the |push jobs| client, the |chef client| must also be present on the node (because only the |chef client| can use a cookbook to configure a node)
* .. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports_push_jobs.rst
