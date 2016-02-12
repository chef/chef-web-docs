.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

At the end of every |chef client| run, the node object is saved to the |chef server|. From the |chef server|, each node object is then added to the ``SOLR`` search index. This process is asynchronous. By default, node objects are committed to the search index every 60 seconds or per 1000 node objects, whichever occurs first. 

|solr_update_frequency_caveat|

For |chef server osc|, these settings are configurable in the |chef server rb| file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``chef_solr['commit_interval']``
     - |solr_commit_interval| Default value: ``60000`` (every 60 seconds).
   * - ``chef_solr['max_commit_docs']``
     - |solr_max_commit_docs| Default value: ``1000`` (every 1000 documents).


