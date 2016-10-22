.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``/search`` endpoint allows nodes, roles, data bags, environments to be searched. This endpoint has the following methods: ``GET``.

.. note:: At the end of every chef-client run, the node object is saved to the Chef server. From the Chef server, each node object is then added to the Apache Solr search index. This process is asynchronous. By default, node objects are committed to the search index every 60 seconds or per 1000 node objects, whichever occurs first.

.. note:: This endpoint does not have any ACL restrictions, which means it may be used by any user or client that is able to make the request to the Chef server.
