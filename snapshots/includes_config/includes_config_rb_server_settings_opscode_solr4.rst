.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``opscode-solr4``:

``opscode_solr4['auto_soft_commit']``
   The maximum number of documents before a soft commit is triggered. Default value: ``1000``.

``opscode_solr4['commit_interval']``
   The frequency (in seconds) at which node objects are added to the Apache Solr search index. This value should be tuned carefully. When data is committed to the Apache Solr index, all incoming updates are blocked. If the duration between updates is too short, it is possible for the rate at which updates are asked to occur to be faster than the rate at which objects can be actually committed. Default value: ``60000`` (every 60 seconds).

``opscode_solr4['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value:

   .. code-block:: ruby

      /var/opt/opscode/opscode-solr4/data

``opscode_solr4['dir']``
   The working directory. The default value is the recommended value. Default value:

   .. code-block:: ruby

      /var/opt/opscode/opscode-solr4

``opscode_solr4['enable']``
   Enable a service. Default value: ``true``.

``opscode_solr4['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``opscode_solr4['heap_size']``
   The amount of memory (in MBs) available to Apache Solr. If there is not enough memory available, search queries made by nodes to Apache Solr may fail. The amount of memory that must be available also depends on the number of nodes in the organization, the frequency of search queries, and other characteristics that are unique to each organization. In general, as the number of nodes increases, so does the amount of memory. The default value should work for many organizations with fewer than 25 nodes. For an organization with several hundred nodes, the amount of memory that is required often exceeds 3GB. Default value: ``nil``, which is equivalent to 25% of the system memory or 1024 (MB, but this setting is specified as an integer number of MB in EC11), whichever is smaller.

``opscode_solr4['ip_address']``
   The IP address for the machine on which Apache Solr is running. Default value: ``127.0.0.1``.

``opscode_solr4['java_opts']``
   A Hash of ``JAVA_OPTS`` environment variables to be set. (``-XX:NewSize`` is configured using the ``new_size`` setting.) Default value: ``' '`` (empty).

``opscode_solr4['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value:

   .. code-block:: ruby

      /var/log/opscode/opscode-solr4

``opscode_solr4['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``opscode_solr4['max_commit_docs']``
   The frequency (in documents) at which node objects are added to the Apache Solr search index. This value should be tuned carefully.  When data is committed to the Apache Solr index, all incoming updates are blocked. If the duration between updates is too short, it is possible for the rate at which updates are asked to occur to be faster than the rate at which objects can be actually committed. Default value: ``1000`` (every 1000 documents).

``opscode_solr4['max_field_length']``
   The maximum field length (in number of tokens/terms). If a field length exceeds this value, Apache Solr may not be able to complete building the index. Default value: ``100000`` (increased from the Apache Solr default value of ``10000``).

``opscode_solr4['max_merge_docs']``
   The maximum number of index segments allowed before they are merged into a single index. Default value: ``2147483647``.

``opscode_solr4['merge_factor']``
   The maximum number of document updates that can be stored in memory before being flushed and added to the current index segment. Default value: ``15``.

``opscode_solr4['new_size']``
   Configure the ``-XX:NewSize`` ``JAVA_OPTS`` environment variable. Default value: ``nil``.

``opscode_solr4['poll_seconds']``
   The frequency (in seconds) at which the secondary machine polls the primary. Default value: ``20``.

``opscode_solr4['port']``
   The port on which the service is to listen. Default value: ``8983``.

``opscode_solr4['ram_buffer_size']``
   The size (in megabytes) of the RAM buffer. When document updates exceed this amout, pending updates are flushed. Default value: ``100``.

``opscode_solr4['url']``
   Default value: ``'http://localhost:8983/solr'``.

``opscode_solr4['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.
