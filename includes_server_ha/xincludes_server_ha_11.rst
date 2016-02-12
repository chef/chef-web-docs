.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

|chef server oec| can operate in a high availability configuration that provides automated failover for stateful components in the system architecture. This configuration splits servers into two segments: front-end and back-end servers. The front-end servers handle requests to the user interface and requests that use the |api chef server|. The back-end servers handle data storage and retrieval, which consists of:

* |couch db|
* |postgresql|
* |opscode solr|
* |rabbitmq|
* |redis|
* Cookbook data

Failover on the back-end servers is achieved using the following:

* Asynchronous block level replication of logical volume managers using |drbd|, positioned between two back-end servers
* A primary and backup cluster election using |vrrp| over unicast TCP/IP and |keepalived|
* A virtual IP address to the primary server, maintained based on the results of the election done by |keepalived|

.. image:: ../../images_old/oec_ha.png

The front-end servers require load-balancers. |company_name| recommends:

* Hardware load-balancers (such as |f5| or |netscalar|)
* |ssl| off-loading
* Round-robin as the load-balancing algorithm
