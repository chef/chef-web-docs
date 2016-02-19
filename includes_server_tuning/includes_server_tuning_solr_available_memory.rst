.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the following configuration setting to help ensure that |apache solr| does not run out of memory:

``opscode_solr4['heap_size']``
   |heap_size solr| 
       
If |apache solr| is running out of memory, the ``/var/log/opscode/opscode-solr4/current`` log file will contain a message similar to:

.. code-block:: bash

   SEVERE: java.lang.OutOfMemoryError: Java heap space
       
The default value for ``opscode_solr4['heap_size']`` should work for many organizations, especially those with fewer than 25 nodes. For organizations with more than 25 nodes, set this value to 25% of system memory or ``1024``, whichever is smaller. For very large configurations, increase this value to 25% of system memory or ``4096``, whichever is smaller. This value should not exceed ``8192``.
