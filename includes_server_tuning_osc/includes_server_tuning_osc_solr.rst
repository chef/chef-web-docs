.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following settings are often modified from the default as part of the tuning effort for the |service solr| service:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``chef_solr['heap_size']``
     - |heap_size solr| 
       
       If |apache solr| is running out of memory, the ``/var/log/opscode/chef_solr-solr/current`` log file will contain ``SEVERE: java.lang.OutOfMemoryError: Java heap space``.
       
       The default value should work for many organizations with fewer than 25 nodes. Suggested value: ``256`` per every 25 nodes. For example, an organization with 300 nodes, this value should be set to ``3072``.
   * - ``chef_solr['max_field_length']``
     - |solr_max_field_length| Default value: ``100000`` (increased from the |apache solr| default value of ``10000``).


