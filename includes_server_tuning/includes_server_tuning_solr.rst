.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following settings are often modified from the default as part of the tuning effort for the |service solr4| service:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``opscode_solr4['heap_size']``
     - |heap_size solr| 
       
       If |apache solr| is running out of memory, the ``/var/log/opscode/opscode-solr4/current`` log file will contain ``SEVERE: java.lang.OutOfMemoryError: Java heap space``.
       
       The default value should work for many organizations with fewer than 25 nodes. Suggested value: 25% of system memory or ``1024``, whichever is smaller. For larger configurations, increase this value to 25% of system memory or ``4096``, whichever is smaller. This value should not exceed ``8192``.
   * - ``opscode_solr4['max_field_length']``
     - |solr_max_field_length| Default value: ``100000`` (increased from the |apache solr| default value of ``10000``).
