.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |chef server| can operate in a high availability configuration that provides automated load balancing and failover for stateful components in the system architecture. This type of configuration typically splits the servers into two segments: front-end and back-end machines: 

.. image:: ../../images/chef_server_ha.svg
   :width: 600px
   :align: center

Front-end machines handle requests to the |api chef server| and access to the web user interface. Front-end machines should be load balanced and scaled horizontally by increasing the number of servers available to handle requests.

Back-end machines handle data storage and retrieval, messaging and routing, analytics processing, and search. Back-end machines should be configured for failover using block level replication.
