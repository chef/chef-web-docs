.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``opscode-solr4``:

``opscode_solr4['auto_soft_commit']``
   |solr_auto_soft_commit| Default value: ``1000``.

``opscode_solr4['commit_interval']``
   |solr_commit_interval| This value should be tuned carefully. |solr_update_frequency_caveat| Default value: ``60000`` (every 60 seconds).

``opscode_solr4['data_dir']``
   |directory generic_data| |default_value_recommended| Default value:

   .. code-block:: ruby

      /var/opt/opscode/opscode-solr4/data

``opscode_solr4['dir']``
   |directory generic| |default_value_recommended| Default value:

   .. code-block:: ruby

      /var/opt/opscode/opscode-solr4

``opscode_solr4['enable']``
   |enable service| Default value: ``true``.

``opscode_solr4['ha']``
   |use ha| |ha true| Default value: ``false``.

``opscode_solr4['heap_size']``
   |heap_size solr| The default value should work for many organizations with fewer than 25 nodes. For an organization with several hundred nodes, the amount of memory that is required often exceeds 3GB. Default value: ``nil``, which is equivalent to 25% of the system memory or 1024 (MB, but this setting is specified as an integer number of MB in EC11), whichever is smaller.

``opscode_solr4['ip_address']``
   |solr_ip_address| Default value: ``127.0.0.1``.

``opscode_solr4['java_opts']``
   |solr_java_opts| (``-XX:NewSize`` is configured using the ``new_size`` setting.) Default value: ``' '`` (empty).

``opscode_solr4['log_directory']``
   |directory logs| |default_value_recommended| Default value:

   .. code-block:: ruby

      /var/log/opscode/opscode-solr4

``opscode_solr4['log_rotation']``
   |log_rotation| Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``opscode_solr4['max_commit_docs']``
   |solr_max_commit_docs| This value should be tuned carefully.  |solr_update_frequency_caveat| Default value: ``1000`` (every 1000 documents).

``opscode_solr4['max_field_length']``
   |solr_max_field_length| Default value: ``100000`` (increased from the |apache solr| default value of ``10000``).

``opscode_solr4['max_merge_docs']``
   |solr_max_merge_docs| Default value: ``2147483647``.

``opscode_solr4['merge_factor']``
   |solr_merge_factor| Default value: ``15``.

``opscode_solr4['new_size']``
   |solr_new_size| Default value: ``nil``.

``opscode_solr4['poll_seconds']``
   |solr_poll_seconds| Default value: ``20``.

``opscode_solr4['port']``
   |port service| Default value: ``8983``.

``opscode_solr4['ram_buffer_size']``
   |solr_ram_buffer_size| Default value: ``100``.

``opscode_solr4['url']``
   Default value: ``'http://localhost:8983/solr'``.

``opscode_solr4['vip']``
   |ip_address virtual| Default value: ``127.0.0.1``.
