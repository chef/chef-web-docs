.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

At the end of every chef-client run, the node object is saved to the Chef server. From the Chef server, each node object is then added to the ``SOLR`` search index. This process is asynchronous. By default, node objects are committed to the search index every 60 seconds or per 1000 node objects, whichever occurs first. 

When data is committed to the Apache Solr index, all incoming updates are blocked. If the duration between updates is too short, it is possible for the rate at which updates are asked to occur to be faster than the rate at which objects can be actually committed.

For Open Source Chef, these settings are configurable in the chef-server.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``chef_solr['commit_interval']``
     - The frequency (in seconds) at which node objects are added to the Apache Solr search index. Default value: ``60000`` (every 60 seconds).
   * - ``chef_solr['max_commit_docs']``
     - The frequency (in documents) at which node objects are added to the Apache Solr search index. Default value: ``1000`` (every 1000 documents).


