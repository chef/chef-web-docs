.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``opscode-chef-mover``:

``opscode_chef_mover['bulk_fetch_batch_size']``
   Default value: ``'5'``.

``opscode_chef_mover['cache_ttl']``
   Default value: ``'3600'``.

``opscode_chef_mover['db_pool_size']``
   The number of open connections to PostgreSQL that are maintained by the service. Default value: ``'5'``.

``opscode_chef_mover['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value:

   .. code-block:: ruby

      '/var/opt/opscode/opscode-chef-mover/data'

``opscode_chef_mover['dir']``
   The working directory. The default value is the recommended value. Default value:

   .. code-block:: ruby

      '/var/opt/opscode/opscode-chef-mover'

``opscode_chef_mover['enable']``
   Enable a service. Default value: ``true``.

``opscode_chef_mover['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``opscode_chef_mover['ibrowse_max_pipeline_size']``
   Default value: ``1``.

``opscode_chef_mover['ibrowse_max_sessions']``
   Default value: ``256``.

``opscode_chef_mover['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value:

   .. code-block:: ruby

      '/var/log/opscode/opscode-chef-mover'

``opscode_chef_mover['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``opscode_chef_mover['max_cache_size']``
   Default value: ``'10000'``.

``opscode_chef_mover['solr_http_cull_interval']``
   Default value: ``'{1, min}'``.

``opscode_chef_mover['solr_http_init_count']``
   Default value: ``25``.

``opscode_chef_mover['solr_http_max_age']``
   Default value: ``'{70, sec}'``.

``opscode_chef_mover['solr_http_max_connection_duration']``
   Default value: ``'{70, sec}'``.

``opscode_chef_mover['solr_http_max_count']``
   Default value: ``100``.

``opscode_chef_mover['solr_ibrowse_options']``
   Default value: ``'[{connect_timeout, 10000}]'``.

``opscode_chef_mover['solr_timeout']``
   Default value: ``30000``.
