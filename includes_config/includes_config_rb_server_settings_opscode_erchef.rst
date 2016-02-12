.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``opscode-erchef``:

``opscode_erchef['auth_skew']``
   Default value: ``900``.

``opscode_erchef['authz_fanout']``
   Default value: ``20``.

``opscode_erchef['authz_timeout']``
   |timeout bifrost| Default value: ``2000``.

``opscode_erchef['base_resource_url']``
   |url chef_server_base| Default value: ``:host_header``.

``opscode_erchef['bulk_fetch_batch_size']``
   |batch_size bulk_fetch| |default_value_recommended| Default value: ``5``.

``opscode_erchef['cache_ttl']``
   Default value: ``3600``.

``opscode_erchef['cleanup_batch_size']``
   Default value: ``0``.

``opscode_erchef['couchdb_max_conn']``
   Default value: ``'100'``.

``opscode_erchef['db_pool_size']``
   |db_pool_size| Default value: ``20``.

``opscode_erchef['depsolver_timeout']``
   |timeout depsolver| Default value: ``'5000'``.

``opscode_erchef['depsolver_worker_count']``
   |worker_processes depsolver| Use the ``pgrep -fl depselector`` command to verify the number of depsolver workers that are running. If you are seeing 503 service unavailable errors, increase this value. Default value: ``'5'``.

``opscode_erchef['dir']``
   |directory generic| |default_value_recommended| Default value: ``/var/opt/opscode/opscode-erchef``.

``opscode_erchef['enable']``
   |enable service| Default value: ``true``.

``opscode_erchef['enable_actionlog']``
   Use to enable |chef actions|, a premium feature of the |chef server|. Default value: ``false``.

``opscode_erchef['ha']``
   |use ha| |ha true| Default value: ``false``.

``opscode_erchef['ibrowse_max_pipeline_size']``
   Default value: ``1``.

``opscode_erchef['ibrowse_max_sessions']``
   Default value: ``256``.

``opscode_erchef['listen']``
   |ip_address service| Default value: ``127.0.0.1``.

``opscode_erchef['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``/var/log/opscode/opscode-erchef``.

``opscode_erchef['log_rotation']``
   |log_rotation| Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``opscode_erchef['max_cache_size']``
   Default value: ``10000``.

``opscode_erchef['max_request_size']``
   Default value: ``1000000``.

``opscode_erchef['nginx_bookshelf_caching']``
   |nginx bookshelf_caching| Default value: ``:off``.

``opscode_erchef['port']``
   |port service| Default value: ``8000``.

``opscode_erchef['root_metric_key']``
   Default value: ``chefAPI``.

``opscode_erchef['s3_bucket']``
   |name s3_bucket| (This is configurable and may be pointed at external storage locations, such as |amazon ec2|. |cookbook external_storage_settings| Default value: ``bookshelf``.

``opscode_erchef['s3_parallel_ops_fanout']``
   Default value: ``20``.

``opscode_erchef['s3_parallel_ops_timeout']``
   Default value: ``5000``.

``opscode_erchef['s3_url_expiry_window_size']``
   |s3_url_expiry_window_size| Default value: ``:off``.

``opscode_erchef['s3_url_ttl']``
   |s3_url_ttl| If node bootstraps are timing out, increase this setting. Default value: ``28800``.

``opscode_erchef['strict_search_result_acls']``
   .. include:: ../../includes_settings/includes_settings_strict_search_result_acls.rst

``opscode_erchef['udp_socket_pool_size']``
   Default value: ``20``.

``opscode_erchef['umask']``
   Default value: ``0022``.

``opscode_erchef['validation_client_name']``
   Default value: ``chef-validator``.

``opscode_erchef['vip']``
   |ip_address virtual| Default value: ``127.0.0.1``.
